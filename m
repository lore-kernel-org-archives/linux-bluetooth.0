Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898131;
	b=XsjI99Zx2o37moZEMW3RpAci1EliccLia8HpjQmmHiJ2Cfka+SgQefoRRXZRtpK1G9cJ
	 g3cj0ncGKmUbs6bdr8x2DJENMvOY3zoftPM/eF44SY090fWzpXoBicc3aloNEn7nOnZwl
	 V10KdmqvGshN+s/ZCuqdMxyilSCnL0jYd/+t8pXW+43TjI3ojASe4zEoYEA1bDGwBilCo
	 Mkm4WLi1MmsTqn82dkgaaQb9vrDd0aK94Rwfd8blfuxgIGwwvB/NQ4RVMVcMqq2COy/8L
	 sVvDHN4H8HMvQkS4/JMb0d9w0WlLKPp9H32FH6nRj4ljDvMr2FNj9lVtDRZ0fo9/S6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
	b=bgtPSnomRs2TgTSErbPZ/UH2/3QUj3H9Ng0WHfnBqtXDzlK70CKRYqDKh/HhUD0Rer0C
	 QeVtXe8aVH80htgigyNOYgPPNkdmph02OoRWIBXZrQC0sSkq/Et/jFGAfpfu57y+EINoD
	 Mp7RrI+VsrQrvtVG0yA9goz18AnfWHTdVkE6FmEXY65O42p9MSlvAyQhoSxDj4+MsPr1I
	 4WUO0Izq8ImMIMd39c4U3866zI2KDI2b0Nm2m1QRE/b/9kH6Pozrj9vGK3PwDxZQ3CZHe
	 69/ujI+l35jo/tvPt7giFXGykTLZrxl7B+1qExHGKfcrHVuBn5N4c9czsKJalAX5kDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="UT/D8aSt";
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FF606D80F
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 193FF606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UT/D8aSt
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso1083197241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793898125; x=1794502925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=UT/D8aStYb7dPEp/Z1PTR1znD76pBm0Z1nPlORuFlgDbzwSX/aHEaMIKgxREgduhMs
         7b184i+9WuyWU3kP4ECdvxL5tqJCBp+sE58xftFr07RVMuYSe2D0AHX1L8wkHJuC4lcP
         6d7IEtulMVc64pTkfBc/dFTnsuyCXdHVpF//V/K2Xgp9mPmSNI4/p7tLi2H5V42yljeY
         GtO1ChQ2JjqDeaKC4B9biWxL+z3aUuPX/f+FWBrD4U/FW4Q80YjAWhMK/Up13oskn2O3
         3V6ObKXKjzYpPS1tL8mHYVexmV3sD/kfJUj7ToJWfvaytzTBimAL6fO0bssiuf+AQf9l
         4B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898125; x=1794502925;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E1zVtHMFtNJFSrWULrvIbtVVqDsU9/hCEAvj/Fm4m+Y=;
        b=koJlzKw5Geticnw7BrLzqcePf1z0LvhCWbTxkRhA390x+ZmOYmCArRmf+MeSnkjT1m
         WYXcOic7fBWZuRBOYDaNkmE29ab5AS8KzknwJVH19Z+h2ACbsQygdMU3uB24yo1fajhd
         d1acY6KnioIvP7pMFh00A4C3mA7HGso1IAh+o5b4qT8KKYNqr1nfQy7ZjZObgCqr50PR
         9Z4PKtNW5RO5ltE1pLTKnfg7waPXu4iCLSIykYhq5U54FDl0e+8kw5wSYq8EJM2Y+ZEL
         DcImfAIi8K05T/N8HVwz7+VItNlMDhNd0BiKbDFXM0iszrqEfNO4NFFZRmSxDCciFc22
         vaRg==
X-Forwarded-Encrypted: i=1; AKwUvBzDMQEYlJ0LzrUVB5ErWNepqrHeh+GWgc6oJ4osQCfDzi7hJfE9gyQWQuG8b1AscDQDS+0zq00Rf2JF75RX+rI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bjygRhoSSbm/NO4JGAndUo+xxFPR7tVJ3ETBPe/6PqLwqWeRZ
	7yvtgodRJqegPblvE0fURKKDLdFt6lWRpvBR2GI3Jhe1Qc9ZS78A+Z+rir7KyrKof08=
