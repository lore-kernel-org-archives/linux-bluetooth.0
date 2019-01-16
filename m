Return-Path: <SRS0=3VKx=PY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6118DC43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jan 2019 06:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392AD20840
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jan 2019 06:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387510AbfAPGfl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:35:41 -0500
Received: from gesmail.globaledgesoft.com ([123.63.243.152]:33883 "EHLO
        gesmail.globaledgesoft.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730938AbfAPGfl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jan 2019 01:35:41 -0500
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2019 01:35:40 EST
Received: from mail.globaledgesoft.com (mail.globaledgesoft.com [172.16.2.30])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by gesmail.globaledgesoft.com (Postfix) with ESMTP id F175E7C8597;
        Wed, 16 Jan 2019 11:53:21 +0530 (IST)
Received: from mail.globaledgesoft.com (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTPS id 99C2CB80880;
        Wed, 16 Jan 2019 11:59:51 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
        by mail.globaledgesoft.com (Postfix) with ESMTP id 61A21B80879;
        Wed, 16 Jan 2019 11:59:51 +0530 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mail.globaledgesoft.com
Received: from mail.globaledgesoft.com ([127.0.0.1])
        by localhost (mail.globaledgesoft.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F124_1OeNroo; Wed, 16 Jan 2019 11:59:51 +0530 (IST)
Received: from mail.globaledgesoft.com (mail.globaledgesoft.com [172.16.2.30])
        by mail.globaledgesoft.com (Postfix) with ESMTP id C2730B80722;
        Wed, 16 Jan 2019 11:59:50 +0530 (IST)
Date:   Wed, 16 Jan 2019 11:59:48 +0530 (IST)
From:   Ramya BM <m.ramya@globaledgesoft.com>
To:     Petr Kazda <Petr.Kazda@konicaminolta.cz>
Cc:     linux-bluetooth@vger.kernel.org
Message-ID: <73493293.9326732.1547620188512.JavaMail.zimbra@globaledgesoft.com>
In-Reply-To: <1037851944.9325328.1547620149906.JavaMail.zimbra@globaledgesoft.com>
References: <909a3877987d4e1d917e365f7d1eb603@KMLEXC66.kme.intern>
Subject: Re: Bluez4 HSP problems -> backporting of Bluez5 to Ubuntu 12.04
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.2.30]
X-Mailer: Zimbra 8.5.1_GA_3056 (ZimbraWebClient - GC67 (Linux)/8.5.1_GA_3056)
Thread-Topic: Bluez4 HSP problems -> backporting of Bluez5 to Ubuntu 12.04
Thread-Index: AdSow7Xpa/A3NgioSxqdDhtpMSmNNc01zvIx
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Petr,


>> Now to the main question. Is it possible to backport Bluez5 to Ubuntu 12.04? We do not need the GUI elements, just the basic modules (BLE, HID, audio).


Yes it is possible to configure bluez5 on ubuntu 12.04.


 
Regards, 
Ramya


----- Original Message -----
From: "Petr Kazda" <Petr.Kazda@konicaminolta.cz>
To: linux-bluetooth@vger.kernel.org
Sent: Thursday, 10 January, 2019 15:05:19
Subject: Bluez4 HSP problems -> backporting of Bluez5 to Ubuntu 12.04

Dear Bluez developers,
we have a product that is currently build using OMAP4 platform with Ubuntu 12.04 (armhf build) running on it. Due to various reasons the upgrade to more recent version of Linux is not possible (mainly because TI does not provide updated OS image and sources for proprietary drivers).

So we are stuck with Bluez 4.101 (latest available version built from sources).

We have been testing compatibility with two Bluetooth headsets - Jabra Steel and Plantronics Explorer 55. Neither of these works in HSP mode, Plantronics does not work even in A2DP. We are using Edimax EW-7611ULB dongle.

More specifically Jabra works in A2DP, in HSP it does not show any errors anywhere, but it simply does not transfer any sound in or out. Plantronics does not work in A2DP (there is message like failed to acquire transport bluez_XXXXXXXX from pulseaudio), in HSP it throws error in btusb module. I tried every possible workaround found on the internet, tweaked the settings back and forth, tried different combinations, but no luck. I came to the conclusion that it might be somehow connected with SCO packets routing, but at this point I do not see any way how to move further by myself.

I tested both devices with more recent Ubuntu 18.04 with the same Edimax dongle, same drivers and both headsets work without issues, so it seems that the culprit outdated Bluez. 

Now to the main question. Is it possible to backport Bluez5 to Ubuntu 12.04? We do not need the GUI elements, just the basic modules (BLE, HID, audio). If it is theoretically possible, is there anyone willing to do it (even as a paid job)?

Thank you.

Petr
Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.

