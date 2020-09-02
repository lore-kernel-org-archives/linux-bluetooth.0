Return-Path: <SRS0=7X4B=CL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,ZIPFILE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4212C433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 05:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6AA2075D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Sep 2020 05:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiGgC/DB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBF6g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIBF6f (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Sep 2020 01:58:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B8C061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 22:58:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so3228076wmk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 22:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=LMkJYniRKsd1ko2QbohaB0IuegDUmqjOhD/emII8lcQ=;
        b=OiGgC/DB5bxvfd5J5npQyxzvWMQURSpRXh3mycicYJihDdW1/Y/CMyEqtBxJOfW4s/
         85Yylp/YwnAMlKE3Zjw4mbmYcXCpE+AJo2sEfsicyoK7pgY5UG1dM9ZufF2gY+ZjSBhh
         YW15C5q58P6b98SwxtnTYvDi3edAGWediYDAHUwkvZfgl5FrWsKF61hVYnF5JIjlpPEg
         w5+tvcK71XqF7QqpHOZRtiFY+JOrRG8MjRBa6L5Z5n0qengAudowSzIPUMwUuPvUl+AX
         wzvh5s5G1bQC3q7+R8hdQMaDM1hFem8oS+zBx1hgNyivOTE1Bi0gPdsBob5K2FK69VNt
         53LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=LMkJYniRKsd1ko2QbohaB0IuegDUmqjOhD/emII8lcQ=;
        b=oYczm6N/ilfHqyskgRF+d+7W1fsjLEeldvDNFFYR1RnfS0Hmk37lNSv7+utYb7ioP5
         m6EihDCVnERDQljuI3pqZZyKpun62Ed93a/5A5v0CxUX9EgHZI/WQHhYFahqCvZCIGjP
         DIdcD/tVc96uMnhCgA2qi17lMvudbBtfp33cdZkXN6T1Ovz6yaSWZ7qz1AJyv6bDu/z3
         /iEmfaGQmjcy74YpXqdaxwAdClsJWUQ20nylQD8VN5iRa2H0c6PkJe+8CPHdu382knzN
         f/nR85BLQv6t3y2itJgzBZwMsI6I54+CxRudbvYc0lA0PufTAHYfy5iC+S3HJpoL9D7j
         nWVg==
X-Gm-Message-State: AOAM531Euk8l27We/y/1AhtZ/+dfZxSxzMfKZR5EPPRTiZBdsUmsZuqr
        2j+3gd7pjnT+RNU92mOsvt2dyWFZTaA=
X-Google-Smtp-Source: ABdhPJzNe/W7APBUToa5u78Hh9hRRkT6CK/uplazWeURIaa8v8rjtMOL1v53oza12pd5uOnyy/f6Aw==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr5015943wmj.90.1599026311345;
        Tue, 01 Sep 2020 22:58:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1982:45e0:80a3:8327:7b91:9429? ([2a02:908:1982:45e0:80a3:8327:7b91:9429])
        by smtp.googlemail.com with ESMTPSA id c14sm5116928wrv.12.2020.09.01.22.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 22:58:30 -0700 (PDT)
Subject: Re: Bluetooth connection disconnects every few minutes
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <67077b05-dc49-3a97-c83f-4090f1cc7cea@gmail.com>
 <phdhvi$sdh$1@blaine.gmane.org>
 <8e41e2ae-bef4-d479-9706-49fd214081a6@chini.tk>
 <phdpkn$q3q$1@blaine.gmane.org> <pht30d$27m$1@blaine.gmane.org>
 <53d57478-4b61-65a4-7f09-b7e473cc613a@chini.tk>
 <305017ee-6420-3c44-7842-14776c37207d@gmail.com>
 <12fa0585-c993-0685-ac76-27d96d539ca2@gmail.com>
 <9a633975-704c-1a00-3f9f-b93a499947c2@gmail.com>
 <8bf4641f-4d3e-faf4-f53a-c571b97d9be4@gmail.com>
 <2bd00ced-f685-9048-5a10-a20028595086@gmail.com>
 <CABBYNZ+ZqS1LHVjLwt3mQvmFi1y7ogf_Tstvu70-XnDVT3nAAA@mail.gmail.com>
From:   Julian Sikorski <belegdol@gmail.com>
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
Message-ID: <21f3b905-566c-00a0-e576-f47ae13019a6@gmail.com>
Date:   Wed, 2 Sep 2020 07:58:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+ZqS1LHVjLwt3mQvmFi1y7ogf_Tstvu70-XnDVT3nAAA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------EA2EFEED3655352BC8E8D3C6"
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a multi-part message in MIME format.
--------------EA2EFEED3655352BC8E8D3C6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

W dniu 02.09.2020 o 01:14, Luiz Augusto von Dentz pisze:
> Hi Julian,
> 
> On Tue, Sep 1, 2020 at 1:42 PM Julian Sikorski <belegdol@gmail.com> wrote:
>>
>> W dniu 01.09.2020 o 22:10, Julian Sikorski pisze:
>>> W dniu 12.08.2018 o 17:49, Julian Sikorski pisze:
>>>> W dniu 01.08.2018 o 19:46, Julian Sikorski pisze:
>>>>> W dniu 09.07.2018 o 18:51, Julian Sikorski pisze:
>>>>>> W dniu 08.07.2018 o 19:46, Georg Chini pisze:
>>>>>>> On 08.07.2018 15:21, Julian Sikorski wrote:
>>>>>>>> W dniu 02.07.2018 o 20:09, Julian Sikorski pisze:
>>>>>>>>> W dniu 02.07.2018 o 18:04, Georg Chini pisze:
>>>>>>>>>> On 02.07.2018 17:58, Julian Sikorski wrote:
>>>>>>>>>>> W dniu 29.06.2018 o 21:47, Julian Sikorski pisze:
>>>>>>>>>>>> Hi list,
>>>>>>>>>>>>
>>>>>>>>>>>> I have noticed that the bluetooth connection between my laptop (Intel
>>>>>>>>>>>> 7260) and my headphones (Sennheiser Momentum Wirelless) is very
>>>>>>>>>>>> unreliable. While under Windows 10 devices stay connected for
>>>>>>>>>>>> hours on
>>>>>>>>>>>> end, under Fedora 28 the connection is lost every few minutes at
>>>>>>>>>>>> most.
>>>>>>>>>>>> Often the connection will be reestablished only to be lost again.
>>>>>>>>>>>> bluetoothd shows messages like:
>>>>>>>>>>>>
>>>>>>>
>>>>>>>>>>>> I am not sure where to look further. Does it look like an issue with
>>>>>>>>>>>> pulseaudio, or a deeper problem with linux bluetooth stack? Thanks
>>>>>>>>>>>> for
>>>>>>>>>>>> your input in advance!
>>>>>>>>>>>>
>>>>>>>>>>>> Best regards,
>>>>>>>>>>>> Julian
>>>>>>>>>>> This is what is logged by pulseaudio at the time the connection is
>>>>>>>>>>> lost:
>>>>>>>>>>>
>>>>>>>>>>> ( 118.064|  34.694) I: [bluetooth] module-bluez5-device.c: FD error:
>>>>>>>>>>> POLLERR POLLHUP
>>>>>>>>>>> ( 118.064|   0.000) I: [bluetooth] bluez5-util.c: Transport
>>>>>>>>>>> /org/bluez/hci0/dev_00_1B_66_81_8D_76/fd27 auto-released by BlueZ or
>>>>>>>>>>> already released
>>>>>>>>>>> ( 118.064|   0.000) I: [pulseaudio] backend-native.c: Lost RFCOMM
>>>>>>>>>>> connection.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>  From what you are writing, it looks to me as if the issue is in the
>>>>>>>>>> USB
>>>>>>>>>> stack and the BT dongle keeps disconnecting/connecting. Have you
>>>>>>>>>> tried another dongle?
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I unfortunately do not own any other dongles. I tried getting some
>>>>>>>>> useful info with btmon but the log seems flooded with way too many
>>>>>>>>> messages to make anything out.
>>>>>>>>>
>>>>>>>> Hi Georg,
>>>>>>>>
>>>>>>>> it looks like the problem is more related to how the dongle interacts
>>>>>>>> with this specific headphone model. I have recently bought another one
>>>>>>>> for running (AfterShokz Trekz Air) and it works perfectly, connecting
>>>>>>>> automatically, staying connected and even switching profiles
>>>>>>>> automatically without issues so far.
>>>>>>>> The hci0: last event is not cmd complete (0x0f) message seems harmless
>>>>>>>> as it spams the dmesg output regardless of the device connected (and
>>>>>>>> also when no device is connected at all.
>>>>>>>> It appears that whatever is happening it makes the dongle reconnect:
>>>>>>>>
>>>>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: USB disconnect, device number 6
>>>>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: new full-speed USB device number 7
>>>>>>>> using ehci-pci
>>>>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: New USB device found,
>>>>>>>> idVendor=8087, idProduct=07dc, bcdDevice= 0.01
>>>>>>>> [nie lip  8 15:14:12 2018] usb 2-1.4: New USB device strings: Mfr=0,
>>>>>>>> Product=0, SerialNumber=0
>>>>>>>> [nie lip  8 15:14:12 2018] Bluetooth: hci0: read Intel version:
>>>>>>>> 3707100180012d0d2a
>>>>>>>> [nie lip  8 15:14:12 2018] Bluetooth: hci0: Intel device is already
>>>>>>>> patched. patch num: 2a
>>>>>>>>
>>>>>>>> Where would you recommend to look for reasons for this behaviour? btmon?
>>>>>>>> Thank you for the pointers!
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>> Julian
>>>>>>>>
>>>>>>>>
>>>>>>> Hi Julian,
>>>>>>>
>>>>>>> sorry, I have no further ideas. Maybe Luiz can help you to investigate.
>>>>>>> To me it looks like the headphone is sending something that makes the
>>>>>>> dongle reset.
>>>>>>>
>>>>>>> Regards
>>>>>>>             Georg
>>>>>>
>>>>>> Hi Georg,
>>>>>>
>>>>>> no worries - hopefully Luiz will find some time to look into this.
>>>>>> In the meantime I have been getting acquainted with btmon. I have
>>>>>> managed to pinpoint the exact moment during which sound stops coming
>>>>>> through the headphones and starts coming through the laptop speakers. In
>>>>>> the below testcase, it happens at 18:42:58:
>>>>>>
>>>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>>>                               #1825 [hci0] 18:42:58.908586
>>>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>>>                               #1826 [hci0] 18:42:58.928877
>>>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>>>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>>>>>                            {0x0002} [hci0] 18:43:00.653578
>>>>>>         Class: 0x000000
>>>>>>           Major class: Miscellaneous
>>>>>>           Minor class: 0x00
>>>>>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>>>>>                            {0x0001} [hci0] 18:43:00.653578
>>>>>>         Class: 0x000000
>>>>>>           Major class: Miscellaneous
>>>>>>           Minor class: 0x00
>>>>>> @ MGMT Event: New Settings (0x0006) plen 4
>>>>>>                            {0x0002} [hci0] 18:43:00.653609
>>>>>>         Current settings: 0x00000ada
>>>>>>           Connectable
>>>>>>           Discoverable
>>>>>>           Bondable
>>>>>>           Secure Simple Pairing
>>>>>>           BR/EDR
>>>>>>           Low Energy
>>>>>>           Secure Connections
>>>>>> @ MGMT Event: New Settings (0x0006) plen 4
>>>>>>                            {0x0001} [hci0] 18:43:00.653609
>>>>>>         Current settings: 0x00000ada
>>>>>>           Connectable
>>>>>>           Discoverable
>>>>>>           Bondable
>>>>>>           Secure Simple Pairing
>>>>>>           BR/EDR
>>>>>>           Low Energy
>>>>>>           Secure Connections
>>>>>> = bluetoothd: Unable to get io data for Headset Voice gateway:
>>>>>> getpeername: Transport endpoint is not connected..   18:43:00.654133
>>>>>> = Close Index: 7C:5C:F8:B2:DF:08
>>>>>>                                     [hci0] 18:43:00.678348
>>>>>> @ MGMT Event: Index Removed (0x0005) plen 0
>>>>>>                            {0x0002} [hci0] 18:43:00.678372
>>>>>> @ MGMT Event: Index Removed (0x0005) plen 0
>>>>>>                            {0x0001} [hci0] 18:43:00.678372
>>>>>> = Delete Index: 7C:5C:F8:B2:DF:08
>>>>>>                                     [hci0] 18:43:00.678377
>>>>>> = bluetoothd: Endpoint unregistered: sender=:1.1492
>>>>>> path=/MediaEndpoint/A2DPSource
>>>>>> 18:43:00.678966
>>>>>> = bluetoothd: Endpoint unregistered: sender=:1.1492
>>>>>> path=/MediaEndpoint/A2DPSink
>>>>>> 18:43:00.678984
>>>>>>
>>>>>> I am copying linux-bluetooth, maybe someone there will have an idea as
>>>>>> well. Thank you for all your help in advance!
>>>>>>
>>>>>> Best regards,
>>>>>> Julian
>>>>>
>>>>> Hi all,
>>>>>
>>>>> I tried to get more information using hcidump, but it does not appear
>>>>> very interesting. I am attaching it here just in case. The last entry
>>>>> appearing - command complete (read encryption key size) - appears upon
>>>>> successful connection, not when the connection is dropped. How else
>>>>> could I try to figure out what is being sent at the time of
>>>>> disconnection? Thank you!
>>>>>
>>>>> Best regards,
>>>>> Julian
>>>>
>>>> Hi list,
>>>>
>>>> I just realised I never attached the full btmon dump. Here it goes, the
>>>> connection drops at 17:32:04:
>>>>
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1340 [hci0] 17:32:04.774611
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>                               #1341 [hci0] 17:32:04.783175
>>>>         Num handles: 1
>>>>         Handle: 256
>>>>         Count: 1
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1342 [hci0] 17:32:04.794981
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>                               #1343 [hci0] 17:32:04.803054
>>>>         Num handles: 1
>>>>         Handle: 256
>>>>         Count: 1
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1344 [hci0] 17:32:04.815326
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>>> HCI Event: Number of Completed Packets (0x13) plen 5
>>>>                               #1345 [hci0] 17:32:04.823198
>>>>         Num handles: 1
>>>>         Handle: 256
>>>>         Count: 1
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1346 [hci0] 17:32:04.835578
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1347 [hci0] 17:32:04.856093
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1348 [hci0] 17:32:04.876186
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1349 [hci0] 17:32:04.896454
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>> < ACL Data TX: Handle 256 flags 0x02 dlen 850
>>>>                               #1350 [hci0] 17:32:04.916869
>>>>       Channel: 450 len 846 [PSM 25 mode 0] {chan 2}
>>>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>>>                            {0x0002} [hci0] 17:32:06.637019
>>>>         Class: 0x000000
>>>>           Major class: Miscellaneous
>>>>           Minor class: 0x00
>>>> @ MGMT Event: Class Of Device Changed (0x0007) plen 3
>>>>                            {0x0001} [hci0] 17:32:06.637019
>>>>         Class: 0x000000
>>>>           Major class: Miscellaneous
>>>>           Minor class: 0x00
>>>> @ MGMT Event: New Settings (0x0006) plen 4
>>>>                            {0x0002} [hci0] 17:32:06.637034
>>>>         Current settings: 0x00000ada
>>>>           Connectable
>>>>           Discoverable
>>>>           Bondable
>>>>           Secure Simple Pairing
>>>>           BR/EDR
>>>>           Low Energy
>>>>           Secure Connections
>>>> @ MGMT Event: New Settings (0x0006) plen 4
>>>>                            {0x0001} [hci0] 17:32:06.637034
>>>>         Current settings: 0x00000ada
>>>>           Connectable
>>>>           Discoverable
>>>>           Bondable
>>>>           Secure Simple Pairing
>>>>           BR/EDR
>>>>           Low Energy
>>>>           Secure Connections
>>>> = Close Index: 7C:5C:F8:B2:DF:08
>>>>                                     [hci0] 17:32:06.654087
>>>> @ MGMT Event: Index Removed (0x0005) plen 0
>>>>                            {0x0002} [hci0] 17:32:06.654114
>>>> @ MGMT Event: Index Removed (0x0005) plen 0
>>>>                            {0x0001} [hci0] 17:32:06.654114
>>>> = Delete Index: 7C:5C:F8:B2:DF:08
>>>>                                     [hci0] 17:32:06.654120
>>>> = bluetoothd: Unable to get io data for Headset Voice gateway:
>>>> getpeername: Transport endpoint is not connected..   17:32:06.654352
>>>> = bluetoothd: Endpoint unregistered: sender=:1.750
>>>> path=/MediaEndpoint/A2DPSource
>>>> 17:32:06.654796
>>>> = bluetoothd: Endpoint unregistered: sender=:1.750
>>>> path=/MediaEndpoint/A2DPSink
>>>> 17:32:06.654836
>>>>
>>>> I tried sending the btmon capture as attachment but it appears to be too
>>>> large for the list, so I uploaded it here instead:
>>>>
>>>> https://belegdol.fedorapeople.org/btmon-aug.log
> 
> Is this perhaps related to https://github.com/bluez/bluez/issues/18,
> we have a fix already applied upstream for it.
> 

Hi Luiz,

it looks like a different issue. I tried both passing --noplugin=avrcp
and applying the two patches mentioned in the github issue to Fedora
RPM, neither helped. I am attaching a new btmon capture in case
something changed. In this one the disconnect happens after #371.

Best regards,
Julian
>>>> Best regards,
>>>> Julian
>>>>
>>>
>>> Hi all,
>>>
>>> I have tried the headset again with kernel-5.8.4, bluez-5.54 and
>>> pulseaudio-13.99.1. The situation has unfortunately not improved in the
>>> last two years.
>>> I am attaching the btmon capture of two connection attempts:
>>> - the first connects and then almost immediately disconnects
>>> - the second never succeeds
>>> Does the capture provide any information as to why the connection is
>>> failing? If I can provide any more data, please let me know. Thanks!
>>>
>>> Best regards,
>>> Julian
>>>
>> If I am not mistaken, the disconnect happens right after #636
>>
>> Best regards,
>> Julian
> 
> 
> 


--------------EA2EFEED3655352BC8E8D3C6
Content-Type: application/zip;
 name="btmon-m2aebt-2.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="btmon-m2aebt-2.zip"

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
--------------EA2EFEED3655352BC8E8D3C6--