X-Gm-Gg: AYBFou13pYfrHeD/F+Y/3xjEyJ9rgu4XGgvnxKGtlA7mETx+xt+7KZTLamssXA46Oox
	Iel11ufTqdXHTgSLKuekJR+SvEqd+wlgWMRu/pg1jeZ9ujgm2aofAuVPxkPNAq/MWQyyFD1XMes
	24yiWqmaW2aCuXo9blbjvqKSE8nG1skr6IjhCd+RJLT6MREWQvLhA8hl6Fn8NBdQ+2J7Uz/GWSE
	3idoeJd9uvribNkVpeC8tQ2WpDMl5MbUXoKmIlIwqQlP/em6DyZX7CRt7KNdunrRodGs3/Mmvcc
	xit8LiZj5pXvRzZ5EdUI83VeH6kTY7p1tmCB1PZXQuwRF1NHqxwqairFB8bcKn+tmX/ZJxSl1j5
	R952ajkND84yORqp+aD3j/oF+th6/6Sn2sh5PyzXLfI3a5WhzSREtQJC5zqlvnenhhdyK42QNWt
	6uODkOZ3a66sehErRJwB11eczRbY0c2K2TmQo2H+9HVODYtD5IleOw+7wY/SsudCwcYm8dmagp7
	Vu6qNanpBmXnck2KQkWTWSP63J6QWLOwmsa45NkfrlhiwiEVm+C336IUsc4slGRpfEbFzs7NSlw
	JAkWx/bXEG5Nb1QXJkjOnHhdd05EyuYSRxqbBxaRcMwxDM8Q5OgUlAiyUw4RG96hnM1Qxv/vd0C
	5FEhjUcw+ODTXEtovfHAaaYfkzPUVCHI=
X-Received: by 2002:a05:6102:2c1b:b0:7cc:2bb7:1335 with SMTP id ada2fe7eead31-7d2a16c7f35mr120203137.33.1793898124846;
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm4619225137.3.2026.11.05.09.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:02:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0qh-0000000388I-28Zd;
	Thu, 05 Nov 2026 13:02:03 -0400
Date: Thu, 5 Nov 2026 13:02:03 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 10/17] driver core: Expose device trust authorization
 through sysfs
Message-ID: <20261105170203.GC663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
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
In-Reply-To: <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:23PM +0200, Leon Romanovsky wrote:
> +		(RW) The requested trust policy for the device. The initial
> +		value may be selected by the bus before the device is
> +		registered; otherwise it is "default". The policy is resolved
> +		to an active trust level before the device is probed.
> +
> +		The values are "default", "disabled", "adversary", and
> +		"full". "default" lets the bus select the active trust level.
> +		"disabled" prevents a functional driver from binding.

For making this more general:

"disabled" prevents a driver from binding and informs the kernel to
provide containment of the device. For example a PCIe device should be
unable to DMA to memory.

> +		"adversary" requests operation with the restrictions that the
> +		bus and DMA layers can enforce for a potentially malicious
> +		device; it does not isolate DMA by itself. "full" requests
> +		normal operation.


"adversary" informs the kernel that the userspace wants to opt into
any security defenses the kernel may have to restrict and further
validate interactions with the device. This may have a performance or
functional cost compared to "full". As an example the DMA API and
IOMMU layers will avoid exposing unrelated nearby memory to the device
during DMA.

> +		Successful resolution to an allowed level commits policy
> +		and operating level before driver or DMA setup. Both remain

"before driver startup"

> +		fixed for the device object's lifetime, including through
> +		failed or deferred probes, unbind, reset, and driver reload.
> +		Later binds must resolve to the same level, including when
> +		the policy is "default". A resolver error or disabled result
> +		before commitment leaves the policy's writability unchanged.

Not sure what "resolver error" is.

Jason
