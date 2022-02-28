Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4491C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Feb 2022 21:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiB1VDF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Feb 2022 16:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiB1VDE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Feb 2022 16:03:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFCDE2C0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 13:02:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j17so17437179wrc.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Feb 2022 13:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=eDK54Mi47ux+H8/Fc/yYFMHxLB+WNQmcSJ3zj0ycUOs=;
        b=Nao/xJaZSChztmqL9RGX7AvqUh5RbQsrizqO0XgzO06WkVKwA0gLVz2uVNNNw+xn1e
         oM7wtSQNqCx+9Kd55UqqLJ4XbzJ65aHtT1DPi9hCndP1RBaI/WtKCzGxem8kZPcjIVDU
         jdePWG6iNQiMG5b8N29+esQFWAqgVyAha7mYlfw7ZxEfoQ2jdc8vNs3DzC8iVip5zPrA
         048RzUYVKJXZlCTFk77Gw/HkBSMSEkMtwlVExwFvAGTNuKRJ5m4SeEiQNjzVQgMRxlsk
         qI/EU4OwM/+GKyETJyncvpnfRHkqUJwE0GLwLN8TtZ1/MpnmNKAoCv6negojr3ftJXQE
         ukGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eDK54Mi47ux+H8/Fc/yYFMHxLB+WNQmcSJ3zj0ycUOs=;
        b=Uyr/IZx4ch1FZsrPZRmkoL8yaaT6i73dPQfU79J8mJGv1ljMX76I6AgsNqi2TFKgWf
         M+WMn7bzWvu/5YbisB6LdwS1ZMROwLI957spj9tL5wYYO4b9/KOFzVxllwC73mBas6Ro
         VIqfj6PFxLJxsSihsPNyzwbm4NWT1oRVjjgoPIjQItz55WTKI5N0+8apmQX2kotCuDuG
         hw911uUxmPAEMqZu8KByJ5EoarUw9IBXn7PbXNyLvUfQzHHmFsQTnIMBPF7bSKaQ98hG
         lqEU1y8lRGFsysmFoE1qdYojTAcUj73roIGsvlVVZCLQjsxDl6uo2gh6FuK2iNBtzlcF
         wujQ==
X-Gm-Message-State: AOAM531/UNcLH8Xo8zOzYbWdOfKKPvFo0q1hUyYL6MxipIy5TG2Vpkhk
        opabrzGD9Hp6mEwQlH6Nk4w=
X-Google-Smtp-Source: ABdhPJwoNrHa3wHYLr1Nwhc0H28rkR6weh2g6+kZp6mUAlNgMQkZGkW8boEOIe1YXeft3Hho6D7iAw==
X-Received: by 2002:adf:f406:0:b0:1ef:879c:3228 with SMTP id g6-20020adff406000000b001ef879c3228mr9614804wro.287.1646082142799;
        Mon, 28 Feb 2022 13:02:22 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id n15-20020a5d4c4f000000b001f0052c712bsm335917wrt.102.2022.02.28.13.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 13:02:21 -0800 (PST)
Message-ID: <6b17bdb5-dddb-e7c7-86f6-2240c6523a81@googlemail.com>
Date:   Mon, 28 Feb 2022 21:02:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: bug kernel 5.17, qualcom and intel adapters, unable to reliably
 connect to bluetooth devices
Content-Language: en-GB
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Bluetooth <linux-bluetooth@vger.kernel.org>,
        regressions@lists.linux.dev
