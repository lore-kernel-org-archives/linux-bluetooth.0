Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F742C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Feb 2021 17:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CEC64E92
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Feb 2021 17:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBARm4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Feb 2021 12:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhBARml (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Feb 2021 12:42:41 -0500
Received: from mail.eh5.me (mail.eh5.me [IPv6:2001:19f0:7001:2deb:5400:2ff:fef8:7fd6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF421C061793
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Feb 2021 09:41:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1D15F349AD63
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Feb 2021 01:41:50 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sokka.cn; s=dkim;
        t=1612201312; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=PEn7XuiCmkjmaPELAHfTQQnNPl8rlfgdN3m8FvGaLAI=;
        b=M6Mhtr5oOrWGjpxdKz8ucJs7797SbZM1cjR+1w9988qJawomRhKQipfb/E77D2/aBeYPpB
        uekFC2iQ0O6yhKWVxR4D4r4N6CaPWZFXa7wBsOu9E2Hy6EPMisS9IQaLiUEB4zefpz+4OC
        oLux80Be8GTetIPpl/zKL5I916mTB7Q=
Subject: Re: Some headsets appear don't work when BlueZ connecting with both
 HSP AG and HFP AG.
From:   Huang-Huang Bao <eh5@sokka.cn>
To:     linux-bluetooth@vger.kernel.org
References: <8b62372c-bb87-5dbe-200d-d32c7c94f50d@sokka.cn>
Message-ID: <54ab3327-f14d-fd74-5501-47203a1bd06f@sokka.cn>
Date:   Tue, 2 Feb 2021 01:41:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <8b62372c-bb87-5dbe-200d-d32c7c94f50d@sokka.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

Any comments on this?

We have thought about how to fix it in client side, that is registering 
HFP AG or HSP AG profile with `AutoConnect` disabled and let PipeWire to 
initiate  headset profile connection throw 
`org.bluez.Device1.ConnectProfile(string uuid).

But for headset has no A2DP support, PipeWire is not possible to get 
triggered with device connection event when other application is calling 
`org.bluez.Device1.Connect()` if `AutoConnect` is disabled on HSP AG and 
HFP AG profiles, so that PipeWire don't know when to initiate headset 
profile connection.

Currently we disabled HSP AG by default on PipeWire to work around this 
problem.
https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/425

Regards,
Bao.

On 1/23/21 10:14 PM, Huang-Huang Bao wrote:
> Hi linux-bluetooth,
> 
> 
> PipeWire recently got HFP AG support,
> 
> its native headset backend registers both HSP AG profile and HFP AG 
> profile with `AutoConnect` enabled by default.
> 
> Hence, BlueZ would trying to connect headset with both HSP and HFP. 
> Seems it causes some headsets stop to work with HFP/HSP profile.
> 
> Discussions on PipeWire: 
> https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/604#note_773590
> 
> Frédéric Danis says:
>  >Currently it seems to me that there are at least 3 behaviours when 
> both native HSP and HFP are enabled, depending on the Headset/Speaker:
>  >
>  >    with Sony WH-1000XM3, iiuc:
>  >        HFP is tried first, starting SLC process
>  >        then a connection to HSP is rejected by the headset which 
> stops to send AT commands on the HFP RFComm channel
>  >        Audio is not working
>  >    with Sony WH-CH710N:
>  >        HFP is tried first, starting SLC process
>  >        then a connection to HSP is rejected by the headset, but the 
> headset keeps on sending AT commands on the HFP RFComm channel
>  >        Audio is working
>  >    with JBL GO 2 speaker:
>  >        HFP is tried first, starting SLC process on a RFComm channel
>  >        then HSP is connected on a second RFComm channel and following 
> HFP AT commands are sent on this second channel
>  >        Audio is not working (iirc)
> 
> Can it be fixed in BlueZ? For example, do not auto-connect HSP or HFP 
> profile if the other one has been connected. Maybe to add an extra 
> option "Conflicts" on "org.bluez.ProfileManager1.RegisterProfile()" to 
> indicate UUIDs which conflict with registered profile.
> 
> Regards,
> Bao
