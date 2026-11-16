Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794844785;
	b=hJ9zg26OaVOcgobULrpo9O2VvyC+JNafcH2vkylEXm/CtnedUXkyonH+8SIXEBb83a9v
	 TPD4kVaFpSOgJqxxbhIKidpUwpLsBR0ZEODdkhC04Qb93wa2hf/BZsl4HtQgZd6UfA9vx
	 qcjGfCXjDheipYfLZB0DpQeB8uiOxYnatQ95Ys7s3b8IV0htkC+4ivf4T+zt8E1B9BUun
	 P/7mKoM+IGtNOXhIjLGloDWJsGXtBNlqjg/YYO+BU5TyDVR8RtXhsWslgCsqp8OYLoZ8/
	 JIw8dBMFTUlPS2FYLNFDZa4fu8+KvWwTNFjPEQZV2bOHtrY2WsE7KpUhqM4NqY74X9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794844785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
	b=Uol8kreHRGEcLaDFitH1BlojxpG2bfFcw+MEAQ8wgMmsRbTDQYeGa/SpdPLtOHRPLX2q
	 y+B+XhKAw9uJC3p7myJdNW0wN0APbko22YayW8wGG6s3QMubQlyTf+yRDKOa7A06Nx2Sx
	 izllUGfjkcXFLbWAgUV7NqTb6MJb61O4O0B2RClHX86PftQofgo3WtSGEIegzYWximnKd
	 F40N1WVzhHnXooS/qXCoZ8Vu+H1foV7PGros/eXbmIhfsRCeq9WpmLcFiyPcCk8zaxZb1
	 JYla9J7Vln1b7TuxjXUFlK0UHUel4KeDuoZwcUPPacIQMDA90HzYpTAbZG6g79HRh/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="T4EaFVj/";
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC852606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 15:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC852606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=T4EaFVj/
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91eb7d1478cso45211506d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 07:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794844784; x=1795449584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=T4EaFVj/Db2Oh0QQIN6fEsneaLWasSmYdaomNevHcWQV9XfC0eku9uiWRA8yiTc/gq
         beN2zhlEBUDpPwvlJXNnJXYG7SLeGP2RUl/CIxz8vHb+CRPGvwOGP84P37zc/ASqwdCv
         a2ZImH/j9PEIljcRTrH9YjQx1m9XzvHX9w4v1GGAYhpr16oDLUf0JwGEJPe+tOCosZjE
         d53ULE5uBklWCIuWvycUfx9hIvJ8w6anXEcNacgC3MbLl4k/Apkhq6kLpk0rmKpAkcTv
         Trqjo9GQ8ASe6EH/m27mrq6sK/GeD3Uc4wVkpatMXBaBSojYeEkRpq+DgrGx3awVmJv/
         hg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794844784; x=1795449584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zt6BKnr5OMQnoN+jLF5J5ZxUIjEZ6DGHzLguvsf5vs=;
        b=iVb1zFdGZ553DWeAWnqO7Ysygmx3WwYBUtjjDiO5rDtZAJQUkz9QL5lf7sYX5gMAEE
         u1X0Kd2OHtGAowS/HvuPjtaPZz5Q+KYGa4KO2Hp3NXP+kf5UBmOndicwe76bPp2nDFoB
         0FOogaiw15jgUeyaTF6qRdgrZNN/IqeLdc3qVeY86/YEhL+SV1ThCY7Ve1dlFYMnRxJc
         QhBiDOMT+oSCwTcKgQUGCmTeZS+dywSdURij4lRJSBuYmMC45dbShNP0955tDrbiQaYD
         XfWfGF9ZhU+DCU2+/zHvGLRZlH7lFQrW2qSjai6r2LD7BDmNEnjJhYIP9TkdGIv/rOQi
         naoQ==
X-Forwarded-Encrypted: i=1; AL+hErGLvUIZZis95QK1rJvZTwVkUdIGntgjbmflnmWNbX7W4XFh9/vMwvLaQ7ozS4cG0PYJvVPqAMaWebUUqFMsOKc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+dcAayuZQOg/g1WY0zLUQtJnjFgmkfm2eUVuaZs7g8ZpjKle4
	y/GRNB5jGMchk5Q3V8p/wAbmkRBef4YYwIArLG92cdS7UyteMA25xwNoLem3isxGvnk=
X-Gm-Gg: AZFdTZdt7ysbUc5I0I14/fF9px9WHwz5+xj0tWeUR83zDWalX9Lh+hVF877mLMQNKZN
	lfpEHatlFMTAWMfpAB5ueONNJQm9AIrakx/EsXjG8vHs3pgQ+CZSSJv3Iqb69SwFrWADHfaKibx
	ae1avK5OXYgCpW7yKDaZJwyZwrpPGPc8/3KYZ6mA8O51JxBr0fRA9f15AeZk3gTEDkDTq5H2J15
	SkX4OyDSHrnDZ53nMj5TFkhUMj5L9rXkRj2Aj3L4/SOiFIjTami3mgnwLJSvb+UOJ7dRhtng79d
	LwX3b1v3ayCSkQe2g4TBAXUKX3aMELmt4przuGTsM/DrreFeoHYupwW2x3zQx+AEuKfnU/utamH
	D6sdQWcEdtQDDWVJTkloYJ6VEGQWZhv9KCEk6mZ5J+RA9tZ9MoOZu5U4t6GPHrX/hDpuy9Pr+GI
	K/m3wwU+Ly07R9Po6/FxaGXdrvJRCMMXhz6zk06lf8kNVv+x0+baQ80d5y8JlZfstYpXCKr/3ia
	isBYPj+hLMUWvh3OBi60hlYp4ZBSX3Yzm5j9OTsXSeiIlv9k2yN2ZMXhG6Y22QCLrpLHqf6WCvP
	WVxBjg==
X-Received: by 2002:a05:6214:2467:b0:91c:7f1f:2c9e with SMTP id 6a1803df08f44-91f24209db6mr171122396d6.55.1794844783992;
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d93f10sm87735096d6.30.2026.11.16.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 07:59:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xSz7O-00000009eOI-3Mx3;
	Mon, 16 Nov 2026 11:59:42 -0400
Date: Mon, 16 Nov 2026 11:59:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261116155942.GA2299285@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <yq5amrr8yldi.fsf@kernel.org>
 <20261116132046.GI2532299@ziepe.ca>
 <yq5aa4n8ydsk.fsf@kernel.org>
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
In-Reply-To: <yq5aa4n8ydsk.fsf@kernel.org>

On Mon, Nov 16, 2026 at 09:22:11PM +0530, Aneesh Kumar K.V wrote:
> > Once you turn on TDISP you effectively activate DMA, just like turning
> > on the IOMMU.
> 
> We considered two options for doing this:
> 
> 1. Via the ->accept() callback in pci_tsm_ops.
> 2. Via pci_dma_configure(), based on a combination of device trust and device acceptance.
> 
> If I understand correctly, you are suggesting that we stick with the
> former?

It should still be done in #2, just with nothing to do with device
trust.

You can't run a TDISP run device at all if DMA_ENABLE is not done,
there is no half step here so it has nothing to do with device trust.

Jason
