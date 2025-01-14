Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756128EC9C;
	Tue, 14 Jan 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858167; cv=none; b=ZDLg02bcVsZIKBMaOJ6osc6aPUza/vXAaJ8wZBZp4FsGFyGmTteaPwSBd2JaKGcomquR6R+dIs8A+dKGQRgJ0LzSwyZ/zhLIuwFaIFzrHL6x11095OpBLce4pcdCIo+Uew2m7GITI6N2CRd7Q2kbuLWFBc7BgAh3nmv0fTYLnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858167; c=relaxed/simple;
	bh=GDOXFhLagS7DF5xQEfxgZYnan3kBi581D7l3kvFXS3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abNHjSqqu6tpDNxikQvWAtdYPxzPt7wsn/ynt/JRSRmhLZIZu9Iod/EuAXe5Pc4BYRPf6iqJTPoseK7Z0vM36KDRErQ0BM849g7uAXYSNidD+wdU/3xocltw4kb+EtoiFG5UaytO1gv8g70vvl3sdQPBGp9hKVwTpJ7cbifAVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd2zoiRK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd2zoiRK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF065C4CEE4;
	Tue, 14 Jan 2025 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736858166;
	bh=GDOXFhLagS7DF5xQEfxgZYnan3kBi581D7l3kvFXS3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gd2zoiRKLMZ3dG74DHx9ycDiY2X7Q8APKhBCdBlDndgBJY1dDeKzv0ImjuhfjsYQ2
	 ioaK1onzlTLWMCbG4Pn7tMtw1HhwYRO50YdhbXYU29rLePhMCnxLATi/DHeg10EuWY
	 7FEQeaELrVenwu+INJ16G1Sry60K3l670lSyvMMNLhcoRPGnmnbacmCwU2LAarnviV
	 E24r1A7lNY1XxgeUqeaAo6s/6k3d41bJzlwzJjixdFRnnchBMk52h7aC60n3gUxwGQ
	 fnMq4yh86pvMop9zkJkC0gdDxm/LwuSMBS10LLt4/EChMGcS09dRqKWMZMoKYsPGZF
	 0+MHx4F4fxhSQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tXg9R-000000003Mp-0Klo;
	Tue, 14 Jan 2025 13:36:09 +0100
Date: Tue, 14 Jan 2025 13:36:09 +0100
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
	jirislaby@kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>,
	tomi.valkeinen@ideasonboard.com,
	=?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@gmail.com>,
	robh@kernel.org, hns@goldelico.com
Subject: Re: [PATCH RFC v4 4/4] gnss: ai2: replace long sleeps by wait for
 acks
Message-ID: <Z4ZaOXiUVQXK_d7L@hovoldconsulting.com>
References: <20240606183032.684481-1-andreas@kemnade.info>
 <20240606183032.684481-5-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606183032.684481-5-andreas@kemnade.info>

On Thu, Jun 06, 2024 at 08:30:32PM +0200, Andreas Kemnade wrote:
> Previously there were long sleeps for everything sent out.
> Replace the sleeps by some wait for completion.
> Wait times like 60ms are seen.
> There are ack packets sent out if requested. Unfortunately
> just waiting for them seems not stable, some open()/close()
> loop stress-testing brings the communication into complete
> disorder. Unfortunately these ack packets arrive before
> a complete answer of the command has been received but
> apparently after some processing has been done.
> Properly declaring expected answers might help but adding
> that can only be justified after some wider testing.
> 
> So leaving this part of the series as a RFC and base
> for future optimzations.

Haven't really looked at this patch, but based on the above this doesn't
really provide any confidence that this protocol should be handled in
the kernel rather than in user space...

Johan
