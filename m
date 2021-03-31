Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B48C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 14:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23A66101A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Mar 2021 14:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhCaOw5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Mar 2021 10:52:57 -0400
Received: from mout01.posteo.de ([185.67.36.65]:40884 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236150AbhCaOw1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Mar 2021 10:52:27 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E79CC160060
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 16:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1617202344; bh=4aC9n+dKvjuk1et3+AXjg52lIFKE+uYdKzvlT8scPRE=;
        h=To:From:Subject:Date:From;
        b=HGpaamuaMpynLmm2Z5vfmqt0mu0Cq3Tt7zD4shWAUD0Csp7MzCfDtvUg6qQumkIZp
         sHOFJR9xpxpBe7d5+fAz6PO8RMW23RsKyKhlFan0snRWIg+GQ7QB0n8eoWf9OL2ezF
         2QgFoc78GPtsAj4aCmnCftTSYyMflK/fxC4zDMBZR1+/A1+ShFmSJxZSWunrOHHnzS
         td7L7W7cNbtbigGvX/6iM1pEzwJAgDEoJ/TAbO6EZmY9cZFqiEAe4pfdP/MzTmi1Qq
         VkMmFuDLTRWgLXsIPnl9K5l4EI8bFOTUV44/8d8pi5sR0fs87TM3qTIuPL66c6XpXv
         44csyLxv5dYcA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4F9Tn439m3z6tmD
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Mar 2021 16:52:24 +0200 (CEST)
To:     linux-bluetooth@vger.kernel.org
From:   "mailinglisten@posteo.de" <mailinglisten@posteo.de>
Subject: cannot get a2dp profile enabled
Message-ID: <e2fb3695-5596-18c7-0bf1-fc701ba780f8@posteo.de>
Date:   Wed, 31 Mar 2021 16:52:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

I hope this is the place to ask for user questions, bluez.org offers no
other mailing list....

I have a Jabra headphone/headset device and pulseaudio can´t activate
the a2dp_sink, I want to be sure, A2DP is properly enabled in bluez.

bluetoothctl info MAC-OF-HEADPHONE says:

UUID: Advanced Audio Distribu.. (0000110d-0000-1000-8000-00805f9b34fb)

Thus, the device supports a2dp.

At the bottom I put output from "show CONTROLLER-MAC".

I tried

register-service 0000110d-0000-1000-8000-00805f9b34fb

to no avail, still no a2dp_sink in pulseaudio.

How can I ensure using bluetoothctl that a2dp is really enabled in bluez?

I´m not sure, if I deal with a bluetooth or pulseaudio issue, I want to
exclude a misconfigured bt device.

I´m using bluez 5.48 and kernel 5.11.3.

Thank you very much in advance!



This is the output from bluetoothctl show CONTROLLER-MAC:


Controller 00:F4:8D:C9:40:5E (public)
        Name: foobar
        Alias: onboard
        Class: 0x007c010c
        Powered: yes
        Discoverable: no
        Pairable: yes
        UUID: Message Notification Se..
(00001133-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control
(0000110e-0000-1000-8000-00805f9b34fb)
        UUID: OBEX Object Push
(00001105-0000-1000-8000-00805f9b34fb)
        UUID: Message Access Server
(00001132-0000-1000-8000-00805f9b34fb)
        UUID: IrMC Sync
(00001104-0000-1000-8000-00805f9b34fb)
        UUID: PnP Information
(00001200-0000-1000-8000-00805f9b34fb)
        UUID: Vendor specific
(00005005-0000-1000-8000-0002ee000001)
        UUID: Headset AG
(00001112-0000-1000-8000-00805f9b34fb)
        UUID: A/V Remote Control Target
(0000110c-0000-1000-8000-00805f9b34fb)
        UUID: Headset
(00001108-0000-1000-8000-00805f9b34fb)
        UUID: Phonebook Access Server
(0000112f-0000-1000-8000-00805f9b34fb)
        UUID: Audio Sink
(0000110b-0000-1000-8000-00805f9b34fb)
        UUID: Generic Access Profile
(00001800-0000-1000-8000-00805f9b34fb)
        UUID: Generic Attribute Profile
(00001801-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree Audio Gateway
(0000111f-0000-1000-8000-00805f9b34fb)
        UUID: Audio Source
(0000110a-0000-1000-8000-00805f9b34fb)
        UUID: OBEX File Transfer
(00001106-0000-1000-8000-00805f9b34fb)
        UUID: Handsfree
(0000111e-0000-1000-8000-00805f9b34fb)
        Modalias: usb:v1D6Bp0246d0530
        Discovering: no

