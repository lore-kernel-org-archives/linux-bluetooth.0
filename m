Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1B0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Mar 2022 18:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiCAS5l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiCAS5l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 13:57:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C861A06
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 10:56:57 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so1217592wmq.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Mar 2022 10:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SWEI93yfGbpWOM+6hji8PFGV8eOLo8IDaBqB5egfY1M=;
        b=al+EPycduS3zhBQDGbo7mIFyjagdz6xnOOycQjL7Rz1V9ZSxCT35QfpzWaG0Umfyow
         WRTMZDXlWegL0/ohxls+J1AQKAfXS9QVJMqwllMU6lrgL+h1G5o1ejHFBvOBCcc1sOXk
         C6PIbcD3ZFer7tmu98joRBjS+fcwxe1IwPkAUvJBVQP4nOmx5c+7rhty9eS3gX5tFtdq
         kGD+puoYj1v2crFvU3Z2d4ygqHwXIOtorFNOzlRUTNcK0OhEqol33NvDHpjqfr/02rZo
         BbUiQ5AKwiZ06AqolhJSfjqv+VbBOm/dVLyXKxmPUlFtB9sCQk6nvs7wcQHLHBViPi7w
         xAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SWEI93yfGbpWOM+6hji8PFGV8eOLo8IDaBqB5egfY1M=;
        b=7zAHJd7N2B+Os7mi4s9f7s0uX8nLLDB9J/S9J+lAKmMewEPjz0UVXgSrRrEpLjRh/h
         6zDygopxrE8nPvR9E09vdH48B5ykOxnqvPVAUSGy/iI3KBbE4iEMiSEONJpwXbR7jhgM
         S0FzNuLB5R4n/LFy0ABqapEGbP8Vez9jU+Z8GlUcG2tjGxmAhXhQFrLy50CaoZYbUhRj
         NpSlr30xAKifOztT71rlRaoohcVQBUJi52V3swxE6Zef7Q+ImshjewYb2t8G6SQZhTSj
         yCDHIzGcCb2b7VoUkJyLZuHP0HC077qm3KF03JAloiYO+BdbSbCCEvzX4DVNOYhvyItB
         fI7w==
X-Gm-Message-State: AOAM533eT/YHGuYBuk8++ICWmRF3ZDLA1AcYqHtmVFbjpSjYYMguxfin
        SyqP5hau+/44JbeWZvYtUsKKoC5S2No=
X-Google-Smtp-Source: ABdhPJwCURoe6cQR75MCKTQ1nywyVeaTcGOKmx4/1+KjF2FqY4iMB5MwJ8LfHvYtB7vqXQjhDKUIUQ==
X-Received: by 2002:a05:600c:2217:b0:381:546c:92c1 with SMTP id z23-20020a05600c221700b00381546c92c1mr10426575wml.38.1646161015897;
        Tue, 01 Mar 2022 10:56:55 -0800 (PST)
Received: from [192.168.1.10] (4e691f2a.skybroadband.com. [78.105.31.42])
        by smtp.googlemail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm14431768wrv.10.2022.03.01.10.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 10:56:55 -0800 (PST)
Message-ID: <94c891cf-86d8-d5a6-083c-8fe9e51f2581@googlemail.com>
Date:   Tue, 1 Mar 2022 18:56:54 +0000
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
 <6b17bdb5-dddb-e7c7-86f6-2240c6523a81@googlemail.com>
 <CABBYNZ+2Dg+AdnJqpR=wS0juektNapwHcPHBWdZyvSGFT1dVLQ@mail.gmail.com>
 <cdfed116-a5ea-0313-ba87-da429a0ac089@googlemail.com>
 <CABBYNZLnMwod+pgomEfvu83AJ=jM+uqwK9-Eqj6fA9_wXg6HBA@mail.gmail.com>
From:   Chris Clayton <chris2553@googlemail.com>
In-Reply-To: <CABBYNZLnMwod+pgomEfvu83AJ=jM+uqwK9-Eqj6fA9_wXg6HBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi

