Return-Path: <SRS0=XR6q=ZU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C516C432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 10:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE0620880
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=socoptimum-com.20150623.gappssmtp.com header.i=@socoptimum-com.20150623.gappssmtp.com header.b="cBj5sC1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfK1K6e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Nov 2019 05:58:34 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:32815 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfK1K6d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Nov 2019 05:58:33 -0500
Received: by mail-pg1-f169.google.com with SMTP id 6so8194285pgk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2019 02:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=socoptimum-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2Zqccpoq3rctCOVwPeyNGG/DFZtMbvNd/3EluXqvTR8=;
        b=cBj5sC1XEsuQYPPuAbtUSeQd36iDfRR0iQZcM+JfCeBkZtUsnauX/meShrJRF/rEwM
         9ZjiakONv7FXusK2wmzxubjWAnevGeKZZ/m1K1+fY8lKmOQpgL0XiZBuxGEG6T9RVThV
         YJ8LOzRtSIxIwkCR02tiK6UkaXhztXmmWTjGHCL3+tJAx8n9YS3ktIVpr7y5xmIEZ7hY
         QEh0kLggQhKOp2aExpg75mmua60JQnmulmR1Bk7ZS74V6B8RNktdKs/6iM0ogDfP+VLw
         +nyLTGohZN/XfdxAQpk1WGRpuYb27WE0OWylNhWyLfwJFCsxEs866Qapd/0kWgSGZsa2
         dKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2Zqccpoq3rctCOVwPeyNGG/DFZtMbvNd/3EluXqvTR8=;
        b=FITfDyufTuNpmkD90jtNwbO1ZOMDLOTAwes+svTU6v1JsPHIBkmH4oIqQxKJodro7x
         nty8BNAYDNYxvT2GLjndmXKyzqYZH9m6O2dA45w3PmArYWEzTAPN3r+5eetW6uLKCj0t
         Pskvf6H3ACmOOHijV8GSwKTX6ZGg21BtHeKhsuZYUQKG94BWfwwUZMcI8D/v/Gv+IzyU
         UdA/pRFJdFwKFKRxfWSH15YlRLRl/NV78nhVeQfCsBjSLayIHRC1wVF2OSY/c2Je68ZN
         gzQUMgEGqU0YkUH5rncyUOepHuuXA76TB9vHaWRu32ALJwWExP0yzbZ1U81wGYGs9VeP
         lDag==
X-Gm-Message-State: APjAAAVoytdPpPYgrgvZ7LyfqBLOp5tul9j+uyb20kyaRiNxOZmRAsqx
        0deUdsqSwe9UbvlveJzNwTt36ooYJ7k=
X-Google-Smtp-Source: APXvYqw+GMELOG3u4YspL4OeITfglRPB7U76bbZ7cQNW206Yw0Dl8h7x1UD9iQd4XdCIqGprndhg8w==
X-Received: by 2002:a63:6705:: with SMTP id b5mr10854013pgc.23.1574938712690;
        Thu, 28 Nov 2019 02:58:32 -0800 (PST)
Received: from [192.168.1.9] ([122.179.42.13])
        by smtp.gmail.com with ESMTPSA id i65sm20301448pfg.176.2019.11.28.02.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 02:58:32 -0800 (PST)
Subject: Re: bluez meshctl error: socket operation on non-socket
To:     "Gix, Brian" <brian.gix@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <b260550e-0884-662d-e395-90e7678cb1a7@socoptimum.com>
 <78DAB7EA-B99D-4EDE-804B-7D127203DA1B@intel.com>
From:   Venkat Vallapaneni <vallapaneni@socoptimum.com>
Message-ID: <b332ed76-d5b1-c245-9301-3af578a274e4@socoptimum.com>
Date:   Thu, 28 Nov 2019 16:28:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <78DAB7EA-B99D-4EDE-804B-7D127203DA1B@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

Thanks for the response. Yes, I am using PB-GATT barrier. With 
bluetooothd running, I am able to provision my device.

I also tried mesh-cfgclient but unsuccessful. I launched the shell with 
mesh-cfgclient (with bluetooth-meshd running) and I gave create command 
in the shell. I see segmentation fault. Any steps I am missing?

Is mesh-cfgclient only for provisioning or also for sending mesh 
messages also?

Rgds,

Venkat.


On 28/11/19 4:22 am, Gix, Brian wrote:
> Hi Venkat,
>
> Are you attempting to provision a device that requires PB-GATT provisioning?  If so, the bluetoothd daemon must be up and running. However, this tool is old, and will probably be deprecated at some point.
>
> However most Mesh devices should support Advertising based provisioning.
>
> The Mesh daemon (Bluetooth-meshd) and the mesh-cfgclient tool (in the tools directory) has been undergoing modification even since v5.52, so you will want to checkout the tip.
>
> ./tools/mesh-cfgclient is the tool most appropriate for mesh development today.
>
>
>
>> On Nov 26, 2019, at 8:16 PM, Venkat Vallapaneni <vallapaneni@socoptimum.com> wrote:
>>
>> ﻿Hi,
>>
>> I am trying to use bluez 5.52 for provisioning a bluetooth mesh capable device. When I gave provision <uuid>, I get this below error. Please let me know what I am missing.
>>
>> I am using ell 0.26 on ubuntu 18.04. I am able to provision successfully with bluez 5.50.
>>
>> AcquireWrite success: fd 8 MTU 69
>> GATT-TX:     03 00 10
>> *sendmsg: Socket operation on non-socket*[Zephyr]#
>>
>> Rgds,
>> Venkat.
>>
>>
