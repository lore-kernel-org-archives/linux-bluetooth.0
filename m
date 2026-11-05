Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887594;
	b=pJ+DtBSHeuu1Ho1x63Gedae7zG386Tz3CRXgCEsqiW0kSu+nRYkZ+HSS4Ffr0OLIv+hU
	 FhvTq/73hOVch5BcJv408gefv8SXUbFKKuJIFBQJFE3mz1Kb8cLD6ol9/vcYzOBNHr578
	 Hr2QeZ3471SeJktiF/2wOgYSHOzAjPdzn5vs5ymfeb3QcfqTc4SDh9bI7n3Anj359Vywj
	 OdD4ngWbapzmOBI7ptKhdaEKLTuBUDLX3LePaOconxicOLCwDfGXyg0L8wzo0rRM592ls
	 hYTjwwzZwTTYyUVyo0ETywt9wyC0QyhwOgk8Kszib5OY34QlBVWnDhkXOm/Y0+lFUlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
	b=1co4UFLYL734PF9cqg39ColYQgq2OWJAKcpfuUfjdmWI76OcVYcMJJPw1pHBEo/yJ4sV
	 MYTi8pBnQrF9SftNzLGgHD/jeIvC49vyOJybV932/kOLSC0iPStT36ve3nYWfykNptxE7
	 gNtkd0r8OiYOBELY3tfwW/udZEgh2b6ty7RHxFTZPpoiprc298Vvtf66eKDeQWX2UWmkg
	 mRxBDAdkGP/C9opuDZAtzw5uovWsdCXaoT5VmcM0s8bpZUPaaTwxyScSCeyaIxd/0Hg85
	 +dG2QCEUokWN1vCSwOZrJ0CkUBUmequDBaIO1YZ1LWtYzsYY9O6HB45l9uU34pQbXAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RnR9WnLw;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08815606A336
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 14:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08815606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=RnR9WnLw
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-99b49d6a5caso42290241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 06:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887593; x=1794492393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=RnR9WnLw6ZCMoaFK9OfD+Z3SyEdhvj+uf0rMG8hHCJ508GqyJ6ANwZoUk4+aGiOUw2
         /BkiFTe3GFbXdlDhgGNTyo1p8KbFcLTeuViDrXT0G8rPqBzVVo12Ao+p4Nr1qmRZcl61
         4eaArBRyBLbC70PWW9D8DSwCjUpFcwxnrtfrVG8awSc3G2DLBl7ue9/tyD5BZlfo0PwR
         zdxT7MPa5WtJxCqrk+LMM1B4PGIKPha9YDx2d3ZgVPNqHnLfPw9K0SbdoIeozyBU6kJV
         fXJaMOJT5b2NTv+4F4NS5Cw1swAwWPhfu1r6zxddYwAc/lzTbX1ed12Z3pRWm4FFq8m7
         OBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887593; x=1794492393;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bxiPLBqzkOz0GIdUWUmBLaUitvgttuw9ZH2qvbUZkg=;
        b=Slp84V81Qpefe6TOwbPdCBZ0mX/f38I+nPeG6vxdcbWA+ydsKVUrTIUlmE/SxtYiE6
         Dij5dV4+EpnlrCS4M0hWpnqtY44vcE1sd3C0HtUoSTsGGhfCdY8ZnYJvvvnCG33SdE1J
         mFJ06Y2QFgxb2nElyXhWNviV8dJTHjVZ1wP3V5DAYU9zzF/Yp76sq5GTG4EXSFSYbC2p
         PJGoK9n30n5sadfW0edhgMYzmelmkYM2xQpDXnFJwdtaJMXOGxH6eVFzF9lC/1B030WV
         3jmkKZXbV+jcxZ8II8cdcFWX1cYlLFYHlRrIpITadsD82rskuj43f4pyNsuSYKZneJFp
         Wzyw==
X-Forwarded-Encrypted: i=1; AKwUvBxvRGy6TtLFy/WYXByChTFdqV0BgV+qpLCG3FTtqj4SYIF9Phx9vFUFuPpWLSeibVVoRL7OENPMSXrrJQ2wuz4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+J4Q5AJtsM7952BPcchAHNXBtL6Yee2Vzyt+HNT3pgmcamHzUi
	qkABIFz0FdlLCslWjT/2dmJPbBzAVJuBhEo709lCn2eQkkEIPlnkVETlAt2apKSPNnQ=
X-Gm-Gg: AYBFou2z+Figzj2RK+AswLKN4tzHCWqixOf0TRs8AO9bOHvpV6ifvGMbFYNHcbj+8x4
	l6lY3fIOQrC4I0maaDbQV+7QT8AE3X0aQ18u7gDvGDuBe5HhBQIQZDN16XYU4ZhlAxRh7i3b1K7
	QT52+MbWwWfbmNHljvFRMZTyT8k58rmdn3wHIU/qnQBCI6WTJHK4zglvdlMSk4pv4VQRT+0Q1qN
	vI3IXsIZCurldVolp2bhDzzYKH3SRFniwvjZLcmjMsx2LspcYmQO+vqc8ADBO4kDFHzmSvpO9AW
	78kQ6+Nt1/S0f457khXXJ1nf7I1M3c4z/Z5ifZk8W7yOwGPweTEohd5DtHXqabdEtBzxVQO6fR7
	7LLHuUb6e4pCvkY1A/VU9Tb/LAv/EFXj/m6jzj2BOFq5xnUs38u0DUWK53MI6SZ7byGSkWE+2KM
	Q3dLwaNrm5D07qT3Kb8XspP22pokq5Ja6MOmf8X73zyQak3Zv3SHT5jIBL2kc1CJviHKv2Aq765
	/3CtvtJq0GC4tUxo22PC9nHGNsEayCU/XAZnlQphmAZAjK9fFwUgyBLk2QsYP0aEuoLvWKre1Ea
	Qkj8K9wwRuSwooEEY0DJ/AdadYlbz6k+7+GFt1x3bVY4VQcqbM8rffyyxTlE8OYpxwMezZBcYbG
	UroUxfJsOUQ==
X-Received: by 2002:a05:6122:4f9f:b0:5ea:389c:51fe with SMTP id 71dfb90a1353d-5ec68949c50mr9274698e0c.17.1793887592873;
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm4161881e0c.8.2026.11.05.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:06:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy6p-00000002ezu-00ao;
	Thu, 05 Nov 2026 10:06:31 -0400
Date: Thu, 5 Nov 2026 10:06:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105140630.GG3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
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
In-Reply-To: <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>

On Thu, Nov 05, 2026 at 01:59:20PM +0000, Robin Murphy wrote:
> Yup, and that's true even in the PCI TDISP case - there's a major amount of
> "communication" and "configuration" involved in that. The principle which
> should (hopefully) generalise is that a bus/host controller driver can
> always interrogate its child device to perform whatever attestation and
> general configuration is appropriate, but we won't hand off any _control_ of
> that device to a specific device driver (nor enable potentially-impactful
> bus-level features like DMA, interrupts, etc. if relevant) without the
> requisite agreement between the bus code and the user.

+1, I think that captures the idea very well.

Jason
