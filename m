Return-Path: <SRS0=CJlv=4S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106ECC3F2C6
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Mar 2020 02:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE2821D56
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Mar 2020 02:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCACog convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Feb 2020 21:44:36 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:39290 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCACog (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Feb 2020 21:44:36 -0500
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id D4FCDCED13;
        Sun,  1 Mar 2020 03:54:01 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v1] bluetooth: guard against controllers sending zero'd
 events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <C59D3CDE-0EA8-4839-A34E-5ADA1BDE4949@gmail.com>
Date:   Sun, 1 Mar 2020 03:44:34 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <14FD24FA-1455-4FE4-832B-9851D9E22780@holtmann.org>
References: <20200228205146.161229-1-alainm@chromium.org>
 <788439D3-E0CC-4CBA-99C2-0B9C3703B23D@holtmann.org>
 <C59D3CDE-0EA8-4839-A34E-5ADA1BDE4949@gmail.com>
To:     Johan Hedberg <johan.hedberg@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,

>>> --- a/net/bluetooth/hci_event.c
>>> +++ b/net/bluetooth/hci_event.c
>>> @@ -5868,7 +5868,8 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
>>> 	u8 status = 0, event = hdr->evt, req_evt = 0;
>>> 	u16 opcode = HCI_OP_NOP;
>>> 
>>> -	if (hdev->sent_cmd && bt_cb(hdev->sent_cmd)->hci.req_event == event) {
>>> +	if (hdev->sent_cmd && event &&
>>> +	    bt_cb(hdev->sent_cmd)->hci.req_event == event) {
>> 
>> Why are you bothering to check for event here. Do we have requests set with hci_req.event == 0?
> 
> If I remember right, most requests are like that. req.event is only used then the request completes in something else than a command complete/status.

so what do we do then if we get an event == 0 from the controller? Just bail out early? It seems kind pointless to keep processing it.

Regards

Marcel

