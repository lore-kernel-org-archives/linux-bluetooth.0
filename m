Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620148;
	b=I202T+IeJ3zXNaxQN1Ks0WMPN8ia76U26hU3+3fGH5dGSaFGank6Oal1+gYDU8b/2ulG
	 3AfwWQ0vIFrAPokvnnyZHKE0DlTTtvCBnNK1Y2N9dG3WX2/FCwOSUezDMKbpOF3syKnjg
	 YxdJSdvjpK0HTpQaGnicZiVlRzqrAaLwWL4cQy+c1HfWKorvS76R7auQU2+5bbTwqmbQB
	 ZmwwNZ89Z+XUwdqKF5ApF1UhSE56ryvjY0WPNT1t4c3D4o7XPzcjPOf03sd9DpcI22DaS
	 Iee8r/5JRMgLtZ4zQvMaX9MdBF/kxBFnlYCKiE9G3ysGkWo5k9cMT31RlZ0us7rRhRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZOVH7GPrhhsO60hstl6R1o81Xncu0EyH/gOszIASMlQ=;
	b=RDvtQfk877hYruiZuLNYKTE5DOMgn8TrbUfvBau2DxRPPDsUahzbqausvKuiu3nBO5zR
	 kTkYU8kOWsmMqhb2qojz7bbHC7h3N8lW6Ev4pCIaW++gOOLn+szBWXVKZ1hlox7WWWoIR
	 DRw1h1Rqo+qqbVjGzEB5VSLNAs1VpCO03Nz1CAYsImYZL6jYWW88W6pmlb+Y8G7UJiEeI
	 7HCPpYT7fRJf/qjpCJl7Acf5yjEzq9Rk2b8R/Y7uVVIqd09AWI/BTd9yoL2UGQSqIQyZh
	 SOmbalJYyeEuFTcuGnMj0vY8tDNNwvtCBKHovmsKuNlyCBbeMZnIuwLacdZ/8AGiBqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPmkv8Pe;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE0606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8BE0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jPmkv8Pe
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so2678121b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 07:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795620147; x=1796224947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZOVH7GPrhhsO60hstl6R1o81Xncu0EyH/gOszIASMlQ=;
        b=jPmkv8PesLa4C6zoxhIKZOfN+riZ7aay+ijRUaAeWqiffleQuxgF/xyzsGymgLXQ2K
         c2EIOTlZARL2nWO4NDlS5KFLUVw+8/R7GZ/99j8y/7nkSm3U6D60u3omHxRTyvqLImXg
         JPQJjTY71Ss1hSVM7QAe9o7JPiDdmK3mXaGjuyAfvk3Quvf5oAarmN/IvIovCNY728Jw
         f6dvv27kIOTWl/E293jgTa6mkda13TdnSLRd1mG97MZYZDzpox0CNTCoTcCW6aSG95kt
         yAyQ5Tg/CfVRuTFBT5wrGq5LQgvLFvaqQmpgr8lcIK1Rp0r4Pz06lluw6RYeoV9ApWO7
         q6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620147; x=1796224947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZOVH7GPrhhsO60hstl6R1o81Xncu0EyH/gOszIASMlQ=;
        b=yFb6SlWsH90R+OiH1uFqnjN4nf9uFrx8XKSCMRjN7rGGTVoBLBd89M/YO87pQHVRr5
         VaG5vNUPlNRtBsZtHU995WfTqHflIa0mnWc0+uT0h4+zH3PVVKYNF/WBqto0/PtFPhIZ
         pkZFCqsAJGE4Ig2nfldMH41sBvTLga/qTyYwzgRrd6v8ZcGHxm3TgzZHS7ZGaMquUjB/
         p5ja+AxMzYzF8ZxdiSZ3/bNuXTP4x93xAOqxg3BsDQvlvRnSrQrkz3BomEdDUeamyCk6
         E8ODlJo1pdflHnNSyoALISPDjCDVypC9vIU1IjDJvs7MEcB5/njmin7JY7zP+AAegmCK
         vYWw==
X-Gm-Message-State: APuU4Z/xstJpPyERXwABV35m0LSqY5HHiAX6pR3JQ2s7DjtTSHF3tTDw
	mnApu0Sl5EMv6RXpqwjJ3b3sggbgmdG0+xxGoH/HGzxV9riKH9AtB9qv
X-Gm-Gg: AZFdTZfL5d8wkYQU6ZEZJJB9mM/MF8LWjS6cxU5cd/OzaeON7TjxPQ6WnmkEFssE3d/
	do4wzMbAQgUSgwmFfxwvUbD59rFTNz/6Z2lEYtji10PW64HL9oAGEkpo7iRbYBjErXhdwpnVF6L
	r6WNAq6VvsJZRLh9hYpMpQAG1YVCedja56IZMVf4MnWTL0BZMBAVosfd4f5zf+S4u9+4olRwoZs
	JhiAMFWvDI1Lr2F5KbAtL8NNjlG4a+qTt4VEPVZ/OjHNsAjEY4fgJFXKwoiX+xUJ1CcvbPFP1xw
	C8lefzfyP4tEXxOvwWMY4cjDLBEeriSbMNHqZxxNDh35rLpCy6Fw4CxO8kG0mewQOU9dYVwMbz/
	VLK86xSWRE9Su+H4F6o8ICFvaW4CK/FF1pvQCNr0on9Px1Ih07A9NV5bzi48sI0KemTTigT3T6c
	YjP066b3NrzWy3EagcZfp5b0vxiTHVg4wRtRLSPnq3s8zEu3Aybw9NRI8PQ1Ukg+dElEyFVwhX1
	HryW3/+H5m9/c/EfKAtX7S0wfRrTmmttWzxafYjhzOIFnIBCr9+Z2YoLjub1ifpu1vfT6XDI0nJ
	BUWcUOJFpu4gkXY6qP5GyWes
X-Received: by 2002:a05:6a00:348f:b0:88d:3f61:20e9 with SMTP id d2e1a72fcca58-8c87d124ee2mr13760222b3a.48.1795620146973;
        Wed, 25 Nov 2026 07:22:26 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077a058sm9221775b3a.8.2026.11.25.07.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:22:26 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/2] Bluetooth: RFCOMM: Fix listener shutdown and TTY setup
Date: Wed, 25 Nov 2026 23:22:16 +0800
Message-Id: <pm-bluetooth-objects-candidate-0218-followup-v2-88edfec8c72ed860e626-0@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found that an RFCOMM socket can still start listening after
shutdown, allowing release to skip accept queue cleanup. Reject
listen after shutdown.

The review also found that failed TTY registration can leave a
transferred DLC open. Close the DLC before dropping the port
references and purge pending input when the port is destroyed. Use
the existing RFCOMM_CONNINFO locking to avoid waiting for the socket
lock while holding global locks during handoff.

Cen Zhang (2):
  Bluetooth: RFCOMM: Reject listen after socket shutdown
  Bluetooth: RFCOMM: Close DLC on TTY registration failure

 net/bluetooth/rfcomm/sock.c |  2 +-
 net/bluetooth/rfcomm/tty.c  | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)


base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00

---
