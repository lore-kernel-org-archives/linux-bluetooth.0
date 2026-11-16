Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859754;
	b=ZW85GKnNzirvDW8xMONQ5OCz3G2ytESkg6Bv7KS2Ejctkw3WPWn0y/huPds9NRoRQskF
	 +HO73Q3eSU9dbmN/o+reSyyLwAznbfhku6mr0BbS0Tn+W7aTu+X5E4EGHfrC3jy/c3yYw
	 hCUqHhgO36AVZUqdimA2eL18VVwf6c5JRKvQCnKex3IHSJE8kaPeStjfq5+oXgR/De9JJ
	 7d0ZiKN0y/w9D6Imzf5lCXWuEj/l+Rk0csbODZlHGBcwDNKur5PqG7QvsNMZUC1Umffdu
	 a+1r1uukOzmnbSVxbY/aWqHR2fIJMV/NHAJAZX8FI2f2aMcWSlTZQFQ3xu39N8Gi2JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
	b=RHMDElvMMwrikT9MKSuc+JHa8RvBHETcdTazrs/epKdA+8FUpxKY0I/P5perfl6u9/J1
	 IK7ekdLa+emEVBJDoxwn62BS2KQfJy3QxHlF0wmkNCVwPZOAY/z6F7NIuzZ6bkB7od3yR
	 Tb1DmGRuh/3rCvPJAd+kMwVx5MwAl++OyV4jO1AcGF4mYq0YTpuyDsGC7qQn9H1cwHdyR
	 Tc+gNY+TEEhER+tQbFlpOoIMLzn4XUp3bRJyU0898Dx9WLT5cOzKVn841lQ2CkV0HvOei
	 mptm3AwW+GtvQQpDDmajJojFFNEw2EdqMqzrmEjXMxawAI/8/Gjx+crjUDMJiBpxwAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbZUyxTk;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27D606A339
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 20:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F27D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nbZUyxTk
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-55d03bfd477so25683671cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794859753; x=1795464553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=nbZUyxTk1xDDi9/JiN9In9kNH24m3xvR3W8MPaMB063K/nb6P74sDih4ebpP83k2np
         SjqTAYuPLCHW+FRVrjLKSTbDX5aM/IVbZZxu+ASYJ/ssH0gDFbMJvSJmLcdHAAsDSEL+
         FG47SOuU8PRulqvpOebFRdp+iKyncNtYeoKxWrzhMSjcb9i+1jD4cThvDUO+7PnMd3zc
         ImV7NXhI8pI4k1LW/eM2oLltJhXP6hUveoFekGEVH6+oWgooyZkYdcVCIAs0jW9hoXxW
         5IGbSHDAmwoeFMTug5VO+bv+VKknP1f2hoIrUsvWYeNqALAO8eTePO8ZOjSwRNnR3p0b
         L2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859753; x=1795464553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIDjnnpHadC4roO6Pjzwfgg43uG+Y6jCh2hpR36q9WA=;
        b=bQv3HgUr4+WhAHM3jQrNIAFxDFztaqoFOi8igYrPNOHB8hhb038kZrpcYY8FQoPgA6
         UgYOcYKMIbgRa6wUDa7UjUEm612jQaMCxExDBlL+cZg1FISQmgpeGbLu8UWYbSGEs/l/
         gPm+ypVVcPG8QwcAa9A0Bcnq2gSkek4dc3ktytdc1KTktQYtRU0aLd9D9O8qmMX+fTjN
         KjB0bys8165rCsUr59PV1ldYF8R5xs+rejk0veu4/4UY3v7pU3bOzIfJKNwgvC4Mw1Lb
         yKb0mW6rcNLm5wRHjLqwBXtsfEAAaBK60MjNv/iEMzSdXj37uhU8xC5oOq3OM0WR2Kx6
         91oA==
