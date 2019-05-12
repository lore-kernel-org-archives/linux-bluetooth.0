Return-Path: <SRS0=5XQb=TM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54930C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 May 2019 05:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9D72146F
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 May 2019 05:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies-com.20150623.gappssmtp.com header.i=@colorremedies-com.20150623.gappssmtp.com header.b="hLmYFeC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfELFqJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 May 2019 01:46:09 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:33619 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfELFqJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 May 2019 01:46:09 -0400
Received: by mail-lf1-f53.google.com with SMTP id x132so6792137lfd.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2019 22:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=KigJgYaroWLxgxhbzgmxMc63R8INzm3v9syNtuRMtxY=;
        b=hLmYFeC0EOsRM/bHjjU/qWFplDBHlKVvaZFOgB+A1kD51QvwU0dJdqu/HWBhvfz90U
         r3DpcT1rbPcYzWccTybkfbRe4l8YRzvHQckbVvN202f/H8qu5iyzjVtxE7D3V9nG2c0P
         427mLS23WNTM+Ot9zWeJtRrimx1wFub6TKfAdKBKeCSYWn27MLfmqYVUmwtuaASHij7r
         1MArf4P1nxjj2bz6kMzDoX0QCzJRQCryuxUgaXc1vCaW4KKMbNSq4PwFq19mKLScaVQ5
         vg+WvfzGcRmAA3/jqg2qh6KPJ4YQmnXPnwg+hTbIAeg2RuOOW44bnyfIFIT7XBefVWVk
         zwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KigJgYaroWLxgxhbzgmxMc63R8INzm3v9syNtuRMtxY=;
        b=LAF/hx6r4suI+vWLARQvSqvCFZCDkcLagiFfXgS2gnhbJA6RIm7P3NPMfaCqAedqMm
         YbEpvqyE5gpLYdQUNTswmIQHPV/hLAySQy1U0O7S6PoYPfLhV+a6CsS0AChNLTwC0xMJ
         Kgi3Bsp79oVhrC8CSvhBlYCyIwXThtf1LUxlw511mgqA/zGdB19d92fGnv3RAbfgJnvC
         YdSeDO7uCThr650gXp6ulDvDe2TVJytQcL9M96e7mIkwvhBkXxYGNdH0rx6AtU5uy6XW
         QO5IgpmgcRp30k2RyUzjAIXkQ9f4oN8rZRaGro/kYVt3mwngyXJtA6QqSmkYci9u29nI
         FnTA==
X-Gm-Message-State: APjAAAUKHdUVaRvpSGpWPDwFG8smpYBTD0iAvAXzLfKfoVxUUaYLSQ1B
        01hZr5+vBCbUc9b5djaXP1SiX/QfjJ3cKWfttmGoEkDWa7E=
X-Google-Smtp-Source: APXvYqwpnl3DPEhtuLebCNXZ62SoQXOZmknNHIqmFQrCL7R9fx+1p4wB/honoRBPzEJzGGXKl4aQuaHxET/wOj5bMvA=
X-Received: by 2002:a19:189:: with SMTP id 131mr9909941lfb.74.1557639967001;
 Sat, 11 May 2019 22:46:07 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <chris@colorremedies.com>
Date:   Sat, 11 May 2019 22:45:55 -0700
Message-ID: <CAJCQCtTnoLGDByW+S4Cc311KzsSReH-_uNgtV5=pe_Fou5q9Zg@mail.gmail.com>
Subject: Apple magicmouse disconnects
To:     Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

kernel 5.1 (is not a regression, goes back to 4.9)

I get anywhere from 1 to 20 bluetooth mouse disconnects per hour, only
when booting Linux. When the same mouse and laptop running Windows 10,
the problem doesn't happen. But I can't tell from the kernel messages
if this is a problem with the mouse drive or the laptop bluetooth
driver. Is there a way to make this more verbose?

[ 1367.387984] flap.local kernel: magicmouse 0005:05AC:030D.0004:
unknown main item tag 0x0
[ 1367.388472] flap.local kernel: input: mouses as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:512/0005:05AC:030D.0004/input/input20
[ 1367.391109] flap.local kernel: magicmouse 0005:05AC:030D.0004:
input,hidraw2: BLUETOOTH HID v3.06 Mouse [mouses] on 00:c2:c6:f0:52:57


This bug suggests the mouse disconnects when its battery status is
polled by the kernel; if the mouse isn't polled by compiling without
CONFIG_HID_BATTERY_STRENGTH=y  then the problem doesn't happen. I can
try that if it's useful information, but I don't think that's the
proper fix. I think the battery polling needs to be fixed instead.
https://bugzilla.kernel.org/show_bug.cgi?id=103631


hci0:    Type: Primary  Bus: USB
    BD Address: 00:C2:C6:F0:52:57  ACL MTU: 1021:4  SCO MTU: 96:6
    UP RUNNING PSCAN
    RX bytes:15083 acl:0 sco:0 events:2439 errors:0
    TX bytes:600912 acl:0 sco:0 commands:2437 errors:0
    Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
    Link policy: RSWITCH SNIFF
    Link mode: SLAVE ACCEPT
    Name: 'flap.local'
    Class: 0x0c010c
    Service Classes: Rendering, Capturing
    Device Class: Computer, Laptop
    HCI Version: 4.2 (0x8)  Revision: 0x100
    LMP Version: 4.2 (0x8)  Subversion: 0x100
    Manufacturer: Intel Corp. (2)

Apple Magic Mouse (original, not the 2)


-- 
Chris Murphy
