Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B012C18E05F;
	Fri, 15 Nov 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664898; cv=none; b=QMLCbGyl1zvYLb8YmXr/EGtZz8mll2vDl2wzmbzI3nw2+zbTkgmeU2PBxM2hrXYnBtUUs4wWuRuIHIPMZ/lTLBe5HhP2COT7lqIlFuzunqGiX5bFJMSlALEREjcdcvT8wZ0ZxMWnoxv4HNjJn3pW9ubuhzRXmFXC2O5EKItGTZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664898; c=relaxed/simple;
	bh=m8jgVZsuBKRd6dcDiSSMxAD8/y52gQvvVrdEydnNn/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUgZ1KmF9otcJbgicbvPxXphZg5SjQM6d6aj5NyCkACiARylGDFIkPmeJ8N3qH7azXo8NwOL2R6EO6sANqHxMDNK/RUXmxUoyKC9D6EDBh3Iwjr+TLQ9BJfEqbENRDINBr0417tuu32RuZbl3bKa5sUc0W19ogmRo6dcgrjkesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xat+7N79; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xat+7N79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3EDC4CECF;
	Fri, 15 Nov 2024 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731664898;
	bh=m8jgVZsuBKRd6dcDiSSMxAD8/y52gQvvVrdEydnNn/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xat+7N79T43vT7ib97v8vf306v5C3vshdMVOKtnXqS5QALYMJd7hvyFxgpKGR54AU
	 XUukhgCpp5J3sbJE3J6A8RxORQgDd4EW8bNu9c7D2ZQjxtg0g6tbW0WgZdDkqZKVTk
	 pL2HdX75wNra3OnxqAy0DhQcWI/fMjh0yHyMr6TCY8T3TFochG0XrEu0LGv7OQvipV
	 FU0vimU9HNZjGHbAz4YseKlCSh83tgcysTFsuKJi/CTPPZPmXvDhiSy5xNgGlPc7is
	 aLOk4Bpo6m3FUytwp/8qBLb8NdhBhtg2Lakp0iDsrxLvLdd2ko+o0TCQYr2Ci7cG3e
	 YN28U4lWsGf0g==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tBt8r-000000003NN-05M9;
	Fri, 15 Nov 2024 11:01:29 +0100
Date: Fri, 15 Nov 2024 11:01:29 +0100
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Zijun Hu <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <bjorande@quicinc.com>,
	"Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
	Cheng Jiang <quic_chejiang@quicinc.com>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] Bluetooth: qca: Support downloading board id specific
 NVM for WCN6855
Message-ID: <Zzcb-Yqvs3Mn2PxC@hovoldconsulting.com>
References: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com>

On Wed, Nov 13, 2024 at 10:26:56PM -0800, Zijun Hu wrote:
> Download board id specific NVM instead of default for WCN6855 if board
> id is available, and that is required by Lenovo ThinkPad X13s.
> 
> Cc: Bjorn Andersson <bjorande@quicinc.com>
> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> Cc: Cheng Jiang <quic_chejiang@quicinc.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

This works like a charm on my X13s which has the GF variant.

Unlike with the "default" NVM file, the range is excellent with the
board-specific file now pushed to linux-firmware (similar to what I see
when using the Windows driver NVM file). Specifically, the range with
the headphones I use for testing increases from about two meters to 20 m
(around a bend).

Even if these NVM files didn't make it into the November release of
linux-firmware and therefore won't make it into the distros for another
month, I think we should mark this one as a fix and backport it to
stable as soon as possible.

Zijun, could you amend the commit message with some details about why
this needs to be fixed and backported (e.g. refer to my range example
above)?

Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
Cc: stable@vger.kernel.org	# 6.4

It's possible to add a comment after the stable tag to delay backporting
until the next linux-firmware release, but in this case it may be better
to break existing setups and force people to update to the correct radio
calibration data.

Either way:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
