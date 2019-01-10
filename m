Return-Path: <SRS0=Rbfz=PS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCCBC43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AAD214DA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Jan 2019 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfAJJmJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:42:09 -0500
Received: from mx-relay45-hz1.antispameurope.com ([94.100.133.221]:46800 "EHLO
        mx-relay45-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727968AbfAJJmJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Jan 2019 04:42:09 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 04:42:08 EST
Received: from unknown ([193.201.169.249]) by mx-relay45-hz1.antispameurope.com;
 Thu, 10 Jan 2019 10:35:25 +0100
Received: from KMLEXC66.kme.intern (10.120.237.251) by KMLEXC65.kme.intern
 (10.120.236.251) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 10 Jan
 2019 10:35:19 +0100
Received: from KMLEXC66.kme.intern ([fe80::4193:55fc:3d0a:1908]) by
 KMLEXC66.kme.intern ([fe80::4193:55fc:3d0a:1908%14]) with mapi id
 15.00.1367.000; Thu, 10 Jan 2019 10:35:19 +0100
From:   "Kazda, Petr" <Petr.Kazda@konicaminolta.cz>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bluez4 HSP problems -> backporting of Bluez5 to Ubuntu 12.04
Thread-Topic: Bluez4 HSP problems -> backporting of Bluez5 to Ubuntu 12.04
Thread-Index: AdSow7Xpa/A3NgioSxqdDhtpMSmNNQ==
Date:   Thu, 10 Jan 2019 09:35:19 +0000
Message-ID: <909a3877987d4e1d917e365f7d1eb603@KMLEXC66.kme.intern>
Accept-Language: cs-CZ, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.120.236.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-cloud-security-sender: petr.kazda@konicaminolta.cz
X-cloud-security-recipient: linux-bluetooth@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay45-hz1.antispameurope.com with D2B7318096A
X-cloud-security-connect: unknown[193.201.169.249], TLS=1, IP=193.201.169.249
X-cloud-security: scantime:.3027
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Bluez developers,
we have a product that is currently build using OMAP4 platform with Ubuntu 12.04 (armhf build) running on it. Due to various reasons the upgrade to more recent version of Linux is not possible (mainly because TI does not provide updated OS image and sources for proprietary drivers).

So we are stuck with Bluez 4.101 (latest available version built from sources).

We have been testing compatibility with two Bluetooth headsets - Jabra Steel and Plantronics Explorer 55. Neither of these works in HSP mode, Plantronics does not work even in A2DP. We are using Edimax EW-7611ULB dongle.

More specifically Jabra works in A2DP, in HSP it does not show any errors anywhere, but it simply does not transfer any sound in or out. Plantronics does not work in A2DP (there is message like failed to acquire transport bluez_XXXXXXXX from pulseaudio), in HSP it throws error in btusb module. I tried every possible workaround found on the internet, tweaked the settings back and forth, tried different combinations, but no luck. I came to the conclusion that it might be somehow connected with SCO packets routing, but at this point I do not see any way how to move further by myself.

I tested both devices with more recent Ubuntu 18.04 with the same Edimax dongle, same drivers and both headsets work without issues, so it seems that the culprit outdated Bluez. 

Now to the main question. Is it possible to backport Bluez5 to Ubuntu 12.04? We do not need the GUI elements, just the basic modules (BLE, HID, audio). If it is theoretically possible, is there anyone willing to do it (even as a paid job)?

Thank you.

Petr
