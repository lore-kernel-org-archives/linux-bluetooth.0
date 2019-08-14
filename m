Return-Path: <SRS0=WtLI=WK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2262C433FF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 18:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A2F206C1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Aug 2019 18:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfHNSz3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:55:29 -0400
Received: from vimdzmsp-mail02.bluewin.ch ([195.186.227.120]:58806 "EHLO
        vimdzmsp-mail02.bluewin.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727791AbfHNSz2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Aug 2019 14:55:28 -0400
X-Greylist: delayed 360 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 14:55:27 EDT
Received: from vimdzmsp-rich11.bluewin.ch ([195.186.122.144])
        by vimdzmsp-mail02.bluewin.ch Swisscom AG with SMTP
        id xyKrhS7C9yiKqxyKrhmVre; Wed, 14 Aug 2019 20:49:25 +0200
X-Bluewin-Spam-Analysis: v=2.1 cv=TfdbzUkh c=1 sm=1 tr=0
 a=U7DQdSofu78aJvAWM0d88Q==:117 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10
 a=FmdZ9Uzk2mMA:10 a=qhmI3J_UTh88eX6OXJUA:9 a=QEXdDO2ut3YA:10
X-Bluewin-Spam-Score: 0.00
Received: from vimdzmsp-rich11.bluewin.ch (localhost.bluewin.ch [127.0.0.1])
        by vimdzmsp-rich11.bluewin.ch (Postfix) with ESMTP id D975F204F7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Aug 2019 20:49:25 +0200 (CEST)
Date:   Wed, 14 Aug 2019 20:49:25 +0200 (CEST)
From:   "hans.w.kramer@bluewin.ch" <hans.w.kramer@bluewin.ch>
Reply-To: hans.w.kramer@bluewin.ch
To:     linux-bluetooth@vger.kernel.org
Message-ID: <1665860812.35399.1565808565891@bluewin.ch>
In-Reply-To: <515577254.15611.1565603370379@bluewin.ch>
References: <519900441.7067.1565432065454@bluewin.ch> <515577254.15611.1565603370379@bluewin.ch>
Subject: Bluetooth V. 5.50: "error updating services: Connection refused";,
 for unknown reason. This worked in v. 5.43
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Importance: 3 (Normal)
X-Priority: 3 (Normal)
X-FXIT-IP: IPv4[178.198.170.47] Epoch[1565808565889]
X-CMAE-Envelope: MS4wfLNVHELj2LjKcc3oPoZYzA+oknFGS10YtHv90p5bkFcsSTiC70u0pp7RkmUC+zfoBoNzwj0+fURo/VvBcsEzTSm/UvsmESIHpRUTnTcKRtZXBGq4p/UP
 VMCkjKsexIy8ie1/mVsuOhs/0v2l/QloCRwgZb6CsZgGMSCdtgYmaTh39cndmPR4d+VcW2OlN02uMqTkYJs9k2HASrQ5S0kFLYA=
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, 

I have the following problem with a bluetooth audio device (Cambridge Audio One ) in v. 5.50 which i do not have in v. 5.43.

Attempting to connect to XX:XX:XX:XX:XX:XX
[CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
[CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001108-0000-1000-8000-00805f9b34fb
[CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000110b-0000-1000-8000-00805f9b34fb
[CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000110c-0000-1000-8000-00805f9b34fb
[CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000110e-0000-1000-8000-00805f9b34fb
[CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000111e-0000-1000-8000-00805f9b34fb
[CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
Failed to connect: org.bluez.Error.Failed
[CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: no
[CHG] Device XX:XX:XX:XX:XX:XX Connected: no

Another bluetooth audio device (JBL GO) works ok in 5.43 and 5.50.

The following two btmon traces are available upon request:

1. V. 5.50, NOK: "cambridge_hcitrace.txt", OS Raspbian Buster Lite, Linux raspberrypi 4.19.57+ #1244 Thu Jul 4 18:42:50 BST 2019 armv6l GNU/Linux (77.7 KB)
2. V. 5.43, OK:  "stretch_cambridge_hcitrace.txt", OS Raspbian Stretch, Linux raspberrypi 4.14.98+ #1200 Tue Feb 12 20:11:02 GMT 2019 armv6l GNU/Linux (86.8 KB)

Note especially: "cambridge_hcitrace.txt", line 476: "Reason: Remote User Terminated Connection (0x13)".
There is no obvious reason, why this should occur. Timeout problem in the kernel?

Regards

Hans

PS: Almost the same happens with an up-to-date Fedora 30 (Bluetooth 5.50, Linux 5.2.6-200.fc30.x86_64 #1 SMP Mon Aug 5 13:20:47 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux)



