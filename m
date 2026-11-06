Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945129;
	b=zZK61bphx4DkqwqCIi3S+zCKH907kHF8jQXcY4Y/cwDcr02C03LxZZlAMgWv8NdbFXgG
	 ItEgOxBlJsE0VCGwuoLACxFxzx2aeEjH0WS8iq+dHx3OzDrzZw6fMoQcsLsCq1jaifbTm
	 IWhDd5EFTi6ruY/yLiHb9G9yUXfuKfiBVGd63T/d5tRT6wciBBq+8/+NkPYKwRuF4dsRV
	 Jq9uMjINscscx44oKvMWee+vwoEDuNCYFeajZ8i+/W/K0+ANdUiI4TIhkprGCkjEbF1HZ
	 yV9OY07sRrFf2rjkaDRQjtYyGeaXNK2caDN5vNM/YR6MMAVg+/8aKBJkAamIiu00xgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5KBUz5itfW2H0npvZHDcjaGSjYLfy+DCPcwOiE7R4cY=;
	b=A+8gvYOeA9bVwAWGrrhMh4cKbuz3Gwz1fYt1AGsSW/moZkkSBDIsE8fEDfBUBKqT5ghP
	 QTY1xQjAIgz98wogvoKEIqBAncmeFt11mPhEOIaP75HsUHzlTRlXVqywd+hRy3UHXJIA4
	 Hrpeg3Jj09nVbjLJHmb6hvrhCY9RiOq/mTWlJHleKg87AGOV+IrboaOFGhiPvoKU0YHCU
	 WAy1nFahA4Ly7olZLYIA2B0StMJcyvV8LOOWdpBU4goEgDJbR1ZqP1T7s6pdAtthww2PU
	 dQd0IQ8XJXTbjY4BZD0SD6ez9ZiBhHdL4wHx6ZaPg+NkDZnzfqOf+2XVPFs1W6Lmmbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D5xMsX5Q;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE6606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 06:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2DE6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D5xMsX5Q
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-89f639ba307so85301b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 22:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793945128; x=1794549928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5KBUz5itfW2H0npvZHDcjaGSjYLfy+DCPcwOiE7R4cY=;
        b=D5xMsX5Q5Y+ELb1XuZwb7AiDoSadX6UgEPUlS5WvNXHL33zjCUzQr0hbNSBgVmOF02
         98n9gc4/ACh89x4RlkfqkaT0D2rZhfnyFm0Y1roVjJxqiOyTB4aMKuQgn4ShRIB5qaiV
         ewksZawLdzpD+lSJvqtrRRmHByuk1RoJiHwmE0v4QmHHCxyZJwqbxkAZzSd5Qt/AZpP/
         XdPXYfVvaZwqmNMlNokEyFPVqEpUBHMqtcw2K6U3khlFwe1Ro01kR1nXeCiQHRbp2Abv
         s3UUNgbMO6YcxszmjLWASodBHsdSjrFx9K8qHetjhAwIn+DHdN4tfk8Dt99rUCzUPWAS
         Gemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793945128; x=1794549928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5KBUz5itfW2H0npvZHDcjaGSjYLfy+DCPcwOiE7R4cY=;
        b=h6HXqmSuoC66w3SmEJEUjQu/5UsqL5OjgHxoWR2s/UK5V5PJlLRdcbjZBybEk77W7H
         VmAGM7ChlHoP6HEWfZIc4OyurO/QkrKvgQqHSZraERkx80Eu/80IWomazrp2tioYGTnF
         jEOr/6+mZnvVWXk6KmEjPdCo2iNVbvobCbkpGPL54fE0ueXqAOhdwZOBvLqrep/ly38M
         vjORndo0MRBvDLURNHv7XMuCbnRLpGuCSnHHu2SM92wDcVBdO0346asY9j4sm8luHDiP
         hN8/BEX2Ejvo8bfyEr41Sln2Nztvu/dGajlAo/hd+31Tw/NvpynoVhCRyU6yhroJ3+ln
         pN9A==
X-Forwarded-Encrypted: i=1; AKwUvBxk8wp+OKYUM/P0OPbAIvCagNObf1WWaZfuZkEercMNeUSTjZa4EA3Ymx2Ctesma/J2uRst0OIETuVxYMVFkBQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/wspaD0T4ZsW6hGqLEV/ekHOx8oxG53zt2XB/TwO3W4CbwJoVy
	BrsfbHrsDI95JCahzEkponSKseZIgsg5bLV32ve/XhdDBHyG+ORlYN+v
