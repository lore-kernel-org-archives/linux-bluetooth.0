Return-Path: <SRS0=OdH+=QI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EF4C282D8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Feb 2019 21:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D144F2146E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Feb 2019 21:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfBAVUp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:20:45 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51533 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbfBAVUp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Feb 2019 16:20:45 -0500
Received: from [10.4.103.96] (dd5fb4620.static.telenet.be [213.251.70.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 19E17201353433;
        Fri,  1 Feb 2019 22:20:42 +0100 (CET)
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Bluetooth: hci0: last event is not cmd complete (0x0f) with LG TV
Message-ID: <47c0a63f-a8d8-17bb-64df-65455da2ea7c@molgen.mpg.de>
Date:   Fri, 1 Feb 2019 22:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear Linux folks,


When trying to pair a Dell Latitude E7250 running Debian Sid/unstable 
with Linux 4.20 and GNOME 3.30 with an LG TV, after starting the pairing 
process the TV is listed. in Bluetooth dialog of GNOME setting.

The TV displays the instructions below.

> Complete the next three steps on your mobile device:
> 1. Turn ON Bluetooth.
> 2. Select the TV name from the list of available devices.
>    • TV Name : 679
> 3. Confirm the connection request.

Selecting the TV in the GNOME dialog, a dialog is shown on my system 
with a PIN consisting of six numbers. With the dialog, Linux logs the 
message below.

      Bluetooth: hci0: last event is not cmd complete (0x0f)

But, the TV does not show any PIN. Confirming it anyway, nothing is 
happening further.

Is that supposed to work? It’d be great if you helped me to set this up.


Kind regards,

Paul
