Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6B8BE7
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133901; cv=none; b=YPeVphoSIU1dw2Te7eyxnEN2fA1UsmgwTbEvd9c1wblxoGMqxmxPM3u2mWUZOs/ZL5/cG7wIbFgIYcRJW8Ts8rV321+Ysjkj+L7PKK6HfBAOc3FgFG1WBnOsr9ZbCDe4HmRDFVmjPVzz2V94yRxfRDA0h/YGJU3Dp9u0It2Kj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133901; c=relaxed/simple;
	bh=nIsmRl78ulinnKkTb7wpc6NtA/a6+ptYO2iLn4YO3SA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VO8O3FozJql+7M6ikZpBaC89XIlbPpZTzQgzp3GiN8+f84SPs5fm+VQLzsRMiioQTsxMdICV6bIappKwuESkzPVPyZCHmlY3zxyLXZQrIH8k3aKXdiV3Vdp1BUYHFhZsfaYAc6w+rXZLGTV+HegqWm8T/I57pVgKp//GiP1zync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCOkBdtv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCOkBdtv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231DAC2BBFC;
	Wed,  8 May 2024 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715133901;
	bh=nIsmRl78ulinnKkTb7wpc6NtA/a6+ptYO2iLn4YO3SA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MCOkBdtvf0pkThrK2HOmaN6i8sbBmIAwWsl5NN6hTZ46fFWXAP0RbbkWYpVEjQANt
	 yulWl2ze9uk3FaVqgAdE54sfQqsoApa4hhu3zppGpVgzv4/+QadZ1VKvhYv8ui5lnh
	 782UilcrODRxJv2bLFNqKYpfIgH9dVDyur2BqEnta1hWD3oT2H0hv5Cig/ZA6j+UJp
	 uZ09bsLxp3IOAMuyiynQD82UG0GFlXF/AhoeJ8k5EBFOCWyoBumPkFo23b0nfOe1Ax
	 Xw6geSSvyHAFyw5cOvqxEhpjTQEJfTv973YqtlFsovfaRkuBidrd9qDbdYrWNgM3Sx
	 dP7U6lpzSR2KQ==
Date: Tue, 7 May 2024 21:04:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar <chandrashekar.devegowda@intel.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: btintel_pcie: Add *setup* function to
 download firmware
Message-ID: <20240508020459.GA1746498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508020330.GA1746392@bhelgaas>

On Tue, May 07, 2024 at 09:03:32PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 28, 2024 at 04:49:04PM +0530, Kiran K wrote:
> > Add to support to download firmware.
> > 
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Co-developed-by: Chandrashekar <chandrashekar.devegowda@intel.com>
> > Signed-off-by: Chandrashekar <chandrashekar.devegowda@intel.com>
> 
> > +	/* Due to the fw limitation, the type header of the packet should be
> > +	 * 4 bytes unlikely 1 byte for UART. In UART, the firmware can reads
> 
> s/unlikely/unlike/ (I think?)
> s/can reads/can read/

Sorry, ignore this.  I didn't notice that this was an old thread and
just popped up again because somebody else responded to it.
