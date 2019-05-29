Return-Path: <SRS0=mLwb=T5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF6DC28CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 13:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CE8208CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 13:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrcSt4OM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfE2NAE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 May 2019 09:00:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44904 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2NAE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 May 2019 09:00:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so1690887wru.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2019 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=DG0J06WYquqjQTUpupTiSnY5wMFFJ7KNuevy5h6k2eQ=;
        b=PrcSt4OMi0ecfRdJffrQydRDu6wPCN6D08gEnmPezzMSbAYK91Etg+3eA+kQCzaTzr
         PVFD3Y8/iUWwuedGs9nKQKuP8OD3FmhYunzd9enbjpmzxpL93iwo11BcoZE2M+lpnfyS
         HuyEFBxrR7Kg6qNWtd9AeMlvXxgT5OYrgJbs0xI4q7DIbRpqxI6wipHGOyY+wcZXFOCs
         sE2V/nRDlM3YOgwsVPQU8djdmDh9tYQ5K1gVvkhZs+VmhTTKR5NfWd8r4mi7XBUHNQVv
         FTK7xt+vDbO5yWlDhbkB735OIqlCuJngZRognqQ298dlqEZUXKp3z3NruRLgmo1PldXY
         ompQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DG0J06WYquqjQTUpupTiSnY5wMFFJ7KNuevy5h6k2eQ=;
        b=ZrTr+tYPrnMEwowAHi7yByQBe3saqVOyGAhhsKakq2B9lzjheGpRVtxk0CEImpTcCb
         Zt/V0f7qXr3lR0v6V6tO6YaQCyn1zU49mv/2R5fEjXCNBxdNE5ncobyGKYdoJY5v9WV5
         e9Ri+LUPYWhjjOEltPUhO7iVRPpOsKHAss8D5JnU8KI+ffYNY4iw2/6zFUS3Z21RfqVf
         LsMtO0cZCpizccnDzLOnje5unOHT8eNDAmpy+CTHbMfJM09A3+OPYu8HtrIxOe49bue1
         fcr99G2Px5EjDEgY2SdqOR5v1gBdIG9Awl56sDbiWLug7PIn8xRBcdhUlmXPCjt6Lvl8
         o/VQ==
X-Gm-Message-State: APjAAAWFtbZqpXFJrQSr9josu9AErV/9DyQ3PmgHC0CHjFYe7BQjnl5z
        5txf7DIuqjX+674Q8jlITZlFp7PZn/0=
X-Google-Smtp-Source: APXvYqwGv/6ocRRLh/Q6zu5bssrKxMesLaBv/U1gLyRAUetUpptbm911dwUGmTCBHVnrgCAkVhaaVg==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr21871603wrw.309.1559134800919;
        Wed, 29 May 2019 06:00:00 -0700 (PDT)
Received: from [140.105.105.62] (cli105-62.wireless-s.units.it. [140.105.105.62])
        by smtp.gmail.com with ESMTPSA id 19sm6110918wmi.10.2019.05.29.06.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 06:00:00 -0700 (PDT)
Subject: Re: Problems with bluez
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f61b05a1-3e87-d09e-6892-ac1999dc6abd@gmail.com>
 <CABBYNZL8JopSfd4AYyYHLAHLzaSNuGPmHbMSOF9wbeNo_QwOLg@mail.gmail.com>
 <1a6318a2-1aef-a322-fe7e-d40848424f19@gmail.com>
 <CABBYNZ+WGZuOV1_m8ShopNrh24x_EpkbjCjEMjGKrfr3fw0WPA@mail.gmail.com>
From:   Matteo Formigli <matteo.formigli@gmail.com>
Message-ID: <77b3d8ee-a8c0-5090-6d83-afc8202b35fc@gmail.com>
Date:   Wed, 29 May 2019 14:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+WGZuOV1_m8ShopNrh24x_EpkbjCjEMjGKrfr3fw0WPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz!

Thanks for your advice. Now I am in a public library with a lot of 
bluetooth devices around so I think the btmon has quite an unreadable 
output. I will try to do it at home this evening. Instead I am postin 
here the output for the deamon logs:

:~$ sudo journalctl --unit=bluetooth.service
-- Logs begin at mer 2019-05-29 14:39:16 CEST, end at mer 2019-05-29 
14:53:13 CEST. --
mag 29 14:39:17 Sigmund-Lenovo systemd[1]: Starting Bluetooth service...
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Bluetooth daemon 5.37
mag 29 14:39:17 Sigmund-Lenovo systemd[1]: Started Bluetooth service.
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Starting SDP server
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Bluetooth management 
interface 1.10 initialized
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Failed to obtain 
handles for "Service Changed" characteristic
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Not enough free handles 
to register service
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Error adding Link Loss 
service
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Not enough free handles 
to register service
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Not enough free handles 
to register service
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Not enough free handles 
to register service
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Current Time Service 
could not be registered
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: gatt-time-server: 
Input/output error (5)
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Not enough free handles 
to register service
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Not enough free handles 
to register service
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: Sap driver 
initialization failed.
mag 29 14:39:17 Sigmund-Lenovo bluetoothd[1144]: sap-server: Operation 
not permitted (1)
mag 29 14:39:23 Sigmund-Lenovo bluetoothd[1144]: Endpoint registered: 
sender=:1.43 path=/MediaEndpoint/A2DPSource
mag 29 14:39:23 Sigmund-Lenovo bluetoothd[1144]: Endpoint registered: 
sender=:1.43 path=/MediaEndpoint/A2DPSink
mag 29 14:39:54 Sigmund-Lenovo bluetoothd[1144]: Endpoint registered: 
sender=:1.78 path=/MediaEndpoint/A2DPSource
mag 29 14:39:54 Sigmund-Lenovo bluetoothd[1144]: Endpoint registered: 
sender=:1.78 path=/MediaEndpoint/A2DPSink
mag 29 14:39:54 Sigmund-Lenovo bluetoothd[1144]: RFCOMM server failed 
for Headset Voice gateway: rfcomm_bind: Address already in use (98)
mag 29 14:40:11 Sigmund-Lenovo bluetoothd[1144]: Endpoint unregistered: 
sender=:1.43 path=/MediaEndpoint/A2DPSource
mag 29 14:40:11 Sigmund-Lenovo bluetoothd[1144]: Endpoint unregistered: 
sender=:1.43 path=/MediaEndpoint/A2DPSink

