Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,ZIPFILE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B4C433E2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 20:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC372078B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 20:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQYwc2o1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgIAUKp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgIAUKm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 16:10:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE31C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 13:10:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t10so2050245wrv.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:from:to:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=NYzyMb4rPm82sJ8hGvbDWKjmvRFv2Bb/9x0WE3GTIuc=;
        b=uQYwc2o18BV5dKnvP7zNbIkXalbNXRsW2NRdE4vkqMzxqZnXX8d7yNNBNLrcMEBOEp
         YgTsNHWwu85/titHdyjUbx7WUBsXsjAsQUt9P42csxBRH+MDcVSdHDGmcSJ4OG0Bo+xp
         WrohX1sNLnvwsEsDNCwMhSjRIcHpjEC91Uf3tu2WZWxhNMHuVsD2kynRerqvWgkHY+Qo
         b8GI4G+/ZZhVa9QBoZYZ9WXmCjPWH6u10x1JzJvU7dtSI/Ni0U9K4B4iT7xAAULJICzN
         NbWcSmINak169fAliT2mxi/LXOTkCA/XTkPGe+LboKJ6lMAnU7t5mZWRzpb4HQqXzZ2s
         98aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:from:to:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language;
        bh=NYzyMb4rPm82sJ8hGvbDWKjmvRFv2Bb/9x0WE3GTIuc=;
        b=uLmYu37ajVYSmme23XgxAsrGCfPJKxrjVQ0l8B1RpxTvtgaz/yrr+5P1mw3EYJBi9E
         c2RX092rPJd15hRcH24uCgSHIRQpIdmN0OmavFMTvx4dwC0hYW8p+nen80DbONjwixI8
         9xCF7+R4rIhQEGwUfONirfnM2OVfI5n6iqUxaJdDICrfaosybo1EkdTP8noY7DQrMm63
         gUHXn8JbCJvgQLtbcb5jX0umxA8/ecfHJgob9IR1DqpsgSPLUP1BUnV5xhBO/1ZvzH2M
         kqEvqOg06vl3A1zWltnLGAtAFIZCF8JBp8OFaGKQ0wVnmXTbUDfs12it2JuZOMWhsOLL
         zQOA==
X-Gm-Message-State: AOAM533Tf3SNs3+3f0Ej3YAemqdFrPMPnaJj8VrRcx/ovHWOGyKOnVQP
        y/HbCfFHbv3T5E+NXJFxiqyd+x0NCDw=
X-Google-Smtp-Source: ABdhPJxiyWeV87flX1ToFKNDDcg6Lopne8VOcfAD47K/I0os51iWqi/qNvEBhXle3hunWfupxGskSA==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr3508315wrm.422.1598991037902;
        Tue, 01 Sep 2020 13:10:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1982:45e0:80a3:8327:7b91:9429? ([2a02:908:1982:45e0:80a3:8327:7b91:9429])
        by smtp.googlemail.com with ESMTPSA id p14sm4292496wrg.96.2020.09.01.13.10.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 13:10:36 -0700 (PDT)
Subject: Re: Bluetooth connection disconnects every few minutes
References: <67077b05-dc49-3a97-c83f-4090f1cc7cea@gmail.com>
 <phdhvi$sdh$1@blaine.gmane.org>
 <8e41e2ae-bef4-d479-9706-49fd214081a6@chini.tk>
 <phdpkn$q3q$1@blaine.gmane.org> <pht30d$27m$1@blaine.gmane.org>
 <53d57478-4b61-65a4-7f09-b7e473cc613a@chini.tk>
 <305017ee-6420-3c44-7842-14776c37207d@gmail.com>
 <12fa0585-c993-0685-ac76-27d96d539ca2@gmail.com>
 <9a633975-704c-1a00-3f9f-b93a499947c2@gmail.com>
