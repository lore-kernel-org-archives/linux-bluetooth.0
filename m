Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA68C147
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133813; cv=none; b=YkTLDutN/mGL9QXoH/ufSHv3L95DfcWAPc72/kL0fRmQ7uWeA1zYs+C3kVKm5G6C2wGDK461vr+YEb4tloxqHMxQTThbKS3i/+uxLVGEojSg1h7xOAclKZoioBtUbEeHWTAAR5XMlHxxQ9TQ9Sngrahu6R899Uv9evf68dsqsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133813; c=relaxed/simple;
	bh=6OIlaLCOi2eIqKr6NGkyrcDFYwdmXjUkv5Uc/aYMbmY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q7NWwBMKUYPgAbXAVrszxMTqgy0f6Gse58SdTgjAMrgCapInVyXyN0+jyFHk0veSo7Gr/P04Xfr1HATCJs/5uXhwbmx6RJm8/lJqIWflBiEt6WqG2+aJ/sDsxJpW0pLeIJjqnQM624Ks1th/hWjPmyn7BSjQ6ALPHj8lu6AFcqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUifaC62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUifaC62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F5EC2BBFC;
	Wed,  8 May 2024 02:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715133812;
	bh=6OIlaLCOi2eIqKr6NGkyrcDFYwdmXjUkv5Uc/aYMbmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tUifaC62AiplYk2EsJ7zs86IwYGW6L6+71RL8fqiRvsJOFsmKvR7ECuRUspPa9pog
	 8NFDQuQsebHiLW+B4kYMxwX/SKBapUYdXHhnft83t/dLF8dy/nrMzBTHIXz/5PxQhm
	 4Qnour1l/eJjfK5ln9/8jM8eyinEZaNTg3Me15Zsp8h4AopYkrKN0yfwhfL+EygsTU
	 ULxh5/GlxHVwwATprHYXrlkae//xPH7o0G4fyIW7FPvq9Oxn6SThGVi4T494nWdCLL
	 Auu0ciYtUHis/rKR7oqUy7MK0nHDKw2oHpku4Y/4lKNfYG0qvt+4a8/lG2SkB7uj5r
	 8libgPNr2LjOQ==
Date: Tue, 7 May 2024 21:03:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar <chandrashekar.devegowda@intel.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add *setup* function to
 download firmware
Message-ID: <20240508020330.GA1746392@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328111904.992068-3-kiran.k@intel.com>

On Thu, Mar 28, 2024 at 04:49:04PM +0530, Kiran K wrote:
> Add to support to download firmware.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Co-developed-by: Chandrashekar <chandrashekar.devegowda@intel.com>
> Signed-off-by: Chandrashekar <chandrashekar.devegowda@intel.com>

> +	/* Due to the fw limitation, the type header of the packet should be
> +	 * 4 bytes unlikely 1 byte for UART. In UART, the firmware can reads

s/unlikely/unlike/ (I think?)
s/can reads/can read/

> +	 * the first byte to get the packet type and redirect the rest of data
> +	 * packet to the right handler. But for PCIe, THF(Transfer Flow Handler)
> +	 * fetches the 4 bytes of data from DMA memory and by the time it reads
> +	 * the first 4 bytes, it already consumes some part of packet. Thus
> +	 * the packet type indicator for iBT PCIe is 4 bytes.
> +	 * Luckily, when HCI core creates the skb, it allocated 8 bytes of
> +	 * head room for profile and driver use, and before sending the data
> +	 * to the device, append the iBT PCIe packet type in the front.
> +	 */