X-Forwarded-Encrypted: i=1; AL+hErHsTspD4jPtGvZbU78EDrLgWcc2QcAym5dp/+facUxXlZtEWtjMzAwMnRBVIoLFTSM3WdeEgsujaR5rhxKNUbM=@vger.kernel.org
X-Gm-Message-State: APuU4Z80DrrfHEKFaglszoSprzjVSnkq1IWAt3FS4szb4mK/2lYgdD6k
	RabNIU0WW3USBtGmh2dFbK76KsFwENLhn1ZMcQWmixBE6loq8KjSLi5XgoDlRL9dQFY=
X-Gm-Gg: AYBFou08L9Zlpnec0kn7Sa350rxh4S7k2fqyDtpiun9oq7YQlH6eTtM1duD6bkhyDE0
	4YuLx1MzfA48JLHn0MRqgGRBEJIOQeiwfxWaSUTsWaRXZna0DCYKHIjEer55NVLCoe0c0ab9l2o
	MB9eJW3iv38q9RGNXXlSoL2uNS1VcqeYVAQO0TlH3a1VUvU4sKrRT1+aHfndSKtC7WpCK/ba2dO
	IXfvTg7n2N39gtcjfM7ubnEkOBBYJYSw8/dKucbcjN0UTfSkG5NkF2W4rZCp53w684CXjZ+XUw3
	blJT41yjhl8Uq10ZzpqsrqMXWj+wqDT01yTezwCTZcS4UtjI2y9pT93pssf9Q1/jNSpw4QGLLbr
	K52gkFaGwCboFu34Q5m2qxkBpJtTl49QSfLXfhVhzjjjAPm0xByhzgp9X9IU7KE0WrYHi1rYPR/
	xWsM3aeePiyZrmBZksd8xJ8dhtYoHPsUlF3zM96QQZA35t5lJMK9S+hOgP/OX8p+ifcMqHzSBzE
	k+o8OeUaA0u+1mQytGAyic7IQizVcWGC/LOFEMteV48d9LGgdUd00+fRoPCNpZEL3uKbgi76CR8
	b5i5CA==
X-Received: by 2002:a05:622a:5144:b0:536:98da:f790 with SMTP id d75a77b69052e-55ac43909femr187873791cf.6.1794859753196;
        Mon, 16 Nov 2026 12:09:13 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d445d1sm92856046d6.8.2026.11.16.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:09:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xT30p-0000000ANtb-30lh;
	Mon, 16 Nov 2026 16:09:11 -0400
Date: Mon, 16 Nov 2026 16:09:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
Message-ID: <20261116200911.GA2473219@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
 <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
 <20261116190417.GD2299285@ziepe.ca>
 <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>
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
In-Reply-To: <2965c691-82fc-49f3-abdb-383860f6e82f@linux.microsoft.com>

On Mon, Nov 16, 2026 at 11:24:17AM -0800, Kameron Carr wrote:
> >> My scenario is pci-hyperv in a confidential VM with a paravisor. The
> >> paravisor is inside the guest's trust boundary and owns TDISP. It locks,
> >> attests and accepts the device, then answers a VMBus query describing
> >> which BAR ranges are private and whether the device's DMA may target
> >> private memory. Before a driver can bind pci-hyperv has to:
> > 
> > Sounds like a user in such an environment just wouldn't use the trust
> > level mechanism at all.
> > 
> > What use do you see for enabling trust level but having all the
> > devices unattestable and accepted already?
> 
> Previous iterations of device trust used the trust level to make
> decisions around DMA bounce buffering, etc. Is that no longer the
> case?

It is not, this is now just about userspace attestation really.

> I am looking for good hook candidates. I was hoping that trust levels
> would end up directing DMA behavior, etc. but maybe I am
> misunderstanding the design direction for these trust levels.

I don't know, I broadly expect some flag in the struct device to
indicate that it can access private memory, but how and when hyper-v
could get involved to set that flag I don't know.

Jason
