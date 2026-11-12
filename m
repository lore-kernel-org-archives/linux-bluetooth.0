Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473826;
	b=PJbaxM5yzC/oxK8+WXLlMe9EO1e3mQnVgC90r4C+xV+WSKksQr5U8iCdVrCon8KW2mWe
	 CWT8ZqoSLtfkPsp+CvFF8s6a7zqpGSYv3t0IwdofVDDK6ng3O1eNwgopDvEJSC5JyeI4C
	 8V2PPhE6GJSqPqEJmFIH8W3/9RyyMwRkwMcFWwhvF0zgqAY8M19uJhQsY6/v9ojeKvjAY
	 XbrQzPIuHHoFgK8cGt2+tPij72QHJFSFEZraQPenQfIbOCeKqMGoMSEMhKuk8QfFvFQeP
	 osCoX+7R+aty1uKy4D4vzYVLx/UiSyX4uPmxMGax/FOz2hny6XBJBwKoOOYWf6GHNiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473826;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bLsxGg+UbntTm846AKMWGYVEPT6bUdBmF4X/znMO0vM=;
	b=Z22s1RA6deqBsyMOBjMMC6QcjjOrVvxLBk/C4V2M+7nNeVjbJnBd4IZXWyL42KcKCZzT
	 ziCYX5UitWG1X1RZTBjaHpXefXiNYBY8E75Bu1ymiBjMOwCjCuzeLcpTWS5gMvgNqdmIZ
	 sbZkxb+WQMnprTrMH3Y6hhMokAzmBLpzDcpXCiE1qZRlAFLJaQUQfbE+fin9yPCehGjrv
	 hELEc8LNrQOe14fSHS8yCg8o7a4aMaL5YRLaICzboIl7sFSb/gcIW2tTnnkRSTPAKL1du
	 YOkzpVKipET2dbQ/D5K0kPQMf4dSy3lf+7my3XRvJi4GgpYCQavZe8vtV+1r11PC2FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=VqupciBa;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D97606A333;
	Thu, 12 Nov 2026 08:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76D97606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=VqupciBa
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 4555620D4DD5;
	Thu, 12 Nov 2026 09:57:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 1A9E320D4C14;
	Thu, 12 Nov 2026 09:57:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 1A9E320D4C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794473823;
	bh=bLsxGg+UbntTm846AKMWGYVEPT6bUdBmF4X/znMO0vM=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=VqupciBabbvQh99o8OZqmQSPXRix8ZKYFXfNMY0VarwGMbfP2D/ZWloFmC6E3rKkV
	 lknk3uOyr+ausKBTikuzhXfo51yCLtRpXeEs+etL3HeSrA5WcD+qmP5x+uvBmTEuAY
	 nJiVfSeGcCDRPsN+QQkDdSmpNe1S0ZdKkOaBEn/WB4o0qSRQHZTYMN2N2ZD0ZKbe1/
	 wDfeUlHFwKRwzPxqTlWHHJxkqOiibunX5MPBqKLXdswzKQRblES5yQm/Jj0qyH+x47
	 r1oNlfEhTo09KekvYeJI4hBQJQ4HNEEDw6Bi6G61gTHSqU5rfTRd14GNWwQdUCBsto
	 6Ts21iaM1hfjw==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id oDmgEuZsXvji; Thu, 12 Nov 2026 09:57:03 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id E74D620D4DD5;
	Thu, 12 Nov 2026 09:57:01 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: Yixun Lan <dlan@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	anarsoul@gmail.com,
	alistair@alistair23.me,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Bluetooth for the RTL8852BS on BPI-F3
Date: Thu, 12 Nov 2026 09:56:17 +0100
Message-ID: <20261112085617.516945-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112061951-GKA62271@kernel.org>
References: <20261111094557.443481-1-frederic.mahe@cirad.fr> <179442601916.1604530.1705197925952408060.git-patchwork-notify@kernel.org> <DMSUPKS0VL8N.1RUUESQVU8FMF@linux.spacemit.com> <20261112061951-GKA62271@kernel.org>
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

Hi Luiz, Yixun,

Sorry, I should have said in the cover letter which tree each patch
was meant for.

The split is fine with me: binding in bluetooth-next, DTS through
Yixun's tree. I can resend patch 2/2 on its own, rebased on the
SpacemiT tree, if that helps.

Thanks,
Fr=C3=A9d=C3=A9ric
