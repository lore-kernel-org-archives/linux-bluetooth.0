Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BA1C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 20:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0762071B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 20:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLbgRLt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgIAUjY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgIAUjW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 16:39:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75866C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 13:39:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c18so2944402wrm.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5W1bCq0H++5vHkhWo54hQn5+PNnP+ARcLtctPXcOeRE=;
        b=TLbgRLt/6zdkTXVEL3nt2vJj5g+MzD3g1f6LIwIBDk+n+9uDYWf+gRXXF8VkvSUmfv
         rZdVLEaUjJ4ei7PH9XJgz0XVZRmApHBClSwczIphpSSB5eB9CLeEW1vuAZmVkiHMEx0R
         UdzykY1Nyn3iFmsSfvj4XYKjHANDpXaab7WKkNLx1SJJyhNInZ2ah4TXRUCBKsIOthCr
         FegWznJM51wtCAjxaCZ+GhQ0aw/auKwEGsnvc0ki1vV8zMg+Z+xxpCXlbGE10KBe5uEW
         fSvWNNmBxsET6IlA+gkFXahYjVj0HSJqjFuLuhn+Gsvg9T8q690NvsstCkaJyGM0f7Iq
         0yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5W1bCq0H++5vHkhWo54hQn5+PNnP+ARcLtctPXcOeRE=;
        b=PwzLcDRmz7nPZ0VP+cl8HJAy2I+utbkYcq9+RTeGNSc47Q9WBa7tSJW0ji4EQmfDxT
         Xkgcyl1heuAyZBYbIfyt7R9H0dtWBC3mViy2KryMfk7ambzmfhjQpznMnNu8O8+GWJZV
         m+DXmcrNJw5Sfj1Kxpvg6S0BleMhAV3pO5wSA4BzpjI2W8rbyVW0J902O5risBI9uhxc
         46tOROP0jA8UJ/8ZPMCyYM8NFQUDf0JICcOjipPlhUGwm7VcI2fQ4QAUmhej1hyDKg5b
         Y2V4SDwY8N3wfpsUK/ufLz3AGiTgXQ4NEIlaENT4WdybtdACyMJmkfQLKI0Aicg6qR/4
         u2CQ==
X-Gm-Message-State: AOAM532mEowaXywVZ3aLDfSywN6Et5s2jhfRAqUx+nhAYRB5Z7x5HFIL
        IF2Dca2Vj5OQBbwJb+jD0oGXvvhOQSI=
X-Google-Smtp-Source: ABdhPJxwNgN5OrNFJAVVGsBqMSGlO0iIoP0B8HbGSy9aFZw+lPGKQaZlbuJBdWSFhMdv4EimrG0GYQ==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr2441403wrq.365.1598992760624;
        Tue, 01 Sep 2020 13:39:20 -0700 (PDT)
Received: from ?IPv6:2a02:908:1982:45e0:80a3:8327:7b91:9429? ([2a02:908:1982:45e0:80a3:8327:7b91:9429])
        by smtp.googlemail.com with ESMTPSA id l21sm3048712wmj.25.2020.09.01.13.39.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 13:39:19 -0700 (PDT)
Subject: Re: Bluetooth connection disconnects every few minutes
From:   Julian Sikorski <belegdol@gmail.com>
To:     linux-bluetooth@vger.kernel.org
References: <67077b05-dc49-3a97-c83f-4090f1cc7cea@gmail.com>
 <phdhvi$sdh$1@blaine.gmane.org>
 <8e41e2ae-bef4-d479-9706-49fd214081a6@chini.tk>
 <phdpkn$q3q$1@blaine.gmane.org> <pht30d$27m$1@blaine.gmane.org>
 <53d57478-4b61-65a4-7f09-b7e473cc613a@chini.tk>
 <305017ee-6420-3c44-7842-14776c37207d@gmail.com>
 <12fa0585-c993-0685-ac76-27d96d539ca2@gmail.com>
 <9a633975-704c-1a00-3f9f-b93a499947c2@gmail.com>
 <8bf4641f-4d3e-faf4-f53a-c571b97d9be4@gmail.com>
