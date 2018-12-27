Return-Path: <SRS0=UKt+=PE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0546C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Dec 2018 03:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8502148E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Dec 2018 03:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pb/uAbCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeL0DVZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:21:25 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:42935 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0DVY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Dec 2018 22:21:24 -0500
Received: by mail-pf1-f175.google.com with SMTP id 64so8559621pfr.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Dec 2018 19:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BbgnRf82Ay7tSMVbg8N23yF5iL3rfvOKiDcSWKr73lY=;
        b=pb/uAbClYV32AeZVRdMBpPJJeaE2jaVcYjTasE2z1AP11+pq3pd8GQInJp0fhYLJNA
         t3cRYMjnOxPj0y0z4cOKa8ltggM5CxDDbAxITvlXVv8eP8tCgH5jpGRWjUwii1XlSzuo
         RF3M2XupM4A9mLgI6cCmqS9Gv/NVC7xAP2mkn8inEBamHaXGGITJkXw7xQS35aq1dppa
         k5PXlSDWS1hCVBnbHxkL3gg6GKNpjdqZ3jh6Md3NI6QbPKnrGxJ1xK56erqYkgPXoETq
         rySaw8b1X/nIYFER8ekbxlR4vMGZNhWu1WtF7f8+fqvSbGisHON761BkRtK0Tw+A9TT9
         M48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BbgnRf82Ay7tSMVbg8N23yF5iL3rfvOKiDcSWKr73lY=;
        b=akAmQcKzYvOe+WybYJmrYex5MZHC4D80uPh8QNCMR9IrJxH0VdrOmY/ZX79FeA5pEf
         nRswS4QmVqbyuZU3mte/sVbIg4Rot1HZGTW1bq/yQmJjjh+2+ZMOi/E8s+/fhPaoBflX
         sNV2hM/iTY4KnMzc4lDNSa8KOqp73a+ZhqNG+/LsABgp7fbqNMxURAmZTjiRjbnINRyf
         5G+Dk/fqRYyiK9THtCcK5IddR6+konTwnRmaJvzEi3p7YU5o3LqhNcSIRks1dtQ/8r5s
         pQ4J4UOZp2+cmnxeVzYlXxsOnNZymBWAjkG6l6Tu+3mzxanKhwBml3tarUgEYCpF6ELC
         zItQ==
X-Gm-Message-State: AJcUukdbEzfPp+xEjPCST9STJbH+1J/4zEQs8EvZ967Y1SVidycCW+un
        dIIQcSNJKb6mrYfs1moF/tMBZoExbG8lRfh7lnX5YSRl
X-Google-Smtp-Source: ALg8bN7d5wh0/vq9l26PfdmbLM4bAQiYON6dwUScF7qxOx1uOi33CNAJ0RpcwPsRi6r+sHeG2dBvxKXhWvykObsoyFo=
X-Received: by 2002:a63:5a57:: with SMTP id k23mr21011805pgm.5.1545880883957;
 Wed, 26 Dec 2018 19:21:23 -0800 (PST)
MIME-Version: 1.0
From:   Andrey Batyiev <batyiev@gmail.com>
Date:   Thu, 27 Dec 2018 05:21:10 +0200
Message-ID: <CAEQQxWzdBy9JOC7+oQTBJ35Gov1CDk17fy+XH=jha8MuT9fy9Q@mail.gmail.com>
Subject: Bluetooth ECDH selftest failed (endianness issue?)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello everyone,

I'm trying to pair my MIPS based router with a phone (using bluez),
without success.
I have turned on debugging features of bluetooth kernel module and I
got this in dmesg:

[  234.481526] Bluetooth: Core ver 2.22
[  234.485231] Bluetooth: Starting self testing
[  234.525375] Bluetooth: ECDH sample 1 failed
[  234.529728] Bluetooth: Finished self testing

Also, I checked hcidump, and it seems that SMP "Pairing confirm"
command got rejected by the phone with an error ("Reason: Unspecified
Reason (0x08)").
As far as I understand, ECDH computation is involved in a pairing process.

However, my Linux desktop is able to successfully pair to the phone
(Ubuntu 18.04) via the same dongle, using same version of bluez.

The huge difference between my desktop and router is endianness:
router is big-endian, while desktop is little-endian. Maybe, that's
the case?

I'm not sure how to debug this, could you please advise?

Router specs:
CPU: QCA9531 (MIPS_24KC, big-endian)
Distro: OpenWRT git master
Linux: 4.14.88
BlueZ: 5.49
Bluetooth dongle: CSR8510 A10

Thanks,
  Andrey
