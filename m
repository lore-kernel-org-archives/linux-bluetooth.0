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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D440C2BA83
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F34B222C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Feb 2020 18:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fq0tSyNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBMSc5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:32:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35660 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSc5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Feb 2020 13:32:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id w12so7949903wrt.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Feb 2020 10:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nQ1O54l/xJoKtZAHjl/ZHrEcTWofgNpjma9R21hQbe4=;
        b=Fq0tSyNwt4zsLvpuJ38pHkmkFWJBAweoWjmcKy4s6y8cy6xE9B9Ivw9yJ4XTL9zQkj
         MlQ8NcJbalHXJUEAzFRc43XuR+W++DcQSGOwYZGlK3jY4ClC0CjJPluVgseGDfhm4HzV
         4HB0Z3oYxuEVIl+/brm0izoHAg9vkPrl8GISm+50RTtRWlYzvg6kIMl3qZvQALb8PKWF
         n0WSwO/4dyUr0kvOQ1qrgqYLVl2ntNQ9YXNH33VYXVHbxOnfCOnoNegb90Ye2BOjCY3K
         6in559lrMep2SFeOYPkc/k2eC3v4iSQ6DchLZFvnRU31dRFf64p5dNQvpX44nwHyGDIM
         v1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nQ1O54l/xJoKtZAHjl/ZHrEcTWofgNpjma9R21hQbe4=;
        b=IHbaqX9YI+y8EjamWTi+1g7JXncjdNn4Q7nrqwGL5Zj5QhRAv9wWP68ShVvC0ebIir
         B8NGxtyWN++TecsG1NmEw+7ddQmLUvAe+0MRDPq3/pDT0Q/82dXWSgSdMeru7U/TQ2LZ
         4XFu8TSdIq3vq2xGOCUhUdRn5NnwLooxE8Al7uM/c9tBp5HG3bVnAD1WM7BcYyT/51K5
         vFXuu1unW3WqUjQ1maeQGg5mD9VOt31BdadwcP4mTPfQ0RGrLQIVPSr9EeN9fW7yugxE
         jSqcI4hyyaiMku8yz88iATBX2yOPhBCB6Msd4Czt4qg5Ge1ltPHHHH+75KRhx+LfQfr6
         Sy6A==
X-Gm-Message-State: APjAAAVRlDeBhgJ3kWlFXH3Xw7VQAr5w1PqU6DPmUPaHJJs20ifid5jJ
        jKRjcaUbw3lFHG0Mca0vrxzXtdqm
X-Google-Smtp-Source: APXvYqyYVpp14JrlB95imf7znV2ZQlZn89dHM+lhTR8di95r2HIqCXNw78aNiXZueqqQcEnMXJqOtw==
X-Received: by 2002:adf:afd2:: with SMTP id y18mr856600wrd.90.1581618774660;
        Thu, 13 Feb 2020 10:32:54 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id 25sm4118723wmi.32.2020.02.13.10.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:32:54 -0800 (PST)
Date:   Thu, 13 Feb 2020 19:32:53 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     ofono@ofono.org, linux-bluetooth@vger.kernel.org
Subject: Re: HSP/HFP ofono bluetooth support for Linux desktop
Message-ID: <20200213183253.44vkm6bpddre4dvp@pali>
References: <20200107192311.efit6zftt27encdc@pali>
 <721332d3-336a-b9d2-f8cd-72da785fb9dc@gmail.com>
 <20200108212537.zs6pesil2vjguvu6@pali>
 <57639029-7588-956b-8e3c-a2a6ed11b758@gmail.com>
 <20200213174621.e2q4ryu36p5ericx@pali>
 <6679dd2b-4780-e44f-b86d-28cf65638888@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6679dd2b-4780-e44f-b86d-28cf65638888@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thursday 13 February 2020 12:14:06 Denis Kenzior wrote:
> Hi Pali,
> 
> > Used by who? Gateway role is fully broken and client (hfp) role is used
> 
> I guess that depends on your perspective.  I've already pointed out that the
> desktop 'AG' use case was never something we needed to implement. If you
> want to fix oFono to do that, great.  If you want to write your own daemon
> to do this, also great.
> 
> > probably only by some power users. Also there is no support for mSBC in
> > pusleaudio.
> 
> Why is oFono at fault for this?  Genuine question.  What are the roadblocks
> to mSBC support?

Because does not provide needed API.

