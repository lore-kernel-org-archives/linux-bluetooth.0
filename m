Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD46C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 12:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiCCMhf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Mar 2022 07:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiCCMhe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Mar 2022 07:37:34 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3EBD517AEFF
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Mar 2022 04:36:49 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 92601CED24;
        Thu,  3 Mar 2022 13:36:48 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2] Bluetooth: hci_sync: Fix not processing all entries on
 cmd_sync_work
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220302210245.392267-1-luiz.dentz@gmail.com>
Date:   Thu, 3 Mar 2022 13:36:48 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <4E5B9E16-B6B5-430E-BB26-D6919F448F6E@holtmann.org>
References: <20220302210245.392267-1-luiz.dentz@gmail.com>
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
> net/bluetooth/hci_sync.c | 39 +++++++++++++++++++++------------------
> 1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d146d4efae43..06c6e954dcbd 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -283,33 +283,36 @@ static void hci_cmd_sync_work(struct work_struct *work)
> 
> 	bt_dev_dbg(hdev, "");
> 
> -	mutex_lock(&hdev->cmd_sync_work_lock);
> -	entry = list_first_entry(&hdev->cmd_sync_work_list,
> -				 struct hci_cmd_sync_work_entry, list);
> -	if (entry) {
> -		list_del(&entry->list);
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
> +
> 		func = entry->func;
> 		data = entry->data;
> 		destroy = entry->destroy;
> 		kfree(entry);
> -	} else {
> -		func = NULL;
> -		data = NULL;
> -		destroy = NULL;
> -	}
> -	mutex_unlock(&hdev->cmd_sync_work_lock);
> 
> -	if (func) {
> -		int err;
> +		if (func) {
> +			int err;
> 
> -		hci_req_sync_lock(hdev);
> +			hci_req_sync_lock(hdev);
> 
> -		err = func(hdev, data);
> +			err = func(hdev, data);
> 
> -		if (destroy)
> -			destroy(hdev, data, err);
> +			if (destroy)
> +				destroy(hdev, data, err);
> 
> -		hci_req_sync_unlock(hdev);
> +			hci_req_sync_unlock(hdev);
> +		}
> 	}
> }

I really don’t get this. I already gave you how I think this should look like and you still keep the massive amount of variables for no apparent reason. If I am stupid and made a mistake, then please enlighten me, otherwise this should look like this:

@@ -276,40 +276,37 @@ EXPORT_SYMBOL(__hci_cmd_sync_status);
 static void hci_cmd_sync_work(struct work_struct *work)
 {
        struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_sync_work);
-       struct hci_cmd_sync_work_entry *entry;
-       hci_cmd_sync_work_func_t func;
-       hci_cmd_sync_work_destroy_t destroy;
-       void *data;
 
        bt_dev_dbg(hdev, "");
 
-       mutex_lock(&hdev->cmd_sync_work_lock);
-       entry = list_first_entry(&hdev->cmd_sync_work_list,
-                                struct hci_cmd_sync_work_entry, list);
-       if (entry) {
-               list_del(&entry->list);
-               func = entry->func;
-               data = entry->data;
-               destroy = entry->destroy;
+       /* Dequeue all entries and run them */
+       while (1) {
+               struct hci_cmd_sync_work_entry *entry;
+
+               mutex_lock(&hdev->cmd_sync_work_lock);
+               entry = list_first_entry_or_null(&hdev->cmd_sync_work_list,
+                                                struct hci_cmd_sync_work_entry,
+                                                list);
+               if (entry)
+                       list_del(&entry->list);
+               mutex_unlock(&hdev->cmd_sync_work_lock);
+
+               if (!entry)
+                       break;
+
+               bt_dev_dbg(hdev, "entry %p", entry);
+
+               if (entry->func) {
+                       int err;
+
+                       hci_req_sync_lock(hdev);
+                       err = entry->func(hdev, entry->data);
+                       if (entry->destroy)
+                               entry->destroy(hdev, entry->data, err);
+                       hci_req_sync_unlock(hdev);
+               }
+
                kfree(entry);
-       } else {
-               func = NULL;
-               data = NULL;
-               destroy = NULL;
-       }
-       mutex_unlock(&hdev->cmd_sync_work_lock);
-
-       if (func) {
-               int err;
-
-               hci_req_sync_lock(hdev);
-
-               err = func(hdev, data);
-
-               if (destroy)
-                       destroy(hdev, data, err);
-
-               hci_req_sync_unlock(hdev);
        }
 }

I amended the patch now and applied it to bluetooth-stable tree. I am not doing any more iterations to get this right.

Regards

Marcel

