Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0846C47256
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FDB20746
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqZPe69e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgEFR3A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbgEFR27 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 13:28:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B497C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 10:28:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a21so3232186ljb.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kiSj3I5lgLWlxYRzOH3oPOtJDt8V9PEQLTReuWBjPCA=;
        b=mqZPe69eDowMOvr5A+8ew7fsCIvqvvqsXlmgwCtep1BD9Fe8cn4a5RXt/H8rC7NcQI
         z/rYce/blszgcmEfkFxstjQXky8HPa2ciwZgJv/Bv0euP1oJ6XGKyg11xdCcKFK4vzte
         +IbVV4+aQ4DgEQOqJoOZqxO1SXUZsGjQmPkEAlXXH8GmqsD3mqWTq3k3Z7n0VljU0flO
         BX1QphuCzlWo2XLA/Pxcb/CMQZZ7mp5Xw91qxMfqDd1pCdIt59dVlAKDaX+eUyb5SxG0
         izVPZV80nTfbfd7uz3usXyFyhl8SIrhtsCzaYTmP3xaixhGNVNCfYPmZqB/ZJTMEmkyt
         guRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kiSj3I5lgLWlxYRzOH3oPOtJDt8V9PEQLTReuWBjPCA=;
        b=BQTn18yWs15zhit80taLuh/dWOCwEV/XROpoJR7O/3kwJYHC2xKcBvm0EC5DPHgKsV
         nMMofoy4UjG4Vpb7Sxh0IInLjmIXFnOiS+RQmfdgIlsOXYl++CdrSCQZ/SGju15+EPeb
         izLfXPZO34WKRYWy4pfD4aD1pDjixUrZhrrNFeL6V38l5wQevm29N3Dti4hRyjQjGDkz
         9mWqw0E1rukk7LeQk+ns8j+Fyu6TBwGM5S6npC4hFD4Ubs6mig0Kcx4+WkraxKV8FNNb
         T3rLueJXQIYPLNXZAg6vwCitKBgvmF7pJPqG0uLdA5BmfKg3M78oR33iwzIWdbkXQCzc
         GroQ==
X-Gm-Message-State: AGi0PuYTa3Cj3koJBu7KLEcD7oEaPToI0Ni63dSGaFrZNmc7kHJe3GlI
        IGP9G1lr/sSci0MGIrtEYbMdLQr6oPE=
X-Google-Smtp-Source: APiQypI2iXUlTxjBs6Ca58PgARLNcrcQYpQz/aRs/B65OFenXe0NGOcp1P/wo/c4Qtl9iqWVUg+elg==
X-Received: by 2002:a2e:b248:: with SMTP id n8mr5529909ljm.207.1588786137376;
        Wed, 06 May 2020 10:28:57 -0700 (PDT)
Received: from [192.168.1.2] (broadband-188-255-20-215.ip.moscow.rt.ru. [188.255.20.215])
        by smtp.gmail.com with ESMTPSA id u3sm2014933lfq.59.2020.05.06.10.28.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 10:28:56 -0700 (PDT)
Subject: Re: avrcp: Cannot connect Sennheiser Momentum True Wireless 2
From:   Andrey Semashev <andrey.semashev@gmail.com>
To:     linux-bluetooth@vger.kernel.org
References: <7c4e6f59-d2ef-36c0-46df-0195fad40e7e@gmail.com>
Message-ID: <76911d0f-dd24-5536-586a-a8e9bc7ad786@gmail.com>
Date:   Wed, 6 May 2020 20:28:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7c4e6f59-d2ef-36c0-46df-0195fad40e7e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2020-05-06 19:56, Andrey Semashev wrote:
> Hello!
> 
> I have a problem connecting Sennheiser Momentum True Wireless 2 
> headphones over Bluetooth. The headphones say "Connected" and then 
> reboot immediately after. After reboot the headphones say "Power on" and 
> try connecting again, and fail the same way, and so on.
> 
>  From the Bluetooth packet dump it looks like the problem happens after 
> bluetoothd sends AVRCP ListPlayerApplicationSettingAttributes message to 
> the headphones. The headphones send Not Implemented response and then 
> reboot. Both in the request and the response Wireshark shows warnings 
> about encoding issues.
> 
> I'm attaching a packet dump captured from one of the connection 
> attempts. The ListPlayerApplicationSettingAttributes message is in 
> packet 262 and the response is in packet 264.
> 
> This is on Kubuntu 20.04. I tried bluez 5.53 from Kubuntu and revision 
> 3146b7a0785758be2d4e894d44e99d29c0db983e from git master - the behavior 
> is the same.
> 
> I've also verified that the headphones do work on Windows 10. On that 
> system, ListPlayerApplicationSettingAttributes is not present in the 
> packet exchange. I can provide the packet dump from Windows, if needed.
> 
> I hope this is the right place to report problems like this one. If not 
> - sorry, and please point me to the right place.
> 
> Thank you.

I'll add that I can connect the headphones if I disable AVRCP by adding 
--noplugin=avrcp to bluetoothd command line.
