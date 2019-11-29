Return-Path: <SRS0=sIa/=ZV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E162C432C0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Nov 2019 01:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF492176D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Nov 2019 01:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=socoptimum-com.20150623.gappssmtp.com header.i=@socoptimum-com.20150623.gappssmtp.com header.b="BsUTqqnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfK2B2U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Nov 2019 20:28:20 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:35404 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfK2B2U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Nov 2019 20:28:20 -0500
Received: by mail-pl1-f175.google.com with SMTP id s10so12238491plp.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2019 17:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=socoptimum-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+Nw9uo4YmWR1h8TLhALqelnOZ3+2+sd0GZkVTmCUuOI=;
        b=BsUTqqnqvKMOdzT6qztpHBd6bvCFp3iFexZYPAQZGG9JbbzfmPytDwtLWN9jphvP7+
         I+v4OymQZ2qyvLAokTh2qpshR2ywUJU2Ldnpz3jI9mun69j8HpEQVNsLurTUispNt8OT
         Fh6hlxXk41eFmhDxwbBpwdLEMhv44KoR+WBxEBHnoY8zSvpkqWBFF2bRLILhNDiXRISh
         Q6qE8qXI12IGYUy/40F9LPhL6mPYGlDVJvjaj9zlo7snNgHkMoi6mxCh4ACeJu+1S8NV
         Ne1tET8rmvc1fO+xkxc0PAK5f9t8+UarDMsVY2O0daGjBDf3FDc1IiGJIvffc8Omct+n
         +gwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+Nw9uo4YmWR1h8TLhALqelnOZ3+2+sd0GZkVTmCUuOI=;
        b=EWhXv/omItPwEpJOtnWgARAv9NoIaHlweF4EWOQLfkcdGKxZL1MhE+c0CDP18KRkWy
         4rzlUkMf00R7CgmTb2zwH4gtOOhsoBg+LpUkIq1jEPhGO5jkD6Vj6U/w6Zxn0uvewL9+
         iPQdQvw15EFgB09LR5HmzhR4qpJc4EIrkzDNplfyURTEEDhdjJ97IuhDBjh9aRgwygbq
         QjV4mcWtOT3RA4QVgYxg6q8ek0KAiSB/gpya73rxKZDgKK7c9QPw0gTb51AmnCwtP8bz
         LaQuJS0W05XWiRVYPXeQoKek+piFfG5rRUyHhrw7Cs5pLCOg+ZuFsJxXWi2u+gyDOIfb
         1DvA==
X-Gm-Message-State: APjAAAUVR7R1YC5Ulk6iKTEgrTj1ntVw6DTLqDzzfFDAWNzjNJ9GoIZT
        bhSvwM6iB6x3xzXa1g1Fkf/2+Y8IcbI=
X-Google-Smtp-Source: APXvYqzkpYeqbhaMK1NEkLWOmvqr9oFoAgBZoM+S5ZeAQ8sEttglAb1YXr6sgMtsHB/HDH1vFRBIFg==
X-Received: by 2002:a17:902:758a:: with SMTP id j10mr12570698pll.29.1574990898579;
        Thu, 28 Nov 2019 17:28:18 -0800 (PST)
Received: from [192.168.0.107] ([106.51.28.78])
        by smtp.gmail.com with ESMTPSA id p3sm21839625pfb.163.2019.11.28.17.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 17:28:17 -0800 (PST)
Subject: Re: bluez meshctl error: socket operation on non-socket
To:     Steve Brown <sbrown@ewol.com>, "Gix, Brian" <brian.gix@intel.com>,
        Ananth J <ananth@socoptimum.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <b260550e-0884-662d-e395-90e7678cb1a7@socoptimum.com>
 <78DAB7EA-B99D-4EDE-804B-7D127203DA1B@intel.com>
 <b332ed76-d5b1-c245-9301-3af578a274e4@socoptimum.com>
 <F3DC25C3-6C29-402B-B935-A4171B336403@intel.com>
 <f08116d3-4329-06a9-1b35-f8a7e4c8eff5@socoptimum.com>
 <d8c0faa1bde18f8cb7180344bb03c816acdcdd3c.camel@ewol.com>
