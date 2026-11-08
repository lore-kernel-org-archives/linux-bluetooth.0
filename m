Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157159;
	b=5FZVtDXnYGHLSTZieOam4bKznBv3UxPL00DlyWfPOD8jXil6TQOAa8yh0dVu5S3KRoBr
	 RTzb1h4Qn/u52yGB9YysdsFNjA9ynHEQUJxgOUB5kiTBdUzEVcAmSLaNz+lYGD/cvcbkw
	 MSp09v+nigeoj9JnDFp6EuVdBrhHScv6f7EFqJGR0D7Cfm8urp59vaohtMwiWfzwYXapa
	 iVWUbqmaUrtBmM3MaoApP21Piz/RpscuYDOLJmQo4Mm0fb7syRQjg4L64Wtf47WzMPGdv
	 EUzPE70gZqKFdUNH8IFcpMUQJlaAXhoUYDHGWN/X3p2LJZYLpxFZLEomjt62hCfpewA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
	b=MxAK2vznZ/oJvri2BCZTQ+WYiYkSjtSemP87Omj0RT6kc9LSCPWn7V8RvWVkdLXqtTjE
	 9CBVn2lQXslYnXiiwICGE9oIEvUkzEF9e+j/iRKPriVbz6dtr5fBo2BSh3GdPsXHalGZg
	 d9/lM2/fqivGAP7IAFbneuOfYlF2gqNueBAsRAQA8Sk3hUkbTpqcKpsTUyjq+gbiC26Xi
	 lQnFeVwOZmAKXlWuMEr4IUuhKZj6/vbskXVFSYB15d2J8GW0Y+gKeM0KcpbufqhK2+EPi
	 tsLNp8/4/a1iXx+5CyVXnvgojYm6EwOyzJPHtRvP3UmHtNYhLUliX/2bHnub73oRUWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DD606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 16:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32DD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91ebf4cd218so2050736d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2026 08:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1794157158; x=1794761958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
        b=vVWQLNs+Rnn6NOsMpjKSpUM9H3gRT4E/HZTt53PMAZ2SXIz+Low080hQm0r2oKAsG+
         HZ5TLknOMUGXKR3KUCz20FyQXU1Y7n4k67s/O97MTY2HciAv7W5/XWWVJI3wnxiYTpJN
         gDPuohXn6LbvsrECp0/Ji6cvN5My5wm8EgfEsTmjv66hd/4pZ3HhjPBADrWO+gshRLZX
         1w4cJtE0RQlZSB1u8qCDumnVcL5w0oR/W9xf8l09re306PAWvYklsReVbujjFSq7ckfb
         ysHxLPgUuyjzLYLRPYb0BIszOUV4j3JsJcseKz7sg4xVYz+KH4V8tOVQekOfo5kBRIRc
         SzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794157158; x=1794761958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lmwJQdwiPgvUanu0gwsKytij+Ict3+h8IPwu4vyFkUU=;
        b=Z9KDqq8XaDga0X7CDfW5jHFjZV8Z176FubED9jAhZcjEB6+/CwK/TxUselRCkM4xzX
         D04lgTL8RkkOqGM6YLM/hXicpiXs9PU0UD1GckwBv9PJCRc5rjapxKvgR+tgL8EuK6Tk
         KrmL5Jz2z/3A6ozxFhWi+UCDNXFRkTq05/VSOS3XjkXbztwprtLYt7zQ2ciPuAolzZ3R
         c0l/iVAS34MVnNZE90esj9Noa2DFcEAT0Fn4SaKqlDnTwqhGeWbYWMrwwdhXXsJ1t0UW
         41Pj6JNgJhsGpHlR/VIXVBQqEb9wN2hh2yTs9wRgACaFIohp8zH52v8Ck17w9MbSVtps
         pIsQ==
X-Forwarded-Encrypted: i=1; AL+hErFbbMvIG6Fmr5Y5fzsqFpETYK3kbrS1pevAgYq0PsILdnUmvOiippKqBK0r+484tL7DW+GyDh9O0q5qIjXrRxI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TB+dRjcLQBgDCicxHsnra6cNfAVtxPO2yTLS6njU4tY5GRLcw
	oscaIna0OSD0RRSRaE+nmvr1mLBatqTnpHnvcL1ncpkX3k2CQss2kfQ1E0WtgmW/WA==
