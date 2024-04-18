Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9A168B0D
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456488; cv=none; b=E7JMN68voB9udQVn6rciUYluoneSzA/pYMwwytphP/avZyKhhKtsKvpeHyqvvrQngPyOswxn9NMGvIc/DPp0PQdIeh+AaI7VvKYWOL1tA2IWB4m1G202SCSdq1+0mre9v+BgJywUtZ6BJAf6dcRyYOj3VycjOIg13M3fMmXkNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456488; c=relaxed/simple;
	bh=Rczi1aLxAhiHeqIqTD5B7dHeBXxD2nttxBXaMbC+K8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1Vo4Ns50KtxbCEW59EwFvaWu0GGUbyhrdDmmyhFCpz5SXgqPhRnaaa7nidNUJlOG95YyOfMHhNVxqKlh87wm5mXHof0AL4X7kkZC3yd/AAujHiVrOyc2N0kpBiBRdSzchGRg1iaOkarnv2f6xoTz84FMyaAXr8bvQR2bOehuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4/NKCBP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4/NKCBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E808FC113CC;
	Thu, 18 Apr 2024 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713456487;
	bh=Rczi1aLxAhiHeqIqTD5B7dHeBXxD2nttxBXaMbC+K8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4/NKCBPOjAR+Rc+pI51TpxTbfjgwRt1OZheyt3RbxZ9hl2RigdClrzcs7kcgXXQV
	 IiO4qHhjqOJ2jyeAoDzOBm46CHSXTiWFcGlr9EWnZRrqExbxWEPTf9I8V/XobHAn70
	 +OjqCWGsZ7V/gxDMhHaXbLWV4A8eUbBvQr65ZbTJRn8GC52skaWs9qWywtrDwnL9Li
	 sCsJNKB++pjM+AA41LG174srsXrWAp1x+7yD2RBx/i8uNFaqu1ETzlNZw3zX0jLQCC
	 esMM7yKnxM1HzQ9Tj1xuxbi7QRI0uQECQJRmqT+q6OHizNnNRwf9Uos5cXUcIFJ2xr
	 SHdd8vogtHkTw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxUJ1-0000000032g-0Hy7;
	Thu, 18 Apr 2024 18:08:11 +0200
Date: Thu, 18 Apr 2024 18:08:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/4] Bluetooth: qca: Fix nullptr dereference for
 non-serdev devices
Message-ID: <ZiFFa1JxVZuByuBZ@hovoldconsulting.com>
References: <1713358336-29619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713409913-13042-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713409913-13042-3-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713409913-13042-3-git-send-email-quic_zijuhu@quicinc.com>

On Thu, Apr 18, 2024 at 11:11:51AM +0800, Zijun Hu wrote:
> hu->serdev is nullptr and will cause nullptr dereference if qca_setup()
> is called by non-serdev device, fixed by nullptr checking before access.

As I explained elsewhere, this is not a fix. It is only something you
need *after* you added the later patches in this series. This needs to
be reflected in the commit summary and commit message as I already told
you:

	https://lore.kernel.org/all/Zh91zq13nZvH3-Yj@hovoldconsulting.com/

Johan
