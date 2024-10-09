Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348E1537D7
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470410; cv=none; b=AvEvLLKoD0TYFb+JDOotw1z2u2azeKfxkImteMQCMio3fWSjXYHbdkYMQCLDLFnwofdo1ycCbYEgJyARISwrxoYwOwdOmeofVHkJI1K11jaMYsseWOsZNEln0LdI3qR/01Ksaiv103P7xVCVCwuT3l7VJQl7YUwqnVZA5ikCQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470410; c=relaxed/simple;
	bh=Z3hngFiEMpz2hOFuZ0iOtqNCHyrYtPRZV7ZXDj2ig1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5i5lWKZugeOy7sXiqc07QscLPHuM3xG/PKFVdDv9pR6+AsVr7hLNjjWBMBKuo4oy2ixIFYPBLpPDeKCUGQSISqLmvmnM2zAk53yK+7ErrD5+VqAVuwzkWQ4hrAUexwK4qfTIAghSRIpZSEpgIXv/aILxQdyH3fwJdOvrFfMVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id CF0FC20062;
	Wed,  9 Oct 2024 12:30:38 +0200 (CEST)
Date: Wed, 9 Oct 2024 12:30:37 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>, 
	Bartosz Fabianowski <bartosz@fabianowski.eu>, Pauli Virtanen <pav@iki.fi>, 
	Marek Czerski <ma.czerski@gmail.com>
Subject: Re: [PATCH BlueZ v4 3/3] audio/avrcp: Determine Absolute Volume
 support from feature category 2
Message-ID: <brenpr5jeeivae4e2zqalqctcblyq3cvoeqqte36hnmyxh6v57@efpmjykxruj5>
References: <20241005214321.84250-1-marijn.suijten@somainline.org>
 <20241005214321.84250-4-marijn.suijten@somainline.org>
 <CABBYNZLQexGSfm_0B-0_EFi3MOSZDiGzEdLBWqqUAU6_jRwOZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZLQexGSfm_0B-0_EFi3MOSZDiGzEdLBWqqUAU6_jRwOZg@mail.gmail.com>

On 2024-10-07 11:56:06, Luiz Augusto von Dentz wrote:
> Hi Marijn,
> 
<snip>
> > diff --git a/src/main.conf b/src/main.conf
> > index fff13ed2f..b6b32a720 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -316,6 +316,15 @@
> >  # notifications.
> >  #VolumeCategory = true
> >
> > +# Require peer AVRCP controllers to have at least version 1.4 before
> > +# accessing category-2 (absolute volume) features (depending on the value
> > +# of VolumeCategory above).  It is common for Android-powered devices to not
> > +# signal the desired minimum version of 1.4 while still supporting absolute
> > +# volume based on the feature category bit, as mentioned in this comment:
> > +# https://android.googlesource.com/platform/system/bt/+/android-12.0.0_r1/bta/
> > +# av/bta_av_main.cc#621
> > +#VolumeVersion = false
> 
> I'd change this to have the version e.g. #VolumeVersion = 1.4, so the
> user can switch to 1.3 or "any" in case he want to bypass version
> checking

We can surely change this to parse a version which would override the version
of the remote CT, and rename it to CTVersion since it's no longer only affecting
volume?  Maybe add a TGVersion as well, and/or something else entirely?

That would save the ugly combinatorial explosion.  Maybe the same works for
VolumeCategory introduced in the previous patch as well?

> also perhaps we should create an issue for Android folks to
> fix their version, as it seems they do support browsing features
> channel for TG they should be able to do the same for CT.

I don't think this patch aged particularly well as hinted by the testing
steps in the cover letter: on my Android 14 phone AVRCP 1.5 is the default in
developer settings, so they might have realized that this was a problem in the
past.  Don't think we need to report it anymore, and we should perhaps start
discussing whether this patch is still desired in the first place?  Either way
I'd appreciate to land the first and second patch.

- Marijn

> > +
> >  [Policy]
> >  #
> >  # The ReconnectUUIDs defines the set of remote services that should try
> > --
> > 2.46.2
> >
> 
> 
> -- 
> Luiz Augusto von Dentz