From:   Venkat Vallapaneni <vallapaneni@socoptimum.com>
Message-ID: <9da49c06-9c21-ca17-e802-e324883d9014@socoptimum.com>
Date:   Fri, 29 Nov 2019 06:58:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d8c0faa1bde18f8cb7180344bb03c816acdcdd3c.camel@ewol.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Yes, if I run bluetooth-mesh daemon with systemctl, I am able to execute 
create successfully but if I run the daemon with sudo manually, create 
crashes.
Any order dependencies for daemon that are broken when run manually but 
honored with systemctl?

Rgds,
Venkat.

On 29/11/19 4:35 am, Steve Brown wrote:
> I've successfully provisioned the zephyr onoff-app with both meshctl
> and mesh-cfgclient.
>
> However, when installing meshd, I found that you have to enable
> bluetooth-mesh with systemctl or I get this when I issue the "create".
>
> GNU gdb (Ubuntu 8.3-0ubuntu1) 8.3
> Copyright (C) 2019 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "aarch64-linux-gnu".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <http://www.gnu.org/software/gdb/bugs/>;.
> Find the GDB manual and other documentation resources online at:
>      <http://www.gnu.org/software/gdb/documentation/>;.
>
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from mesh-cfgclient...
> (gdb) run
> Starting program: /usr/bin/mesh-cfgclient
>
> Warning: config file "/home/ubuntu/.config/meshcfg/config_db.json" not found
> [mesh-cfgclient]# create 0100
>
> Program received signal SIGSEGV, Segmentation fault.
> l_dbus_proxy_method_call (proxy=0x0, method=0xaaaaaaada7a8 "CreateNetwork", setup=0xaaaaaaab6ba0 <create_net_setup>, reply=0xaaaaaaab69e0 <create_net_reply>, user_data=0x0, destroy=0x0)
>      at ell/dbus-client.c:305
> 305		req->proxy = proxy;
> (gdb) bt
> #0  l_dbus_proxy_method_call (proxy=0x0, method=0xaaaaaaada7a8 "CreateNetwork", setup=0xaaaaaaab6ba0 <create_net_setup>, reply=0xaaaaaaab69e0 <create_net_reply>, user_data=0x0, destroy=0x0)
>      at ell/dbus-client.c:305
> #1  0x0000aaaaaaac1c34 in cmd_exec (argv=0xaaaaaab40650, argc=2, entry=0xaaaaaaafdf18 <main_menu+16>) at src/shared/shell.c:441
> #2  menu_exec (entry=0xaaaaaaafdf18 <main_menu+16>, argc=argc@entry=2, argv=argv@entry=0xaaaaaab40650) at src/shared/shell.c:468
> #3  0x0000aaaaaaac2008 in shell_exec (argc=2, argv=0xaaaaaab40650) at src/shared/shell.c:511
> #4  0x0000aaaaaaac312c in rl_handler (input=0xaaaaaab41900 "create 0100") at src/shared/shell.c:713
> #5  0x0000ffffbf6809e8 in rl_callback_read_char () from /lib/aarch64-linux-gnu/libreadline.so.8
> #6  0x0000aaaaaaac1ecc in input_read (io=<optimized out>, user_data=<optimized out>) at src/shared/shell.c:1256
> #7  0x0000aaaaaaac7440 in io_callback (fd=<optimized out>, events=1, user_data=0xaaaaaab40780) at ell/io.c:126
> #8  0x0000aaaaaaac83f8 in l_main_iterate (timeout=<optimized out>) at ell/main.c:473
> #9  0x0000aaaaaaac84d8 in l_main_run () at ell/main.c:520
> #10 l_main_run () at ell/main.c:502
> #11 0x0000aaaaaaac86f4 in l_main_run_with_signal (callback=callback@entry=0xaaaaaaac3c20 <l_sig_func>, user_data=user_data@entry=0x0) at ell/main.c:642
> #12 0x0000aaaaaaac3cf4 in mainloop_run_with_signal (func=func@entry=0xaaaaaaac2130 <signal_callback>, user_data=user_data@entry=0x0) at src/shared/mainloop-ell.c:87
> #13 0x0000aaaaaaac3394 in bt_shell_run () at src/shared/shell.c:1174
> #14 0x0000aaaaaaab42d8 in main (argc=<optimized out>, argv=<optimized out>) at tools/mesh-cfgclient.c:1970
> (gdb) quit
> A debugging session is active.
>
> 	Inferior 1 [process 5112] will be killed.
> Steve
>
> On Thu, 2019-11-28 at 22:41 +0530, Venkat Vallapaneni wrote:
>> Hi Brian,
>> I am using latest bluez and ell trees on ubuntu 18.04. Log windows
>> showing segmentation fault if it helps. I ran demon first and then
>> mesh-cfgclient
>>
>> vallapaneni@venkat-laptop:~$ sudo ~/tools/bluez/mesh/bluetooth-meshd
>> D-Bus ready
>> Request name success
>> Loading node configuration from /var/lib/bluetooth/mesh
>> filter_set id: 1, --> 2b
>> filter_set id: 2, --> 29
>> filter_set id: 3, --> 2a
>> filter_set id: 4, --> 2b
>> Controller hci 0 is in use
>>
>> vallapaneni@venkat-laptop:~/tools/bluez$ sudo
>> ~/tools/bluez/tools/mesh-cfgclient
>>
>> Warning: config file
>> "/home/vallapaneni/.config/meshcfg/config_db.json"
>> not found
>> [mesh-cfgclient]# create
>> Segmentation fault
>> vallapaneni@venkat-laptop:~/tools/bluez$
>>
>> Rgds,
>> Venkat.
>>
>> On 28/11/19 9:37 pm, Gix, Brian wrote:
>>> Hi Venkat,
>>>
>>>> On Nov 28, 2019, at 2:59 AM, Venkat Vallapaneni <
>>>> vallapaneni@socoptimum.com> wrote:
>>>>
>>>> ﻿Hi Brian,
>>>>
>>>> Thanks for the response. Yes, I am using PB-GATT barrier. With
>>>> bluetooothd running, I am able to provision my device.
>>> Ok... well if this is specifically to play with Zephyr, you can
>>> build it to accept PB-ADV based provisioning as well. But i think
>>> Zephyrs mesh tip is PN-GATT by default.
>>>
>>>> I also tried mesh-cfgclient but unsuccessful. I launched the
>>>> shell with mesh-cfgclient (with bluetooth-meshd running) and I
>>>> gave create command in the shell. I see segmentation fault. Any
>>>> steps I am missing?
>>> Are you on the tip of both the BlueZ tree, and the ELL tree? Also,
>>> what linux distro are you using?
>>>
>>>> Is mesh-cfgclient only for provisioning or also for sending mesh
>>>> messages also?
>>> mesh-cfgclient not only provisions devices with PB-ADV, but it also
>>> is a full featured Config Client. It can send keys, bindings,
>>> subscriptions, and publications.
>>>
>>>
>>>> Rgds,
>>>>
>>>> Venkat.
>>>>
>>>>
>>>>> On 28/11/19 4:22 am, Gix, Brian wrote:
>>>>> Hi Venkat,
>>>>>
>>>>> Are you attempting to provision a device that requires PB-GATT
>>>>> provisioning?  If so, the bluetoothd daemon must be up and
>>>>> running. However, this tool is old, and will probably be
>>>>> deprecated at some point.
>>>>>
>>>>> However most Mesh devices should support Advertising based
>>>>> provisioning.
>>>>>
>>>>> The Mesh daemon (Bluetooth-meshd) and the mesh-cfgclient tool
>>>>> (in the tools directory) has been undergoing modification even
>>>>> since v5.52, so you will want to checkout the tip.
>>>>>
>>>>> ./tools/mesh-cfgclient is the tool most appropriate for mesh
>>>>> development today.
>>>>>
>>>>>
>>>>>
>>>>>>> On Nov 26, 2019, at 8:16 PM, Venkat Vallapaneni <
>>>>>>> vallapaneni@socoptimum.com> wrote:
>>>>>> ﻿Hi,
>>>>>>
>>>>>> I am trying to use bluez 5.52 for provisioning a bluetooth
>>>>>> mesh capable device. When I gave provision <uuid>, I get this
>>>>>> below error. Please let me know what I am missing.
>>>>>>
>>>>>> I am using ell 0.26 on ubuntu 18.04. I am able to provision
>>>>>> successfully with bluez 5.50.
>>>>>>
>>>>>> AcquireWrite success: fd 8 MTU 69
>>>>>> GATT-TX:     03 00 10
>>>>>> *sendmsg: Socket operation on non-socket*[Zephyr]#
>>>>>>
>>>>>> Rgds,
>>>>>> Venkat.
>>>>>>
>>>>>>

