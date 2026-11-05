Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890796;
	b=mxtRp481B59N65ZbiSQUhZ0yTJ1Q9JNHsGFLiPvfP7g2n5p9KR7rzCO4qntG4S7zbopO
	 QgoemyWlq9H1M4L2Ebr7iRWELOwXh72imO+QpNHqwT39JRvb2R8L7JYwas9hrMPB4LDmv
	 q8WF0gBlglJiKUfBlqP3dRCx6ehDKDnnzpuwwG2dXhz1eg6g+gKEAvKttjqAJk+QQ3kWJ
	 1iEq/8jouUnVYfe13Bgr1xJGkNFi2s/XbY5GH+CKdfd+DIM0DgZhaUpfZV2wSEK9Mz+ou
	 PkVdsmu3L9wdGSB77MxzcbhL1jzZXATl74gp3nbX94weFUzKg2jHteoUCUqBi4azXfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
	b=RWdr4uuTyjW8FiCVik3wMLjuphWWF+jRncBHSYU6G9Kf8u8DnTpjInKRxxFIGI9OTBYx
	 HXJhmPXmomtNbZQTTW7ssksL90LXw2TyLyULpxd7t552Q1iqTVLXFuHkVSjvG/BM5D4Vm
	 cmD8DIFBuhP+/ScVF0pl96j+hQns5q9Fhluhw6JhYB1MVQDfWOaPi7XNwsKXvoCpUy1gE
	 QhYXvZgRLgZB6xNgo1c6LBTqRW9cEZuA8XQO1OPjS9jA+nTBWvjt5J5ZTL0d3MJU91DCx
	 W5LOvc6M4byA7eaGCRvvVG527sMyiQU/a7JH2K/MC3R5nfIAe5zSYvXYhv0psYHgnkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bpBlGkKK;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB337606A33D
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 14:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB337606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bpBlGkKK
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ec3561b07dso620948e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793890795; x=1794495595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=bpBlGkKKYmX68RAsE9EkcMc+aPwep+Jt4D7c/OZg3kVQeHpZyfmkntRrTHho6EP8wd
         Ydil1svNY3g9CpIhj2GHYQ7d434gL/SpPpSr+DXV/upiAZMCvC9nreTgfts3zuhMwCcm
         Qskdy4s4owr7KaU/9VifToG4uoaZc2rkAAcVF19z0f6dAbM64dHUzvDPxywg/TCQt9WF
         2ooxRy05KElc/DdqHagH2RzabKyRAsKGjv0e7Kqhd2EeSxnmqf8lncs0n6nLDm8+XKat
         ++mZs0G+SfgC2WTprHf/u2SbYhDe7xP1yG7Q6zYRZWtdxX3hRx/GELgc/Kk/Jaz7fcIZ
         8CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890795; x=1794495595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sv1GqJtGOVxD2bg62FKkDXwLV7ybcH0/LrV/szN48RM=;
        b=gNPvXgpOUfPj0LoM1eDKYqYWB/LI1+0L0ihtihbV93IN5stuB1Zo8qf2/fQUtNolYi
         MTExdaXYG02M6dw8+IASaOoKGMQ1aMs1lT5SQsHy/R0RVzH0CzRT6qUxf+XKbEHc6NaL
         TjYZR/qAFaHZS9cTSHKjS3fU5qTSaHIOwGnXEHtsqvDWPBRdM51hGpJ/onlAWxvWrneB
         kcwuHn6KdmW7ST0fBf9bDmAjoEVJAgz7Ln5u/1XiEGaZd8K8891o9PGe3xE9UHZGZ0W/
         EjTE1WqOztdA4N50sVYNrnPnwbjRTZZ7YuHhe0xF+wPWhweZNBdAHgRr58v7ieLlnBzE
         tUmg==
X-Forwarded-Encrypted: i=1; AKwUvByh0CvVI17fk3FPNK9Q5HwmaeOTrZLDwZwMe7JC+/OBptkmhjAihpeq8HKkB9WML7788CTu/bMRTot0TxGp/qY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bx+3YqS3W40jHhTiIJriA+vt+Vn/ZW95SkOYqsOP5l+Ae5Opn
	bnkquXrLQNGLpw+U/352BkCyZS/h1fA2U/twlYh6e1wejw1p2wwFRiTDamB9XMcMcIQ=
