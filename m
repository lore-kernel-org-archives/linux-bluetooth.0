Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20AEEC0;
	Wed, 22 Apr 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855327; cv=none; b=jpuA573BIWdVk72lDQl8P1S8XZCaIoYfoWvBHKg37Ssr3FMBnvhor/CSmHV//Z23VC6kTO4+zQzC3cIifHNJbutj/sbyumLGDQaQShEkr0Va+hvnoTG345okCJbPJ1YJsLfkTwpYHvK9HEQXnNtaujAsNo2jwriA+Q4QAJmfCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855327; c=relaxed/simple;
	bh=Cv/dvtt9j+p8MbtSj7Sysg2FpL5y9fNb3weRLkynaWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBjME7YrnCM9kKmrxEzPG4cqCogfh8UjJat7dgF/YkZpxiMu3PXBeAEV5HrgnkrhNNqzo4UhzVyq5wf//Kb6uga33tctBgg4c7WphDZ9wgODJyDYCp1tVGiD1qtyICpiAPC/5sxdSbKQK4PSkAt2lJJ9FHPmnBh86P1sFb775tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArQE3mYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArQE3mYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEDDC19425;
	Wed, 22 Apr 2026 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776855327;
	bh=Cv/dvtt9j+p8MbtSj7Sysg2FpL5y9fNb3weRLkynaWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArQE3mYUDYrhzX+54sLB9RhfxEf5H81CS8mcbi8mUaELpUurEgvq9posUW1zfxq6u
	 GX6wuyTtjA3YLevsf+u39UeeqLTY3Z0nJlD/VZOOapW+QFvCJttxJRHSmbDVL+plNg
	 i2Ozp3hU7kcwCQR4y+eAgFN0veEmgAdsohrCK2fa3JPWa+hKy98tmpEPLfemuLS55b
	 Nzzn4MX5/ehEIhigE2mtIobktFku2Bl5yBSTzYzHh44GLABvYxfFPgjjcjr4EpgB6a
	 dC1GlMsWFvHbhiSyINSlWef96SBv64+oya2Aqy8R6UidGyiD2vfjRuPfYSlP2idFmv
	 hE3qjQvZPG9sA==
Date: Wed, 22 Apr 2026 11:55:16 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net,
	skhan@linuxfoundation.org, marcel@holtmann.org,
	luiz.dentz@gmail.com, mchehab+huawei@kernel.org,
	jani.nikula@intel.com, gregkh@linuxfoundation.org,
	demarchi@kernel.org, rdunlap@infradead.org, justonli@chromium.org,
	ivecera@redhat.com, jonathan.cameron@huawei.com, kees@kernel.org,
	marco.crivellari@suse.com, ferr.lambarginio@gmail.com,
	nihaal@cse.iitm.ac.in, mingo@kernel.org, tglx@kernel.org,
	linmq006@gmail.com, linux-doc@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ISDN subsystem and Bluetooth
 CMTP
Message-ID: <20260422105516.GN651125@horms.kernel.org>
References: <20260421022108.1299678-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421022108.1299678-1-kuba@kernel.org>

On Mon, Apr 20, 2026 at 07:21:07PM -0700, Jakub Kicinski wrote:
> Remove the ISDN (mISDN, CAPI) subsystem and Bluetooth CMTP protocol
> from the kernel tree.
> 
> ISDN is a pretty old technology and it's unclear whether anyone still
> uses it. I went over the last few years of git history and all the
> commits are either tree-wide conversions or syzbot/static analyzer
> fixes.
> 
> When we discussed removal in the past IIRC there were some concerns
> about ISDN still being used in parts of Germany. Unfortunately, the
> code base is quite old, none of the current maintainers are familiar
> with it and AI tools will have a field day finding bugs here.
> 
> Delete this code and preserve it in an out-of-tree repository
> for any remaining users:
> https://github.com/linux-netdev/mod-orphan
> 
> UAPI constants AF_ISDN/PF_ISDN and the SELinux isdn_socket class
> are preserved for ABI stability, but the rest of uAPI is removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

