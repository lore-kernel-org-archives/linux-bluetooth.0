Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A81422AB
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737389; cv=none; b=iJn67Vndiuxv+TtLj/LToCV/B7jQ9iSNC10SY46UczbmAw/uqpcXDaK+BIKwQ119+RYhovspnLMas6y6kTxpv3ClYkB3Grn+cS71hCgfPaj+e/6/MhBmRdPZRhK+YBAs85bDHOdQX7vUeuq5C5SX5CUnw1Xg6XiSIaE37h3G8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737389; c=relaxed/simple;
	bh=Xyg0XpUbpiUdllgiR/yv6rUr17S9DBLMYDtMbMc2rRo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/pkWQbYf18Iz09/80LNroEW+Hj14Iio+9d6LXs3fCXZi72VNqZx7kYqXev3R6+Oy6Uceg1dc0sa6OSN6sRv8VyfCZIZOGIQs8FnUhxwhMJECHHJTLjUIzposxxLrMTouI6zJIswVtOeTKSvGyIPAImjqx9OR5E7iqMamM483E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhOlCDRQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhOlCDRQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C1FC4CEE9
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Apr 2025 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744737389;
	bh=Xyg0XpUbpiUdllgiR/yv6rUr17S9DBLMYDtMbMc2rRo=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=OhOlCDRQwW+yO6B4Upw5R5aJd3Yzeh9PmBkn5awCwH5z1tAJ76fYOJTyyTlE7h2uE
	 1Eu62XP68pUU1QhYAnhpcnQ/QmEpbg8/iNDMZgbB9f4ygSckOsjHB8EYLBqkZiyMgC
	 L0jsICNNkPLzWf9v5v0G/kcxMmCN7FE1hRksLLWHsCqwQ2ecW0WqPgWMzzcKtfYgzD
	 EdtAuPNUxaz2kM1oco2ofNtkQawF8lJ+ILSFBYRMudvVyKJZLtk8Z2vPcloQ9di4Tu
	 JkVdSxJ32BZQNVQAPvttFmpW9acKKWcGEf/QXr7vXjJmOJ/AAq9YBSg+bd9m4cUDXO
	 sW+fkVV2EKIwA==
Date: Tue, 15 Apr 2025 10:16:26 -0700
From: Kees Cook <kees@kernel.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth: vhci: Avoid needless snprintf() calls
Message-ID: <202504151015.2774F67C@keescook>
References: <20250415161518.work.889-kees@kernel.org>
 <67fe9189.050a0220.3238e4.a78d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67fe9189.050a0220.3238e4.a78d@mx.google.com>

On Tue, Apr 15, 2025 at 10:04:09AM -0700, bluez.test.bot@gmail.com wrote:
> TestRunner_mgmt-tester        FAIL      120.00 seconds

This test looks to be broken? Or the existing tree is broken? It fails
with other unrelated patches too, e.g.:

https://patchwork.kernel.org/project/bluetooth/patch/20250411165608.871089-2-luiz.dentz@gmail.com/

-- 
Kees Cook
