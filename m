Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB3BC0015E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Aug 2023 09:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjHLJCZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Aug 2023 05:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbjHLJCY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Aug 2023 05:02:24 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89462E60
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Aug 2023 02:02:25 -0700 (PDT)
Received: from [192.168.0.185] (unknown [95.90.238.123])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E93C061E5FE03;
        Sat, 12 Aug 2023 11:02:05 +0200 (CEST)
Message-ID: <c69edd3b-bace-42a0-91e5-d8606a443853@molgen.mpg.de>
Date:   Sat, 12 Aug 2023 11:02:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: Firmware for MT7922 missing in initrd; bluetooth disabled after
 update
To:     =?UTF-8?Q?J=C3=BCrgen_Hofmann?= <hofmann@shiphrah.com>
Cc:     linux-bluetooth@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Qu Wenruo <wqu@suse.com>, Chris Lu <chris.lu@mediatek.com>
References: <8ddaee26-b4d7-f694-ac8b-2aaf4d3c5f8e@shiphrah.com>
Content-Language: en-US
In-Reply-To: <8ddaee26-b4d7-f694-ac8b-2aaf4d3c5f8e@shiphrah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[Cc: +Qu, +Chris]

Dear Jürgen,


Am 10.08.23 um 22:24 schrieb Jürgen Hofmann:

> I updated openSuse Tumbleweed 20230806 with a bluetooth keyboard 
> attached to the PC. After the update to 20230808 and rebooting bluetooth 
> was disabled and it was impossible to enable it again. Before the update 
> bluetooth was working fine.

Sorry, I do not know what software versions changed updating to openSUSE 
Tumbleweed. Could you please mention that for the Linux kernel and BlueZ 
and the initrd generator?

> The attached bluetooth keyboard caused the bluetooth module being added 
> to initrd. However, the corresponding firmware for MT7922 is not added.
> 
> dmesg shows:
> 
> [    4.368031] bluetooth hci0: Direct firmware load for mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin failed with error -2
> 
> In fact the file is present on the system
> 
> ls -l /usr/lib/firmware/mediatek/BT_RAM_CODE*
> -rw-r--r-- 1 root root 512104  3. Aug 17:36 /usr/lib/firmware/mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin.xz
> -rw-r--r-- 1 root root 343052  3. Aug 17:36 /usr/lib/firmware/mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin.xz
> 
> but missing in initrd
> 
> lsinitrd | grep BT_RAM_CODE
> -rw-r--r--   1 root     root       343052 Aug  3 17:36 usr/lib/firmware/mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin.xz
> 
> Manually adding the file to initrd makes bluetooth work again.
> 
> I reported the bug here
> https://bugzilla.suse.com/show_bug.cgi?id=1214133
> and was requested to report here.
> 
> If I can be of any help or you need further information please let me
> know.
 From Qu’s answer in the thread *[PATCH v3 1/2] Bluetooth: btusb: Add 
new VID/PID 0489/e102 for MT7922* [1] it sounds to me, support for chip 
was only added recently, and is going to be in Linux v6.6.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-bluetooth/8a261418-17ca-405f-b340-7e6634c169bc@suse.com/
