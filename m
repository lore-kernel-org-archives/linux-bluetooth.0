Received: from mail.discnull.de (mail.discnull.de [46.224.56.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD84C0426
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.224.56.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790276249; cv=none; b=YK06sdO1ce3vUS1znkCruhjuYo68T9oDXRwBGbyMBASWjcyboqIFZUPScLVdT1J8HKV094XMzfZb6qABFJ1vuz2LsJkjrp26iC1ud5fbyJcKKKflIYfuL9/9nXa0KQb0/Q+tfWvAUUhmgNhYT2yErCY9MuBsWUBr+ZWH8x2jACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790276249; c=relaxed/simple;
	bh=ZTBCDpvvM8go96yw0ipbSR29F5obp/EEJEc5OXOyBbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JANMlvIJCIwhhBb+NbKW1c5RPLJ6nIW8X5hec6NaWSgGuJlBrvwfO8b6i9tq4GjJW3UJ3gqkkMCZ8fQ74G2CU35yM2peradvauAJoOv2m2/Pa0HwI8T+SGKimmwUtxPBlfCzO+PLvUvpLT0GBRwDSPCX9QPb/eNmP5Q50+mHWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de; spf=pass smtp.mailfrom=discnull.de; dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b=U0P2Ka3E; arc=none smtp.client-ip=46.224.56.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=discnull.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b="U0P2Ka3E"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CADB27D45D;
	Thu, 24 Sep 2026 20:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=discnull.de; s=dkim;
	t=1790276243; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZTBCDpvvM8go96yw0ipbSR29F5obp/EEJEc5OXOyBbE=;
	b=U0P2Ka3EQIG8G+mtXFM4LRcNl+MOBdXm7vhNZUvOrNR+9SRBCtDF2e/oz/jMZXQRaacII/
	Bgp0p5vNIsROiPO5irEC3DRF0D7BES79N2J60UGjuk1g5iuC9pUYNOatPZw30FsY8oHf9H
	c3MJmOXz/VH0LZXmdi64Nu9joRLNnntPjdRDkcmx7fEBtikJtDqHLsdIEiGfXTz/DSCt4M
	bEdKaMeSWIzQPCW0qbyTgM6IAepNm2Bjk3DAmv7p11L+dpMCnShIvHY7qFZV9Ca3H8n9nA
	m5Vz+d1eC0ZuYndA+ZFp2116PnsxdWJql0V+MrgiNRTGUBc4SaEYIJntOq6sXA==
Date: Thu, 24 Sep 2026 20:57:20 +0200
From: Alexander Sarmanow <as@discnull.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/2] org.bluez.LEAdvertisement: Add broadcast name
 support
Message-ID: <arVykKJmqbhL0pEo@machine>
References: <20260924151720.1769259-1-as@discnull.de>
 <CABBYNZJhvRubX7w7Wj6cKMPvSUFr-GsnqYBYJp66sWGW153Y6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJhvRubX7w7Wj6cKMPvSUFr-GsnqYBYJp66sWGW153Y6w@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Luiz,

thank you for your quick reply.

> This is already supported on bluetoothctl; see:

I was aware of the blutoothctl implementation, but my motiviation came
from pipewire where to my knowledge no such mechanism is existing yet
and thought it would be nice to shift it to bluetoothd. However I
understand your perspective of what's the role of the client!

> Now it doesn't seem to have the string limits you pointed out, so
> perhaps it is worth extending it. We could, in theory move the
> detection of the PBP uuid to bluetoothd

I will take a look on both the extension of the string limits and moving
the PBP UUID detection to the daemon.

Thanks for your time.

Best,
Alexander
