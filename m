Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 14:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbiCBOiZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiCBOiY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 09:38:24 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75E42A18D
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 06:37:40 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id AC4FCCED0C;
        Wed,  2 Mar 2022 15:37:39 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC] Bluetooth: hci_sync: Fix not processing all entries on
 cmd_sync_work
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220302064351.225212-1-luiz.dentz@gmail.com>
Date:   Wed, 2 Mar 2022 15:37:39 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <37F2BAFF-8251-4E8F-A48A-89694E64CBF1@holtmann.org>
References: <20220302064351.225212-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> The could be multiple hci_cmd_sync_work_entry enqueued when
> hci_cmd_sync_work is executed so this makes sure they are all
> dequeued properly.

might want to be a bit more verbose in the issue description.

> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/hci_sync.c | 65 ++++++++++++++++++++++++----------------
> 1 file changed, 39 insertions(+), 26 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d146d4efae43..724d34bdd62a 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -273,43 +273,56 @@ int __hci_cmd_sync_status(struct hci_dev *hdev, u16 opcode, u32 plen,
> }
> EXPORT_SYMBOL(__hci_cmd_sync_status);
> 
> -static void hci_cmd_sync_work(struct work_struct *work)
> +
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
> +
> +	hci_req_sync_lock(hdev);
> +
> +	err = func(hdev, data);
> 
> -		hci_req_sync_lock(hdev);
> +	if (destroy)
> +		destroy(hdev, data, err);
> 
> -		err = func(hdev, data);
> +	hci_req_sync_unlock(hdev);
> +}
> 
> -		if (destroy)
> -			destroy(hdev, data, err);
> +static void hci_cmd_sync_work(struct work_struct *work)
> +{
> +	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
> +	struct hci_cmd_sync_work_entry *entry;
> +
> +	bt_dev_dbg(hdev, "");
> +
> +	while (1) {
> +		mutex_lock(&hdev->cmd_sync_work_lock);
> +		entry = list_first_entry_or_null(&hdev->cmd_sync_work_list,
> +						 struct hci_cmd_sync_work_entry,
> +						 list);
> +		if (!entry) {
> +			mutex_unlock(&hdev->cmd_sync_work_lock);
> +			break;
> +		}
> +
> +		list_del(&entry->list);
> +		mutex_unlock(&hdev->cmd_sync_work_lock);
> 
> -		hci_req_sync_unlock(hdev);
> +		hci_cmd_sync_work_entry_run(hdev, entry);
> 	}
> }

In general I don’t like having two unlock vs one lock in the code. I know it is correct and the tools will also understand it is correct, but I just dislike it. I think it makes it hard for human eyes to verify locking balance.

I would prefer something like this:

	while (1) {
		struct hci_cmd_sync_work_entry *entry;
		int err;

		mutex_lock(&hdev->cmd_sync_work_lock);
		entry = list_first_entry_or_null(&hdev->cmd_..
		if (entry)
			list_del(&entry->list);
		mutex_unlock(&hdev->cmd_sync_work_lock);

		if (!entry)
			break;

		bt_dev_dbg(hdev, "entry %p", entry);

		if (entry->func) {
			hci_req_sync_lock(hdev);
			err = func(hdev, entry->data);
			if (entry->destroy)
				entry->destroy(hdev, entry->data, err);
			hci_req_sync_unlock(hdev);
		}

		kfree(entry);
	}

This looks a lot easy to read and verify to me.

Regards

Marcel

