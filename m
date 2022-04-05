Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5853FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 00:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiDFAlZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572915AbiDERUK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Apr 2022 13:20:10 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73FA725DA
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Apr 2022 10:18:09 -0700 (PDT)
Received: from smtpclient.apple (CMPC-089-239-127-162.CNet.Gawex.PL [89.239.127.162])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6F86CCECC4;
        Tue,  5 Apr 2022 19:18:08 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] Bluetooth: use hdev lock for accept_list and reject_list
 in conn req
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220404003403.35690-1-dossche.niels@gmail.com>
Date:   Tue, 5 Apr 2022 19:18:07 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <2F8732A2-FED9-4649-8F9D-680536E94D34@holtmann.org>
References: <20220404003403.35690-1-dossche.niels@gmail.com>
To:     Niels Dossche <dossche.niels@gmail.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Niels,

> All accesses (both read and modifications) to
> hdev->{accept,reject}_list are protected by hdev lock,
> except the ones in hci_conn_request_evt. This can cause a race condition
> in the form of a list corruption.
> The solution is to protect these lists in hci_conn_request_evt as well.
> 
> I was unable to find the exact commit that introduced the issue for the
> reject list, I was only able to find it for the accept list.
> 
> Note:
> I am currently working on a static analyser to detect missing locks
> using type-based static analysis as my master's thesis
> in order to obtain my master's degree.
> If you would like to have more details, please let me know.
> This was a reported case. I manually verified the report by looking
> at the code, so that I do not send wrong information or patches.
> After concluding that this seems to be a true positive, I created
> this patch. I have both compile-tested this patch and runtime-tested
> this patch on x86_64. The effect on a running system could be a
> potential race condition in exceptional cases.
> This issue was found on Linux v5.17.1.

this doesn’t belong in the commit message.

> 
> Fixes: a55bd29d5227 ("Bluetooth: Add white list lookup for incoming connection requests")
> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
> ---
> net/bluetooth/hci_event.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index abaabfae19cc..b9038f24f46f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3222,8 +3222,11 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
> 		return;
> 	}
> 
> +	hci_dev_lock(hdev);
> +
> 	if (hci_bdaddr_list_lookup(&hdev->reject_list, &ev->bdaddr,
> 				   BDADDR_BREDR)) {
> +		hci_dev_unlock(hdev);
> 		hci_reject_conn(hdev, &ev->bdaddr);
> 		return;
> 	}
> @@ -3236,14 +3239,13 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
> 	    !hci_dev_test_flag(hdev, HCI_CONNECTABLE) &&
> 	    !hci_bdaddr_list_lookup_with_flags(&hdev->accept_list, &ev->bdaddr,
> 					       BDADDR_BREDR)) {
> +		hci_dev_unlock(hdev);
> 		hci_reject_conn(hdev, &ev->bdaddr);
> 		return;
> 	}

Can we use an exit goto-label instead. I am not a big fan of "unbalanced” _unlock statements.

> 	/* Connection accepted */
> 
> -	hci_dev_lock(hdev);
> -
> 	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
> 	if (ie)
> 		memcpy(ie->data.dev_class, ev->dev_class, 3);

Regards

Marcel