X-Gm-Gg: AYBFou0voPFdK3PXoSjgWjy+hkG5qoOCh07W7QROuIpWBKBov5FcPnEVLCmvIGGOFUJ
	ROJTla3GNl+RFpwVHhA6c4WEdbrLF60/tACUVP+YslqTkBfMdIKP144OfpOQo2wXD99XjMdjLhi
	XHJKaQIOF+H0dIFcPCcop12OY5TDSLAlBAm9aAbhabVvTGyn5ubQrWRZZhm159AdDb8BPaRQvji
	OfBqfw2VvDSxEg7XePUvLD8AceRcYFDYo4RVtDRFkB1ZLXqHkd59a65gGP+P3ZfQOqJ857rUJa/
	4ipV7tKkBOLnkh4phs5vRpQF9ei7O+Vv2txg/DmPNJPPFMacpv5tVtVIfdG1bGakmFDhJCdLY6X
	wriKN3vHsve/WGAE5Tn9v8k5WoS8BzFQpbFnBr/N2MRH+JH9tB86QQx/y7IKnN/hNx4W8v+kqa4
	QU909oQvO8nYq9z+5irvvawcu+TPptQsFKJIfSgV84oQ7UbiBuSWpW5Pl40pSgjStGUs1u3yi+M
	LMcAYCuOFdne+x2w/mhGzPdHA+LLnAakiMz3zCQx4y0JGiGYMdRpIQWMXrdQna1fOzM7hx35lNl
	5bmbKSVr3q7+/Lsd8s7hMG1SMJ6+
X-Received: by 2002:a05:6a00:4211:b0:87c:e44e:5694 with SMTP id d2e1a72fcca58-8b37ae9cca3mr1380301b3a.21.1793945127925;
        Thu, 05 Nov 2026 22:05:27 -0800 (PST)
Received: from macbookair ([150.203.68.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b3597f0161sm306194b3a.26.2026.11.05.22.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:05:26 -0800 (PST)
Date: Fri, 6 Nov 2026 17:05:19 +1100
From: Myria Sarvay <myrialsarvay@gmail.com>
To: Andre Eikmeyer <dev@deq.rocks>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	sven@kernel.org, j@jannau.net, neal@gompa.dev,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Yossef Osman <Yossef.Osman@proton.me>,
	Aditya Garg <aditya.garg@linux.dev>
Subject: Re: [PATCH v2 1/2] Bluetooth: btbcm: raise ACL priority on Apple
 Broadcom controllers
Message-ID: <au1uH6uxtsw2vHfP@macbookair>
References: <20261105085750.120392-1-dev@deq.rocks>
 <20261105085750.120392-2-dev@deq.rocks>
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
In-Reply-To: <20261105085750.120392-2-dev@deq.rocks>

On Thu, Nov 05, 2026 at 09:57:49AM +0100, Andre Eikmeyer wrote:
> On the MacBookPro15,1 (BCM4364B0 over UART) A2DP audio drops out as
> soon as WLAN runs on 2.4 GHz with traffic. The host keeps the eight ACL
> buffers of the controller filled, but the controller holds single ACL
> packets for 160-200 ms, so the sink runs dry.
> 
> Sending the Broadcom vendor command 0xfc57 (HCI_BRCM_SET_ACL_PRIORITY,
> handle and priority, as used by the Android Broadcom vendor library) with
> priority high for the audio link stops the dropouts. Setting it back to
> normal brings them back right away. The BCM4377 of the MacBookAir9,1
> accepts the command as well.
> 
> Raise the priority for every BR/EDR ACL link once its Connection Complete
> event arrives. This covers audio as well as HID links. hci_bcm does this
> on Apple machines only, hci_bcm4377 always, since it only runs on Apple
> machines. The PCIe driver receives events in hard interrupt context, so
> the command is queued from a work item.
Hi Andre,

Just wanted to point it out, if you hadn't seen it before, that Sasha
has in the past sent a different patch [1] to run these priority
commands. They seem to take a different approach to when to enable/run
them. Wasn't sure if one was better or worse though.

Thanks,
Myria

[1]: https://lore.kernel.org/asahi/20260525-brcm-prio-v3-1-6259e10233f8@chaosmail.tech/
