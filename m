Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060ED3B9DAE
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222994; cv=none; b=SLVwOvnJPrWfgSvZn9G7Ux8w7bT+szhAcvQPrUcVeu9pf4Qefp8z7fDnt7aMt1Illw2Rs7TLwMHdMVRN4+rR8KdMcouTqzMcvkIK69cq7DIzqvAeOIZm9g1rRT4JFMCMs4SX/LcnDfr8A/1pZovxvqI+fsVz6pkwYg4quho/lxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222994; c=relaxed/simple;
	bh=dwkAHgSWygFChA4zCmYYHKJj7zBx0a8LCXOmRvUngcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoTovJ39KdnzamMh4kYzCBHFTuPAH7LdaJPk+TzMiDv6V8w2ZBgw5mYqMAhri5Z1CPJtqfFkuhX/9Ktf0wMCx+cvOLUZ8ZEK+FzcvKb8+YEWgFpqoMpetYQW9z9eHTrOoNS7erO5HVLrPVz4LVpVHmn6Ctud8WdM1KsmV7CvtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwJ/XfeM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwJ/XfeM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso19021985e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775222991; x=1775827791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Fntrn64n6j1OStWvWhr8G0RM9RqPfnNWUS29Jome3I=;
        b=JwJ/XfeMMYytFsFpLVIGiUPfBLd9hOGBnIOPm5U6I+n6jBov7G8uDQt/OSjVOG+ooC
         8LwfKzxMBQ9aoGoxlGGgdWlS/83dIlt5oHbYGZPfdFhGeqURYYWF6d3ddfd9KFRXCrS4
         XI2sxl821OOuRRIJgOABQaAQyLLUbap5pzb9kdg+v2rG5v0dvtxKI2Tlv2tv9auBMuxw
         oUpoukox5JULe31rl0J/221XUendvOL3gql23olgIyMt+/hodXSSWiVTKfPJ3ZqPE+Iv
         fB1Xpo/JRndvhrdSArTNOB2IkbtAezFm9KU4e9sS+9z57GThHvUBsKU8uuvHrLCbgWX5
         Wzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775222991; x=1775827791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Fntrn64n6j1OStWvWhr8G0RM9RqPfnNWUS29Jome3I=;
        b=GiEH3yEQH0vjCSHitfoq5jSBeVc3SU7KVQC43sAamcyzQUVTST73WNJpOVNU22SnAk
         hjU1yaafHY0aV6mUbWUkJvJ7uq+dF5M7IoOPNBsWOxbSQJZS92ZJHltgSIfXd8EI0LTV
         cvs3Yw/wvzDhLQTx/4j4m58cvYv4MpsVVgYkhN4jHBppg0MoadGlWBJYnOD8M6/hJZg9
         NtSrjmWnpwLY426MAG33VdVRAA603dk8Bf6WPli/mZ8CcditDgwscFyFg7wEKzXQwpkR
         YbUmWA5+EfiG/37Vgc9ntKOxj3oJIU+apBiNgqJ0uxwm3jQhJhU5WnalQFAv23E0SPOw
         XR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsKjsXQXPpIPoJgLHeT498j5bWGMOUgdaR6Z/a1X6D1+1rqxikShcC8HP37RCst5k123hFo5hpqr8XztQvgAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPfM0KgbLyGTqU0QtV5CsWd5McAQeHtR4geFh9GXIK8A8KyVBU
	nnvbDIF1Jzwdb+pru58a/WGvTphHli+4ai4JHiXfZo2F21qJCdYLdtCd
X-Gm-Gg: ATEYQzxXPCQbGsvabS3Y2CGoyORUNbH6E3+tIUh0cD22zpo+bK4+tyKBEJCfhbf7P4d
	akBAVFov/F2wim7WGfC+uMECacqq8l2IO8K+OoiL7KSVqBRDYyHZbMpcZk5YaMP6vpEhDHSFHa4
	pR65cJVN3xf7Wia/Z5qAVqxy15SwFrdHfT6Ngo6kAJtcucfMJXOPgstesNmu5TqEKrXfXXSK15X
	f2Ccuo90O/3ga3S63ksXEKCproQscNMaQy9sKIFnC1Cc9hsVEDxf/3sWRNcjyUEHagx2Hy/43qU
	dwWajIYOgjMMBeeWnmqa9ZIwrqM5w1ZT7vC0F0zT01QfNXbtV8ipakCHCNQIDuzT4RhHgQDQ4WJ
	tIcS2/P0+92/mYpG8G9bFt2i3sT5eHkmscA5MEOkD7OGofGgyeO92+HXEq7LoR7RhAyU8AZz8gw
	i9jsoMFpmzC7W2AdR/qTBj3W/iAIQHXjGyEPWy5+UQ1uHfgY5fp73LT5QbyunoOwXz3CNjH8IdZ
	Iq2FQudALd3mKXz6kqbeg==
X-Received: by 2002:a05:600c:c0cf:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-4889945f8e8mr35163925e9.2.1775222991066;
        Fri, 03 Apr 2026 06:29:51 -0700 (PDT)
Received: from GLaDOS.station (mob-5-90-7-64.net.vodafone.it. [5.90.7.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889b5427cfsm30886435e9.1.2026.04.03.06.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:29:50 -0700 (PDT)
Date: Fri, 3 Apr 2026 15:29:47 +0200
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: hci_ll: Enable
 BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
Message-ID: <ac_Ay0p31BSJJdwR@GLaDOS.station>
References: <cover.1771930508.git.stefano.r@variscite.com>
 <36a2c4c75e557527d101897b649f9de8d2180fb6.1771930508.git.stefano.r@variscite.com>
 <6398d0a2-f9ef-42a9-8761-6c924a5fb341@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6398d0a2-f9ef-42a9-8761-6c924a5fb341@molgen.mpg.de>

Hi Paul,

On Thu, Apr 02, 2026 at 10:51:01PM +0200, Paul Menzel wrote:
> 
> Do you have a reproducer?
> 

Yes,
the issue can be reproduced on our Variscite platforms using TI WL183x
modules (e.g. VAR-SOM-MX6). When establishing an SCO connection using
the HCI Enhanced Setup Synchronous Connection command.

Forcing the legacy HCI Setup Synchronous Connection (0x0028) instead
restores correct SCO operation.

> Have you contacted TI about this?
> 

No, we have not contacted TI.

WL183x devices are quite old (released more than 10 years ago), and the
latest available firmware is also quite dated and predates the
introduction of the Enhanced Setup Synchronous Connection handling in
the Linux kernel.

Given this, these devices cannot realistically work correctly with this
command unless a new firmware update is provided by TI, which seems
unlikely at this point.

> 
> Do you have an example device, that uses one of these? 

Yes, for example the VAR-SOM-MX6, which integrates WL183x modules.
The issue has been consistently observed across our platforms using
WL1831, WL1835 and WL1837 modules.

>Also, do you know of
> TI device, where the HCI Enhanced Setup Synchronous Connection command
> works?
> 

At the moment I do not have access to other TI Bluetooth families using
this driver to verify whether the enhanced command works correctly on
newer devices.

For this reason, the patch limits the quirk only to the WL183x family,
based on the compatible string, and does not affect other TI devices
handled by hci_ll. Additional compatibles can be added in the future if
similar behaviour is observed on other controllers.

Thanks for your review!

Best Regards,
Stefano
