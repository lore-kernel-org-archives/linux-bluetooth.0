Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516788;
	b=27p739pHWM8JaZ8+O2oxOPuYg1bJPOnANejOq0Tf3eldu7JrT1QKL8d1mA/Xu6mhD+rr
	 HLeECCTURqUdL6xS7rXpebOqylaJwEeSKQii50SXyfoyclnDOCNQTNRr2JZ+RS4dPB2v8
	 AB4dtMUgcnYmOYYrG+bmmPSQzraQ9S/xbZAeXuP+MkcCV4vZ2HfaBq6OhxlM04Gx5/RYi
	 tMplNj5KONc0jca2Q7QnTFvuDJWM0qmXNAFGX/qlkpNKsUMjv5d5e11qfpu+WRNN+T1Xz
	 2KKs1tHaipVSmXf6bGQf+h3Pw1woiRFHIwkR6+qykQOtShRAR2DKvNj3Qw4Cz9akRRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
	b=jwjwZ305j0XwMHMaKWJQ9V6vGagwx3/eQXqaeCv/XMch+aKZoww928ajfbuZpI2HxeLq
	 4RnjlFHdrucanwcqA73eXN8VW/dBNGJhwVSWzD9RjT7nIh9kQ3Rqq5rNBM/YtyrJiaMgH
	 y+3G4NWmFZRCJUdxgfPMvyhihXStyKvcXl7cyoh0lbbxGsXtNisbvk7pdqk7ZFFMSlg6Q
	 3tsgXJMyjSlq+rBWWEZGOV1re62m/1VkNlj9/acMAsEMMhSBbtjVL7FUN+zUzaQDk6/W7
	 MqUWIB7tz6jbVKu1Gltp64HTStxIqcvVtAJ83Ny2nD/7/Uhri13MRiwL2BM4YgnL7gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KjiX7YWe;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A89606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A89606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=KjiX7YWe
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so39789335e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795516786; x=1796121586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=KjiX7YWeSkA9Dw0WA5xjWaOqnyEHCedD00sUzMhE3sKEAvQ2TPIHmIyS+enWPn9hqU
         UHnNtz+vsI9HdnLLJLRNEHpW3n0qDPjDGGb+MMmUEkY4+DtknEToZAEEAwd6ErlDRM4U
         sl6ks9V8P+KgBQBXge6XtIwqjU1IX32GeqDZpfsQ5053CJLA98ICyRMFUcjrF7GwSx6y
         mLBhDMnek6X1+TiwUBOkVQB80sS1Z2oue9zDTiR4H+wlMmpVb+6EJ+EZoBBfGsOtxa1G
         85CHt1w3B0RFKCYDolOV20zywTKINPHyMkeAAvRZwyufXjasNY7vVq1oJTMaEgpAJPJ9
         588Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516786; x=1796121586;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=Vl46yZgzfCsM0xi0kVsiX9JfNd6zGSXQAP9/pXiThZqKOv91L2BF1Hp9fi8q/IMHyy
         2LsqFc2UAOjRJVhBU0q53wi62PDYf61wppkIPi5YLF2oGQ8SrK5JFIuw69v+Vn2ue2OJ
         OKqOv3HjS+FDg8WYT+616kj6RpvIkEBrnCSddhJKcGPOkWoCDu0B9B+sEFzW12e8Fcum
         1Une1egtlUTlNCkjaGQAfkZuZ2AhL4apLoKma/D4bq4yiPbi/WS/3ulPF2gTi8e6HLrV
         0ukLKe5ZFqVc6kHol5CXSJhYWKpLPowjLXxeRIKkAgt+Zh9SqM5XpmxlAnFUId8eKlE/
         LhDA==
X-Forwarded-Encrypted: i=1; AL+hErGRRbj1VNCG5IOUYA84hzJaotR9oa3fQeU9iK13TSHlA2YbOBpPB71DorZ9g8VFDmHi/YxkdQUM4y0SehubC7k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zGxlM6djmXI3FiwoK/qX7bV3/bnPzIUQ44uOooc4f1Ozd6T74
	TdeJ7RZQ+4uVMyLBHZ0bfCK8aGBPRjiKUwpIUcVQ4Bx/09gIPbzPfUBTfOKiFNPOvVA=
X-Gm-Gg: AZFdTZeJbMvVy908w+BOGUgPzZVS5Cp0EWN4jdlIPmM0oHhHCUHtrqaa9pXtUMKsVoX
	EVJ1pP5nObLQCQwJ8wXcVno5ciJ5Qc/5LV8iKicdY1yCOPi/SxWVsPjCEol3/XJ8lqMTeYFFBH1
	zBz0Hl7gowMyEgxG7lHT8fAB8eOYsZY9U40TdV6uL3kIsVBqubK3p2yRdguQUK7KO1TenoxsJGj
	ABAfdJqJySE3Byc+lhR/+Tf8S1Xe0Z4iri7WXZznLBBU/PYvNaUhKYjGHf2wZnzq67AOrgQ8lpj
	6WxtBwzSFFDikJfDkT+yMWOwWXLC2xwDpgbmOl1unbJ/BazOens0DWHi/oxffivKDWnUOW76+Ok
	2lWE4jmaT36wjOv1t72Neklc21t5RrOhbEIofenUBlAbBZg3loDHCWRbPxXFxcVT6EHOszDpsZp
	kzCho5pkVD8RH/v1IHjYi8cmS6BmdoPca9Uo4MRrv4vdTGcx+pIZ1dLtgyQdhRSG8TiLUWBmd27
	BB3VobeVGkczvMS6VFDmj0FTjD9dNYiR4xs5CfnvE/gHRFL9UrhUI9Tj0OlT+NHgGyXVFHmNcnC
	pqbgF5qmgEFjmJsS9027Mq17hSuQLUSD7tuOKNNR8px82YSPS5Kk1EBxkdA0fw5GpTmK
X-Received: by 2002:a05:600c:64c8:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb8881d141mr281064655e9.26.1795516786433;
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Received: from ?IPV6:2001:a61:132b:a401:6cb8:7c28:11e1:499? ([2001:a61:132b:a401:6cb8:7c28:11e1:499])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm425218335e9.5.2026.11.24.02.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Message-ID: <65749362-927a-492d-8bff-573c277fe456@suse.com>
Date: Tue, 24 Nov 2026 11:39:40 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/33] Bluetooth: btusb: Fix MediaTek ISO claim locking
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Chris Lu <chris.lu@mediatek.com>, Mans Rullgard <mans@mansr.com>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
 Jeff Garzik <jeff@garzik.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Bart Van Assche <bvanassche@acm.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.11.26 10:43, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> MediaTek ISO claims are performed from HCI setup work outside USB probe.
> Locking only the interface does not protect the claim against teardown
> of the parent device. Unconditionally waiting for the parent lock can
> deadlock with disconnect while it drains the setup work.
Hi,

your patch raises a question. Can usb_claim_interface() ever be
used safely outside probe() without this kind of locking?
If the answer to that is negative, should the locking be integrated into
usbcore?

	Regards
		Oliver