X-Gm-Gg: AYBFou2kmVggXBCdLiXVnWhPvD7L38trV82IqgOCRhZ1B0lEqW1l34qDzr1iJYr7/Me
	R7xhVsGnwiTspTLMHvzsKuV5C2RVbWlG+AZNfUFLvV3+OSBnCB0kLo8V2bf3NswUsQfk4Z47hpv
	oXy7QSRPtwRRcrgQf4eZe1lfgQXn0kGJ28Yl9yykd2/5FFXPe2DhnkFIRdq0cpSLYOHKZHIJdMV
	teChWCdIAEqEj9hdmIJPUznutqlHoc1peKo+UqTXXZS2SkiDvtityUivypIBTETSBRvBgx9ZBv7
	KoMfZUGC1Ro4rfrCnyew4wop0rTxAk9z+o1w5IApEZraBioYb8kQEZjVb0WCGWGbveAK/j3DY8l
	Sj7GyT0eZlKsWjbklnfdhnDgdGOt27eCkqMGRv5fUU26oEdqTicVdGf+TadmEVq8PEsrir9otg5
	jUyxR/wPD2LkmsPDM1kDeN/FuhoUfv18O9VCUntz1zEHRE6ozaReg4N4w4bgwtVQBxzyQlc1mo6
	yIMEcdzJJSPqBzbhtn4y7lJGiCf4idLzF5ON8Pa8pxlCkt3WRqb/b82cpenTgt923Bv4oBzLPa8
	Sv4khElR7SndBTuVqImMsdxbbgEH3mv9TvtPooeDHeO1qyE8ZBPVXt2IHVITDPoP21JWoTRYFaj
	p2xP+vCg2KHc=
X-Received: by 2002:a05:6122:6c0a:b0:5d9:302a:8243 with SMTP id 71dfb90a1353d-5ecb429571cmr1423011e0c.12.1793890794801;
        Thu, 05 Nov 2026 06:59:54 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8df2a38sm4234612e0c.16.2026.11.05.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:59:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOywS-00000002o7b-2oaN;
	Thu, 05 Nov 2026 10:59:52 -0400
Date: Thu, 5 Nov 2026 10:59:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Message-ID: <20261105145952.GA663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-10-1e536825b4eb@nvidia.com>
 <2026110514-bunkhouse-handset-6a3a@gregkh>
 <20261105132729.GB8298@unreal>
 <2026110535-engulf-precut-cf10@gregkh>
 <9d896ebb-6892-4cac-a7c5-41def47f0be0@arm.com>
 <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>
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
In-Reply-To: <54c9476c-9f76-4ea1-a73a-c9937d6b463c@lunn.ch>

On Thu, Nov 05, 2026 at 03:43:53PM +0100, Andrew Lunn wrote:
> > Yup, and that's true even in the PCI TDISP case - there's a major amount of
> > "communication" and "configuration" involved in that. The principle which
> > should (hopefully) generalise is that a bus/host controller driver can
> > always interrogate its child device to perform whatever attestation and
> > general configuration is appropriate, but we won't hand off any _control_ of
> > that device to a specific device driver (nor enable potentially-impactful
> > bus-level features like DMA, interrupts, etc. if relevant) without the
> > requisite agreement between the bus code and the user.
> 
> Maybe it would be good to list subsystems which the bus driver can
> use, and cannot use.
> 
> You list interrupts as potentially being dangerous. What about reset
> controllers, GPIOs, regulators? At least in the embedded world, the
> bus driver might need to enable power, set a clock ticking, and take
> the device out of reset via a GPIO, before the device pops into
> existence and will enumerate on the bus.
>
> I don't see why interrupts are dangerous, which makes it hard for me
> to determine if GPIOs and clocks, and regulators are also dangerous?

IMHO we shouldn't try to over think this.

The overall point is to give the userspace a place to inject policy.

Bus drivers should try as hard as they can to contain their child
devices. Like PCIE should activate the iommu, disable ATS. USB should
limit the messages it exchanges, and so on.

When userspace accepts the bus driver it also accepts its containment
capability. So if it accepts one that uses gpio, etc then that's fine.

We are not the point of trying to describe what threat models various
kernel drivers can support. Userspace has to figure that out on their
own.

Jason