On 01/03/2022 18:34, Luiz Augusto von Dentz wrote:
> Hi Chris,
> 
> On Tue, Mar 1, 2022 at 1:26 AM Chris Clayton <chris2553@googlemail.com> wrote:
>>
>> Hi Luiz,
>>
>> I guess you are hoping for PEBKAC :-)
>>
>> On 28/02/2022 21:20, Luiz Augusto von Dentz wrote:
>>> Hi Chris,
>>>
>>> On Mon, Feb 28, 2022 at 1:02 PM Chris Clayton <chris2553@googlemail.com> wrote:
>>>>
>>>> Hi Luiz,
>>>>
>>>> On 28/02/2022 19:34, Luiz Augusto von Dentz wrote:
>>>>> Hi Chris,
>>>>>
>>>>> On Sat, Feb 26, 2022 at 12:04 AM Chris Clayton <chris2553@googlemail.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 24/02/2022 15:16, Luiz Augusto von Dentz wrote:
>>>>>>>> I'll try another bisection today, but limit its range to changes made in the net/bluetooth directory.
>>>>>>
>>>>>> That  bisection has proved very difficult because the bluetooth "service" in kernels at some steps of the bisection were
>>>>>> completely borked to the extent that blueman's device-manager application wouldn't start and emitted the messages:
>>>>>>
>>>>>> blueman-manager 12.00.37 ERROR    Manager:137 on_dbus_name_appeared: Default adapter not found, trying first available.
>>>>>> blueman-manager 12.00.37 ERROR    Manager:141 on_dbus_name_appeared: No adapter(s) found, exiting
>>>>>>
>>>>>> Obviously, I don't know whether the problem I am trying to pinpoint is hiding behind this more fundamental problem with
>>>>>> the bluetooth "service", so being unable to say whether that kernel was good or bad, I had to skip. There seems to be a
>>>>>> batch of commits that mean that, whilst the kernel builds okay, hunting down a bluetooth-related problem is not
>>>>>> possible. Eventually and I cursed and gave up. Whatever was causing this breakage has obviously been fixed.
>>>>>>
>>>>>>> Please record the HCI with btmon, it must be producing something since
>>>>>>> it records even the mgmt commands.
>>>>>>>
>>>>>>
>>>>>> Refreshed by a good night's sleep, I started another bisection (between 5.16 and 5.17-rc1) yesterday morning but this
>>>>>> time did not limit it to net/bluetooth.  That was going okay until I ran into what I assume is the same batch of borked
>>>>>> kernels. I've been more persistent this time but have just had a run of 16 steps in which the bluetooth support in the
>>>>>> kernel is broken so badly that testing bluetooth is not possible. I will push on today, but I've suspended that activity
>>>>>> to get the hci trace that Luiz has asked for.
>>>>>>
>>>>>> Using information from the bisect, I built a kernel that had tested as bad (but not borked). The commit is
>>>>>> f2b551fad8d8f2ac5e1f810ad595298381e0b0c5. As I've mentioned before, the problem with devices not connecting is
>>>>>> intermittent - for a given kernel, sometimes a connection works and other times it doesn't. On the first boot of this
>>>>>> kernel, my bluetooth devices could connect, Attached are 4 files related to this - the output from btmon, and the
>>>>>> related portions of daemon.log, kern.log and sys.log from /var/log/. Each of the these files is suffixed with ".good".
>>>>>>
>>>>>> I then powered down the laptop and booted into the same kernel. This time the bluetooth devices could not connect. Four
>>>>>> more files are attached for this boot and are suffixed with ".bad". I said in an earlier email that when connection
>>>>>> fails, there is no output from btmon, so that log is empty. That's still the case, but I guess that fact itself is a
>>>>>> clue to what the problem might be. What I can add, however, is that if, in that same bad kernel, I unload and then
>>>>>> reload the btusb module, connections start to work. Maybe that too is a clue. The same unload/load process revives
>>>>>> bluetooth on a kernel built after a pull of Linus' latest and greatest this morning.
>>>>>>
>>>>>> Since I now have a workround, I'm going stop the current bisection that I was doing.  I've done another couple of steps
>>>>>> this morning and both produced kernels on which I could not test bluetooth and had to tell git bisect to skip. If
>>>>>> however, I can provide any other diagnostics, please let me know.
>>>>>>
>>>>>> Chris
>>>>>
>>>>> Can you try with the following patch:
>>>>>
>>>>> https://patchwork.kernel.org/project/bluetooth/patch/20220228173918.524733-1-brian.gix@intel.com/
>>>>>
>>>>>
>>>> Sorry, that patch has made no difference. After the first boot my headphones connected okay, but after a power-down and
>>>> reboot they would not connect without an unload and reload of the btusb module.
>>>
>>> Can you tell us exactly what steps you are using? Are you applying on
>>> top of what, rc6?
>>>
>>
>> Until I got your patch yesterday, I was using a clone of
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git which I update frequently and have been doing so for as
>> long as I can remember. Just in case there was a hidden flaw in that tree, I took a new clone yesterday, (so yes, the
>> patch was tested on top of rc6) copied over the .config file and applied the patch. Then I built and installed the
>> kernel, updated grub, powered off the laptop and booted into the new kernel. Once the laptop had booted and logged in to
>> my LXQt desktop, I powered on my headphones and a connection was establisehed almost straight away. I powered the
>> headphones off and the disconnection worked fine.
>>
>> Knowing that the problem crops up intermittently, I then rebooted the laptop. When the boot was complete, I then powered
>> on my bluetooth headphones an waited for them to connect to the laptop. After about 20 seconds, a connection had not
>> been established. I powered off the headphones, used modprobe to unload and then reload the btusb module. When I powered
>> on the headphones, a connectiin was established within 2 or 3 seconds.
>>
>> I've booted this laptop countless times over the last few days. Doing the bisect, I didn't mark a commit as good until I
>> had done five boots and been able to connect my headphones on each boot. What I can say from that work is that two
>> consecutive boots into a working kernel are very rare. I can't remeber an occasion when it took more than two boots to
>> establish that a kernel was bad.
> 
> Do commands such as bluetoothctl power on or scan on works?

You're taking about systemd things here but as I said last week, I don't use systemd. I use sysvinit and an associated
set of boot scripts.

 Try
> running bluetoothd -dn from a shell (disable bluetooth.service), also
> are there any settings changed in main.conf?
> 
OK, I'll try that later, It might be tomorrow because I'm busy with other stuff at the moment.

Chris

> 
