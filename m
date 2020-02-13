Return-Path: <SRS0=+UdQ=4B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01816C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 17:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2557217F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 17:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+dQv+em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBMRq0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:46:26 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:56220 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMRq0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 12:46:26 -0500
Received: by mail-wm1-f41.google.com with SMTP id q9so7215466wmj.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2020 09:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QaWc5JBCMzFlM/592DhkRuB4dgARNBMfZF9OC4vvlLg=;
        b=F+dQv+emgryBxhbz0DyH4NhnLaW3A4O59psRn0S+YS+i34E5/g1OVVYpzBWoiHkcid
         120bj42pKlJVZMrtUn8wi7iyp8ajcLkLcFkmTwsH7hY/7rvJN8hc3kNwBbnHL+2rkaQW
         pSoAhJHyTYD6eVRwj6K7Oh96t/VcfsykXjG9j65l8qmCIdkxWVstXguoB7bPJ6faRMEh
         LEcvPfpUS1tHBqxEN9hIuS9J8l69QlYJ/eSPqqV2MqoKsOBxgUsflwQc7E1SXl/zBW9o
         peVEpK4OKh3ilgQ5TzVHWG1jR/EnGM39WQGBihAY5vmdd9S8l/8Dt45jVVKQ5TYvPJY6
         dV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QaWc5JBCMzFlM/592DhkRuB4dgARNBMfZF9OC4vvlLg=;
        b=rtjhsASmeL0EWOT1GyXZQuYCPqALOE0AKoVvgN/WP3l9CHMtvW/oHCrQ3fH3Nrx0Iu
         fTO5UOMOeGPE2T0K1ZndfI1szoMD42aGt0xyovzVQRlFJw4W3Qo72iQo0mBqDWOorg7t
         i31LcJAGbkIs4NBfsiN8noEGe3lvH0iq/LU3fXScEhHvekI7EweI+a1VIU1Iz+clSJMu
         tGGIM/clxSPc9kRApepBEQEbxFLdciv+J5FCSlC11lPAwIKHMOX9rIo8n50F+2ob3i2A
         3bIF2hMnFtxDzxtOg67UKBWU35kAxfwAj4bPAAm6HzZ3f6rVl+kHLiY3i5I0RtzinyGr
         uZZw==
X-Gm-Message-State: APjAAAXc7L46XGZuaXjTgcnPuxo8SDYxBah6p7Z60+bW4MROM1yMFZNr
        OLy56LBPhoB5KzpdXdfB60c=
X-Google-Smtp-Source: APXvYqwsNmChx9pgcDGobgIndQLMO0mQa+WCpOqwm3zE7jCj2S7ibR44YUos7xRbGFxfcy6qF8eUSg==
X-Received: by 2002:a1c:660a:: with SMTP id a10mr6915435wmc.122.1581615982811;
        Thu, 13 Feb 2020 09:46:22 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id l132sm4007827wmf.16.2020.02.13.09.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:46:22 -0800 (PST)
Date:   Thu, 13 Feb 2020 18:46:21 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     ofono@ofono.org, linux-bluetooth@vger.kernel.org
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Message-ID: <20200213174621.e2q4ryu36p5ericx@pali>
References: <20200107192311.efit6zftt27encdc@pali>
 <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
 <20200108212537.zs6pesil2vjguvu6@pali>
 <57639029-7588-956b-8e3c-a2a6ed11b758@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57639029-7588-956b-8e3c-a2a6ed11b758@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 12 February 2020 15:29:04 Denis Kenzior wrote:
> On 1/8/20 3:25 PM, Pali Rohár wrote:
> > Audio application (e.g. pulseaudio) really do not want to handle two
> > separate services to monitor and process HSP/HFP devices. >
> > For audio application are HSP and HFP devices equivalent, they provide
> > same features: SCO socket, API for controlling microphone and speaker
> > gain; plus optionally specify used codec.
> > 
> > So having two separate services which fully divided for audio
> > application purpose does not make sense.
> > 
> > So it is possible that both HSP and HFP audio cards would be available
> > via one audio API? Because I do not see how it could be done via design
> > like dundee.
> > 
> 
> One API sure.  Maybe on multiple services.  Honestly, I don't see why this
> would be such a burden for PA to watch 2 dbus services instead of 1.  From
> oFono perspective it would make more sense to keep the HSP part a separate
> daemon.  I could be convinced otherwise if it is indeed a big burden for
> PA...

It is not only pulseaudio, but also other applications which are going
to use HSP and HFP profiles. Having more services just complicates
things. Most majority of devices support both HSP and HFP profiles and
target application would need to start merging these two services into
one to create object overview of one device.