X-Gm-Gg: AYBFou2EH8mX2fVn5/lI4M3IYwvC/lTnl00lERuUN06060rl/XIw5s4ecMpWPe4TuHu
	ZyKlmWA+SaW++7w1/U1AUNlDnLoQihm6n8hHHjLnoKmg3DULM6EgvKR7fijtV78K64Av9TSo5zi
	iKmJxOVdUvDkFU+/hNLPPsQ/RcNGo2f4uJZvwXST6yiOE0OkiB3lbXLlcJmIwlZ597b6UMt4y5z
	ldOLDr/B9gRX1rlAkodkPlVmHGPmcT9fZOy8++73dL5vts142mldB5NSbZLWxFs2SQnB/q/YulW
	uJ2mdZZ3CopfZuvAbs+1PiKmKsUQbRktb5R/ZdxzA7b/3vp2CZP4/cBpdCzzH3Pq6Wogsdhrncp
	DjsgXRl0/H+7LajDaX8tVmW7DyNk90HWaDuHK4O8xwJ4j5kgglxkDoenDJDk4X2pNJAISlRWbOt
	HCtMrKINJANTE9rkE7GH/s3RzlAvHP6guLgy+H7UXXCK8CDDXOCGYRYRl1ADJjbpYiUrGVNdFJE
	Z568rhFmNfRn6wwrlj27imQ88PbDuBCClBDJQTLHMGjjlXi9l/ENFqWxQmHg11wJ1GuMTWfyqMp
	A3vIxCMs9+vrA/iTXYThl5WPN3jw
X-Received: by 2002:ad4:5d62:0:b0:91e:9d64:3294 with SMTP id 6a1803df08f44-91ed240d34dmr24616736d6.30.1794157157397;
        Sun, 08 Nov 2026 08:59:17 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::66b0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ecedbefb2sm22431036d6.17.2026.11.08.08.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:59:16 -0800 (PST)
Date: Sun, 8 Nov 2026 11:59:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
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
	iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 05/17] USB: Lock registered interfaces during manual
 driver binding
Message-ID: <647f3199-909d-425f-b485-b598a18844d1@rowland.harvard.edu>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-5-1e536825b4eb@nvidia.com>
 <bb83fe3c-cebb-4bc8-bfc9-24df1cf72b0b@rowland.harvard.edu>
 <20261105184442.GF8298@unreal>
 <bf756e50-c77e-40f2-916d-e88887426806@rowland.harvard.edu>
 <20261108110909.GA8635@unreal>
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
In-Reply-To: <20261108110909.GA8635@unreal>

On Sun, Nov 08, 2026 at 01:09:09PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 03:04:18PM -0500, Alan Stern wrote:
> > >  it ensures that the lock is
> > > acquired when the driver is bound.
> > 
> > That may have been your intention when the patch was created, but if you 
> > read the patch you'll see that it includes a whole bunch of material 
> > not related to locking during binding.  Namely, this part:
> 
> Once I added `device_lock()` to `bind`, I had to add it to `unbind` as well.

Obviously I'm not making my points clear.  Let me try again.

The entire patch description, as you wrote it, is this:

> Interface claims hold the USB device lock, but device_bind_driver()
> requires the target interface lock. Without it, trust-policy writes  can
> race admission.

This says nothing about holding the interface lock during unbinding.  In 
other words, it isn't a complete description of the patch.  It implies 
that the patch changes nothing outside the device_bind_driver() 
function, which isn't true.

Furthermore, the patch does not change any of the code in 
usb_driver_release_interface(), which is where unbinding takes place, 
because that routine already takes the interface lock.  So to say that 
you had to add device_lock() to `unbind` is not accurate.

Instead the patch adds a new usb_driver_release_refused_claim() routine, 
plus code in usb_set_configuration() to call the new routine.  The patch 
description says nothing about either of these things.  Not to mention 
the fact that your other changes make it now possible for the driver 
core to delete an interface claim when the interface is registered, 
something which was not possible before.  This is another inadequacy in 
the patch description.

I'm not saying that any of the code is wrong.  But the description does 
a very bad job of explaining the new code.

Alan Stern
