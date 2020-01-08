Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D769C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF936206DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 11:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tah0V5nL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgAHLlD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:41:03 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:42551 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgAHLlD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 06:41:03 -0500
Received: by mail-wr1-f44.google.com with SMTP id q6so2987173wro.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2020 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Be/pnF33rUdHWEv3KFW00cmh9iwQFsZJq3ec00lxSCw=;
        b=tah0V5nLyQoA8HBXgEFM0RtlEsE3LKDs60gIEl0LvTmpe1DwoF/RHU1NSQlVxgXsu0
         eaMG+Wt1Jf9AMmdHVhdtHi+fkY8fLfbf9n80TCgsubMfhygJx0wuDi08aHTmaikUhKkR
         SvUVQJi/8yz42t20JuCSd1Yon/dwygkskcPKtv1YEs9/LeTS4W7BFEfVQz7/jbPtt9Gb
         AmSIUVTHe4GPo3If7VX5j4GgceS67r2HwAXjN6x6vPjc/I456KrT52ODqwNGwqK6a8uk
         zjqvDneKrRyMpZcwzZkWix4mDzocpFm3BcR/VkneZu0FoJtVyQblj056wTO+TpNSFY2E
         8ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Be/pnF33rUdHWEv3KFW00cmh9iwQFsZJq3ec00lxSCw=;
        b=VmYZsOOAyQFSO8l1obLVfmeWAwW7Ab3XyA7uIBHgTXl5+8NPxRhSNFbbQFdHcrhnzl
         KLAdVzDX53991sy0l3+gaMObj1J3DRlaoRyoOvVNY2RmEhgBO1RZTIRsqbaaxxdTHqIV
         oCAJcxAXdXyLzhgzxlV0HEYYiHfclmqycA0kfWUY2mNfNiKAtME8Y8WzBD7Rmc3sUXP9
         ZcMhMae5yRi1/1t47gluVMNi3CN09zJGK36cI+tv8NeDZXvPgMvrKUWvrMRKTskk2Ua3
         4ZndBiDeiy8HF8LWckcn0yZyUhpFEpLA1ZNZhijKiuFEf6IVsbAhfiBV5IRSxP+blCTC
         2iiA==
X-Gm-Message-State: APjAAAWtTUcmtPLCF6TnyHAvFrWD/+8yq7Ugq2nbRL/+07UASU89dcca
        8ft8aFY2Ro2HPLq4q063lfFLetqY
X-Google-Smtp-Source: APXvYqw28te3me6wprEd43CM6MV0GPk5V8ugFOqhuRkWro/nwsaAHRtKJOdd0N0wViQhMoFuyaAWpg==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr4068049wrw.93.1578483661235;
        Wed, 08 Jan 2020 03:41:01 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v8sm3928564wrw.2.2020.01.08.03.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:41:00 -0800 (PST)
Date:   Wed, 8 Jan 2020 12:40:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     ofono@ofono.org, Denis Kenzior <denkenz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Message-ID: <20200108114059.fbypyps6f3nb4ckv@pali>
References: <20200107192311.efit6zftt27encdc@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107192311.efit6zftt27encdc@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

CCing also bluez developers as they may be interested in discussion how
is HSP/HFP going to be implemented and used on Linux desktop.

On Tuesday 07 January 2020 20:23:11 Pali Rohár wrote:
> Hello!
> 
> Denis wanted from me to start a new thread, so I'm doing it.
> 
> As I wrote in different thread current state of HSP and HFP bluetooth
> profiles on Linux desktop is in very bad state, specially usage of SCO
> audio connection for audio applications (e.g. pulseaudio). See all
> details in that email. I proposed a solution for it via hsphfpd daemon
> with its prototype implementation, but Denis wrote that ofono could be a
> better solution.
> 
> Part of HSP and HFP bluetooth profiles is AT socket connection which
> needs to handle, parse and interpret all needed AT commands.
> 
> ofono project seems to be a candidate for handling AT socket on Linux
> desktop, but in current state it is unusable. For audio application
> (pulseaudio) there are required following features which ofono currently
> missing:
> 
> * ability to connect HFP profiles in HF role without any modem
>   (desktop computers do not have to have any modem). ofono currently
>   does not support establishing HFP connection in HF role when computer
>   does not have any modem
> 
> * support for HSP profiles (in both HS and AG roles). ofono currently
>   does not support HSP profile at all
> 
> These two missing features are main blockers why ofono is unusable for
> desktop/laptop usage as AT parser/handler for bluetooth HSP/HFP
> profiles.
> 
> Denis wrote that fixing first issue would be possible by automatically
> registering some fake dummy modem (when there is no in system) and
> connecting it with HFP profile in HF role.
> 
> Do you have a reasonable solution also for second issue?
> 
> If above two issue could be solved I can write a list of all other
> issues which are needed to be solved for providing HSP/HFP support on
> Linux desktops.
> 

-- 
Pali Rohár
pali.rohar@gmail.com