Autocrypt: addr=belegdol@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBE40CmIBCACj+gI1pIMD0VGrZD4ugde8f3usLc0OE0OnPDXjqelxsC3B/x9BFoQrzfnP
 qJEtcB6F4V5MuEYutnteeuFsIkLHx6UIe9vr1Ze01XtN7Emsya/AKXaEcXYzUUjVmWn1NjJF
 ZlX0ML3mIQPERBDEY/aXAj7cVDGvkFVeKWIWE5KRqQWV2rYo0nizZTRYGB0z6KpMninG4hqF
 KvvpzhDS5ZnxijEYs0YAx0QllI4LjLTH3xLuYMnSbHzFRBh9zUsMttMnZdCudLZC6ZllkjtM
 ov/kIO35P5ygFJ9xlLyxMFkhXsARDWe3qwJCEHfJgtcblQD/LHuY200fTmrbwTK9Q4uNABEB
 AAG0JEp1bGlhbiBTaWtvcnNraSA8YmVsZWdkb2xAZ21haWwuY29tPokBOAQTAQIAIgUCTjQK
 YgIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQLdUZIcIlWSuFYwf+J5lKOXWz+FJW
 Vn4b8Q237R/SOlZVwVfT9u/EjxGkploecihuzRadwXDMu030zdgo0m4lwEubOD5eMvzpBSYu
 Dc3fDPT/T5/O7avybt2w83hptPuwU4O0EmNrkgr6pHql1nxEvBpeB8KkJnexJww95Kl1YmBX
 c1kdRrAShNxiVQDpPnskGtnfK2eTqyuyhECApIVLxMIX5IsqGCpslRUR6e90iHd591iJgRT+
 Ji74QjkCQzJJVcKbX5T7HzbUd6mmkZjNbtog3g6WEPkI4Qdw+ZeDlSViN/SKPS2ptMMzxCOT
 neVuw3c6qM/VUo6AUTPSl+1c1rO2X7ZY5/Z9dCMP9rkBDQRONApiAQgAmurakWU/VVEKiPcM
 o5IsActeWERRTxgUXmliSp02YtBLYwOBQ6WUmJyhywOR8s3Wh93cHEPgEPI/n+cfytNxvpol
 liSXp3PZGJAmBSIq13d1lDYJBzDzNjUz6dj9YMV56zcsWbYF25grXbPY4acy/5RQXHWjQ4R9
 dtGCMd48dhMH6O0DvsiriRxJQrcXz0mgLSi79KVns4VgIuUuPCwPyF1zNUBs/srbgTuL+On0
 GjbK40GnJq/Zw2LhEGeicp0npoc4jshgVTtUXRQrGo04plJNpNg9Tl1UIbsHrjA1qz9yo8GR
 4MLgXzcyfM6h+wz6qC8eI7jx4VEZxMhXtalvywARAQABiQEfBBgBAgAJBQJONApiAhsMAAoJ
 EC3VGSHCJVkrpl0IAJJd8qETlL0XzNZsguk8LwXi0c++iTTbotw/zn1f7CgGsZErm58KqNhR
 UltAZvK+lOclNPbZRsGzoEdg4TIvSymWVLN6jyblhcqH4G9mxmf6QOLvYR5I02UQiIbKvTvv
 mFA8bgr2vXPFc8rBmFXrwyC3DOjfrnz23kGattsFWbRA2OBq7bp/05JVoMb4QRA2TIbbvsyQ
 g0MMs9VldhdVfZcFqU2qKwQs8fBr8BD+OfPeiYndJV4GnfYhK692viMjv/+dgOvYcEgtlFaJ
 TLeiWvwUUxJ7ai45p+gCHXUYPGwrH4Dm2HAw61vUDkbT5pVOeGlFsvtOVEajnQX+MOV93l4=
Message-ID: <2bd00ced-f685-9048-5a10-a20028595086@gmail.com>
Date:   Tue, 1 Sep 2020 22:39:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8bf4641f-4d3e-faf4-f53a-c571b97d9be4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

