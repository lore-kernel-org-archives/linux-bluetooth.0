Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CFE3B6BF1
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502555; cv=none; b=uH0NhVCgmCToM5sVkA2//TTfXaAag59gWx5TEw3iem2IzzU7tSWWHN8cnKDg/pGLgB2X2HGzdg2HD5eR/OglCz4C5lA0DwTbcH/HEc63xWMAeiAo3txNFKPHxqJrK1DlbkZ6vJ0VTUdsj2mb+8owxRNSjbNWv7vze+3goEADsDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502555; c=relaxed/simple;
	bh=9FMw0YoBbJdNgr83/780TEAIbAx5S2E4LJQDWmYC/Gc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEzDQvepcUyIix5tuUfH8f95OI7F+VRapaVoFpS39OjhPHNjBwB12l9Hey0gJgU8ye8amvwylLtdsoRrSYf0i4iCekBwl2aAV1gyD99rSyOiYSf3ZwF5jwhvS+4gWkIiZ3B1LySlDgVl5PdxXbySD7d915mylvnVtN2QIVMRo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kWtKqJ78; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kWtKqJ78"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nO56lfXCbz1oivN3sXgr0tBV+d2gWY36tlBRwy79wI8=; b=kWtKqJ78o2ewHUwxQXjQx7z9oG
	wUB4bdvltumECueXdJrZ6GrkIHlAVKyRiBI1hViCVIPKs/UWT7ZrEJr6KJYfMY6m9sQSBptqROtuK
	V0HCf8G1NJIs3ADJup0IJvQ0nw6+5pqb9rjAK9x4lmZ/6unV8CAUpRKv6E7AlhtQWKyU4k8VNECCP
	LTSQRpldqz8KMpybr1+3o968mRfic9u+B/TX3BJA0qdecTXmB5y/p37XS7X3gZ1v7kqNEDoq2r25O
	JaIaXWH3GGVaFTwwJG2dyeJyWz0vIhqWXuCqQB9JoSX9LlHjCZtWhrnuwaCheAP3dDWF+nNTqgyKh
	Plv2hvSw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMPl2-001bBA-12
	for linux-bluetooth@vger.kernel.org;
	Mon, 11 May 2026 12:29:12 +0000
Date: Mon, 11 May 2026 05:29:08 -0700
From: Breno Leitao <leitao@debian.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: net: convert remaining bluetooth socket families to
 getsockopt_iter
Message-ID: <agHLeMrI_ua1yKIs@gmail.com>
References: <20260511-getsock_three-v1-1-1461fa8786ab@debian.org>
 <6a01b70b.050a0220.366c6d.5746@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a01b70b.050a0220.366c6d.5746@mx.google.com>
X-Debian-User: leitao

On Mon, May 11, 2026 at 04:01:31AM -0700, bluez.test.bot@gmail.com wrote:
> This is an automated email and please do not reply to this email.
> 
> Dear Submitter,
> 
> Thank you for submitting the patches to the linux bluetooth mailing list.
> While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

What is the HEAD of the repository? This should apply against
linux-next-alike branch.
