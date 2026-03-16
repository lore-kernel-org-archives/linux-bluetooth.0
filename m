Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41044372B27;
	Mon, 16 Mar 2026 23:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703587; cv=none; b=iIby0kJqM61PAjiy3YDHlbkio6Drrx5sZFteAaisbeicMLy/tf2hcLOghvi5phL8iviR6HCsZknmFsUqetm4IbGueFH4pbwNZou8kFFh+bT53jj2AJnK2sg501+FUxXJSzBJi9fPbo6raJzqPA+C5x6lyJF5fv6l05dF6BycP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703587; c=relaxed/simple;
	bh=KJlz8SSdNGgaHkDeRIBGgrbr6/4ndUBNjuNgpZhMooU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ha/TYP7PNpd9zKiW4NiDe4JzCmORYcGVGGJJDqNsQTmbPVNJWuVq4XU8PLmm09HP+Eft/Bu8hwOwYBL0iBDPODI8fLsCv1NK5WL2Rg8HzMO54M4C/nAoH/gx4/HxW+qXmFtm52seo0SCBgoxWniGuiZuPRhqdPmMU7/j/lLscNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERhzkRD0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERhzkRD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E597CC2BC9E;
	Mon, 16 Mar 2026 23:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773703587;
	bh=KJlz8SSdNGgaHkDeRIBGgrbr6/4ndUBNjuNgpZhMooU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ERhzkRD0KNo0t1lzJ2F7a3B5Y7m5ouUbyqcXdvuwyrW3DtPU4x8ZnTljG9bIm63Ag
	 rixFfZ0NK70OEBokyR7N3MUhfJNEVpOvfHTHO8Ft1k8O2ijQ0W4ZLBMAuo4KDfc3/+
	 LSpPb9UBaPpWUiESQx/HLCDZyFvL8FB33LEX9pHtX38iVSunSofEBBgwo4HvkaJKFj
	 wxD2KpXRrji5BZPa79zRXd95ILHz5BKJQGSPm/8aoXAMTCE/d5WPdN8hcer+UEG8SD
	 FQMBJCoTuU7Ols5Ogm0oAW+rpaP7LktULksIrpSL/LGltAAbuvajZTCETlaf4FckZS
	 +m4SJpNagyy1A==
Date: Mon, 16 Mar 2026 16:26:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-03-12
Message-ID: <20260316162626.6829f49c@kernel.org>
In-Reply-To: <CABBYNZJo0aZW1p1YqyKNDWURunAHxZcS8B86OZGstfgWr0S58A@mail.gmail.com>
References: <20260312200655.1215688-1-luiz.dentz@gmail.com>
	<20260314094707.105683b1@kernel.org>
	<CABBYNZJo0aZW1p1YqyKNDWURunAHxZcS8B86OZGstfgWr0S58A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 09:58:56 -0400 Luiz Augusto von Dentz wrote:
> > FWIW this is what our AI had to say about the series, mostly nit picks
> > but not all (LMK if you want me to hook the AI reviewer up to your
> > patchwork):  
> 
> Sure, I like to receive reviews of that, note though that
> linux-bluetooth and patchwork are for both kernel and userspace, so we
> may need so quirks for detecting if a set is for kernel or userspace.

I think similar thing happens for iouring.
The user space patches just fail to apply and the LLM doesn't run.
If that's alright with you please ask helpdesk@ to give the "nipa"
user permissions to post checks to your patchwork instance and LMK
when ready, I'll hook it up.