From:   Julian Sikorski <belegdol@gmail.com>
To:     linux-bluetooth@vger.kernel.org
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
Message-ID: <8bf4641f-4d3e-faf4-f53a-c571b97d9be4@gmail.com>
Date:   Tue, 1 Sep 2020 22:10:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9a633975-704c-1a00-3f9f-b93a499947c2@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------1E532EBB45443DF8DB21149B"
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.
--------------1E532EBB45443DF8DB21149B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

W dniu 12.08.2018 o 17:49, Julian Sikorski pisze:
> W dniu 01.08.2018 o 19:46, Julian Sikorski pisze:
>> W dniu 09.07.2018 o 18:51, Julian Sikorski pisze:
>>> W dniu 08.07.2018 o 19:46, Georg Chini pisze:
>>>> On 08.07.2018 15:21, Julian Sikorski wrote:
>>>>> W dniu 02.07.2018 o 20:09, Julian Sikorski pisze:
>>>>>> W dniu 02.07.2018 o 18:04, Georg Chini pisze:
>>>>>>> On 02.07.2018 17:58, Julian Sikorski wrote:
>>>>>>>> W dniu 29.06.2018 o 21:47, Julian Sikorski pisze:
>>>>>>>>> Hi list,
>>>>>>>>>
>>>>>>>>> I have noticed that the bluetooth connection between my laptop (Intel
>>>>>>>>> 7260) and my headphones (Sennheiser Momentum Wirelless) is very
>>>>>>>>> unreliable. While under Windows 10 devices stay connected for
>>>>>>>>> hours on
>>>>>>>>> end, under Fedora 28 the connection is lost every few minutes at
>>>>>>>>> most.
>>>>>>>>> Often the connection will be reestablished only to be lost again.
>>>>>>>>> bluetoothd shows messages like:
>>>>>>>>>
>>>>
>>>>>>>>> I am not sure where to look further. Does it look like an issue with
>>>>>>>>> pulseaudio, or a deeper problem with linux bluetooth stack? Thanks
>>>>>>>>> for
>>>>>>>>> your input in advance!
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>> Julian
>>>>>>>> This is what is logged by pulseaudio at the time the connection is
>>>>>>>> lost:
>>>>>>>>
>>>>>>>> ( 118.064|  34.694) I: [bluetooth] module-bluez5-device.c: FD error:
>>>>>>>> POLLERR POLLHUP
>>>>>>>> ( 118.064|   0.000) I: [bluetooth] bluez5-util.c: Transport
>>>>>>>> /org/bluez/hci0/dev_00_1B_66_81_8D_76/fd27 auto-released by BlueZ or
>>>>>>>> already released
>>>>>>>> ( 118.064|   0.000) I: [pulseaudio] backend-native.c: Lost RFCOMM
>>>>>>>> connection.
>>>>>>>>
>>>>>>>>
>>>>>>>  From what you are writing, it looks to me as if the issue is in the
>>>>>>> USB
>>>>>>> stack and the BT dongle keeps disconnecting/connecting. Have you
>>>>>>> tried another dongle?
>>>>>> Hi,
>>>>>>
>>>>>> I unfortunately do not own any other dongles. I tried getting some
>>>>>> useful info with btmon but the log seems flooded with way too many
>>>>>> messages to make anything out.
>>>>>>
>>>>> Hi Georg,
>>>>>
>>>>> it looks like the problem is more related to how the dongle interacts
>>>>> with this specific headphone model. I have recently bought another one
>>>>> for running (AfterShokz Trekz Air) and it works perfectly, connecting
>>>>> automatically, staying connected and even switching profiles
>>>>> automatically without issues so far.
>>>>> The hci0: last event is not cmd complete (0x0f) message seems harmless
>>>>> as it spams the dmesg output regardless of the device connected (and
>>>>> also when no device is connected at all.
>>>>> It appears that whatever is happening it makes the dongle reconnect:
>>>>>
>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: USB disconnect, device number 6
>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: new full-speed USB device number 7
>>>>> using ehci-pci
>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: New USB device found,
>>>>> idVendor=8087, idProduct=07dc, bcdDevice= 0.01
>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: New USB device strings: Mfr=0,
>>>>> Product=0, SerialNumber=0
>>>>> [nie lip  8 15:14:12 2018] Bluetooth: hci0: read Intel version:
>>>>> 3707100180012d0d2a
>>>>> [nie lip  8 15:14:12 2018] Bluetooth: hci0: Intel device is already
>>>>> patched. patch num: 2a
>>>>>
>>>>> Where would you recommend to look for reasons for this behaviour? btmon?
>>>>> Thank you for the pointers!
>>>>>
>>>>> Best regards,
>>>>> Julian
>>>>>
>>>>>
>>>> Hi Julian,
>>>>
>>>> sorry, I have no further ideas. Maybe Luiz can help you to investigate.
>>>> To me it looks like the headphone is sending something that makes the
>>>> dongle reset.
>>>>
>>>> Regards
>>>>             Georg
>>>
>>> Hi Georg,
>>>
>>> no worries - hopefully Luiz will find some time to look into this.
>>> In the meantime I have been getting acquainted with btmon. I have
>>> managed to pinpoint the exact moment during which sound stops coming
>>> through the headphones and starts coming through the laptop speakers. In
>>> the below testcase, it happens at 18:42:58:
>>>
>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>                               #1825 [hci0] 18:42:58.908586
>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>                               #1826 [hci0] 18:42:58.928877
>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>>                            {0x0002} [hci0] 18:43:00.653578
>>>         Class: 0x000000
>>>           Major class: Miscellaneous
>>>           Minor class: 0x00
>>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>>                            {0x0001} [hci0] 18:43:00.653578
>>>         Class: 0x000000
>>>           Major class: Miscellaneous
>>>           Minor class: 0x00
>>> @ MGMT Event: New Settings (0x0006) plen 4
>>>                            {0x0002} [hci0] 18:43:00.653609
>>>         Current settings: 0x00000ada
>>>           Connectable
>>>           Discoverable
>>>           Bondable
>>>           Secure Simple Pairing
>>>           BR/EDR
>>>           Low Energy
>>>           Secure Connections
>>> @ MGMT Event: New Settings (0x0006) plen 4
>>>                            {0x0001} [hci0] 18:43:00.653609
>>>         Current settings: 0x00000ada
>>>           Connectable
>>>           Discoverable
>>>           Bondable
>>>           Secure Simple Pairing
>>>           BR/EDR
>>>           Low Energy
>>>           Secure Connections
>>> = bluetoothd: Unable to get io data for Headset Voice gateway:
>>> getpeername: Transport endpoint is not connected..   18:43:00.654133
>>> = Close Index: 7C:5C:F8:B2:DF:08
>>>                                     [hci0] 18:43:00.678348
>>> @ MGMT Event: Index Removed (0x0005) plen 0
>>>                            {0x0002} [hci0] 18:43:00.678372
>>> @ MGMT Event: Index Removed (0x0005) plen 0
>>>                            {0x0001} [hci0] 18:43:00.678372
>>> = Delete Index: 7C:5C:F8:B2:DF:08
>>>                                     [hci0] 18:43:00.678377
>>> = bluetoothd: Endpoint unregistered: sender=:1.1492
>>> path=/MediaEndpoint/A2DPSource
>>> 18:43:00.678966
>>> = bluetoothd: Endpoint unregistered: sender=:1.1492
>>> path=/MediaEndpoint/A2DPSink
>>> 18:43:00.678984
>>>
>>> I am copying linux-bluetooth, maybe someone there will have an idea as
>>> well. Thank you for all your help in advance!
>>>
>>> Best regards,
>>> Julian
>>
>> Hi all,
>>
>> I tried to get more information using hcidump, but it does not appear
>> very interesting. I am attaching it here just in case. The last entry
>> appearing - command complete (read encryption key size) - appears upon
>> successful connection, not when the connection is dropped. How else
>> could I try to figure out what is being sent at the time of
>> disconnection? Thank you!
>>
>> Best regards,
>> Julian
> 
> Hi list,
> 
> I just realised I never attached the full btmon dump. Here it goes, the
> connection drops at 17:32:04:
> 
> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>                               #1340 [hci0] 17:32:04.774611
>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>> HCI Event: Number of Completed Packets (0x13) plen 5
>                               #1341 [hci0] 17:32:04.783175
>         Num handles: 1
>         Handle: 256
>         Count: 1
> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>                               #1342 [hci0] 17:32:04.794981
>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>> HCI Event: Number of Completed Packets (0x13) plen 5
>                               #1343 [hci0] 17:32:04.803054
>         Num handles: 1
>         Handle: 256
>         Count: 1
> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>                               #1344 [hci0] 17:32:04.815326
>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>> HCI Event: Number of Completed Packets (0x13) plen 5
>                               #1345 [hci0] 17:32:04.823198
>         Num handles: 1
>         Handle: 256
>         Count: 1
> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>                               #1346 [hci0] 17:32:04.835578
>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>                               #1347 [hci0] 17:32:04.856093
>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>                               #1348 [hci0] 17:32:04.876186
>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>                               #1349 [hci0] 17:32:04.896454
>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>                               #1350 [hci0] 17:32:04.916869
>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>                            {0x0002} [hci0] 17:32:06.637019
>         Class: 0x000000
>           Major class: Miscellaneous
>           Minor class: 0x00
> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>                            {0x0001} [hci0] 17:32:06.637019
>         Class: 0x000000
>           Major class: Miscellaneous
>           Minor class: 0x00
> @ MGMT Event: New Settings (0x0006) plen 4
>                            {0x0002} [hci0] 17:32:06.637034
>         Current settings: 0x00000ada
>           Connectable
>           Discoverable
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> @ MGMT Event: New Settings (0x0006) plen 4
>                            {0x0001} [hci0] 17:32:06.637034
>         Current settings: 0x00000ada
>           Connectable
>           Discoverable
>           Bondable
>           Secure Simple Pairing
>           BR/EDR
>           Low Energy
>           Secure Connections
> = Close Index: 7C:5C:F8:B2:DF:08
>                                     [hci0] 17:32:06.654087
> @ MGMT Event: Index Removed (0x0005) plen 0
>                            {0x0002} [hci0] 17:32:06.654114
> @ MGMT Event: Index Removed (0x0005) plen 0
>                            {0x0001} [hci0] 17:32:06.654114
> = Delete Index: 7C:5C:F8:B2:DF:08
>                                     [hci0] 17:32:06.654120
> = bluetoothd: Unable to get io data for Headset Voice gateway:
> getpeername: Transport endpoint is not connected..   17:32:06.654352
> = bluetoothd: Endpoint unregistered: sender=:1.750
> path=/MediaEndpoint/A2DPSource
> 17:32:06.654796
> = bluetoothd: Endpoint unregistered: sender=:1.750
> path=/MediaEndpoint/A2DPSink
> 17:32:06.654836
> 
> I tried sending the btmon capture as attachment but it appears to be too
> large for the list, so I uploaded it here instead:
> 
> https://belegdol.fedorapeople.org/btmon-aug.log
> 
> Best regards,
> Julian
> 

Hi all,

I have tried the headset again with kernel-5.8.4, bluez-5.54 and
pulseaudio-13.99.1. The situation has unfortunately not improved in the
last two years.
I am attaching the btmon capture of two connection attempts:
- the first connects and then almost immediately disconnects
- the second never succeeds
Does the capture provide any information as to why the connection is
failing? If I can provide any more data, please let me know. Thanks!

Best regards,
Julian


--------------1E532EBB45443DF8DB21149B
Content-Type: application/zip;
 name="btmon-m2aebt.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="btmon-m2aebt.zip"

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
--------------1E532EBB45443DF8DB21149B--
