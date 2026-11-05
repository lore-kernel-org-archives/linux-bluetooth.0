Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896023;
	b=hTSZ6GvBlurj5X/dsRFsMnG1NmwrNjMWTKlp3u3c5B3F/hZaFzV1EG9bqcXI+zsmJDTo
	 qjbV+F5IUzlRFVxZyVurM+uEEBUhLdkom0CU82pLupAwsGiFkCsd1mnjy/qBVsfUxnK2m
	 cW0xaIWg4dQZ0e4wk2w+1jzUCyUiErZkaSTI22Gl4jU/ZMyQC6xubjlZvHqLsBiIJGn7l
	 kooJM1CUvx6pgWPp76z2tRYGn1GyoJo/bPg7MFY5rHtUjAYwFU9ktLfZrRewb5s/BZZ3f
	 wfFE74DUAk5nLlQhUnICjeKSmFxIne2lVXi7g1i6VkQy/czS0yfi7yraxF+irCXIK4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
	b=2uAMBmgI4mj4ofDL1vu5wdkdju24jciLzKPX1/RGwFRltdBDtvU7v5BpZOQ9gX6kWA13
	 VXHZ9ZQUXdEf1mgk021jYiVmSc3HW/rPTeG0SFhbAPeJa8pRlPyePVCpT4dgx7ZsbCbdK
	 qkUbV9nFw/7/i2wTLjZ3KsyrncWCvGeXT/GIki/4hc8o32z8Nn9Y1Lg8vcqbyzvQk7ymk
	 xqGo5VZ4TSrhdDzSM7rXHB1NNbimv7m3LMDew7uBXKkVjy9ezH44zvvW672uR+zwIagCH
	 MEk3T9EDbDr0jTCepScLIHyZSzj/knXpK4+A1hINaTtK8HMQabW7cByMvBGBxOATnBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D46606D803
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 16:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D46606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TH080M2b
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc3eb09dd2so738080137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793896021; x=1794500821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=TH080M2b2W5GU83fC4bkAl8rc89cXnFJ2JUZ1DQM2E1G7nxV0uZ+iMHWJDX5M/hBR0
         v8Q4S1dZz9e+Wy709/pkQPJoJ382ui88GBuCa7YwB1Pwv+V08ySzbQGdCs4et9sFRxVX
         1a78LWa2r/qDmkC73yn92WJjnMydzWl2HaDmNekF7y5RHwsZB7YPGLTTr3xjjmuI4LbR
         sgpTrG1DSTm++FzIJZEq0knZSmQ9xxE9IezNyVfi/1ZtU95O+iPlQHI5LWAc3/YmXStT
         Vgy3IZE07Q/+XWoEa8k60w3BygO7yb8zhuyYBqBwOLPUaUevbalW8R2MAA5wjUpSFz6r
         zz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793896021; x=1794500821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=auiIKhbmoRZT4mFY+NhWtro4ChWc0LCFT6CcONkj2hM=;
        b=PWrZZoGX1uISnS114tF8FGaw4Xkfj35eb5XkHQxW7xTXb/iZFPfmkjJ0m7N0uhO8QM
         n6ys6XHoyKWFeMqwYtEd6dAAqCypJkVFsXbZt1aeof9EGON1SOe++HUW9sCg2P8mBLhu
         RO4IpSBBPosY3AXZqtdH3CdR8qJmInfbFadrKyTnlk16lixxCFNiveWIBaKSXb+jKrbB
         XcZNsssRdWY53orQBAJUuSPYOfGaIimS1BIl9y1Vo8i6B8yStfQpxhLk4PsiU8imBI+O
         klsHEByBSjdBGPh3tkPwOL51C5b8tvGdtSAtbt1YcbhOgcyuZ044r/uxnR/Bn8/J+KYS
         5aTA==