W dniu 01.09.2020 o 22:10, Julian Sikorski pisze:
> W dniu 12.08.2018 o 17:49, Julian Sikorski pisze:
>> W dniu 01.08.2018 o 19:46, Julian Sikorski pisze:
>>> W dniu 09.07.2018 o 18:51, Julian Sikorski pisze:
>>>> W dniu 08.07.2018 o 19:46, Georg Chini pisze:
>>>>> On 08.07.2018 15:21, Julian Sikorski wrote:
>>>>>> W dniu 02.07.2018 o 20:09, Julian Sikorski pisze:
>>>>>>> W dniu 02.07.2018 o 18:04, Georg Chini pisze:
>>>>>>>> On 02.07.2018 17:58, Julian Sikorski wrote:
>>>>>>>>> W dniu 29.06.2018 o 21:47, Julian Sikorski pisze:
>>>>>>>>>> Hi list,
>>>>>>>>>>
>>>>>>>>>> I have noticed that the bluetooth connection between my laptop (Intel
>>>>>>>>>> 7260) and my headphones (Sennheiser Momentum Wirelless) is very
>>>>>>>>>> unreliable. While under Windows 10 devices stay connected for
>>>>>>>>>> hours on
>>>>>>>>>> end, under Fedora 28 the connection is lost every few minutes at
>>>>>>>>>> most.
>>>>>>>>>> Often the connection will be reestablished only to be lost again.
>>>>>>>>>> bluetoothd shows messages like:
>>>>>>>>>>
>>>>>
>>>>>>>>>> I am not sure where to look further. Does it look like an issue with
>>>>>>>>>> pulseaudio, or a deeper problem with linux bluetooth stack? Thanks
>>>>>>>>>> for
>>>>>>>>>> your input in advance!
>>>>>>>>>>
>>>>>>>>>> Best regards,
>>>>>>>>>> Julian
>>>>>>>>> This is what is logged by pulseaudio at the time the connection is
>>>>>>>>> lost:
>>>>>>>>>
>>>>>>>>> ( 118.064|  34.694) I: [bluetooth] module-bluez5-device.c: FD error:
>>>>>>>>> POLLERR POLLHUP
>>>>>>>>> ( 118.064|   0.000) I: [bluetooth] bluez5-util.c: Transport
>>>>>>>>> /org/bluez/hci0/dev_00_1B_66_81_8D_76/fd27 auto-released by BlueZ or
>>>>>>>>> already released
>>>>>>>>> ( 118.064|   0.000) I: [pulseaudio] backend-native.c: Lost RFCOMM
>>>>>>>>> connection.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>  From what you are writing, it looks to me as if the issue is in the
>>>>>>>> USB
>>>>>>>> stack and the BT dongle keeps disconnecting/connecting. Have you
>>>>>>>> tried another dongle?
>>>>>>> Hi,
>>>>>>>
>>>>>>> I unfortunately do not own any other dongles. I tried getting some
>>>>>>> useful info with btmon but the log seems flooded with way too many
>>>>>>> messages to make anything out.
>>>>>>>
>>>>>> Hi Georg,
>>>>>>
>>>>>> it looks like the problem is more related to how the dongle interacts
>>>>>> with this specific headphone model. I have recently bought another one
>>>>>> for running (AfterShokz Trekz Air) and it works perfectly, connecting
>>>>>> automatically, staying connected and even switching profiles
>>>>>> automatically without issues so far.
>>>>>> The hci0: last event is not cmd complete (0x0f) message seems harmless
>>>>>> as it spams the dmesg output regardless of the device connected (and
>>>>>> also when no device is connected at all.
>>>>>> It appears that whatever is happening it makes the dongle reconnect:
>>>>>>
>>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: USB disconnect, device number 6
>>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: new full-speed USB device number 7
>>>>>> using ehci-pci
>>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: New USB device found,
>>>>>> idVendor=8087, idProduct=07dc, bcdDevice= 0.01
>>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: New USB device strings: Mfr=0,
>>>>>> Product=0, SerialNumber=0
>>>>>> [nie lip  8 15:14:12 2018] Bluetooth: hci0: read Intel version:
>>>>>> 3707100180012d0d2a
>>>>>> [nie lip  8 15:14:12 2018] Bluetooth: hci0: Intel device is already
>>>>>> patched. patch num: 2a
>>>>>>
>>>>>> Where would you recommend to look for reasons for this behaviour? btmon?
>>>>>> Thank you for the pointers!
>>>>>>
>>>>>> Best regards,
>>>>>> Julian
>>>>>>
>>>>>>
>>>>> Hi Julian,
>>>>>
>>>>> sorry, I have no further ideas. Maybe Luiz can help you to investigate.
>>>>> To me it looks like the headphone is sending something that makes the
>>>>> dongle reset.
>>>>>
>>>>> Regards
>>>>>             Georg
>>>>
>>>> Hi Georg,
>>>>
>>>> no worries - hopefully Luiz will find some time to look into this.
>>>> In the meantime I have been getting acquainted with btmon. I have
>>>> managed to pinpoint the exact moment during which sound stops coming
>>>> through the headphones and starts coming through the laptop speakers. In
>>>> the below testcase, it happens at 18:42:58:
>>>>
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1825 [hci0] 18:42:58.908586
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1826 [hci0] 18:42:58.928877
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>>>                            {0x0002} [hci0] 18:43:00.653578
>>>>         Class: 0x000000
>>>>           Major class: Miscellaneous
>>>>           Minor class: 0x00
>>>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>>>                            {0x0001} [hci0] 18:43:00.653578
>>>>         Class: 0x000000
>>>>           Major class: Miscellaneous
>>>>           Minor class: 0x00
>>>> @ MGMT Event: New Settings (0x0006) plen 4
>>>>                            {0x0002} [hci0] 18:43:00.653609
>>>>         Current settings: 0x00000ada
>>>>           Connectable
>>>>           Discoverable
>>>>           Bondable
>>>>           Secure Simple Pairing
>>>>           BR/EDR
>>>>           Low Energy
>>>>           Secure Connections
>>>> @ MGMT Event: New Settings (0x0006) plen 4
>>>>                            {0x0001} [hci0] 18:43:00.653609
>>>>         Current settings: 0x00000ada
>>>>           Connectable
>>>>           Discoverable
>>>>           Bondable
>>>>           Secure Simple Pairing
>>>>           BR/EDR
>>>>           Low Energy
>>>>           Secure Connections
>>>> = bluetoothd: Unable to get io data for Headset Voice gateway:
>>>> getpeername: Transport endpoint is not connected..   18:43:00.654133
>>>> = Close Index: 7C:5C:F8:B2:DF:08
>>>>                                     [hci0] 18:43:00.678348
>>>> @ MGMT Event: Index Removed (0x0005) plen 0
>>>>                            {0x0002} [hci0] 18:43:00.678372
>>>> @ MGMT Event: Index Removed (0x0005) plen 0
>>>>                            {0x0001} [hci0] 18:43:00.678372
>>>> = Delete Index: 7C:5C:F8:B2:DF:08
>>>>                                     [hci0] 18:43:00.678377
>>>> = bluetoothd: Endpoint unregistered: sender=:1.1492
>>>> path=/MediaEndpoint/A2DPSource
>>>> 18:43:00.678966
>>>> = bluetoothd: Endpoint unregistered: sender=:1.1492
>>>> path=/MediaEndpoint/A2DPSink
>>>> 18:43:00.678984
>>>>
>>>> I am copying linux-bluetooth, maybe someone there will have an idea as
>>>> well. Thank you for all your help in advance!
>>>>
>>>> Best regards,
>>>> Julian
>>>
>>> Hi all,
>>>
>>> I tried to get more information using hcidump, but it does not appear
>>> very interesting. I am attaching it here just in case. The last entry
>>> appearing - command complete (read encryption key size) - appears upon
>>> successful connection, not when the connection is dropped. How else
>>> could I try to figure out what is being sent at the time of
>>> disconnection? Thank you!
>>>
>>> Best regards,
>>> Julian
>>
>> Hi list,
>>
>> I just realised I never attached the full btmon dump. Here it goes, the
>> connection drops at 17:32:04:
>>
>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>                               #1340 [hci0] 17:32:04.774611
>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>                               #1341 [hci0] 17:32:04.783175
>>         Num handles: 1
>>         Handle: 256
>>         Count: 1
>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>                               #1342 [hci0] 17:32:04.794981
>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>                               #1343 [hci0] 17:32:04.803054
>>         Num handles: 1
>>         Handle: 256
>>         Count: 1
>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>                               #1344 [hci0] 17:32:04.815326
>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>                               #1345 [hci0] 17:32:04.823198
>>         Num handles: 1
>>         Handle: 256
>>         Count: 1
>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>                               #1346 [hci0] 17:32:04.835578
>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>                               #1347 [hci0] 17:32:04.856093
>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>                               #1348 [hci0] 17:32:04.876186
>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>                               #1349 [hci0] 17:32:04.896454
>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>                               #1350 [hci0] 17:32:04.916869
>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>                            {0x0002} [hci0] 17:32:06.637019
>>         Class: 0x000000
>>           Major class: Miscellaneous
>>           Minor class: 0x00
>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>                            {0x0001} [hci0] 17:32:06.637019
>>         Class: 0x000000
>>           Major class: Miscellaneous
>>           Minor class: 0x00
>> @ MGMT Event: New Settings (0x0006) plen 4
>>                            {0x0002} [hci0] 17:32:06.637034
>>         Current settings: 0x00000ada
>>           Connectable
>>           Discoverable
>>           Bondable
>>           Secure Simple Pairing
>>           BR/EDR
>>           Low Energy
>>           Secure Connections
>> @ MGMT Event: New Settings (0x0006) plen 4
>>                            {0x0001} [hci0] 17:32:06.637034
>>         Current settings: 0x00000ada
>>           Connectable
>>           Discoverable
>>           Bondable
>>           Secure Simple Pairing
>>           BR/EDR
>>           Low Energy
>>           Secure Connections
>> = Close Index: 7C:5C:F8:B2:DF:08
>>                                     [hci0] 17:32:06.654087
>> @ MGMT Event: Index Removed (0x0005) plen 0
>>                            {0x0002} [hci0] 17:32:06.654114
>> @ MGMT Event: Index Removed (0x0005) plen 0
>>                            {0x0001} [hci0] 17:32:06.654114
>> = Delete Index: 7C:5C:F8:B2:DF:08
>>                                     [hci0] 17:32:06.654120
>> = bluetoothd: Unable to get io data for Headset Voice gateway:
>> getpeername: Transport endpoint is not connected..   17:32:06.654352
>> = bluetoothd: Endpoint unregistered: sender=:1.750
>> path=/MediaEndpoint/A2DPSource
>> 17:32:06.654796
>> = bluetoothd: Endpoint unregistered: sender=:1.750
>> path=/MediaEndpoint/A2DPSink
>> 17:32:06.654836
>>
>> I tried sending the btmon capture as attachment but it appears to be too
>> large for the list, so I uploaded it here instead:
>>
>> https://belegdol.fedorapeople.org/btmon-aug.log
>>
>> Best regards,
>> Julian
>>
> 
> Hi all,
> 
> I have tried the headset again with kernel-5.8.4, bluez-5.54 and
> pulseaudio-13.99.1. The situation has unfortunately not improved in the
> last two years.
> I am attaching the btmon capture of two connection attempts:
> - the first connects and then almost immediately disconnects
> - the second never succeeds
> Does the capture provide any information as to why the connection is
> failing? If I can provide any more data, please let me know. Thanks!
> 
> Best regards,
> Julian
> 
If I am not mistaken, the disconnect happens right after #636

Best regards,
Julian
