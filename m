Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3404CC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 19:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8D8611C2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Apr 2021 19:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244475AbhDPT6H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:58:07 -0400
Received: from mout01.posteo.de ([185.67.36.65]:43293 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244367AbhDPT6G (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Apr 2021 15:58:06 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 45F37240029
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 21:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1618603059; bh=3yzy215IycUe6EtG/3F2CBzelo/7OEe17yVAwtiEEPM=;
        h=To:From:Subject:Date:From;
        b=Z/TGfbBP6ce2T8oFG9o4wdt7mF5wFqsZayAm/2qBy97ofdpt/tk8MvMn4CxhgMSBa
         PE3AHMOMXwMPMahYqfsnDVynEVGVtLfm9KdDyMfMTRQFpXFGkCEUKv5bBiOmOFi3hI
         cXcsCKKch7B5//k2rbVF4zyiux58/BfU4wpgAnGnrHkLKOKfKXn8eAFFCuTbI+fDQN
         OWpXDjXbT/UKWpaIvnZ8/vuzbwyLyTIu246CoG8Ds3HsVsSAO20d5qqPnf6EE0xO2o
         3cghB0zgZ7aM9XzMaULzg33kzwUGS/inXUc4f7ELdZ5UXyFS+FMCVgC3kaiQ1Oj+jf
         lf54BM3mOUE9A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FMRnt6FQJz9rxK
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Apr 2021 21:57:38 +0200 (CEST)
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From:   "mailinglisten@posteo.de" <mailinglisten@posteo.de>
Subject: =?UTF-8?Q?bt_keyboard_won=c2=b4t_connect?=
Message-ID: <3b645cc1-80c0-63a5-b283-57e101972456@posteo.de>
Date:   Fri, 16 Apr 2021 19:57:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Dear List,

I have an iPazzport bt mini keyboard that won´t connect.

Bluez is version 5.58, kernel 5.11.11.

Below I put the output from btmon.
The battery in the keyboard is charged, checked twice.

BT adapter is an onboard Qualcomm/Atheros 0cf3:e500 device in a laptop.

Could it be, the adapter needs to be put in HID mode?
How can I find out, what mode the adapter uses? I could not see in lsusb
-v what mode the adapter uses.

Below I put btmon output,
the same output as screen shot, more eye friendly there:
https://ibb.co/NZC3zKD

Thanks a lot in advance !

~$ btmon
Bluetooth monitor ver 5.58
= Note: Linux version 5.11.11-1.tpad (x86_64)

             0.070249
= Note: Bluetooth subsystem version 2.22

             0.070257
= New Index: 00:F4:8D:C9:40:5E (Primary,USB,hci0)

      [hci0] 0.070261
= Open Index: 00:F4:8D:C9:40:5E

      [hci0] 0.070269
= Index Info: 00:F4:8D:C9:40:5E (Qualcomm)

      [hci0] 0.070273
@ MGMT Open: bluetoothd (privileged) version 1.19

    {0x0001} 0.070278
= bluetoothd: profiles/input/device.c:ioctl_is_connected() Can't get
HIDP connection info
                46.562408
< HCI Command: Create Connection (0x01|0x0005) plen 13

  #1 [hci0] 46.562467
        Address: 54:46:6B:01:99:DA (Shenzhen CZTIC Electronic Technology
Co., Ltd)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4

  #2 [hci0] 46.565296
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11

  #3 [hci0] 51.687430
        Status: Page Timeout (0x04)
        Handle: 2
        Address: 54:46:6B:01:99:DA (Shenzhen CZTIC Electronic Technology
Co., Ltd)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
@ MGMT Event: Connect Failed (0x000d) plen 8

{0x0001} [hci0] 51.687500
        BR/EDR Address: 54:46:6B:01:99:DA (Shenzhen CZTIC Electronic
Technology Co., Ltd)
        Status: Connect Failed (0x04)
= bluetoothd: profiles/input/device.c:control_connect_cb() connect to
54:46:6B:01:99:DA: Host is down (112)
               51.688047