X-Forwarded-Encrypted: i=1; AKwUvBw3J+v/Gd/1E2gEWjsCuQBSos9v2d7tMqihuerk5cxzKuO9AYj05njc1MJqG6nQYOShkBKxxfj4BmG3NpUabCI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ngmo0kpjqsjwzZp3QrtzpSQKpLJ0126RXfvDEyUQxdR2WmH4O
	4JVYiACZ1p90YqVcKsXGn8B6FXnZAhEk8UcELLLPcfwhwOY47Cq11TV0g/6Z9GcpY5w=
X-Gm-Gg: AYBFou1mR6E06rK1gafGgwfEHxR1DkoMMUV6Cv1tQitcuKxFjuTD4VA11oEFvRfdPL/
	zEB0ym3i8vxvDwBRRSrTedapLd3Z0dFA9V9ObVfK4vlVEDAzjRlgvqeR6lj3jaJ9iUzc49hLQ1v
	NKs/5odX24gJc8YeO6EmslsjCNM5SeM5BjDU7lDpiy3Dx+2/ztWPquBQVC3DEdHgI3LIH6grxQi
	oLrMi0xYxzvXbcjjLKOdiCqAAzuNRM9zvylcVjjMBvAygaX2ygscbZVc2TVsrNpRy9qXNYiQtSk
	hqlHa2hficvVwIOUUNlBZN0hpGi+ecT7iuf1HhfV2RVMPYi8NmL/lM2kkYuh19gAzhyIoj7oHKX
	XdNUHOYNqPgbJt6vrL52ci9jDjcyng/CqD43K2NgB9nuDn6JKmRJod2l5xS0U4KLj/dJi/Z3Vv6
	HJaovNPWslYL5d1tEv4vGkWUO02kVKwItcwpa2Y2stDyMOVSjxggq0Nlx190zjgQ0lDzOEhOsY8
	wwtNSTMZszCFiDJ6ujAFVn3fVQu7JCwgD8b5COYgF47hggd/gLDVWZjAXLPv5m6Vk4D2SttFqS7
	rTO5Dqrp6KwlCf5K3fYCMkqi2VbzfGEg4BpWYORQ7Yy56RVLdFjDn/hwsA3uJE2ed1S+9WNB0Ie
	so3X7y935O7yf4/q0UxQPxLtNnVfYp7U=
X-Received: by 2002:a05:6102:3f9f:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d2a15715c3mr29296137.15.1793896021174;
        Thu, 05 Nov 2026 08:27:01 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm4667110137.11.2026.11.05.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:27:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP0Il-000000032XP-37xT;
	Thu, 05 Nov 2026 12:26:59 -0400
Date: Thu, 5 Nov 2026 12:26:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leon@kernel.org>,
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
Message-ID: <20261105162659.GB663069@ziepe.ca>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-17-1e536825b4eb@nvidia.com>
 <2026110526-aerobics-correct-4c06@gregkh>
 <20261105131856.GA8298@unreal>
 <20261105140352.GF3889730@ziepe.ca>
 <2026110558-tartar-juicy-036a@gregkh>
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
In-Reply-To: <2026110558-tartar-juicy-036a@gregkh>

On Thu, Nov 05, 2026 at 10:43:00AM -0500, Greg Kroah-Hartman wrote:

> > But I supposed Greg is asking about /sys/bus/usb/devices/DEVICE/authorized ..
> 
> Yes, that is exactly what I am asking about.

It looks like that does the same basic idea of delaying driver binding
that this series does. Hopefully Leon can harmonize it to use the
shared trust level flag instead of a usb specific flag and retain all
the uABI around it.

But, even with this v1 the user can choose to use the generic trust
level and ignore the USB specific authorized and get the same
functional outcome.

> And I know there are other types of devices that will want to use this
> type of thing (i.e. SPDM seems to be spreading to other new bus types),
> so it's good to have and get right.

Yes, we are investing alot of time right now in trying to get SPDM
uAPI right when we bring the general framework into the
kernel. Everyone needing SPDM should be able to re-use it.

Jason