I do not see search why to complicate it for HSP and HFP applications
users to divide these two profiles into separate services and daemons.
Due to these problems I designed my hsphfpd to handle both profiles as
for audio applications they are fully equivalent and for other are very
similar. In that way hsphfpd provides all supported HSP and HFP profiles
and therefore taraget application do not have to introspect lot of
places and then merge information together. Otherwise every one HSP/HFP
application need to do this.

> > > You can then implement the same API interfaces for setting up the HSP audio
> > > stream as oFono does today (i.e. https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/handsfree-audio-api.txt),
> > 
> > This API is unusable for both HSP and HFP audio streams. In pulseaudio
> > it is somehow used, but it is not suitable.
> > 
> 
> Funny.  "It is used but not suitable"?

Used by who? Gateway role is fully broken and client (hfp) role is used
probably only by some power users. Also there is no support for mSBC in
pusleaudio.

So, no, really it is not used.

> > Main objection for handsfree-audio-api.txt is that it does not provide
> > information about locally used codec and somehow mixes air codec and
> > local codec. In my hsphfpd.txt I used term "AgentCodec" for bluetooth
> > local codec and term "AirCodec" for bluetooth air codec format.
> 
> Okay.  But, just FYI, at the time there was no hw that could do such
> on-the-fly conversions, so this use case wasn't considered/implemented.

This cannot be truth as probably every bluetooth HW is doing on-the-fly
conversion between CVSD and PCM. I was not able to find HW which allows
me to send raw CVSD samples...

But OK, I understand that just for one codec (or two?) API was designed
very simple and nobody though about possibility about usage of HW
encoders also for non-CVSD codecs. For that time in past, it make sense.

> There's really no reason why we couldn't extend our APIs to handle this.
> 
> > 
> > Another objection against handsfree-audio-api.txt API is that it is
> > bound to HF codecs (via number) and does not support for pass e.g. CSR
> > codecs.
> 
> True.  In retrospect we probably should have used strings.  But it was
> assumed that vendor extensions would go via the Bluetooth SIG Assigned
> Numbers facility.  Anyhow, we can always add a 'Register2' method that could
> take codecs as a string array or a combination of strings & ints. And if
> Register2 was used, then use 'NewConnection2' with a signature that supports
> passing in vendor codecs and whatever else that might be needed.

This is still not enough. Audio application (e.g. pulseaudio) need to
register AgentCodec, not AirCodec. And current API is somehow mixed.
Audio application needs to know what is the format which bluetooth chip
sends to userspace (PCM? mSBC? CVSD? PCMA? AuriStream?) and which format
bluetooth chip expects. I named this AgentCodec.

And it is fully different of codec negotiated by HFP protocol. Here is
negotiated codec which is transmitted over the air. Hence the name
AirCodec.

HFP daemon needs to negotiate AirCodec via HF codec and audio daemon
(e.g. pulseaudio) needs to negotiate AgentCodec via HFP daemon.

So API in that form is unusable. And e.g. API which I designed for
hsphfpd Audio Agent is needed.

> > 
> > What is completely missing in that API is controlling volume level.
> > 
> 
> It is there on the CallVolume interface
> 
> > And also API does not provide socket MTU information or ability to
> > change/specify which codec would be used.
> 
> There was no need, we automatically defaulted to using Wide band if
> available.  Third party codecs are a new use case (for oFono HFP), so would
> require an API extension.

MTU is needed also for mSBC codec if encoding is done in software
(pulseaudio). Without it, this wide band support in ofono is unusable
for pulseaudio.

And also API extension for choosing codec. Also for choosing if software
of hardware encoding would be used. We know that there are lot of broken
devices in different way and it is really needed for either blacklist
some codec or switch between hw and sw encoding if something strange
happen. Without it pulseaudio is not going to support more codes then
default required (CVSD).

> > 
> > Non-audio APIs which are needed to export (for both HSP and HFP profiles):
> > 
> > * battery level (0% - 100%)
> > * power source (external, battery, unknown)
> > * ability to send "our laptop" battery level and power source to remote device
> > * send text message to embedded display
> > * process button press event (exported via linux kernel uinput)
> > 
> 
> I think all of these are feasible to support under the current oFono
> structure, either via plugins or API extensions.

Ok. Are you going to implement them?
I think that all of these are missing parts in ofono and something which
is needed to be implemented for desktop/laptop HSP and HFP profile
support.

-- 
Pali Rohár
pali.rohar@gmail.com
