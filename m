Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B9B4A68BC;
	Mon, 21 Sep 2026 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003506; cv=none; b=o36sSfhZ9566F5/g0Rd6QUXfFY/K+DaYtFXcgymEpOD6U0t/Fp5pW7au3oYp0p/wwsqScb+GnqxvtSr84HvCy7HBMOTmUsd25JQ+VyUm78IpvlFY3biiMN24l5xQ3CfLu7ttUVcTZIC8i0nX7s4wL61x2IAXclUaJJtRDl61A0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003506; c=relaxed/simple;
	bh=KaqL/InmAr946gzZ9RxUGpN8vi1n6pHbS0s43B6mpvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbjMoLYtLWar6z1vO3V61bl8zTNPRsNDcZ9MyB7biz2/tscD4jt7qGO+dbsCH+ou7qAkLSopGtNONZwwWM1DkiDCLdx9vl5cwEmUy0fLmXklFn8T6C2na1n27TK2W2E3ztInQvDNJlV5W09vLxsG1WuWqw6jcyoBxerk0isXAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YS1ngKlr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YS1ngKlr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E01F00893;
	Mon, 21 Sep 2026 15:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003504;
	bh=pUplAqI0T/vC9i94K4G8o/0LOgXdEtNWcNU4n393ysc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YS1ngKlrpm1CYuXPz5OEzwSDz+KIVNV2eKoR9OnpnrcE33czHGrVKvUzt7RWSimvu
	 L7BSPx6dohW5SS11PuGr3hWfCxkgEo8y1bLsa0Ac+n4Ir0aOqrk+V6BuIboJYMreJE
	 kDX7Dh/ir9EQOYWgMUHGCk5cu9CHj/lhQF0QMHCevweglP2HaaLu3kTotkMWp+xKQ+
	 KY1zZ4WTKEi/ehjdVZYpzKEUWtrrw+NDiU+dIEQkJ833Eykou6gLHzmwqBZ4gfliDY
	 JfGaluVBow21UkZ4r35/UG6E7oOVYaVN7Gj07PKxl4rGt9QNKj+PAbGB9Birq5vzJP
	 07TVt3SxErR7g==
Date: Mon, 21 Sep 2026 17:11:41 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hidp: fix out-of-bounds reads on short frames
 and report_return skb leak
Message-ID: <arFJLN-u5MuzjjCL@quoll>
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