> > 
> > So, no, really it is not used.
> > 
> > > > Main objection for handsfree-audio-api.txt is that it does not provide
> > > > information about locally used codec and somehow mixes air codec and
> > > > local codec. In my hsphfpd.txt I used term "AgentCodec" for bluetooth
> > > > local codec and term "AirCodec" for bluetooth air codec format.
> > > 
> > > Okay.  But, just FYI, at the time there was no hw that could do such
> > > on-the-fly conversions, so this use case wasn't considered/implemented.
> > 
> > This cannot be truth as probably every bluetooth HW is doing on-the-fly
> > conversion between CVSD and PCM. I was not able to find HW which allows
> > me to send raw CVSD samples...
> 
> At the time this was all done in software.

CVSD was never done in software. Always in hardware. As said, even now I
was not able to find bluetooth HW which would allow to do CVSD in software.

> Alternatively, the hardware was
> directly wired between the sound card / modem and the bluetooth chip.  So
> just opening the SCO socket was enough.
> 
> > > True.  In retrospect we probably should have used strings.  But it was
> > > assumed that vendor extensions would go via the Bluetooth SIG Assigned
> > > Numbers facility.  Anyhow, we can always add a 'Register2' method that could
> > > take codecs as a string array or a combination of strings & ints. And if
> > > Register2 was used, then use 'NewConnection2' with a signature that supports
> > > passing in vendor codecs and whatever else that might be needed.
> > 
> > This is still not enough. Audio application (e.g. pulseaudio) need to
> > register AgentCodec, not AirCodec. And current API is somehow mixed.
> > Audio application needs to know what is the format which bluetooth chip
> > sends to userspace (PCM? mSBC? CVSD? PCMA? AuriStream?) and which format
> > bluetooth chip expects. I named this AgentCodec.
> 
> So how do you negotiate the 'AgentCodec'?  Does BlueZ expose this
> information?  If so, how? SCO socket option or ...?

It is done by HCI commands, therefore by kernel. There is discussion for
exporting userspace <--> kernel API to allow setting arbitrary
configurations for codecs supported by bluetooth HW.

Getting list of supported codecs can be done by this script:
https://github.com/pali/hsphfpd-prototype/blob/prototype/sco_features.pl
(needs to be run as root)

> > > > And also API does not provide socket MTU information or ability to
> > > > change/specify which codec would be used.
> > > 
> > > There was no need, we automatically defaulted to using Wide band if
> > > available.  Third party codecs are a new use case (for oFono HFP), so would
> > > require an API extension.
> > 
> > MTU is needed also for mSBC codec if encoding is done in software
> > (pulseaudio). Without it, this wide band support in ofono is unusable
> > for pulseaudio.
> 
> Isn't the MTU obtained from the SCO socket itself?  How is oFono at fault
> here?

Yes, via some ioctl it can be done. But bluez for other bluetooth
profiles provides this information via dbus API. As bluez does not
support HSP/HFP it expects that software which implement it, provide
needed info.

> > 
> > And also API extension for choosing codec. Also for choosing if software
> > of hardware encoding would be used. We know that there are lot of broken
> > devices in different way and it is really needed for either blacklist
> > some codec or switch between hw and sw encoding if something strange
> > happen. Without it pulseaudio is not going to support more codes then
> > default required (CVSD).
> 
> This seems to be a kernel / device driver / firmware  issue and should be
> solved at that level.

Why??? It is up to the application which owns SLC socket and this
application needs to provide API for it. Codecs are negotiated via AT
commands, so again only HFP / HSP daemon can do it.

> > 
> > > > 
> > > > Non-audio APIs which are needed to export (for both HSP and HFP profiles):
> > > > 
> > > > * battery level (0% - 100%)
> > > > * power source (external, battery, unknown)
> > > > * ability to send "our laptop" battery level and power source to remote device
> > > > * send text message to embedded display
> > > > * process button press event (exported via linux kernel uinput)
> > > > 
> > > 
> > > I think all of these are feasible to support under the current oFono
> > > structure, either via plugins or API extensions.
> > 
> > Ok. Are you going to implement them?
> > I think that all of these are missing parts in ofono and something which
> > is needed to be implemented for desktop/laptop HSP and HFP profile
> > support.
> > 
> 
> There are no plans to do this at the moment.

So, why should I even consider to use ofono at all? It does not support
none of above desktop feature, it does not support extended codecs, it
does not support HSP profile and also it does not support HFP profile
without physical modem (majority of desktops and laptops).

Please, do not take me wrong but after 2.5 months long discussion I just
see that ofono does not support needed parts, there are no plans for it
and everything needed is already designed and implemented in my prototype
hsphfpd daemon.

-- 
Pali Rohár
pali.rohar@gmail.com
