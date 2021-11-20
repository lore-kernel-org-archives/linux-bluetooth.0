Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Nov 2021 12:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbhKTMa3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Nov 2021 07:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhKTMa2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Nov 2021 07:30:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896AC061574
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 04:27:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i5so23127265wrb.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Nov 2021 04:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=0yVyHhwMyG5w2QIf7rUI09FwosPiE+aqr4nKlqMiBzs=;
        b=SCrJXi4lbf+Vk2j+tHxo7DlaH0qrkpwqPMRuP3gFUX/EmPYgOcFdFwhv+037DbHrcv
         UWoivUy+p3/Ufuu20dppotTb+ECmxVkc2gba+yVRQXeE7RAdIkvwvC/ipq4uJhuZj+Bv
         etLYRO1Yiefs+9hn+x9jSeyN/pfo2091cksBNVoSL4iCz0Npro868TUbIXh7Bxfx3DNV
         LG2uEBtNHL6HexBjNQGHoYmLK/I7NsEz1a7my7kfgZVzUSGjqi+8hAgb10Yn/eXRZimo
         7kiL5oxaPJe3+aZYz2SQV+CNxSq9AzRfkW8wep6uKBb1AYSn/eoBr2SfbEvRXKn67cVk
         0u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=0yVyHhwMyG5w2QIf7rUI09FwosPiE+aqr4nKlqMiBzs=;
        b=GIrszlJKzakxj2MroX7ub4kUYtUIIOSeziZOIfOgY8GjulzxkbV1/ZdmULHags32aO
         728VZwBXR32E21wOxD8MRnwrMiLLTyUGiYti/IJZ3zN7QXRDd7coaAPH+I2O0x4Wicz8
         MlQ/75lVMzMLZKooOxyYgn/saY+IB7zYoMxHaqFmRFWbMWidMBo4lHOgU6wAme5mSfiG
         rdiNp69wbjPhh46Xus74/wUomicEBXZkEdB4p7GERXlouOCz+10HWjtHNIRXUCqvqkoG
         7uX4u0FipNOK66IvCdde+v2fezqO+htK4hrkPAxy+h3e41WqgHJ+4c+poAB7YwPjvSqI
         xyJw==
X-Gm-Message-State: AOAM531oJvCDAclePXStMF+27kkVtD//2qzWcXy5sMn0JGalAbu38LUV
        i7SwnT3jy3FDyXW+NiQFBWpFeDoFjPIuNg==
X-Google-Smtp-Source: ABdhPJzMkAg7StWhl5MWV4pla/n8FUTJL54/nJZIbKCMMvw/HNKZkU+OWHinVmR0xgGfXFFs1Rzfug==
X-Received: by 2002:adf:f7c2:: with SMTP id a2mr17792939wrq.71.1637411243382;
        Sat, 20 Nov 2021 04:27:23 -0800 (PST)
Received: from ?IPV6:2a02:908:1980:7720::d962? ([2a02:908:1980:7720::d962])
        by smtp.gmail.com with ESMTPSA id o5sm2574424wrx.83.2021.11.20.04.27.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Nov 2021 04:27:22 -0800 (PST)
Message-ID: <23143ae3-1a00-8e77-c66c-ad0e473585bb@gmail.com>
Date:   Sat, 20 Nov 2021 13:27:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     linux-bluetooth@vger.kernel.org
From:   Julian Sikorski <belegdol@gmail.com>
Subject: No sound when connecting Sennheiser M2 AEBT for the first time since
 Fedora 35 upgrade
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

since I upgraded to Fedora 35, am having the following issue with my 
Sennheiser M2 AEBT headphones: upon first connection, the audio will not 
play. I have to go to gnome-control-center, disconnect and reconnect the 
headset, then audio plays normally. The following can be found in the log:

Nov 20 12:48:34 snowball3 kernel: input: MOMENTUM M2 AEBT (AVRCP) as 
/devices/virtual/input/input19

Nov 20 12:48:35 snowball3 bluetoothd[10741]: 
src/service.c:btd_service_connect() a2dp-sink profile connect failed for 
00:1B:66:81:8D:76: Device or resource busy

Nov 20 12:48:35 snowball3 bluetoothd[10741]: 
profiles/audio/avdtp.c:avdtp_parse_rej() OPEN request rejected: Bad 
State (49)

Nov 20 12:48:35 snowball3 wireplumber[1924]: failed to switch codec 
(-19), setting fallback profile

Nov 20 12:49:00 snowball3 wireplumber[1924]: Transport Acquire() failed 
for transport /org/bluez/hci0/dev_00_1B_66_81_8D_76/sep1/fd3 (Did not 
receive a reply. Possible causes include: the remote application did not 
send a reply, the message bus security policy blocked the reply, the 
reply timeout expired, or the network connection was broken.)

Nov 20 12:49:00 snowball3 wireplumber[1924]: 0x561f089d5bf8: can't send 
command 2: Eingabe-/Ausgabefehler

Nov 20 12:49:00 snowball3 wireplumber[1924]: 
(bluez_output.00_1B_66_81_8D_76.a2dp-sink-18) suspended -> error (Start 
error: Eingabe-/Ausgabefehler)

Nov 20 12:49:00 snowball3 wireplumber[1924]: unknown AT+IPHONEACCEV 
key:2 value:0

Nov 20 12:49:00 snowball3 wireplumber[1924]: Transport Acquire() failed 
for transport /org/bluez/hci0/dev_00_1B_66_81_8D_76/sep1/fd3 (Operation 
Not Authorized)

Nov 20 12:49:00 snowball3 wireplumber[1924]: 0x561f089d5bf8: can't send 
command 2: Eingabe-/Ausgabefehler

Nov 20 12:49:00 snowball3 wireplumber[1924]: Transport Acquire() failed 
for transport /org/bluez/hci0/dev_00_1B_66_81_8D_76/sep1/fd3 (Operation 
Not Authorized)

Nov 20 12:49:00 snowball3 wireplumber[1924]: 0x561f089d5bf8: can't send 
command 2: Eingabe-/Ausgabefehler

Nov 20 12:49:23 snowball3 kernel: Bluetooth: hci0: Ignoring error of 
Inquiry Cancel command

Nov 20 12:49:24 snowball3 bluetoothd[10741]: 
/org/bluez/hci0/dev_00_1B_66_81_8D_76/sep1/fd4: fd(42) ready

Nov 20 12:49:24 snowball3 wireplumber[1924]: set volume 94 failed for 
transport /org/bluez/hci0/dev_00_1B_66_81_8D_76/sep1/fd4 (No such 
property 'Volume')

Nov 20 12:49:24 snowball3 kernel: input: MOMENTUM M2 AEBT (AVRCP) as 
/devices/virtual/input/input20

Nov 20 12:49:29 snowball3 wireplumber[1924]: unknown AT+IPHONEACCEV 
key:2 value:0

Nov 20 12:56:34 snowball3 wireplumber[1924]: 
<WpDefaultProfile:0x561f0874c260> failed to get current profile on 
device: pipewire proxy destroyed before finishing

Nov 20 12:56:34 snowball3 bluetoothd[10741]: 
src/profile.c:ext_io_disconnected() Unable to get io data for Hands-Free 
Voice gateway: getpeername: Transport endpoint is not connected (107)



I am not sure whether this is a bluetooth, pipewire, wireplumber or 
firefox issue. It happens when I try to play a youtube video on firefox 
via the headphones.

Best regards,
Julian
