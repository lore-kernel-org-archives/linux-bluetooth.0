Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5BD18FC91;
	Fri, 15 Nov 2024 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731665285; cv=none; b=GGULsoTqu3VbqrXvOMe2VBJt1l2sjk1h08smgSKPN2pnqyueYJpGTsDe16pqWEE8px7VCGy4pr2vCgHhVNQhlFElMjG55XzB/kjbf7THXXL1OFmai82vMg2j0FUKgnfzySpjgUPGSbZwPc0psvCTVG39pcF+nKc7BUVg15YkrUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731665285; c=relaxed/simple;
	bh=mtKQl8SqIqN7/EfblU7m/OnFeAmTkJhcE+zzzH+THPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyZjkCxM+QBwWWUwrco4xxvr4V0tB1qmHKYRIb9/mP5IYPxAVcSy+2qoNEe5+fI1wjSr2PQHpo3i60iL+IeehlsPnWWvCpMt/nXeaCqi4+VsYGEpmmtGxQhLJHMLsi+TBkAvRptCPZFixKAaLZuLjuN9EFGs1u3ARsybL6yKo3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKguetAu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKguetAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E42C4CECF;
	Fri, 15 Nov 2024 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731665285;
	bh=mtKQl8SqIqN7/EfblU7m/OnFeAmTkJhcE+zzzH+THPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKguetAu7lTx9ZqNEWF7LhIa5cVdJ7sO6kqB/P3/pSJj4M3yfoRq9V++9eAjCrxtC
	 7wk2+esLGyJoTRrMeb3rixtzcAzDL/Rf+2pmoAIJ9lJ8SoFjbijV6t4PXtRhNmYTmt
	 oDC29SKDYYm7ees8RTlDkS7iyI2TnEVJ6GJi9CMM3DCI1iU+/YQrc6k2fcrPmmITXx
	 broMfCsGrX2bl2sDRDjgbmIjSwpJnMadit6c1CBJ38PTlKuho/HG5m77VX14iO3lWW
	 D7X+aGKitZqjQCndj4oYoIUnNk5+jYI8iok8jld4lgEpYYmmdSuIjPPv//APuyDWvR
	 I7d2W6WXAg4gg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tBtF6-000000003U3-03TA;
	Fri, 15 Nov 2024 11:07:56 +0100
Date: Fri, 15 Nov 2024 11:07:56 +0100
From: Johan Hovold <johan@kernel.org>
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <quic_zijuhu@quicinc.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <bjorande@quicinc.com>,
	Aiqun Yu <quic_aiquny@quicinc.com>,
	Cheng Jiang <quic_chejiang@quicinc.com>,
	Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific
 NVM for WCN6855
Message-ID: <ZzcdfD9cXuINU8m0@hovoldconsulting.com>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
 <4d973d61-27be-4830-880a-a3d74c4bbbc7@molgen.mpg.de>
 <4186566a-0aa5-4413-96df-fb1b7ebd9db2@oldschoolsolutions.biz>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4186566a-0aa5-4413-96df-fb1b7ebd9db2@oldschoolsolutions.biz>

On Fri, Nov 15, 2024 at 08:13:55AM +0100, Jens Glathe wrote:

> The variant *g* is a SoC variant with some extended capabilities as it
> seems. The X13s doesn't have it, the Windows Dev Kit 2023 and the HP
> Omnibook X14 have it. 

Actually my X13s has the GF (or g) variant, so perhaps also other
machines can come with one or the other.

Understanding what the difference is between GF and non-GF would indeed
be interesting.

Johan
