Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887440;
	b=fb2Bj5omPofnPVwT6OeEgNtb13Ia0UQTI4x7hcHHLZaOxdF6Yb1IxmWyXaLGZIxgM/wO
	 U5aoYD6ckKjxKWI1PpwkaUQYa4Mi4jGLG29FYnEOHWD+9MJASs+PGDOOGeKkqP7cXujGt
	 K3s4coIZh4CxkVpV8C42LhRFS7AuM+D3ylbEucEqWJoD++lPd46j/HN3ST/E0nohivIC1
	 HdbHD9HrDimBIlIqtezEMjJvhuj+/XbpkDnXsU1K8EY7/TPOZozJS7EdEPIMzrWUySFZg
	 30PaLVdSp5gJzen1iE2A1NyIeh/pdBBJIv374GCFTLGQE0cqy1+IxtvRYV3DGUBqi5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
	b=pgTfjd/zO6AZvCxznSkzrJ+PKN6yuPg7RnfF3ZiITdMhA6Pwll9f+gDT3/khxmgke1b7
	 2oNIcGQ2SOfWJOckupGiT4Q49gWOmo4Sx6ESkRBPAGgG4mgN0eeCPFQHS+J/ubB3fySDN
	 iMD3ABCFtgrJkCK8KsSKHsnkPT2yM9YAeCbh3WglfJoOQrjcXYV9kqEyI84qzy2qUVnOW
	 LcHptGGN6JP8BNND3chk+CDa6nqYXxFovS6gIz32ycnLH4UPVdLxezs/Zk6oS5/+EYwkM
	 +U4WuwwBTbh4NJPRD8vRxRtiioXoN9RhF6J8tMftqLJ8w8ko2eyzAYboPQvn4bi85nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCD8606D807
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 14:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCD8606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-98c78660542so1048804241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 06:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793887434; x=1794492234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=kz1XgIBbrvBVV82jfLwzl2boDjAIVUbeNVQas9Wo1Dk5Xdi6H+C3KcpCevzEdclNJ0
         lzsSeS+uRFo6w/gIJIYGLA5nYX/ZA7GDEfg8ye+MEqBYoDAQ+XWmrXIScd3vjjxi3P0s
         TM9V8bmM9C1gt69mu+eIyGDX/aC+cI4xa87K7AUD6ZNwyr7bJjPSJ34eRy3oL+DhO4T4
         z9GIW8q+b2I5fYq6rzeAUUwY6D1cOnVfqLouPYFCQGVgJUGlc0n72Hhgr3e5/i+LRsW4
         Jqs+IOHbUmP6UlpI+ifiIR6Yqw/evL4R0NFbQH8ocPPe+5gcxWg4oty37gZrialLDEod
         LNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887434; x=1794492234;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aHvVt/C+p86HW0thhKORyrpJuSX9G1Rk+ExvThy6OxA=;
        b=kuRxs02nPKiyPLyyyBvDd0mf7OeVw9JYfSHFHsJ6PuYdb54fI4Dky/eyTuHKdakC0Y
         lW+l83BkOQwjR4uz3AmC6mPoj4lN4ZpgK4L2JMhuNIEW0CsKOg9YAkqc+G3vTltztmwv
         HuO/m1oLgKwxW4dJnotqbCqCmWj2hrcIXHpfFn+t6VmbeTDpfhj1BkkGhomrxrDrQ7+1
         bOVKA5eY5m0VyY/x6G5MyJTEoersGaaCMv9EQqtRkVGGxAE3t6L0H79RC2w8/cevi1Dm
         qYruycUD5Nriy6qIqGKCJCZRHIQOEyaPFB5SIVau7gwki91F2w07sEK3FpehEKSd2nPK
         XLUw==
X-Forwarded-Encrypted: i=1; AKwUvBwSooFrYrxA9P7HVQAtv3a8ho3JaAK2SrBJocJRuuggKqvYC5GIxy+uzmuUNM/8w31ECJ4PUvc4sPdL17xh0fs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mCvVD68Sf5PfU7tmAb7uKhShlYOZYX+Qk19Or+xlw6uuS4iMk
	K6hV3wgVQNdKiBmxiyqKAEFr+hJxWC3PWtht5ib1EMMEfC3TNQaFqxKvu0hEssPs1Pk=
