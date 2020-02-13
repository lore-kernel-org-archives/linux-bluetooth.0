Return-Path: <SRS0=+UdQ=4B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64857C352A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D0220656
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 19:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8KqyjG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBMTJE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:09:04 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46629 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMTJE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 14:09:04 -0500
Received: by mail-ot1-f47.google.com with SMTP id g64so6627148otb.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2020 11:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VpGQXJ0lqvwrRUjBsBfcl7cSBVI95lG/qE06ZEw0TWs=;
        b=N8KqyjG/o5gDdunbEZxpwvdQLANR0CAA/8JPl5WmbRuVSceJkY/p9kDvE+HyMHo5ni
         L0qruZvPcC2ukFW+/Y8RIMLhjD2ZbBNhtrUMBmQdR+w1xj/Ser/0hR0lyEtRoxzPLJFE
         UVyQ/hk5x7upodJv+SjaEV7BAHkG5PUmxyPFZ4+FjjuzY3MqvPznxhB5iPbcTzA+j7SN
         z+YuQNfNlqaYNwgaH8uhxTNXLAKu8ioVI8X1Ydvsu0NOQ8BIcC2r9JmyVaQlROPVmr3s
         HbTpE96GLHS4Vid/xHaKmM9hrf8t//BaXl9geT3/L/jf3BXrDuXYzdUVJTY6SVTQKZfb
         eK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VpGQXJ0lqvwrRUjBsBfcl7cSBVI95lG/qE06ZEw0TWs=;
        b=QfcMHw46kEn038itYDthT6i8nrWB/GT+V8CiG4ppetmAYvly5YQx+plqCwJMvRFfd1
         NaZzxe/QEaSbklZBmMR2QapCsZbPxqy7ziC6rQoK1Iaozw5GTbvplWsv3w9MWZnRDCuz
         I+wk9dj0iYA/tGqDwCmWIivVXOX369G0af5QpoMyqUnpYLjyAEvCZk8Qgqae+OKOSDiL
         LvoLuHYjDLupcDZ7QC6kg35BT2lDJjQVZMqbBGstC+RPtmhMLwz9++CfafXEF18KYfje
         GWDkVEHa6aO+2r2WuZ0sZ6gfogQvkub8/Ixk9DHafpcbyv9jXNvEgJ6UGAFEKrqank/3
         smmQ==
X-Gm-Message-State: APjAAAVmlL7r80s9WsPD4weEHu1RNScR9l5KNHw7l+nC0oCt1dhfPVa7
        CU1geujwSeZZp1I2ZudwJ3p9KdGG
X-Google-Smtp-Source: APXvYqy+LkxpeK/KWZHxy8l8M7qySrdf4NVq7hDIDK1MPhhkMAaFmaaQRQTLfCWm1F/RYtZhoN+ecg==
X-Received: by 2002:a05:6830:1615:: with SMTP id g21mr15112938otr.49.1581620942226;
        Thu, 13 Feb 2020 11:09:02 -0800 (PST)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id m22sm1088198otj.3.2020.02.13.11.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 11:09:01 -0800 (PST)
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc:     ofono@ofono.org, linux-bluetooth@vger.kernel.org
References: <20200107192311.efit6zftt27encdc@pali>
 <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
 <20200108212537.zs6pesil2vjguvu6@pali>
 <57639029-7588-956b-8e3c-a2a6ed11b758@gmail.com>
 <20200213174621.e2q4ryu36p5ericx@pali>
 <6679dd2b-4780-e44f-b86d-28cf65638888@gmail.com>
 <20200213183253.44vkm6bpddre4dvp@pali>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <77397684-1c15-854e-b88b-4adff6f73ada@gmail.com>
Date:   Thu, 13 Feb 2020 13:08:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213183253.44vkm6bpddre4dvp@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On 2/13/20 12:32 PM, Pali Rohár wrote:
>> At the time this was all done in software.
> 
> CVSD was never done in software. Always in hardware. As said, even now I
> was not able to find bluetooth HW which would allow to do CVSD in software.
>

I don't remember the exact details.  I seem to remember that for mSBC 
the conversion was being done on the host and no 'on-the-fly' conversion 
was done in hardware.  Thus this host codec negotiation was not needed / 
considered.

https://lists.ofono.org/hyperkitty/list/ofono@ofono.org/message/6CUFGDPUJBRIZA4GUVFD2EPOET25XTN3/

>> So how do you negotiate the 'AgentCodec'?  Does BlueZ expose this
>> information?  If so, how? SCO socket option or ...?
> 
> It is done by HCI commands, therefore by kernel. There is discussion for
> exporting userspace <--> kernel API to allow setting arbitrary
> configurations for codecs supported by bluetooth HW.
> 
> Getting list of supported codecs can be done by this script:
> https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl
> (needs to be run as root)

So you might want to get BlueZ guys to expose this info properly first. 
oFono is not in the business of opening raw hci sockets.

>> Isn't the MTU obtained from the SCO socket itself?  How is oFono at fault
>> here?
> 
> Yes, via some ioctl it can be done. But bluez for other bluetooth
> profiles provides this information via dbus API. As bluez does not
> support HSP/HFP it expects that software which implement it, provide
> needed info

Only PA (or whatever implements the audio agent) really cares about this 
info and it can obtain it via getsockopt.  So I really don't see why the 
MTU should be exposed via D-Bus.  And this is why it wasn't.  I don't 
see an issue here...?

>>
>> This seems to be a kernel / device driver / firmware  issue and should be
>> solved at that level.
> 
> Why??? It is up to the application which owns SLC socket and this
> application needs to provide API for it. Codecs are negotiated via AT
> commands, so again only HFP / HSP daemon can do it.

So in my opinion it is really up to the kernel to tell us whether a 
given hardware supports wideband speech.  So any quirks need to go into 
the kernel.  Then userspace can select the best available codec 
automatically without resorting to having the user twiddle some settings.

> So, why should I even consider to use ofono at all? It does not support
> none of above desktop feature, it does not support extended codecs, it
> does not support HSP profile and also it does not support HFP profile
> without physical modem (majority of desktops and laptops).

Your initial proposal wanted to use oFono as some sort of helper for 
your daemon, and that is just not going to be accepted by oFono 
upstream.  I gave you a few alternatives, including how to extend oFono 
to do what you want.  If you want to roll your own, go for it.

Regards,
-Denis
