Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D412DEA74;
	Tue, 21 Apr 2026 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751436; cv=none; b=KnaUPrBz7DF+yZgkL3GgkkE5bbUsi67+pzoLmlhz30/jewsJ+dNm82QjGZr8sujWgZdi0kl658gJ42dSzT9n3HRcP0suxPODDxaRbEOSjwML69ARhEuXRDUsfZEx3plxxpF4KOM5jnzMnb0RF7LovK9axIqpS9MaHY8+H0QtORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751436; c=relaxed/simple;
	bh=39MG2Se+/eyfVMM8XJDbfOL9SLmB52vW2YmkOjx7r20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikeQ0yO+rpVlDY8BeHTVP431rcxheDunb8FJgHZfQ68AH/93Pw0vaA63ZjkPTSzKT7F60ON/lX3HJ4CRLFtOItvOLjqO/tjeLaEsUntTtBDUpJ9cExj2pZtxk7wvGoZOXkRHMgseMxO+DkSuh1FnpCI47stF0iHaCtD7PsMMzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bgmjUyCx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bgmjUyCx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6839AC2BCB0;
	Tue, 21 Apr 2026 06:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776751435;
	bh=39MG2Se+/eyfVMM8XJDbfOL9SLmB52vW2YmkOjx7r20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgmjUyCxe1lDtznRkSQdMrrR5WAhkEdyjcYyknvtpLYZMokfXpFgYp5S8MmFmADwg
	 +dxfqHOlEMagE/PLX1d+6Hv4yL7DkVwB/aHgeXv2fkYG1OxBw3sxHMq+YI3ZBkWJ7I
	 +tGnwR/zN5LpYqZfvI6OO6veC1eV6qNHAhsdbDu4=
Date: Tue, 21 Apr 2026 08:03:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, marcel@holtmann.org,
	luiz.dentz@gmail.com, mchehab+huawei@kernel.org,
	jani.nikula@intel.com, demarchi@kernel.org, rdunlap@infradead.org,
	justonli@chromium.org, ivecera@redhat.com,
	jonathan.cameron@huawei.com, kees@kernel.org,
	marco.crivellari@suse.com, ferr.lambarginio@gmail.com,
	nihaal@cse.iitm.ac.in, mingo@kernel.org, tglx@kernel.org,
	linmq006@gmail.com, linux-doc@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ISDN subsystem and Bluetooth
 CMTP
Message-ID: <2026042144-crispness-perfected-6cff@gregkh>
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
