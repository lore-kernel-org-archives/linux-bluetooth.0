Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950427;
	b=0VGJgOHE7avaM7PxT1eetkwRllRBeKp1bHn1d9ozSK58yp/30TPfA7ObHlOXbUJdoiTA
	 /jo3qc3cJjunEZiQ16EshP3UPUaWu1W/MRG3zv53SWvpuDTtLbdQxrH/KR/RhMWF7CQxi
	 71TDu0QPF7TuFKPBcI3uebsdgfaJvEXt/lwkq14heoGQmuB66hLl29mN2OT3UidRKMF6k
	 9kjsMWZZPMwWFR73w5eC4oxfRpxG5kBuGeMt8vyOlKPiHzkR7M4zkYITWT0f0QXowWdxp
	 oc3s3SBt4y7aHfblf15FX4RsL7tYao6lQgoWXAo2ikQcD+PjxAJl9KJSKrysLZl8GXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950427;
	h=DMARC-Filter:Date:X-Lima-ML-UUID:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=rKxzvGAlPRe95V0pVMlRztyt1v5h62ch9oQN2DY4Clc=;
	b=YMmhkC4gkX2CVzQ6ZPxlVbk7Kiv+2J3ZpBVjyallU02u8hUADT05Fiz3vQO5Gj73tp2Q
	 jpLjwBhNywsvk2cEzHRdJrQS2FKYrOSF/m1K9ih4Uec3A4WrYNhkriuSPaKKWPPoFwHBm
	 6jmsqgKI1yZP01m8Az/DylPi7AKBu4zF57lDxouUB0bwi9w+9gOM+hJxAk8NdhrM6INYT
	 3SCfqXctfa5r4kCK09FTGkWlql9XDUySm+crBp4ZYw2bKQM7I6df2z0BH5CBbww6pGFne
	 9zdgTPu4hKjgjJ2BXfkpz3x23vF5DNbF2YCSZncMRXODLWLgBGNLe6Caa6OV1yq851w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=r3862YK+;
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E8606A328;
	Fri,  6 Nov 2026 07:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F7E8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=r3862YK+
Date: Fri, 6 Nov 2026 08:33:39 +0100
X-Lima-ML-UUID: efbc4d95-1bba-426c-9435-09581e33fd37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1793950424;
	bh=rKxzvGAlPRe95V0pVMlRztyt1v5h62ch9oQN2DY4Clc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r3862YK+9lpiv6qXkmsupUVvoPmKKTuMSkwmoXBtEt1J2UDdsTGZQxuZaWt7uV1Z6
	 aVB3DRULdeJM38mX2EwLQ4byQeH3TFmfP4nVeTiduKUE2ty+lAw1MG2XPWjgduG55v
	 c2izJpRl2HNikrx/vcy6cU1U3ApgLRU5fUxW+FVFsf9kEvMG5xyDtP9n6UlzzXbt9b
	 ygBAx8VYgcCEBKBs5OwV51TyDPv+haXs0MzCeyu7afPXUc7njU+bZxE5ond6DiVxO9
	 0nm5Ef2v4Qry4tTJ5GfxccylX5PaZJceG7Uawu266B74Ln0S/aHn4nPae3u8hhhrnj
	 V07HqlsjLQ3CA==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Myria Sarvay <myrialsarvay@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 sven@kernel.org, j@jannau.net, neal@gompa.dev, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Yossef Osman
 <Yossef.Osman@proton.me>, Aditya Garg <aditya.garg@linux.dev>
Subject: Re: [PATCH v2 1/2] Bluetooth: btbcm: raise ACL priority on Apple
 Broadcom controllers
Message-ID: <20261106083339.677cc75d@kait2en-mbp15-1>
In-Reply-To: <au1uH6uxtsw2vHfP@macbookair>
References: <20261105085750.120392-1-dev@deq.rocks>
	<20261105085750.120392-2-dev@deq.rocks>
	<au1uH6uxtsw2vHfP@macbookair>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 17:05:19 +1100
Myria Sarvay <myrialsarvay@gmail.com> wrote:

> Just wanted to point it out, if you hadn't seen it before, that Sasha
> has in the past sent a different patch [1] to run these priority
> commands. They seem to take a different approach to when to enable/run
> them. Wasn't sure if one was better or worse though.

Hi Myria,

thanks, indeed I hadn't seen it. Sasha's approach is the better one
IMO, it only raises the links that carry audio. The dropouts I measured
are on the BCM4364 of the MacBookPro15,1 and 16,x behind hci_bcm, which
only needs hci_set_brcm_capable() on Apple machines on top of Sasha's
patch.

Luiz, let me tinker. I'll drop 1/2 and send the hci_bcm part on top of
Sasha's patch once I've tested. Then we should have it nice and
consistent.

Andre
