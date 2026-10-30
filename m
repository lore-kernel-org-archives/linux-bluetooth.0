Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395787;
	b=YfDCpoSFbmaVd9J79Eo5EmSlipCOWdNM/caT2CmysXEy4err1+bWOuZMLvC09R4Wz8Rl
	 0etHCqH23kbBWgOOQ4xGCee89NxAVtIPkzLHCUBibp2F0G+qe4D6VFJOuSgGwkEMOmmeu
	 D7joXPVgA54CEfRqlN5cpo40GU0IYtWDEfVEohWJPZH4Hx1CRRtNwFbXU9Ws6soVlc2zV
	 JBTwikDKV6hes+nmKn+9YqLS6iib+bdinGfiios8IYzk5zWsL4T0CU1tBPRX/ozf3DBWR
	 Q2FmYLUhEvwoA9A50vtXlVoPDubGERRaEiVLKdSQSVCHY5sZD8MOQCgGFz0dKfAWrWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4pydwJ8BgHpdFFbobeYtNs6z0iVyjlp5s92h+AjMva4=;
	b=UE5gond1NHg34e4IWa4+JN8/sVzzDqB+UOSPg6kq/DrdaEg23pAOltSiDTVzrw7HXRpa
	 8SwIpuF9DRSMJbX/GmYvUG5Fxdup0wyg3auvDbSyJU7rk93y5MyFCQmE58IXXYhFmInrc
	 f4pPj6vsDo2FgTno2PjXouGLzmA5RcquZNCGDm0Ugm9g09QWDpTCiEo++qLQKDikgDwnc
	 jZVUa0vW/ziUbA0Bhi5ga42Y3xbYISyVTKcyfY1c4X/3ZwLkPrITs+6k2rL8iVlI/hmHj
	 WyqBbWAqs97VbgBDtmbuxCuzKJ6Qz3Sac8amMPqSFDkCs6o6iN/ZEcVXvrO1ln9kEYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4UnzCmF;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F79E606A327
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F79E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j4UnzCmF
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7ce6cb4c6faso687308137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395786; x=1794000586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4pydwJ8BgHpdFFbobeYtNs6z0iVyjlp5s92h+AjMva4=;
        b=j4UnzCmFv8IPm7CSrdvc4EcJQAt5j6BQAgTQp1UeNGkZb7ReQdv58PIYfvPMTjw25/
         FM8SVBH/56iwdVzMy0h73y3CPwLpfT0U7l/iUTbCl9jZmz9pYuYZ2H7o0Tb0Faq87mBP
         +N14Mw7IBZedbOqFQTO6bxrVu1zI4WMUcwmUgTHOktLuawJaLEerqF9vTpmJFOzqjykH
         dmuKC055SYT1n2t8fsKhVjoKwQNc0XEEF0HrRSPIDimVsgsYxAJjjCBpNxMbYqYamZe+
         +U5D/fZjxlr0Raw6FqKe15Z3ArRGzCZhOBhNvMtzhgUtowMZeKUyNwccHirr0eyjw8sW
         7jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395786; x=1794000586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4pydwJ8BgHpdFFbobeYtNs6z0iVyjlp5s92h+AjMva4=;
        b=LoA4/8U9t+4jBwQaHUC48YM7j3yhP3vTKWMvXx1VFcYDfnWzNJ2M8RLDVAKU7ptoyK
         Vl/qVbCnDmQ0el1cdqBcAV32p0tuh6y8dkCYMoRXT9kL5L5SAnXlqJu+zckf8HVTjsmd
         E9hAxCYyW637/WOETZLt4PvqYaSMjL3vrx4NPJi5TO3GU4e3SV93KhNR/W85cuAZ5XfY
         u0OL5DTbFBZrHegVpT241cla9w7GpD7QJwD2dlKSnOOSqBKOIYN9hlzc63uWr0SPR1xj
         dd3N0GEsC5j2/tPzXBaMSn/nR5DjQuJlHL2aVhcNHBVMEJb7qb6gHWrbOitfcTbMo3f5
         Lygw==