X-Gm-Gg: AYBFou3YE/9IEQ9teOSmsYIgU6w48zivdno7IrHRk0ckjsbh2zcQLKTMT9Fxj+Ffgp+
	iwEvpdS8mrQwWBpvlvOABQLo2vByC3K1SOolPk1EuHfy+hyn5Ayl18MBPyKIvkx0HWnP5DJqQL0
	4qy2wyEwc6JNXF6WBVGijhHcuHz9KlNmqV1x+r47zLT1dkxxtcHRo6br9MlYncMVFz8WPVvTQgD
	gxx2XRXpwX4wP3+ro+8ejf57jEYkJFMTwMC0dCWoRXAl3yzLlA1+G/Yg4o+G5DEmyK4hOm+zIIu
	NnJ55kplvQ5b0ahu9XoYUFVAS83vjH+Z4WyRqFiwJ1bKK70voR0JVxDYvHU4X9fZBvLHLVJwpPj
	WxKkyVxE7ERQbeH9GtICGQhKdqXMtqwefSMCDB+aYhWVSAC5cGqk0OCBam/NyzV8y3mL0oT1Jva
	i0tV6rELNN2G0N7NV5A4fKixEQDoXz+RQMigZ+wQcr9UYx2M38V24K3LppMW+4g8cFv/Y2iAK4+
	RQNZBueLMK2D1K+lEm6QXZDs6CWFKuLBFPxGfXI54OTtQuihqVozsqEv+NTLFYOOgiiIknqlHR5
	t3yjdMEZnMH1OXwBXbc43uOVHoa3IA4n3R76bsHQMCAlL31USuUZLwjHzJ0f+bYXKHr/wb7GeMu
	WYOn2XPe75w==
X-Received: by 2002:a05:6122:8f88:b0:5ea:cfd9:8fbd with SMTP id 71dfb90a1353d-5ec689b0f30mr9760208e0c.17.1793887433885;
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8de4908sm4235128e0c.15.2026.11.05.06.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:03:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOy4G-00000002ecj-0pCb;
	Thu, 05 Nov 2026 10:03:52 -0400
Date: Thu, 5 Nov 2026 10:03:52 -0400
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
Subject: Re: [PATCH 17/17] PCI: Replace untrusted state with device trust
Message-ID: <20261105140352.GF3889730@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
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
In-Reply-To: <20261105131856.GA8298@unreal>

On Thu, Nov 05, 2026 at 03:18:56PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 08:12:51AM -0500, Greg Kroah-Hartman wrote:
> > On Thu, Nov 05, 2026 at 01:42:30PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Convert the PCI specific untrusted to use the common device trust
> > > level. Adversarial means the same thing untrusted does.
> > 
> > What about for USB?  Will that "move" to use this common trust level?
> > If not, I don't think it's very "common" :)
> 
> It supposed to work for all buses out-of-the box, at least this is the
> intention.

You mean DISABLED/FULL should work with this patch series on USB
right? Meaning the core code will not bind a USB driver when DISABLED?

I was wondering if some of the broader things we are doing on PCIe
also apply to USB, like device authentication. I don't know alot about
USB, but I got AI to help me find some relavent spec information.

 https://usb.org/authentication

This looks like the parallel to PCIe SPDM device authentication. I
would expect it to work broadly the same way as PCIe if anyone wanted
to implement it:

1) USB discovery discovers authentication support and creates an
   attestation subsystem device for it
2) The struct device starts up with trust = DISABLED
3) Userspace runs the crypto flow through attestation subsystem. This
   is extremely similar looking to PCIe SPDM:
    1. GET_DIGESTS -> device returns a hash for each certificate chain
       slot it has.
    2. GET_CERTIFICATE -> device returns its certificate chain, read
       in pieces.
    3. CHALLENGE (nonce) -> device returns CHALLENGE_AUTH: the chain
       hash, a salt, a hash of its descriptors, and a signature over the
       challenge and the response.
4) Userspace inspects the above and approves the device
5) trust = FULL, driver is probed.

But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..

Jason
