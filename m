Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF36134CF;
	Tue, 17 Feb 2026 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314815; cv=none; b=dspFYgf0oOnCijAjMUVoWud9eHG8pLEL46HlNkoOeHFM0Ljt865jTqclbyFOe1GYx4dO9FcV/bq4Eer5Ir5Kn6IuimKR6i4+dem9i3Cdguf5UPYQ5FKRsyYGCrRrlKlYL0AqO/LIqsfWMez+EXHkTDPJ+bnf+dZoax+2KCotoJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314815; c=relaxed/simple;
	bh=SWz2lLCjs43QCWbCfAjVHeXN6B9EToDb3PsdMyYhzA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tc2tJ7Hi1nhTSDj1sF1XnpQbtdad+nglrJ3YlahHhB1OTloKMpCOoBFRswNqtSLoAKpexFu5daX2mXbkE25qv6SEus4KzJlbDfS4sdi0d+0blUVegaNxdijVI4hcpDjMSEd7rPl2tBGtDYHpHRHOi1Vy2+zFkxRzo1ktXYNu+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6D4pOji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6D4pOji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA55C4CEF7;
	Tue, 17 Feb 2026 07:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771314815;
	bh=SWz2lLCjs43QCWbCfAjVHeXN6B9EToDb3PsdMyYhzA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6D4pOjiKEZJG0DG/GKmzF8JLlPvvPWpUFavkRQdMV1jjj9KmthxO8WrZVDMYnfGn
	 s38zlcCX1tN4Bedv67w3OC8H9fLZhB890+2CydhTdd3rnHA9zpFylYpk2ENXa0pmHd
	 tJOPKXyub5pWsw+633CTN64MHDgVhjqsDU9duxOZQ4k+xZ6in8Za3nHi1JO7GamUo2
	 NOvQC7cJFVCqt5RtbHmhP0llkLCypVXj5XpZA9qszL5bJbXTo1w6a054XkkCRyKBIC
	 SzlS8nDxwybhxEKsRN2cFP29xUCpnpnEwu0V4vhjMTgbYFQsFx+PaRFO2HuZawvD4f
	 1/c76EVJNZ6uQ==
Date: Tue, 17 Feb 2026 08:53:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Bluetooth: qca: add QCC2072 support
Message-ID: <20260217-mighty-organic-oxpecker-2ed848@quoll>
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-3-vivek.sahu@oss.qualcomm.com>
 <mt4vrzmq7caqddwtz7nc3tn33zxh7uupoxfmk5pfqobhuex43f@se64qz7qvuh6>
 <19d3cced-f630-4a6b-853e-3798487fd769@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19d3cced-f630-4a6b-853e-3798487fd769@oss.qualcomm.com>

On Tue, Feb 17, 2026 at 01:17:29PM +0530, Vivek Sahu wrote:
> > > +		case QCA_QCC2072:
> > > +			snprintf(config.fwname, sizeof(config.fwname),
> > > +				 "qca/ornnv%02x.bin", rom_ver);
> > > +			break;
> > >   		case QCA_WCN3950:
> > >   			if (le32_to_cpu(ver.soc_id) == QCA_WCN3950_SOC_ID_T)
> > >   				variant = "t";
> > > diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> > > index 8f3c1b1c77b3..a175ac31e7b2 100644
> > > --- a/drivers/bluetooth/btqca.h
> > > +++ b/drivers/bluetooth/btqca.h
> > > @@ -158,6 +158,7 @@ enum qca_btsoc_type {
> > >   	QCA_WCN6750,
> > >   	QCA_WCN6855,
> > >   	QCA_WCN7850,
> > > +	QCA_QCC2072,
> > 
> > Why not keep it sorted?
> > 
> As mentioned in the cover letter "qca_btsoc_type" enum in
> drivers/bluetooth/btqca.h contains all the soc type which need to be enabled
> for BT enablement on the target device. There are few places where logic of
> framing packets transferring between SoC  and Host depends on the which
> generation of the chip it is, refer api "qca_read_soc_version". So It is not
> sorted in btqca.h file.

Neither in previous patch comments nor here you respond to actual
comment. You just write something completely irrelevant.

I don't think any of this should be considered if you are not
responding to actual comments.


Best regards,
Krzysztof