X-Gm-Message-State: AFq9FYJEQmh2LnqeOLcuypDiVROgRLOwH55ZxNENH7AhpXhP4ztIAiXY
	Q+gJwBTJn3PwKKtyyXOKSTKY6Lh6LwsoMqldge+YVN+1n+4D7PlT6zPC0/5Rcw==
X-Gm-Gg: AYBFou2fbcM/BOmhnbU68rfJgvBpg17cpwJVHlfhUrlJrpt/b+1QdxOkb/E1pGAbDCL
	PQ53150jf5JfVKRUPN+Tehnq8WBp7Y7iGHjnsmItROfK80FNe1xpSKlNp8vlB6pUdYer3pudYtV
	2usfnxqfdyKGoufNcqLV31P0ToaL13WciWNH9JLVRWIFJ0ymUEXMwPw0di9QRyHf5e6pooUYxZd
	kovq9NUxyCifGnbMUG4HjI4gJi5+6StUgobb69vp49xw5oiKviiTjiAPQYWlTCXtO0HawCC3wfz
	RY8tquu3JUU5lej+UYceORnMzXqRSt0esNok3wAVnsScvgg2UbEt4TexSkVwWM3k+xO/xtuk2yd
	T0ickH2o8vgA8bfTDuWGuMp/UN/RoVSOPqWaeSD8ET86HEyZy11LviDVWo809PmDo5XMVjYCd1F
	MdcGAyO5qq3w+1Q1ID8Lj76NFLLbs0tkw3y+UORhehQzwLOeU1aM8lBnPdq2916KsvAr4gQfJ08
	rBn8NM6gzFD6D1uCCuSYMlMNl9+QhHj1u1cNcPYgU+/xb2gVOt8kTxtmCXHL00ADXv0jmr57Hl2
	9ZPTLrU+MjhvQK7UOj/tXYZ51PxJM8swGD/9Hfyoy/B6WIXGk5FIhBfcA4n4wTUyAzPKQMnLizV
	JjfvHzGj2Fhwd6G5sJJSGMHVP9w46Qs6LiycIgk+6YLyuAhSPV+IL4YhqFTk859BM8oF6rUxr7H
	41A88=
X-Received: by 2002:a05:6102:5126:b0:7cc:22f0:830a with SMTP id ada2fe7eead31-7d07262fa72mr1936693137.8.1793395786294;
        Fri, 30 Oct 2026 14:29:46 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/10] emulator: Answer the time of a guest with a skew
Date: Fri, 30 Oct 2026 17:29:32 -0400
Message-ID: <20261030212940.753771-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With a skew, the current time of the calendar may be ahead of a guest,
so answering it as the time of an interrupt moves the guest past the
events it requested, which then run in its past and make it panic as
time goes backwards.

Answer the time of the guest itself instead.

Fixes: d7ef45305b15 ("emulator: Add time travel calendar to btvirt")
Assisted-by: Claude:claude-opus-5-5
---
 emulator/timetravel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/emulator/timetravel.c b/emulator/timetravel.c
index c1938ed23bdc..be70acd3c10d 100644
--- a/emulator/timetravel.c
+++ b/emulator/timetravel.c
@@ -461,8 +461,14 @@ static void handle_msg(struct tt_client *client, struct tt_msg *msg)
 		break;
 	case TT_GET:
 		/* The guest takes it as the time of an interrupt: the current
-		 * time, which no guest is ahead of.
+		 * time, which no guest is ahead of in lock-step. With a skew,
+		 * other guests may be ahead of this one, which must stay at
+		 * its own time to run the events it requested.
 		 */
+		if (tt.skew) {
+			send_msg(client, TT_ACK, msg->seq, client->time);
+			return;
+		}
 		client->time = MAX(client->time, tt.now);
 		send_msg(client, TT_ACK, msg->seq, client->time);
 		return;
-- 
2.56.0

