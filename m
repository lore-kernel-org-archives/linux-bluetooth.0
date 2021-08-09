Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF59C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C168E60F35
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 20:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbhHIUcE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 16:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbhHIUcE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 16:32:04 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB48C0613D3
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Aug 2021 13:31:42 -0700 (PDT)
Received: from [10.0.20.3] (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8979F1F64C;
        Mon,  9 Aug 2021 22:31:41 +0200 (CEST)
Subject: Re: [PATCH BlueZ] Queue SetAbsoluteVolume if there is an in-progress
 one.
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <CABBYNZKcr74zYzPMcLo5+-49Fv02Kxoyf11bNPSuSGWThz-eqQ@mail.gmail.com>
 <9d386692-4c1c-b262-bca2-cec3568dc579@somainline.org>
 <CABBYNZLXRK9TN_TKdj5T7oP3D_HaeQiBsaCaRtE7nAK9hYuh-w@mail.gmail.com>
 <f3e18adc-b1ad-2ab5-164e-43a1ae20f708@somainline.org>
 <CAO271mkpy5W0KB60X5G1mwp92bB+K2Ru3ODP8K2APCkjfkX70w@mail.gmail.com>
 <391e3587-bb19-05be-cc36-08a8c91916de@somainline.org>
 <CAO271mk0N4yyA74kzB14y8nbFKfT914JNA7Hvq8QMCfs-VR2zw@mail.gmail.com>
From:   Marijn Suijten <marijn.suijten@somainline.org>
Message-ID: <656381df-01bb-ecdb-a782-79bd8bd05423@somainline.org>
Date:   Mon, 9 Aug 2021 22:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAO271mk0N4yyA74kzB14y8nbFKfT914JNA7Hvq8QMCfs-VR2zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On 8/9/21 7:46 PM, Sonny Sasaka wrote:
> Hi Marijn,
> 
> Thank you for following up. Chrome OS has temporarily adopted my patch
> to resolve the issue without changing the audio client. We will pick
> up your patch at the next uprev.

Note that these patches are still draft in search for initial feedback 
on the approach, even if the implementation itself is trivial.  Does 
this mean you won't be able to test this locally until the next uprev? 
Either way I will have to confirm their usefulness in PulseAudio too 
before actually committing to this, so there's no hurry.

Marijn
