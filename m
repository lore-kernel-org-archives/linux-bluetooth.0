Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82355D8F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342778; cv=none; b=YUdD9nHOWQZdb9rF9biOd0L6OwZZ/WNFEbSY3A90sT92nlZ8v+t+EOP5npKjZhdlKgcaPfB+lcM4kSfcpTAV9TQ152zy2Dk6z02HuVLcg7V/EpBTcdgqkztoWCVtKTq7y1X1HP3i6IroV+0wdZDFtPtYJrTaFwa/3IeZa/uf0N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342778; c=relaxed/simple;
	bh=UuKCGZDfBb+rnhrXIbZN/cR/ZQTWM20t989TnEUTvFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWavOL27az94hvnHQkZN+zwDkAYzm3+uiIlnywti9o7DAxXKHtN9YU0Elkqw3r9HGsGxQrc3fTVUTod22qTFKcZXxwKb1s7WWf4tq05bfxgCZdR/jGkxfN7RFF0GV0AECgfFbaKkRPPMibNtCvRVaaLB2oSq6rRtR80wDFXdrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHOyC78w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHOyC78w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DB0C072AA;
	Wed, 17 Apr 2024 08:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342777;
	bh=UuKCGZDfBb+rnhrXIbZN/cR/ZQTWM20t989TnEUTvFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mHOyC78wcx5xAycMXkJLkZhqXwkFoOjSHyLDDTWx/wBKLeYvdPJs2DCiAJpfVzvMF
	 HICDK61uk5WH1h/ua3G02ws2hRkxaSaPBYGTljhkCJeJdeRT/QhukxfYbb8jfHhG+R
	 Eiqdwn0SoZe69bP42qp8trPvqPKl+6qk4U2NN0o40uuOOIpi1MT1rlwQX5JDETKg/M
	 nir/rVAkPGgpe3Jy8qNM13niLh+qtdHwMyiqJofqZHld371dg10ZBw7hbNkZ74YL6X
	 T7cyBvK7Nj6SQlOOqc3uk2L4uPBlpYAnOGTAVX0j+EvmvRYRBg7UEhYwRz7BDdUTe2
	 en+JX05kLT7dg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rx0it-00000000849-44fj;
	Wed, 17 Apr 2024 10:32:56 +0200
Date: Wed, 17 Apr 2024 10:32:55 +0200
From: Johan Hovold <johan@kernel.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH] Bluetooth: qca: Fix nullptr dereference for non-serdev
 devices
Message-ID: <Zh-JNzlskY6ZvsSm@hovoldconsulting.com>
References: <1713325792-17181-1-git-send-email-quic_zijuhu@quicinc.com>
 <Zh9saGbOl-fXP6SD@hovoldconsulting.com>
 <5e4e62c8-d17f-45fd-9212-088eb026dc7b@quicinc.com>
 <Zh91zq13nZvH3-Yj@hovoldconsulting.com>
 <4dac0caa-629d-4b4d-ad54-f6ab15268524@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dac0caa-629d-4b4d-ad54-f6ab15268524@quicinc.com>

Again, make sure wrap you replies at 72 cols and trim unnecessary
context:

  https://docs.kernel.org/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

On Wed, Apr 17, 2024 at 03:32:51PM +0800, quic_zijuhu wrote:
> On 4/17/2024 3:10 PM, Johan Hovold wrote:
> > On Wed, Apr 17, 2024 at 02:51:38PM +0800, quic_zijuhu wrote:

> >> i have submitted below patches to add supports for all other
> >> non-serdev controllers.
> > 
> >> https://patchwork.kernel.org/project/bluetooth/list/?series=844120
> > 
> > Ok, you need it for some future changes, but I'm afraid that adding new
> > random vendor specific ioctls like you do in that is series is a no-go.

> it is a generic ioctl, for QCA, it is used to specific soc_type. it
> maybe be used by other vendor driver to set user specified info.

In it's current form it's a vendor specific hack that is never going to
make it upstream.

For a start, you don't even make sure that the types becomes part of the
ABI, which means that passing, say, type 5 can mean different things
depending on the kernel version.

Can't you just retrieve the device type from the device itself? If it's
already powered, you should not need to know this beforehand.
  
Johan
