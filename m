Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B551004
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337807; cv=none; b=IUl0B8e7lt0+JtmsegriYAeOLgn6bY1m5sbz/lH3tv/Q09B42GV8cMfjpEdhvoAzGFsocpC65z484QDi4F8OrGcRW1Yg7/5CcatHnfcdPefppFhgmMRpFkIxmUcbm2pvXPx1/J4ur0GNsY+OjRaTO2OD4DUbixoqqwgCErscXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337807; c=relaxed/simple;
	bh=iutH2QGyC34xEntr9e0GeGTgOvftPXB7nW5dzbL8Wpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv8bAai+06+cdfCrxa37Ixs01Rs7brYilz697ZxQZCDxsFpD0tojb/WmkuGd/Z2T4ok/7TSNy0SzifZZ7q2ptN0ud95raWtYP3OzbvKZA+sdQhTX1fEO7yOUJ4GFh3VgllDj6N6gur24fIUy3x/Dk2W0KC4OBvhqH05jCmFexok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TndH3AGF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TndH3AGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A5DC072AA;
	Wed, 17 Apr 2024 07:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713337807;
	bh=iutH2QGyC34xEntr9e0GeGTgOvftPXB7nW5dzbL8Wpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TndH3AGFds1aUBLzDgHwUxapB5z92Jb6XimYrcTfpIJJLe8DrzO0rYUkyQSTFNRnP
	 EVFF/v91FhL4ReUFu4mpFS9/7CWd/MzYfWZZmwU+QAQ4Kl5gME0xpdm4jMd+VQ76J4
	 z0CoUqlvdVy/VsmT4fBMdZlvNPW3yDFnIofeTOokpqk3MSP5U7s2CIXOfds3BUrRDS
	 pHuAC38lrcULM+oiFznpvoEaPWDVPBGqmTXvI2y1wyoMZHvKuwgHl400yhYlXoRPRs
	 UhfRA6HDOhrXdmFwuSNnVOY+CBXCxQvki+1vY49I3aZFYBkLgHefWGx++A7Yt+fHFI
	 xyVxUsgoEMP5w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwzQk-000000005wV-1q6G;
	Wed, 17 Apr 2024 09:10:06 +0200
Date: Wed, 17 Apr 2024 09:10:06 +0200
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH] Bluetooth: qca: Fix nullptr dereference for non-serdev
 devices
Message-ID: <Zh91zq13nZvH3-Yj@hovoldconsulting.com>
References: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
 <Zh9saGbOl-fXP6SD@hovoldconsulting.com>
 <5e4e62c8-d17f-45fd-9212-088eb026dc7b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e4e62c8-d17f-45fd-9212-088eb026dc7b@quicinc.com>

[ Please wrap you mails at 72 columns or so and trim unnecessary context
  when replying. ]

On Wed, Apr 17, 2024 at 02:51:38PM +0800, quic_zijuhu wrote:
> On 4/17/2024 2:30 PM, Johan Hovold wrote:
> > On Wed, Apr 17, 2024 at 11:49:52AM +0800, Zijun Hu wrote:
> >> hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
> >> is called by non-serdev device, fixed by null check before access.
> > 
> > No, this patch is not correct.

> i don't think so, nullptr checking for hu->serdev has been performed
> within qca_setup() everywhere when need to access serdev related
> members since this function will be called by both serdev and
> none-serdev. so suggest add such checking.

Your patch is not correct since you claim that this path can trigger a
NULL pointer dereference. As I point out below that is currently not
possible.

If you need this for some future change you need to say so in the commit
message and drop the bogus Fixes tag.

> >> Fixes: 77f45cca8bc5 ("Bluetooth: qca: fix device-address endianness")
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

> >> @@ -1905,10 +1905,11 @@ static int qca_setup(struct hci_uart *hu)
> >>  	case QCA_WCN6750:
> >>  	case QCA_WCN6855:
> >>  	case QCA_WCN7850:
> >> -		qcadev = serdev_device_get_drvdata(hu->serdev);
> > 
> > Non-serdev controllers have type QCA_ROME (see qca_soc_type()) so will
> > never end up in this path.

> i have submitted below patches to add supports for all other
> non-serdev controllers.

> https://patchwork.kernel.org/project/bluetooth/list/?series=844120

Ok, you need it for some future changes, but I'm afraid that adding new
random vendor specific ioctls like you do in that is series is a no-go.

Why are you trying to revive the old line-discipline when we have
serdev?

In any case, a change like this one would should be included in that
series so that it's clear that it is only needed for your proposed
further changes.
 
> > I verified this when I wrote the patch and also fixed up a couple of
> > real non-serdev bugs here:
> > 
> > 	https://lore.kernel.org/lkml/20240319154611.2492-1-johan+linaro@kernel.org/

> actually, i have submitted below fix for this issue earlier.
> https://lore.kernel.org/all/1704960978-5437-1-git-send-email-quic_zijuhu@quicinc.com/

Ok.

Johan
