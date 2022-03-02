Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28599C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 19:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiCBTT0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242314AbiCBTTY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 14:19:24 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E12873334A
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 11:18:37 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 16974CED12;
        Wed,  2 Mar 2022 20:18:37 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix not processing all entries on
 cmd_sync_work
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220302191100.364431-1-luiz.dentz@gmail.com>
Date:   Wed, 2 Mar 2022 20:18:36 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B566F0C8-38BE-40D7-89BD-DAD6F2C96A56@holtmann.org>
References: <20220302191100.364431-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> hci_cmd_sync_queue can be called multiple times, each adding a
> hci_cmd_sync_work_entry, before hci_cmd_sync_work is run so this makes
> sure they are all dequeued properly otherwise it creates a backlog of
> entries that are never run.
> 
> Link: https://lore.kernel.org/all/CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com/T/
> Fixes: 6a98e3836fa20 ("Bluetooth: Add helper for serialized HCI command execution")
> Tested-by: Chris Clayton <chris2553@googlemail.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_sync.c | 64 ++++++++++++++++++++++++----------------
> 1 file changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d146d4efae43..121df2dcf2f1 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -273,43 +273,55 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> }
> EXPORT_SYMBOL(__hci_cmd_sync_status);
> 
> -static void hci_cmd_sync_work(struct work_struct *work)
> +static void hci_cmd_sync_work_entry_run(struct hci_dev *hdev,
> +					struct hci_cmd_sync_work_entry *entry)
> {
> -	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
> -	struct hci_cmd_sync_work_entry *entry;
> 	hci_cmd_sync_work_func_t func;
> 	hci_cmd_sync_work_destroy_t destroy;
> 	void *data;
> +	int err;
> 
> -	bt_dev_dbg(hdev, "");
> +	bt_dev_dbg(hdev, "entry %p", entry);
> 
> -	mutex_lock(&hdev->cmd_sync_work_lock);
> -	entry = list_first_entry(&hdev->cmd_sync_work_list,
> -				 struct hci_cmd_sync_work_entry, list);
> -	if (entry) {
> -		list_del(&entry->list);
> -		func = entry->func;
> -		data = entry->data;
> -		destroy = entry->destroy;
> -		kfree(entry);
> -	} else {
> -		func = NULL;
> -		data = NULL;
> -		destroy = NULL;
> -	}
> -	mutex_unlock(&hdev->cmd_sync_work_lock);
> +	func = entry->func;
> +	data = entry->data;
> +	destroy = entry->destroy;
> +	kfree(entry);
> 
> -	if (func) {
> -		int err;
> +	if (!func)
> +		return;
> 
> -		hci_req_sync_lock(hdev);
> +	hci_req_sync_lock(hdev);
> +
> +	err = func(hdev, data);
> 
> -		err = func(hdev, data);
> +	if (destroy)
> +		destroy(hdev, data, err);
> 
> -		if (destroy)
> -			destroy(hdev, data, err);
> +	hci_req_sync_unlock(hdev);
> +}
> +
> +static void hci_cmd_sync_work(struct work_struct *work)
> +{
> +	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
> +	struct hci_cmd_sync_work_entry *entry;
> +
> +	bt_dev_dbg(hdev, "");
> +
> +	/* Dequeue all entries and run them */
> +	while (1) {
> +		mutex_lock(&hdev->cmd_sync_work_lock);
> +		entry = list_first_entry_or_null(&hdev->cmd_sync_work_list,
> +						 struct hci_cmd_sync_work_entry,
> +						 list);
> +		if (entry)
> +			list_del(&entry->list);
> +		mutex_unlock(&hdev->cmd_sync_work_lock);
> +
> +		if (!entry)
> +			break;
> 
> -		hci_req_sync_unlock(hdev);
> +		hci_cmd_sync_work_entry_run(hdev, entry);
> 	}
> }
> 

I was dead serious with my example on how to do this. Scrap the hci_cmd_sync_work_entry_run and do this all in one while loop.

Regards

Marcel

