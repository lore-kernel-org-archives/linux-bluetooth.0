Return-Path: <SRS0=XR6q=ZU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5323C432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 17:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54BB21739
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 17:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=socoptimum-com.20150623.gappssmtp.com header.i=@socoptimum-com.20150623.gappssmtp.com header.b="ljlxqQ8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfK1RLa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:11:30 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:41189 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfK1RLa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Nov 2019 12:11:30 -0500
Received: by mail-pg1-f169.google.com with SMTP id l26so3014798pgb.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2019 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=socoptimum-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Inx+pGtbM/gX4cG9X78SscFvPKaGPfj3v5IaiZCkfRI=;
        b=ljlxqQ8itLri/TZD3CCDrHpSTnVFMaCFqpz0sqsV/RjSFId1v269HzVFx6zGGB6Msa
         VBktDH9J9nfswMUcz01F9BvqFNDeIVt4x9SeIu+LLkzrHa89RL+0WTb6DKWEPETf8L7b
         QR46ZZJdXMBtF4EUEINiIsttVtOwEfoUR25zQijcdM3UznxKerJDYF8MDEYKwS5kdC2w
         Rnznl4VndnWfkTwmZ8i2KY2nVR75lilqFx4Ba+MVfRfj6Qsqw8mennWgLi+9Erm+x/y1
         cfvOA1H07d1fLZvYcwQdOpapO+EbAQQj9hE6mFyUs7XwnBMDFBXvh3xj3Dp0ZiIm3fQd
         btWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Inx+pGtbM/gX4cG9X78SscFvPKaGPfj3v5IaiZCkfRI=;
        b=ZbF7S0JIgJZKZxGYv6HP4coKq8ePyx4trEq9E/FMc/ETj0X9hUbKIRDoYstgz3HqAi
         OF3S1wP0hrfjkl8KxDf+OAUzFinrQX3tOOpayEA6an50PBGiDVo1E2ooJ9gqSTwckmB8
         1EFXiNPNRZ++L7B2U8MJyqtSS6Kd1KmmD5h5oPMuRlGTF3KdbxMans3a/CUndiAaUA54
         qV4ljcrwymnXGg4qOXcOb6uEcoJP+FumJE3Pu5n+JoCU+3OXyu4E/4ikSrSzqWc0g4Pa
         aoccIdNYgIY4lXelEJj0uqfafSQ+R7H96pjTryl7YVCGBfE++ADw52KxkhGamVRQZ4MD
         AH1w==
X-Gm-Message-State: APjAAAUueCEG6jdcboT4PFEHncgDXo9Ddls4FVPfhybbV1sVR2Ah5w4H
        jq6WjltFCyyTVntWfO+UqfrC42TORWU=
X-Google-Smtp-Source: APXvYqwranndBQTLP7dWdqn7YpErUmdFxQtwX6AtALT2Yh/O/Dkf2jDJGKc2NcEgStZFdywsRPsZBA==
X-Received: by 2002:a63:845:: with SMTP id 66mr12214216pgi.368.1574961089101;
        Thu, 28 Nov 2019 09:11:29 -0800 (PST)
Received: from [192.168.1.9] ([122.179.42.13])
        by smtp.gmail.com with ESMTPSA id b16sm9040346pfo.64.2019.11.28.09.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 09:11:28 -0800 (PST)
Subject: Re: bluez meshctl error: socket operation on non-socket
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <b260550e-0884-662d-e395-90e7678cb1a7@socoptimum.com>
 <78DAB7EA-B99D-4EDE-804B-7D127203DA1B@intel.com>
 <b332ed76-d5b1-c245-9301-3af578a274e4@socoptimum.com>
 <F3DC25C3-6C29-402B-B935-A4171B336403@intel.com>
From:   Venkat Vallapaneni <vallapaneni@socoptimum.com>
Message-ID: <f08116d3-4329-06a9-1b35-f8a7e4c8eff5@socoptimum.com>
Date:   Thu, 28 Nov 2019 22:41:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <F3DC25C3-6C29-402B-B935-A4171B336403@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,
I am using latest bluez and ell trees on ubuntu 18.04. Log windows 
showing segmentation fault if it helps. I ran demon first and then 
mesh-cfgclient

vallapaneni@venkat-laptop:~$ sudo ~/tools/bluez/mesh/bluetooth-meshd
D-Bus ready
Request name success
Loading node configuration from /var/lib/bluetooth/mesh
filter_set id: 1, --> 2b
filter_set id: 2, --> 29
filter_set id: 3, --> 2a
filter_set id: 4, --> 2b
Controller hci 0 is in use

vallapaneni@venkat-laptop:~/tools/bluez$ sudo 
~/tools/bluez/tools/mesh-cfgclient

Warning: config file "/home/vallapaneni/.config/meshcfg/config_db.json" 
not found
[mesh-cfgclient]# create
Segmentation fault
vallapaneni@venkat-laptop:~/tools/bluez$

Rgds,
Venkat.

On 28/11/19 9:37 pm, Gix, Brian wrote:
> Hi Venkat,
>
>> On Nov 28, 2019, at 2:59 AM, Venkat Vallapaneni <vallapaneni@socoptimum.com> wrote:
>>
>> ﻿Hi Brian,
>>
>> Thanks for the response. Yes, I am using PB-GATT barrier. With bluetooothd running, I am able to provision my device.
> Ok... well if this is specifically to play with Zephyr, you can build it to accept PB-ADV based provisioning as well. But i think Zephyrs mesh tip is PN-GATT by default.
>
>> I also tried mesh-cfgclient but unsuccessful. I launched the shell with mesh-cfgclient (with bluetooth-meshd running) and I gave create command in the shell. I see segmentation fault. Any steps I am missing?
> Are you on the tip of both the BlueZ tree, and the ELL tree? Also, what linux distro are you using?
>
>> Is mesh-cfgclient only for provisioning or also for sending mesh messages also?
> mesh-cfgclient not only provisions devices with PB-ADV, but it also is a full featured Config Client. It can send keys, bindings, subscriptions, and publications.
>
>
>> Rgds,
>>
>> Venkat.
>>
>>
>>> On 28/11/19 4:22 am, Gix, Brian wrote:
>>> Hi Venkat,
>>>
>>> Are you attempting to provision a device that requires PB-GATT provisioning?  If so, the bluetoothd daemon must be up and running. However, this tool is old, and will probably be deprecated at some point.
>>>
>>> However most Mesh devices should support Advertising based provisioning.
>>>
>>> The Mesh daemon (Bluetooth-meshd) and the mesh-cfgclient tool (in the tools directory) has been undergoing modification even since v5.52, so you will want to checkout the tip.
>>>
>>> ./tools/mesh-cfgclient is the tool most appropriate for mesh development today.
>>>
>>>
>>>
>>>>> On Nov 26, 2019, at 8:16 PM, Venkat Vallapaneni <vallapaneni@socoptimum.com> wrote:
>>>> ﻿Hi,
>>>>
>>>> I am trying to use bluez 5.52 for provisioning a bluetooth mesh capable device. When I gave provision <uuid>, I get this below error. Please let me know what I am missing.
>>>>
>>>> I am using ell 0.26 on ubuntu 18.04. I am able to provision successfully with bluez 5.50.
>>>>
>>>> AcquireWrite success: fd 8 MTU 69
>>>> GATT-TX:     03 00 10
>>>> *sendmsg: Socket operation on non-socket*[Zephyr]#
>>>>
>>>> Rgds,
>>>> Venkat.
>>>>
>>>>
