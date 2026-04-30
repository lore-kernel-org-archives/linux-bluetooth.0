Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A31DA0E1;
	Thu, 30 Apr 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777537366; cv=none; b=t9RWzi5FnpJFcxiE2IbqqeQAX9M0vBqnoFwtX9gXSTeJ7jBC95jyhD1bG/5IIWAwaA7fcfLcqz1+8lrDlPzv8tzVGrLXjvSKo9P9d54eGRMJJemBxAFG1VZzSZZqfUZfEUD6tswUclVwDopImX/K2uaMxh8+sxyWfLmMOnNDLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777537366; c=relaxed/simple;
	bh=4d4W5UMSrARH0PN4IcfC+pocS/O7iSpsQ8iq+24kqTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD67G2TOcxIhDFfytRqz5MT08NnRTGJY2+1NfhA6TY4sZzuSYEO3AYpgzQqutjXEiv42e88uLsFuRow0T2mrMcG+Zbyt2zP55d6RJ9sVD9SFq8ZXGk7PPaCJxyZIf+GsHakdzAkmViUUOgNFet8QNpCNWx0cFAew60s9EhiuV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMMz1ipu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMMz1ipu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE75C2BCB3;
	Thu, 30 Apr 2026 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777537365;
	bh=4d4W5UMSrARH0PN4IcfC+pocS/O7iSpsQ8iq+24kqTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMMz1ipu0UXs3KCOeoK8ao5LtmQJb/wH7DV9IN8IkyGLGYcMd1gNYQyJqqCrIJvmq
	 Fxlss3Ht5whh5SOFzuR69tUHClOXr5c/s+t8D6sMBDmC9Vn7rTURBLRNniSD+D1Js/
	 VN46pVH+5vclx28kf/8nqK4czyGvNJhKM0bTwZDwHSkV8L4RC/wH+tEQtyXTielu9u
	 0qOJC2fda9eMcnlxnnfw/33UGYANTtp6GeGlV5nRc0rWRyNp8cYi1obP9qkOPa7jfb
	 ZSjMc7fYh9EdPQhuKYBo6vVgEha9Xm+DZT2pTp5GttO2kboPxPmBsw8Hf/swsZxH7q
	 c6ZEisO3jYaSg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wIMfT-00000000tnE-0nXJ;
	Thu, 30 Apr 2026 10:22:43 +0200
Date: Thu, 30 Apr 2026 10:22:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Bluetooth: btusb: fix wakeup irq devres lifetime
Message-ID: <afMRU8lOkHx8oKNM@hovoldconsulting.com>
References: <20260402154810.2467291-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402154810.2467291-1-johan@kernel.org>

On Thu, Apr 02, 2026 at 05:48:05PM +0200, Johan Hovold wrote:
> This series fixes a couple of use-after-free issues and a wakeup source
> leak on probe failure and a (currently benign) OOB wakeup interrupt
> devres lifetime issue.
> 
> Included is also a related cleanup.
> 
> Note that these are intended for 7.1 (e.g. as the fixes are not
> critical) and apply on top of linux-next which has commit 2db5a8b68e31
> ("Bluetooth: btusb: refactor endpoint lookup").

Can these be picked up now (for 7.1 or 7.2)?

Johan
