Return-Path: <SRS0=sF93=VF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54563C606AF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 13:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF8E2087F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Jul 2019 13:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfGHNJL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:09:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:58144 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbfGHNJL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 09:09:11 -0400
Received: from [192.168.0.77] (apn-37-247-209-172.dynamic.gprs.plus.pl [37.247.209.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0A0AFCF18A;
        Mon,  8 Jul 2019 15:17:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Fix endianness bug in hci_core.c
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAEQQxWxQ9A6D+jdc8hVjBjgGbvBovJFxEf7K9Rta+O4noRmSFg@mail.gmail.com>
Date:   Mon, 8 Jul 2019 15:09:08 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <167BCA9E-1BBD-48D9-965B-97AD49A2FB5C@holtmann.org>
References: <CAEQQxWxQ9A6D+jdc8hVjBjgGbvBovJFxEf7K9Rta+O4noRmSFg@mail.gmail.com>
To:     Andrey Batyiev <batyiev@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

> I'm using Linux on big endian CPU (one of MIPS-based home routers).
> Also, I'm trying to use Cypress CYW20704A2 USB-Bluetooth dongle on it.
> However, `hciconfig hci0 up` failed, and `btmon` showed very specific problem:
> 
> 
> 
> < HCI Command: LE Write Suggested Default Data Length (0x08|0x0024) plen 4
>        TX octets: 64256
>        TX time: 18440
>> HCI Event: Command Complete (0x0e) plen 4
>      LE Write Suggested Default Data Length (0x08|0x0024) ncmd 1
>        Status: Invalid HCI Command Parameters (0x12)
> 
> 
> 
> After comparing with similar log on the Linux desktop (where TX octets
> value is `251`), I came to conclusion that it's an endianness problem,
> therefore here is a patch that fixes it.
> 
> Thanks,
>    Andrey
> 
> --- linux-4.14.104-old/net/bluetooth/hci_core.c 2019-07-07
> 23:39:44.069862824 +0000
> +++ linux-4.14.104/net/bluetooth/hci_core.c     2019-07-07
> 22:43:21.291838543 +0000
> @@ -802,8 +802,8 @@
>       if (hdev->le_features[0] & HCI_LE_DATA_LEN_EXT) {
>               struct hci_cp_le_write_def_data_len cp;
> 
> -               cp.tx_len = hdev->le_max_tx_len;
> -               cp.tx_time = hdev->le_max_tx_time;
> +               cp.tx_len = cpu_to_le16(hdev->le_max_tx_len);
> +               cp.tx_time = cpu_to_le16(hdev->le_max_tx_time);
>               hci_req_add(req, HCI_OP_LE_WRITE_DEF_DATA_LEN, sizeof(cp), &cp);
>       }

good catch, but please send a git-format-patch created patch. And following the submitting patches guide. Thanks.

Regards

Marcel

