Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840359;
	b=4bypJJBILmt1+45xJOl0kjefAkO1tGqjHKYLTilBhq2f0ONfLDoe2pn+gNLejHWhCgSf
	 TwIIVaqJtV2YvgT1N1TZ01UHXtbmNRdyiw0XHRuLVFRq+CGfvtxzylhxhXtE0TMG1Idy8
	 KKj4J99vwGF2kc1Jl6scnxwPhP9/5ZappM1NrzUsIrC7sd2pX/up7IZjdCaEcGwGCyI7S
	 7fxCR4pfWX8qwvX1i4NOtiVWh9mh6STLicIhrxQuf0TGHeTIYnuXwPDoDL3PxhxDqhEoI
	 rtB8QlCdNq7Zz8kZmLae8fBePbvaBV+t4GYt55RRCC/st416FVlO0SU7UWNaeCU16yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
	b=Mo7Trik0tejTv2z2P20/NGx33QmO8fV4NslPk4hrPohOBEcbvV/Hco1Lgu80hLsgNztD
	 aMV8Nq/IT7+LMN6DB/5gbB5n8IIk/IKMsjVSLrjtkFLz9Ky/P2xzmSMJw77f/4byaFkiF
	 di/ZvYKtphym614m/k0t5Tmnw36Ve24G1xzGXMfFl2c0kov/MJTBi87OBeZAYR3U6Yxu9
	 YtD6niPDx9bQ628P0gWLxAmYYAlXXTGUyvzgzM3ktAvAre6BHTXby09EJytHni36htGOU
	 LLsBo0D1QrBoqGqkff4/33OKy5j8FiHBLAzbhmycGVxUb96TjqGeWwEWs8aTyCTF+hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dLdJyonb;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03D606A335
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 14:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E03D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=dLdJyonb
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f2049ea7aso276067685a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794840358; x=1795445158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=dLdJyonbx/GT9GciisxRrbnKJNPmXRO37SMr0DcL0fOWPt4npP7q6oSEFPRBxyhYBG
         VwQv88je59xwJGF1tzvO02VHIK2UoI2gFnHM+RoqxVUasg9DyQA32ToeKqV0tOS8H2/F
         utZ+RQHXMciPdHoqR96pmDBV9oFbAflIPtcSFhX2+r9dDE0rLhaGZCPsZ1j517doL9zB
         RpfAbapy98a71EK1akS809jjM1beUX7TmDUaCrtYNcz/JJbJ2sGjj2UfCKl0NoQ68uWW
         NnufbW7FWZvXAJBZh4GXQ7J60xB7eIn/T76+zn9Pq4vvTPBJTSoxoiKRgL0R3QgrjVbx
         3mVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794840358; x=1795445158;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cuLg5FPbuoxv94oaCvgpjnZpkxbSwN3Cw2dU0btsKg=;
        b=ncQkmkEiPuUpx2hAstWFVrifpg1kUsNy018eoeWXyNh9qCr7csxe4WupkwujtEjKT6
         ck0ZUZpyFDXTJNHL80FHq/py6ZBGZYxMMdR/DJ51ErW6xjdUg749+0u2/zIAnotzdPDc
         NGsxZB04iFCHXQfclqznx0H3zMO00m7ZWXWZNQCqxMi/E2I5L3YwmvK6JTaOQgtdXmoe
         PH2wE+r0C/dIUD/t22zEfJFpBSTF0ayXPDlPWTxWjfqVMo2LFj51/7SHQ7md6bS13Z4a
         omGOnqPP1xCnHEl41IUQ2zKa7RX9orI6FK5xrIcM/Oof+dTFJwgfs3nODHR5jbLPCBsZ
         k/uA==
X-Forwarded-Encrypted: i=1; AL+hErGY0xEGCd3ibRXzdzqZBmuOK/08mcy4airqSuXPsCUb0PtnXSL5VVXa6Ln9CjifHpkUkQITqh0QG5GiDrz9LZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+fRYzIbxwS2NfqLpPRLQZdyD+J8Z9VX8RrVCZBldy4EA7dkGB
	NNZPH269NHsQ0+3paF1ruvgWe3Ph85xMYgJOFC6dUj7M2x9BmcbEmRuWbM2AvcwFiA0=
X-Gm-Gg: AYBFou34x3UWWWJmERFnNK89Uakrx8Q3GET/8yS3Y1vWsTMFIxP/iIMXkxQHnfSAHUh
	BagKJYO2AphSA8GROoSSfDRb0kIxodYZNNMxrK0TowimGnuHfMgjnZJ4vZ/hrlkmATcMtSO6iHz
	SUQYphuYQxJrDXd4VowLX76orXUrcGCq3AfoDGUedtjSr/LTfFu0fkQrn6qqvBLTUSmgPQ4eWgy
	m6LWNXI7JyF3Pu4pKOkmlzvLxpbqgGGyomQvxC2PQLKKRUC47rPByuaCM5bFMjKi9a7EFoJXZIM
	nrABl9THb80aWys9PVjbefyMNoLY3LY3WhVpsTya4yo4jYUDhx/MoT59CLWTXXz+pAIylqXdpJ5
	UU61C0YCrSMP5PGJstnWxAethC7MCVjE/sDy01BAlnA1xagmC/gdpKlBysRV/82keFvIX7tJjtE
	fctFIDIOKbSORUNr+HBAd7XDWDeFTZ59FkCdhVtPN7cWNTqY4kX6NqeVqaW1m0S5Y5TXUBwSbmX
	fHD6l9fDJhvnR4kYwS0IFcR3PKzKOYlOANJWmaWlxy6I1/hpOBXMQNq+K0NXhgCs/XxxMXgqlld
	Awjx+A==
X-Received: by 2002:a05:620a:a41a:20b0:949:5872:be1b with SMTP id af79cd13be357-9495872d3c0mr1015844485a.39.1794840357475;
        Mon, 16 Nov 2026 06:45:57 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836079sm858473985a.18.2026.11.16.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 06:45:56 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSxxz-00000009V73-1sJy;
	Mon, 16 Nov 2026 10:45:55 -0400
Date: Mon, 16 Nov 2026 10:45:55 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-input@vger.kernel.org, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116144555.GM2532299@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <20261116144103.GU11319@unreal>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116144103.GU11319@unreal>

On Mon, Nov 16, 2026 at 04:41:03PM +0200, Leon Romanovsky wrote:
> > I think it should only be for the duration of a bound driver?
> 
> For now, I decided to disallow state changes because the IOMMU may outlive the
> bound device. Unbinding does not fully reset the device, so we must quiesce it
> to ensure complete security.

When we refine the lifecycle for the iommu this issue should go away
too

Jason
