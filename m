Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44E4A8418;
	Mon, 21 Sep 2026 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003789; cv=none; b=D8hZepv/yLW92kVnBo3HKBA2LNdp5pZ7KIvmLPXM9oJJRocNxQ6i4X59ZdyV4iq4yMOW0FF4mwSOz5DNTP6uKw2Z9HwhZUBw9HuNWaY6X35/+KGI9gP5vPCWsWvb4ug04CW+8LIP+OHWgpPzsPPfVN1iYYXqB19CU/hrl5mihF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003789; c=relaxed/simple;
	bh=KaqL/InmAr946gzZ9RxUGpN8vi1n6pHbS0s43B6mpvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCP5ezLd5DaKXFu0SbBtaP39jRgnkj7qkcloYHCsrqD2Zm7gMcf+S6l/8+VXVqJ2n8tz5A0f2f5O2R5bsZNhVJNKnoV3SPtIISmpP5YRdpySZ+gCLwTw2DSmz9GlXIDcBKoszvlT7IBIyLIwDLtDcTCdWKYVSmwogux5gIzRSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKoTmb/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKoTmb/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFC21F000FF;
	Mon, 21 Sep 2026 15:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003788;
	bh=pUplAqI0T/vC9i94K4G8o/0LOgXdEtNWcNU4n393ysc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CKoTmb/N5IutXaJ6GkJU0Cnc+AWqz/iwccCkrzi/u8LlfN8xcTgWj+H3Z18YIMblV
	 3vBlNk06lwl8VUImPYezIMw5D8D5IxW7qbByHAyrSILJT4EPcnTGGw2iUIXSTZXbST
	 ZLn2tHwkynbypesH2qaLB1EvpGMISgbnuOh70VT0nhJmXuVoUt3YRNlNPiJW5BLIZe
	 yzyXDM+5wFdUwk3EpHRjxpBMiwmxbKEJ4gPRZv2JRU200zQztt0S++x3LGCdij6L8M
	 SvBDzvKfu36uJZ/TTVMyetCyAzQCv7Ii7pep5467+HeVKRSMczV+HCdLTd3IERXhKm
	 1+mNhUzTMSHJw==
Date: Mon, 21 Sep 2026 17:16:25 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hidp: fix out-of-bounds reads on short frames
 and report_return skb leak
Message-ID: <arFKSC0NALKj3BkD@quoll>
References: <20260919221741.3709254-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919221741.3709254-1-benquike@gmail.com>


On Sat, 19 Sep 2026 22:17:41 +0000, Hui Peng wrote:
> In hidp_recv_intr_frame() and hidp_recv_ctrl_frame()
> (net/bluetooth/hidp/core.c), check skb->len >= 1 with pskb_may_pull()
> before dereferencing skb->data[0] and skb_pull(skb, 1), and free any
> stale session->report_return skb before overwriting it or when tearing
> down the HIDP session.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



