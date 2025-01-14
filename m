Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7D236A72;
	Tue, 14 Jan 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736859946; cv=none; b=OQYRlx61sfaRwQDNovXwxCniWzVR+j1n8EEGkDiVaz1IRTP10oHaoKz6T/BeiidXtGH2emIl+Itq3laxLLKS/bS3odzq6fQPwagUrHD/2a42N09PjnphSe5lL4jLKiX4o4934BsYxFTB+3RilaNNES5uicFHycVnEBbH3lw5pzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736859946; c=relaxed/simple;
	bh=AOiznMyP39NmPXpGmF2byI0PTAqWq3rqIjsp+EvKE9o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gn+1GhSKsf9SQGdGidkWy+4s71oCkNAPTCiV+Yy/jldzzMYN6A/ATIVEWgq2uWh0WD2gWdW3aBdpHEowug5+I5vWzvWqntjkINzQdD7TYdBB4pAZk3VBd8m3an7iZ9U5o6FCB7DGSTOzoz5pO3Q50OC3wBiiI1dWyZC7Y/Iag3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=gcaPYYfO; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gcaPYYfO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OiK37tyA4OKQ3PjZtut4wihyLEmvFD3y7BWJQEvZK4A=; b=gcaPYYfOj8IcFjkKklIjOq9Gie
	Uen1YSwmPUQsJhQZULWR64VHeKOAke2/wbDNsUv5yqvFcnbkYsqPPPhL4Iyj90DiSIY4zKYcs7Sov
	KHoRZBFS4ABySExOyOdlwvexT2vsgGqfg2yi+sOaQJZSX4JUWlsS3ssDX4O/o2WWANsf6MtFP21Wf
	WYegsT5+kjv1pbRUJfxAdqFEjQoT5Ddw+YtirJzgGICojcrlnSodacPP4ZuZYyjLXWt1WbQuUUpzD
	l9WI8trFIxQZIH6mTDGlT0ZwYLqvdQKvZBGh7c3L2oMV7cRy6ce9iPCyRF+kQCVilt/jV5CyBRTvM
	YQwf2Iww==;
Date: Tue, 14 Jan 2025 14:05:25 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Johan Hovold <johan@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
 jirislaby@kernel.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Adam Ford
 <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
 tomi.valkeinen@ideasonboard.com, =?UTF-8?B?UMOpdGVy?= Ujfalusi
 <peter.ujfalusi@gmail.com>, robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH v4 2/4] Bluetooth: ti-st: Add GNSS subdevice for TI
 Wilink chips
Message-ID: <20250114140525.763b4c33@akair>
In-Reply-To: <Z4ZVNU0PdCDpMaNY@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
	<20240606183032.684481-3-andreas@kemnade.info>
	<Z4ZVNU0PdCDpMaNY@hovoldconsulting.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Tue, 14 Jan 2025 13:14:45 +0100
schrieb Johan Hovold <johan@kernel.org>:

> > GNSS support is available through
> > channel 9 whilst FM is through channel 8. Add a platform subdevice for
> > GNSS so that a driver for that functionality can be build.  
> 
> > To avoid having
> > useless GNSS devices, do it only when the devicetree node name contains
> > gnss.  
> 
> That's seems like an unorthodox use of device tree. These devices are
> primarily (WiFi and) Bluetooth controllers so should probably not have
> gone about and updated the node names to 'bluetooth-gnss' as you did,
> for example, here:

yes, the matching of the node name is a bit unorthodox. How do you
define primary? The old design with ti-st driver and bluetooth and
other functions on top does not look like anything primary. If you look
at the current situation with the GNSS stuff sitting on to of
bluetooth, the picture is different, but that is implementation. As the
devicetree is describing hardware, having the nodenames describe things
seems like the right way to do.
But I agree with you that the driver should not care about the node
name, but use a boolean property.

Regards,
Andreas
