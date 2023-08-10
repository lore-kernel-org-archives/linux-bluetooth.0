Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF30C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 20:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjHJUdP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHJUdO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 16:33:14 -0400
X-Greylist: delayed 524 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 13:33:13 PDT
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [IPv6:2001:67c:2050:102:465::105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079522737
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 13:33:12 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4RMJLH5k9Cz9vSg;
        Thu, 10 Aug 2023 22:24:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiphrah.com;
        s=MBO0001; t=1691699063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cujtdTt9vm57nL92w5TpyhVxThZCrv9eYl7g4XDUGfI=;
        b=Yuv5PoSEASxMT/4Fplgs7+9PUz1c6AaaOjsvmXTkPRRyxiPXMvZHUVMiPA/9+bibWcip8f
        nRLhWi+nM3cxKe9Nd7RQ2NtYQvw3CSREOSyEJGIJq38HNik25nujf2/r/6QaG3CGOBfl0n
        kMW2TjqcBxwhKRMm4lOch3hPdrLodV8GHIVUMfWlmJdcnUb0LRjLPmjOaH5ovJyslhPv3a
        mWX66I/PM9WkfBWzW/zlbwZvRQjJCZ/CnZkZbGY32BS8OGlBxjeyqel56NLHrAiJGozSAU
        0xEscAc3EV4miAqBWbpqFmO6OyssjjWihJ5BhLofBinC7GvCQ/VX7BXPrI8pdQ==
Message-ID: <8ddaee26-b4d7-f694-ac8b-2aaf4d3c5f8e@shiphrah.com>
Date:   Thu, 10 Aug 2023 22:24:21 +0200
MIME-Version: 1.0
Content-Language: de-DE
From:   =?UTF-8?Q?J=c3=bcrgen_Hofmann?= <hofmann@shiphrah.com>
Subject: Firmware for MT7922 missing in initrd; bluetooth disabled after
 update
Organization: shiphrah GmbH
To:     linux-bluetooth@vger.kernel.org
Cc:     tiwai@suse.de
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi everybody,

I updated openSuse Tumbleweed 20230806 with a bluetooth keyboard 
attached to the PC. After the update to 20230808 and rebooting bluetooth 
was disabled and it was impossible to enable it again. Before the update 
bluetooth was working fine.

The attached bluetooth keyboard caused the bluetooth module being added 
to initrd. However, the corresponding firmware for MT7922 is not added.

dmesg shows:

[    4.368031] bluetooth hci0: Direct firmware load for 
mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin failed with error -2

In fact the file is present on the system

ls -l /usr/lib/firmware/mediatek/BT_RAM_CODE*
-rw-r--r-- 1 root root 512104  3. Aug 17:36 
/usr/lib/firmware/mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin.xz
-rw-r--r-- 1 root root 343052  3. Aug 17:36 
/usr/lib/firmware/mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin.xz

but missing in initrd

lsinitrd | grep BT_RAM_CODE
-rw-r--r--   1 root     root       343052 Aug  3 17:36 
usr/lib/firmware/mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin.xz

Manually adding the file to initrd makes bluetooth work again.

I reported the bug here
https://bugzilla.suse.com/show_bug.cgi?id=1214133
and was requested to report here.

If I can be of any help or you need further information please let me know.

Thanks and kind regards

Jürgen
