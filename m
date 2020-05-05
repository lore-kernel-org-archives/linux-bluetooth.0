Return-Path: <SRS0=nALV=6T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A3DC47259
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B395620721
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 May 2020 23:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729533AbgEEXmP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 May 2020 19:42:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54131 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgEEXmO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 May 2020 19:42:14 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 23908CECFC;
        Wed,  6 May 2020 01:51:53 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: Handle Inquiry Cancel error after Inquiry
 Complete
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOxioN=1dP9W=WZ2TM+3RLbVmxBYkcrG0s4HiExihAXQ=0pJJg@mail.gmail.com>
Date:   Wed, 6 May 2020 01:42:11 +0200
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <89566A98-F0CE-4E70-A344-915E81FB0C14@holtmann.org>
References: <20200428051151.14879-1-sonnysasaka@gmail.com>
 <D2192131-CC65-4D4E-91BE-B1C3B1C12BC4@holtmann.org>
 <CAOxioN=2p23_K1VuFth5PwFAUR1oXcgs5GPHeM595OOivh6Y2Q@mail.gmail.com>
 <CAOxioN=1dP9W=WZ2TM+3RLbVmxBYkcrG0s4HiExihAXQ=0pJJg@mail.gmail.com>
To:     Sonny Sasaka <sonnysasaka@chromium.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

> Could you take another look at my last proposal based on your
> suggestion? If we are to move the logic inside hci_cc_inquiry_cancel,
> we will need a way to update the status to the caller, for example by
> having hci_cc_inquiry_cancel return a value, or accept a pointer for
> the updated status value. Let me know which way you prefer.

maybe something like this (missing comment of course):

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,14 +42,20 @@
 
 /* Handle HCI Event packets */
 
-static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
+static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
+                                 u8 *new_status)
 {
        __u8 status = *((__u8 *) skb->data);
 
        BT_DBG("%s status 0x%2.2x", hdev->name, status);
 
-       if (status)
+       if (status) {
+               if (!test_bit(HCI_INQUIRY, &hdev->flags) && status == 0x0c) {
+                       BT_DBG("Ignoring error of HCI Inquiry Cancel command");
+                       *new_status = 0x00;
+               }
                return;
+       }
 
        clear_bit(HCI_INQUIRY, &hdev->flags);
        smp_mb__after_atomic(); /* wake_up_bit advises about this barrier */
@@ -3233,7 +3239,7 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
 
        switch (*opcode) {
        case HCI_OP_INQUIRY_CANCEL:
-               hci_cc_inquiry_cancel(hdev, skb);
+               hci_cc_inquiry_cancel(hdev, skb, status);
                break;
 
        case HCI_OP_PERIODIC_INQ:

Regards

Marcel