References: <CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com>
 <CAJCQCtTpHQe2co3fLNs5csKQchmwH=3YwQOvFnuc2nhjRseVnw@mail.gmail.com>
 <9ad505e1-7b59-7ebf-378b-23a6c0e25802@googlemail.com>
 <CABBYNZ+9tUKgLyUWM5vkMW8vHxYsXv6DEaDWdHt8xTTs6puGQA@mail.gmail.com>
 <aaeb4131-d177-d41e-617b-b0060cd83c92@googlemail.com>
 <CABBYNZLB+8UzhzttMrKbHW_+-A1EsY9iT5Y55VuOOEPuD4kAHQ@mail.gmail.com>
 <b1a4a920-dbba-58be-72b4-2c95b9b79283@googlemail.com>
 <82216882-463a-8976-e6bc-4a8919107a31@googlemail.com>
 <CABBYNZ+mO1gQgfwhemY9cqbi8vNLm_60A9c1vPYT2tH4rhgFww@mail.gmail.com>
 <a35b4b75-bb64-89c8-bacd-d58ed8576272@googlemail.com>
 <2ce6175c-74ec-8469-80a5-374bd1429542@googlemail.com>
 <CABBYNZJNTOT-mEQe2cfZiEX6A2pR7+sacBqtBRPRZY69YmgtvA@mail.gmail.com>
 <17f2bf7e-1d6b-e090-8926-21a408f2b496@googlemail.com>
 <CABBYNZ+cL4f8xvTJFQGLgqPueE=-UsOtvcPQez0BEsJ5xGppfQ@mail.gmail.com>
 <16cac2c8-c1ca-c8d7-e3d9-5f00be511614@googlemail.com>
 <CABBYNZJQOSZ1fecTRQOX+w8crdiLdr0_tVstgbnyEVq3NaxscQ@mail.gmail.com>
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <CABBYNZJQOSZ1fecTRQOX+w8crdiLdr0_tVstgbnyEVq3NaxscQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 28/02/2022 19:34, Luiz Augusto von Dentz wrote:
> Hi Chris,
> 
> On Sat, Feb 26, 2022 at 12:04 AM Chris Clayton <chris2553@googlemail.com> wrote:
>>
>> Hi,
>>
>> On 24/02/2022 15:16, Luiz Augusto von Dentz wrote:
>>>> I'll try another bisection today, but limit its range to changes made in the net/bluetooth directory.
>>
>> That  bisection has proved very difficult because the bluetooth "service" in kernels at some steps of the bisection were
>> completely borked to the extent that blueman's device-manager application wouldn't start and emitted the messages:
>>
>> blueman-manager 12.00.37 ERROR    Manager:137 on_dbus_name_appeared: Default adapter not found, trying first available.
>> blueman-manager 12.00.37 ERROR    Manager:141 on_dbus_name_appeared: No adapter(s) found, exiting
>>
>> Obviously, I don't know whether the problem I am trying to pinpoint is hiding behind this more fundamental problem with
>> the bluetooth "service", so being unable to say whether that kernel was good or bad, I had to skip. There seems to be a
>> batch of commits that mean that, whilst the kernel builds okay, hunting down a bluetooth-related problem is not
>> possible. Eventually and I cursed and gave up. Whatever was causing this breakage has obviously been fixed.
>>
>>> Please record the HCI with btmon, it must be producing something since
>>> it records even the mgmt commands.
>>>
>>
>> Refreshed by a good night's sleep, I started another bisection (between 5.16 and 5.17-rc1) yesterday morning but this
>> time did not limit it to net/bluetooth.  That was going okay until I ran into what I assume is the same batch of borked
>> kernels. I've been more persistent this time but have just had a run of 16 steps in which the bluetooth support in the
>> kernel is broken so badly that testing bluetooth is not possible. I will push on today, but I've suspended that activity
>> to get the hci trace that Luiz has asked for.
>>
>> Using information from the bisect, I built a kernel that had tested as bad (but not borked). The commit is
>> f2b551fad8d8f2ac5e1f810ad595298381e0b0c5. As I've mentioned before, the problem with devices not connecting is
>> intermittent - for a given kernel, sometimes a connection works and other times it doesn't. On the first boot of this
>> kernel, my bluetooth devices could connect, Attached are 4 files related to this - the output from btmon, and the
>> related portions of daemon.log, kern.log and sys.log from /var/log/. Each of the these files is suffixed with ".good".
>>
>> I then powered down the laptop and booted into the same kernel. This time the bluetooth devices could not connect. Four
>> more files are attached for this boot and are suffixed with ".bad". I said in an earlier email that when connection
>> fails, there is no output from btmon, so that log is empty. That's still the case, but I guess that fact itself is a
>> clue to what the problem might be. What I can add, however, is that if, in that same bad kernel, I unload and then
>> reload the btusb module, connections start to work. Maybe that too is a clue. The same unload/load process revives
>> bluetooth on a kernel built after a pull of Linus' latest and greatest this morning.
>>
>> Since I now have a workround, I'm going stop the current bisection that I was doing.  I've done another couple of steps
>> this morning and both produced kernels on which I could not test bluetooth and had to tell git bisect to skip. If
>> however, I can provide any other diagnostics, please let me know.
>>
>> Chris
> 
> Can you try with the following patch:
> 
> https://patchwork.kernel.org/project/bluetooth/patch/20220228173918.524733-1-brian.gix@intel.com/
> 
> 
Sorry, that patch has made no difference. After the first boot my headphones connected okay, but after a power-down and
reboot they would not connect without an unload and reload of the btusb module.

Chris
