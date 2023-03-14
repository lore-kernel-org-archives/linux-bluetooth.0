Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C08C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 02:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjCNCX3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 22:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCNCX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 22:23:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEE1943AC
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 19:23:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so4554117pjv.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1678760589;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+ti7xtOyzbfbzi8W+LnBqEFYIptcyP15udw4waHm+8=;
        b=S0mqIpFakAADmRsTKaJ07UEONP/orYcVRu9MB7I5lCuFK/kK6fXsKOmjovSi91yENe
         lHF97Pv7+btZbdaoDUWPfMLAamXQruwvpaefJhhF9VFUFo/xC4xe4UW+d5WZyrntxerx
         vSLDNYIuFTkoGdiy1/7i5sE20H1sNTn/gtEshKFTPUBOx0SMiaetmUdS1PbHzEblOumv
         nySj0SHPGQks1ebreocuE8P3CieSEeSjClvgpUjJZQZu9qqTPxxqMyGFY2JePtmgCc3B
         MiuuYw03vuTf6lo8ZLpcPuEe1cz1AAVqKc1ZyXK/cWjbZiJUxdzqn6LSEffBzq0VB1iK
         LqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678760589;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5+ti7xtOyzbfbzi8W+LnBqEFYIptcyP15udw4waHm+8=;
        b=J6HgpsLNPhpi/nY5BnrRn7+2tOsQ04Pgx2cUNhslZu2t0oUhYqgiYC2N66cGLeDZ90
         cu5pA4P9U7L2PnUlpgE21880kP3T7rPcBUWUg6StLjCqsNldKqYSw80uISvNHfiG+qOl
         XeisFR2lYJObEq+ySDCKLsK7vIqIUsXCK1hYcGKvKaDLW5or6FDNSyxlRlLPCiQWbLQA
         yViVb1QtsNOPNjcQv82p2SCDJfbZcdv6s4a6QiTFrKYsoqy+WYelfpqBVr+D/1maCnz+
         Dwfcqz5DgR8H+R7ikDBQpGE0Fe9vXYZq8shrWfoTAdYFnn4srz7i4P6L56FvSkIXiei2
         fOpA==
X-Gm-Message-State: AO0yUKX6/tXruViaBoVwPng/7zJCWWtxKjwpQ6tE5m9oIqCacKQ+9V52
        Wb+3qy8cffAFSCIHmNJl3SvFyra0voQGclt2Cu8=
X-Google-Smtp-Source: AK7set/9Xa/SCadlNTOOZE2rxRR3Ua8zw/Vwop6qAkpvpHCNkv4b5oSxNdZgiYZjmFrmW8AavS0njw==
X-Received: by 2002:a05:6a20:6a0e:b0:cb:c6f4:62fd with SMTP id p14-20020a056a206a0e00b000cbc6f462fdmr36886390pzk.18.1678760589020;
        Mon, 13 Mar 2023 19:23:09 -0700 (PDT)
Received: from [192.168.1.12] ([171.249.149.49])
        by smtp.gmail.com with ESMTPSA id o1-20020a655bc1000000b00502dc899394sm370008pgr.66.2023.03.13.19.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 19:23:08 -0700 (PDT)
Message-ID: <af4f9118-a189-e353-8cf6-65cabceff3e0@kali.org>
Date:   Tue, 14 Mar 2023 09:23:05 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
Cc:     hildawu@realtek.com, steev@kali.org
From:   Arnaud Rebillout <arnaudr@kali.org>
Subject: RTL8761B BT USB has been broken for a while (mismatched firmware?)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

let me forward an issue that was reported on the Kali Linux bugtracker a 
short
while ago. It's about a USB bluetooth 5.0 dongle which uses Realtek RTL8761B
chip. When the dongle is plugged in, everything looks good in the kernel 
logs,
however the dongle is not functional at all.

Several users reported the issue on various bug trackers:
- 2021-09: https://bugzilla.kernel.org/show_bug.cgi?id=214287
- 2022-04: 
https://bugs.launchpad.net/ubuntu/+source/linux-firmware/+bug/1968604
- 2023-03: https://bugs.kali.org/view.php?id=8216

All of them confirm that the wrong firmware is loaded. Let me explain.

So there are two firmware for this chip: rtl8761b and rtl8761bu. They were
added to linux-firmware back in 2021-06-09, as can be seen with:

   cd linux-firmware
   gitk -- 'rtl_bt/rtl8761b*' &

However at the time, only the firmware rtl8761b was in use. But it worked.
Then on 2021-06-26, a change made it so that the firmware rtl8761b is 
used only
for UART, and rtl8761bu is used for USB. Cf:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9fd2e294

And since then, we have the bug reports above. Users all agree that it 
doesn't
work, but there is a workaround: if they use the firmware rtl8761b 
(instead of
rtl8761bu), it works.

So I wonder if the two firmware are just reversed. After all, the suffix 'u'
was maybe meant for 'UART' and not 'USB', there's room for confusion.

I'm CC-ing Hilda Wu as they are the last person who updated those 
firmware, and
given their email address ('@realtek.com'), they probably are in a good
position to give it a quick check.

For completeness, here are the kernel logs that show up when the dongle is
plugged in (taken from the Kali Linux bug report):

   [81435.017653] usb 2-5: new full-speed USB device number 14 using 
ohci-pci
   [81435.257246] usb 2-5: New USB device found, idVendor=0bda, 
idProduct=8771, bcdDevice= 2.00
   [81435.257264] usb 2-5: New USB device strings: Mfr=1, Product=2, 
SerialNumber=3
   [81435.257272] usb 2-5: Product: Bluetooth Radio
   [81435.257278] usb 2-5: Manufacturer: Realtek
   [81435.257283] usb 2-5: SerialNumber: 00E04C239987
   [81435.267263] Bluetooth: hci0: RTL: examining hci_ver=0a 
hci_rev=000b lmp_ver=0a lmp_subver=8761
   [81435.270241] Bluetooth: hci0: RTL: rom_version status=0 version=1
   [81435.270253] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
   [81435.270391] bluetooth hci0: firmware: direct-loading firmware 
rtl_bt/rtl8761bu_fw.bin
   [81435.270459] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
   [81435.270509] bluetooth hci0: firmware: direct-loading firmware 
rtl_bt/rtl8761bu_config.bin
   [81435.270567] Bluetooth: hci0: RTL: cfg_sz 25, total sz 29949
   [81435.656295] Bluetooth: hci0: RTL: fw version 0x0ca98a6b
   [81435.795713] Bluetooth: MGMT ver 1.22

Thanks for your attention, please CC me as I'm not subscribed to this list.


-- 
Arnaud Rebillout / Offensive Security / Kali Linux Developer
