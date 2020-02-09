Return-Path: <SRS0=VTGX=35=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80608C35250
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Feb 2020 13:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48223206D6
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Feb 2020 13:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rnmb0l+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBINPs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:15:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47080 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgBINPs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Feb 2020 08:15:48 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so4171004wrl.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Feb 2020 05:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JU90lZjpKZyhwIETwG5n01Ksd90VQegebzUEk5eDE1A=;
        b=rnmb0l+fTykQDyIpSYEfFsu856cr0spO4CF+kNUJOSOg3qP2GSQOXvGjW7S31zNcZc
         Gb2q3lBgoa9/sqMrbSE6BA0SivhCNgGvecQCZHHQnPQs0orUU6dn0n8btBsSTy8zMzLJ
         JzQg/iiUX8bIUAy0wOAj5NqH4CP9Uf2sv9YV4b9R+Q6brFox2mNn4w/xIJINlELEyuOz
         JIzIHNffwi5oUWbPpStf5XWxqD1WksBnkJb9KsuWtMPEsUO+9EKdwjGJrAwIU8PJ/nHe
         Ok/PNtAjuVc6MIfVeRAyD1z7Frwgj9q9JAC814cgJXgTmYVeTXMWjJUUY0mPYfg3qiG3
         Xhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JU90lZjpKZyhwIETwG5n01Ksd90VQegebzUEk5eDE1A=;
        b=nw2aBBnabTWcWQJ3HhdlFGobnHN1ggXhlwzqw3TwojtCfQH2fNB2o25pQxTvL18m1b
         opw5mma+TPqHvnoWlc+cnaA0SeXYqszmCzCM6TEebphU4/AKJVpSfmbokyGTo86kvmQo
         qb3PILfGWkeLhRaTgxwYjn8qGQ6PWiq6w+ITZnsoOMgrlz7vEQApN3daMtl39gwnkoHM
         qE4DwmoMEnu71xBjyJh+JrdafzzWzJfzhvWY6SfR0s7MiuD2tSioPtpgAsK53WaABHc3
         ckW4P0i7XoQJMKmSxkxlsAwEQ7e9loCArC+Y1lhDTKErAyVqvzxUvgZMJIRS21G9OGE4
         VRzQ==
X-Gm-Message-State: APjAAAVaZ6MHpS+w2vmtCkTodf1XewIDRQSeeFETJ0af7C0H6aCelgRe
        0W1WrhBVvBWXRL8NBTANH9c=
X-Google-Smtp-Source: APXvYqwgYaTsfGMTc5oaoeroVPUe5dP20PVNwzzaLJ2gdz+Xao1zWRHVWxGNIfa7B80Vo4OVMnEmNQ==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr10644768wru.427.1581254145105;
        Sun, 09 Feb 2020 05:15:45 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q130sm12064951wme.19.2020.02.09.05.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 05:15:44 -0800 (PST)
Date:   Sun, 9 Feb 2020 14:15:43 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     ofono@ofono.org, linux-bluetooth@vger.kernel.org
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Message-ID: <20200209131543.e6pjhqpaiunxmpuw@pali>
References: <20200107192311.efit6zftt27encdc@pali>
 <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
 <20200108212537.zs6pesil2vjguvu6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108212537.zs6pesil2vjguvu6@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello! I could you or other ofono developer please look at my comments
below and say how we can continue with these problems? Now another month
passed and I really would like to continue in effort to implement
HSP/HFP profiles with audio support on Linux desktop.

On Wednesday 08 January 2020 22:25:37 Pali Rohár wrote:
> Hello!
> 
> On Wednesday 08 January 2020 14:34:32 Denis Kenzior wrote:
> > Hi Pali,
> > 
> > > Do you have a reasonable solution also for second issue?
> > > 
> > 
> > HSP profile has always been a problem child.  It isn't really all that
> > useful as a profile, and given how minimal it is, the right place for it
> > always seemed to be inside Pulse Audio itself.  This is what Marcel & I
> > agreed upon back about 8-9 years ago anyway.
> > 
> > You are advocating that HSP is still useful, particularly with vendor
> > extensions.  Which is fair enough, but now you have to figure out how and
> > where to put this support.
> > 
> > As mentioned earlier, one idea you can explore is to create a small daemon
> > (or maybe it can even be part of ofonod itself) that will handle HSP
> > client/server roles.  See for example the dundee daemon that is part of
> > ofono.git.  dundee handles Bluetooth DUN profile and might be a good model /
> > starting point for what you're trying to accomplish.
> 
> I looked at dundee, but it does it is separated service, not on org.ofono
> So it looks like it does not fit into HSP / HFP needs.
> 
> Currently you can list all audio cards by DBus call:
> 
> "org.ofono", "/", "org.ofono.HandsfreeAudioManager", "GetCards"
> 
> and so this (or some new) call should list all HSP and HFP devices/cards
> for audio application (pulseaudio).
> 
> Audio application (e.g. pulseaudio) really do not want to handle two
> separate services to monitor and process HSP/HFP devices.
> 
> For audio application are HSP and HFP devices equivalent, they provide
> same features: SCO socket, API for controlling microphone and speaker
> gain; plus optionally specify used codec.
> 
> So having two separate services which fully divided for audio
> application purpose does not make sense.
> 
> So it is possible that both HSP and HFP audio cards would be available
> via one audio API? Because I do not see how it could be done via design
> like dundee.
> 
> > You can then implement the same API interfaces for setting up the HSP audio
> > stream as oFono does today (i.e. https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/doc/handsfree-audio-api.txt),
> 
> This API is unusable for both HSP and HFP audio streams. In pulseaudio
> it is somehow used, but it is not suitable.
> 
> In part of designing hsphfpd I created a new DBus API for audio
> application to fit for audio daemons. See org.hsphfpd.AudioAgent:
> https://github.com/pali/hsphfpd-prototype/blob/prototype/hsphfpd.txt#L600-L663
> 
> Main objection for handsfree-audio-api.txt is that it does not provide
> information about locally used codec and somehow mixes air codec and
> local codec. In my hsphfpd.txt I used term "AgentCodec" for bluetooth
> local codec and term "AirCodec" for bluetooth air codec format.
> 
> Another objection against handsfree-audio-api.txt API is that it is
> bound to HF codecs (via number) and does not support for pass e.g. CSR
> codecs.
> 
> What is completely missing in that API is controlling volume level.
> 
> And also API does not provide socket MTU information or ability to
> change/specify which codec would be used.
> 
> So something like org.hsphfpd.AudioAgent API in my hsphfpd design would
> be needed.
> 
> > which would make PulseAudio's job much easier, since the audio stream
> > aspects would be essentially identical to HFP.  If you're part of oFono's
> > tree, then in theory many implementation aspects could be reused.
> > 
> > If you want to provide some higher-level APIs for external applications,
> > then HSP specific interfaces (APIs) can be added as needed.
> 
> Non-audio APIs which are needed to export (for both HSP and HFP profiles):
> 
> * battery level (0% - 100%)
> * power source (external, battery, unknown)
> * ability to send "our laptop" battery level and power source to remote device
> * send text message to embedded display
> * process button press event (exported via linux kernel uinput)
> 
> (plus all telephony related operations, but those are already supported
> and provided by ofono)
> 
> > If you decide this is something you want to pursue, then I'm happy to host
> > this in the oFono tree.
> > 
> > Regards,
> > -Denis
> 

-- 
Pali Rohár
pali.rohar@gmail.com
