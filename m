Return-Path: <SRS0=Ljem=T4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E6C04AB6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 May 2019 20:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98AD920989
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 May 2019 20:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpPkePpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfE1UKk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 May 2019 16:10:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55962 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfE1UKk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 May 2019 16:10:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id u78so4325403wmu.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2019 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PahAjDs+1YB2b8YiALDZfddCA9+HPt88Mcg3NO1wTDk=;
        b=FpPkePpT0wEHnXrY5M8wPUfYNu0orIdvXTEXiuA2QVLsiRu8pLU3wIpa/JxgYp6dx4
         opzjuNZIQUMh7aeS0LG5P3Q0j8mdup/fdhzhFcO9B2tMFqNXD7j69axGPRiFTLXCzUuS
         Wp4VOp0mqoCcv3f0Wpa4vLU9k7fEnw7wxS/4zGvDv2qqie13dcSKzIsTlBYD2SSMZeH+
         AEDFlaheUGjPFX056WkVzUhhgrrEmLscOjZBqHTvbLEjkmVbvnZ0M7486aRhMcqJ8QDV
         K4xD4XlxDshj/D5aBq2+9xT96fmRhdLz9up4z/wE75bdMxNHl5dbRVDYsmrEb8VztnUA
         q6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PahAjDs+1YB2b8YiALDZfddCA9+HPt88Mcg3NO1wTDk=;
        b=Uj0iULmKrs0lgDpIklRPc9AfQjH/C05QrTAF61mQlhtthxqo8+SdlXpv8IKfwvhkRC
         8P+bIq+PgXzX7gnkIeD/AqZcf2dG9JZV11A0bJ7iUD/lUBTp0VvdMoyJ2y0FvvGWAQDm
         +88CxLn6FhyX4uUYra22pbOBkg5Q7dpA3FTIlByDtyeSUf6YQhxjkDhpb682H+xM0Si6
         lgL+zdldLesx3tqyAYxxVIiAQQbLjUE8zQvGCt03UzxiiHrJEQ/QHNbCI6IjuNlDG3RV
         c6aJpmgKCp4Fq9yKWFWnNvtfl/Ia4f9Sv3YNr+1MTBGvyU/mIOa7aea10JfARN5sxA7+
         8QVQ==
X-Gm-Message-State: APjAAAVKrsF6MXxc4GEr/XOGCMVKw+psZ8b3zPX38neytbylArIr62r8
        a9Grhv9UdVsgvMQMTfFAXFuIeM1oN+M=
X-Google-Smtp-Source: APXvYqzPuh0tCAyeAUB6+WoW7d01klmvRdzytjMQMuLsQT9Ug97P8O7b1N/sG6e8Gl0iyU096JOTZg==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr3761464wmk.9.1559074237763;
        Tue, 28 May 2019 13:10:37 -0700 (PDT)
Received: from [192.168.1.10] (93-34-147-76.ip50.fastwebnet.it. [93.34.147.76])
        by smtp.gmail.com with ESMTPSA id l18sm39979807wrh.54.2019.05.28.13.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 13:10:37 -0700 (PDT)
Subject: Re: Problems with bluez
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f61b05a1-3e87-d09e-6892-ac1999dc6abd@gmail.com>
 <CABBYNZL8JopSfd4AYyYHLAHLzaSNuGPmHbMSOF9wbeNo_QwOLg@mail.gmail.com>
From:   Matteo Formigli <matteo.formigli@gmail.com>
Message-ID: <1a6318a2-1aef-a322-fe7e-d40848424f19@gmail.com>
Date:   Tue, 28 May 2019 22:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CABBYNZL8JopSfd4AYyYHLAHLzaSNuGPmHbMSOF9wbeNo_QwOLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz!

First, thanks for your answer! For now I can't upgrade my ubuntu, but I 
already tried to upgrade bluez launching classic shell commands such as 
apt-get update, upgrade and dist-upgrade. But bluez remains at version 
5.37. I have to tell you that I tried to uninstall bluez and than 
reinstall it. It was a gamble and maybe it went wrong, but I'm not sure.

About the logs and the HCI traces I don't have knowledge to provide you 
what you want on my own. Can you tell me what commands i have to put in 
the terminal?

Thanks in advance for your help!

Matteo

Il 28/05/19 20:54, Luiz Augusto von Dentz ha scritto:
> Hi Matteo,
>
> On Tue, May 28, 2019 at 9:38 PM Matteo Formigli
> <matteo.formigli@gmail.com> wrote:
>> Hi all!
>>
>>
>> I am using Ubuntu 16.04 and there is no way to make the bluetooth work.
>> Every time I try to pair to my bluetooth headset bluez crashes. I really
>> don't know where to start solving this problem and I really hope that
>> someone on this list can help me.
> Maybe it would help if you update your version of BlueZ, or better yet
> update your ubuntu, if that still doesn't work then we may have a look
> at some logs and HCI traces.
>
>> Thanks in advance for your help!
>>
>> Matteo
>>
>> P.s. The following is the output of the dpkg --status of the bluez packgage
>>
>> :~$ dpkg --status bluez
>> Package: bluez
>> Status: install ok installed
>> Priority: optional
>> Section: admin
>> Installed-Size: 4119
>> Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
>> Architecture: amd64
>> Multi-Arch: foreign
>> Version: 5.37-0ubuntu5.1
>> Replaces: bluez-alsa, bluez-audio (<= 3.36-3), bluez-input,
>> bluez-network, bluez-serial, bluez-utils (<= 3.36-3), udev (<< 170-1)
>> Depends: libc6 (>= 2.15), libdbus-1-3 (>= 1.9.14), libglib2.0-0 (>=
>> 2.31.8), libreadline6 (>= 6.0), libudev1 (>= 196), init-system-helpers
>> (>= 1.18~), lsb-base (>= 4.1+Debian11ubuntu7), kmod, udev (>= 170-1), dbus
>> Breaks: udev (<< 170-1)
>> Conflicts: bluez-alsa, bluez-audio (<= 3.36-3), bluez-utils (<= 3.36-3)
>> Conffiles:
>>    /etc/bluetooth/input.conf
>>    /etc/bluetooth/main.conf
>>    /etc/bluetooth/network.conf
>>    /etc/bluetooth/proximity.conf
>>    /etc/dbus-1/system.d/bluetooth.conf
>>    /etc/init.d/bluetooth
>>    /etc/init/bluetooth.conf
>> Description: Bluetooth tools and daemons
>>    This package contains tools and system daemons for using Bluetooth
>> devices.
>>    .
>>    BlueZ is the official Linux Bluetooth protocol stack. It is an Open
>> Source
>>    project distributed under GNU General Public License (GPL).
>> Homepage: http://www.bluez.org
>> Original-Maintainer: Debian Bluetooth Maintainers
>> <pkg-bluetooth-maintainers@lists.alioth.deb
>>
>