It seems that there are a lot of things that does not work... In any 
case do you think that bluez 5.37 is the last version of bluez 
compatible with my ubuntu 16.04 or there is some kind of broken package 
in my system?

Thanks a lot!

Regards,

Matteo

Il 29/05/19 14:22, Luiz Augusto von Dentz ha scritto:
> Hi Matteo,
>
> On Tue, May 28, 2019 at 11:10 PM Matteo Formigli
> <matteo.formigli@gmail.com> wrote:
>> Hi Luiz!
>>
>> First, thanks for your answer! For now I can't upgrade my ubuntu, but I
>> already tried to upgrade bluez launching classic shell commands such as
>> apt-get update, upgrade and dist-upgrade. But bluez remains at version
>> 5.37. I have to tell you that I tried to uninstall bluez and than
>> reinstall it. It was a gamble and maybe it went wrong, but I'm not sure.
>>
>> About the logs and the HCI traces I don't have knowledge to provide you
>> what you want on my own. Can you tell me what commands i have to put in
>> the terminal?
> 5.37 is quite old so there is a high risk there something new, like
> LE/GATT connection, that happens to be unstable at that point. You can
> use btmon to collect the the HCI traces:
>
>> sudo btmon -t
> You can also check the daemon logs with:
>
>> sudo journalctl --unit=bluetooth.service
>> Thanks in advance for your help!
>>
>> Matteo
>>
>> Il 28/05/19 20:54, Luiz Augusto von Dentz ha scritto:
>>> Hi Matteo,
>>>
>>> On Tue, May 28, 2019 at 9:38 PM Matteo Formigli
>>> <matteo.formigli@gmail.com> wrote:
>>>> Hi all!
>>>>
>>>>
>>>> I am using Ubuntu 16.04 and there is no way to make the bluetooth work.
>>>> Every time I try to pair to my bluetooth headset bluez crashes. I really
>>>> don't know where to start solving this problem and I really hope that
>>>> someone on this list can help me.
>>> Maybe it would help if you update your version of BlueZ, or better yet
>>> update your ubuntu, if that still doesn't work then we may have a look
>>> at some logs and HCI traces.
>>>
>>>> Thanks in advance for your help!
>>>>
>>>> Matteo
>>>>
>>>> P.s. The following is the output of the dpkg --status of the bluez packgage
>>>>
>>>> :~$ dpkg --status bluez
>>>> Package: bluez
>>>> Status: install ok installed
>>>> Priority: optional
>>>> Section: admin
>>>> Installed-Size: 4119
>>>> Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
>>>> Architecture: amd64
>>>> Multi-Arch: foreign
>>>> Version: 5.37-0ubuntu5.1
>>>> Replaces: bluez-alsa, bluez-audio (<= 3.36-3), bluez-input,
>>>> bluez-network, bluez-serial, bluez-utils (<= 3.36-3), udev (<< 170-1)
>>>> Depends: libc6 (>= 2.15), libdbus-1-3 (>= 1.9.14), libglib2.0-0 (>=
>>>> 2.31.8), libreadline6 (>= 6.0), libudev1 (>= 196), init-system-helpers
>>>> (>= 1.18~), lsb-base (>= 4.1+Debian11ubuntu7), kmod, udev (>= 170-1), dbus
>>>> Breaks: udev (<< 170-1)
>>>> Conflicts: bluez-alsa, bluez-audio (<= 3.36-3), bluez-utils (<= 3.36-3)
>>>> Conffiles:
>>>>     /etc/bluetooth/input.conf
>>>>     /etc/bluetooth/main.conf
>>>>     /etc/bluetooth/network.conf
>>>>     /etc/bluetooth/proximity.conf
>>>>     /etc/dbus-1/system.d/bluetooth.conf
>>>>     /etc/init.d/bluetooth
>>>>     /etc/init/bluetooth.conf
>>>> Description: Bluetooth tools and daemons
>>>>     This package contains tools and system daemons for using Bluetooth
>>>> devices.
>>>>     .
>>>>     BlueZ is the official Linux Bluetooth protocol stack. It is an Open
>>>> Source
>>>>     project distributed under GNU General Public License (GPL).
>>>> Homepage: http://www.bluez.org
>>>> Original-Maintainer: Debian Bluetooth Maintainers
>>>> <pkg-bluetooth-maintainers@lists.alioth.deb
>>>>
>
>
