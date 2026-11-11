Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390630;
	b=jI3vMp8w6dGLfw5JmYJVKuGTLY66uqRZaur73lqwBsBz0mxDXSyY59upa7pYK76wkhDU
	 B7vY+87JM/z0xtvyV8f8z9JVVZM6NpCLm7siGUwLBDPU+dY8ebsd+MI7OX4Kkj9hlPRw1
	 +/ba6hs5t9IytNTif9Xx6MXbYvt51ee/2dp7mTRDzzKfOjJNOkFtsyrD0l5xm6VPR9tuZ
	 XiHz2tM+f/qnvB4PND+FPsobSB7g/bPATGPU2bx6PwqGGCtJd3JPPLblvrFH3h6xpCj9y
	 hzkMoAArk6Y4whLbdzkkaN+IhXwTygvbR4C+0Cy02i3qcM+PJDitVcSUdCwujheWokA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390630;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eLu1xb+NMDTuiY/+RyWofsl80izFbG+riI3quVrTUhk=;
	b=421X3bl4N8+0fy9YznBSCO08Ug/M0P5AZuvqRPE/jXXzYkiKV6qUhp5tueEIWAhZvoVI
	 q4zokT8Es8uF9dHtL8Lh70cz5OfWueWK3y/SbUEz5lf8fcxRS48VgzFeIruz4IH/6oFLp
	 YIrITNez2FWWgH9j6ZuB4WmfD4XbpFP5OcDOWbj1RlmIrfnup1qV8m1AO3lwnzqSwSnK8
	 /YCzuu2sNqDhSjk9+FhFuDOiMM+sstZdnTry1H4IxTvBFuYMKp6NBoO7yGJXJiXiLNyze
	 y3q1iZtyGU4YJMUnLFwH3xGGGrhrlfoVmsBBNfh1eCATQ57EXopjpzEqNpdn1Nc1Tcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=NmOYxAAT;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAA606A324;
	Wed, 11 Nov 2026 09:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDAA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=NmOYxAAT
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id CC9EC20DCBFB;
	Wed, 11 Nov 2026 10:50:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id AC12F20D7CEE;
	Wed, 11 Nov 2026 10:50:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr AC12F20D7CEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794390628;
	bh=eLu1xb+NMDTuiY/+RyWofsl80izFbG+riI3quVrTUhk=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=NmOYxAATRQROalXzPOcW+uo9n+nMssOvmsRkXb0DAVG3l/l0deKnvWFOACnKun5VG
	 48J8nouprXrwEg1afhWvj/9D+eI20LY3aQmvTWNmruMmpkozUBvDamHHra9VtgSVoJ
	 Z+IKjNMmcbGLDdNvpe/uvkrz8jEbm/y0yeCVwLBuq7ovTQ/oOWk6mui6WSO8YE10Qt
	 PsNiEe21xUaobr0BRokPdcuPsNKgXW5ULRVE0w84Bjj/dgyUjHIQuwXlzJhpAYnHJw
	 jyZeN5EWurSkn9nHLb5SJ/8rKTTV32s5DQmViMYK5+9MuxZfMlz0WJbATC/e4+PspZ
	 6YVCKjtIUDOpQ==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id le9kw9Hd74oC; Wed, 11 Nov 2026 10:50:28 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 932AA20DCBFB;
	Wed, 11 Nov 2026 10:50:27 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: enable Bluetooth on BPI-F3
Date: Wed, 11 Nov 2026 10:50:01 +0100
Message-ID: <20261111095001.444031-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <DMRED3CXA5IJ.3FLQ7UFUTN0R9@linux.spacemit.com>
References: <20261110074607.363918-3-frederic.mahe@cirad.fr> <DMRED3CXA5IJ.3FLQ7UFUTN0R9@linux.spacemit.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 08:44:36AM +0000, Troy Mitchell wrote:
> Please add CLK_SLOW_UART2 to assigned-clocks and set it explicitly:
>
> 	assigned-clock-rates =3D <0>, <48000000>;

Thanks, done in v2:
https://lore.kernel.org/r/20261111094557.443481-1-frederic.mahe@cirad.fr

I checked that the rate is really applied: with 24 MHz in the DT,
slow_uart2 runs at 24 MHz; with 48 MHz, Bluetooth works as before.

Fr=C3=A9d=C3=A9ric
