Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515620;
	b=IXn7f6oT1GX6WNVBqfZELPfjWU6BH92pcbqGfpmlrMnCTlZI7HAjbptlruz+QtryK5d5
	 03ylLPoSEJHQTQizyChBVwZjW/50Zsh6G6+p9QJZpJMn5KZMYarE6x3H4aTT6NfdZmIP0
	 pUHZdFmFSrpVlmxEGrVuolp9YrIPAfQEIZ1YS53FfPHoe0yzsMjn5jitAqCOOXpUfH4tV
	 US4gm/7EYOLrhTC3ELiJ8ByQ8wPjiAF7WfEEinAiqexvUwau3TvXESdClqyZFQtuZTbpW
	 5pQuW+ZYaCb0BuTwbRNGsyDiQUqO1FgwIXLt6C8qeRPV8QGCWuqYM0sVaR4AvaGSVsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
	b=qYv0R04eP6vXBwhId3XZfxsS5AreVihOWsnPh7gYdQTKHvs30quoq0hE9djuVoLjKZZK
	 neQHSs6Ak1uwIFXWBx6+KnIHaUr7cgFqXyAfjRbHe6PL11BeXFwmss8RobakQ1Tku2WwB
	 PGxB95phRK2XTp3v8NS8TJi7qAZBPg1WIZn/PXa5E2DG17w1pwLBYu2hyYqDCkbxz6xdp
	 fSjj53bmwZ8dGc5mYGZxIczkjygstPfiDK2mapqH6B20uzkQGtLlGS7fvbuqdt4PgnICc
	 HUdTVuPNoZr/y/93IDFDBwaeAwk+AKlwFllaRJSo2tZvUZzrBwFBSJJn5txrzrTSMrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CdVhJeQW;
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993C606A880
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D993C606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CdVhJeQW
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2dc9a7b52so155633137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515619; x=1795120419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=CdVhJeQWGoylRhVH1pAx8Y+BD9aYampuk/Zj5LTTe7RJk3M0XqfcS3mwtOs9ZhIAF6
         OsJz4LxuQFlCp+B4f2wkgVnnfYaF978boDa27R7HiYt5uaUva/ZxfMvRFNzvF7xZuVcQ
         +B+5qsbOtYPsSsdOPBMnRLOHBo6rlKCRW6ozHxIcRdOLrR9SKfNgQroCAGcq7NRecxzK
         PKTThRYeX9fS6ltEAOjgf6sx0TLyY/pPW6rIzWG3D4laUHg+ndtKHt1bRGxgKlegflEy
         qzXDx6O+2QoEIDvOTA4TP+tS/5cssxF+UOoi0ocHnxlocLlcMHrRmc5ReiOTuiicvdJQ
         KJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515619; x=1795120419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=1MC46PziVV5iC1GBu1p9LXwFr3/3dyLWgEPBds6EBgLdT5cRs52/0EoftMWrbVgs/b
         eaYQrXeWz0d0HOGak4VDNGNXmKwYpyOa1LlsY95EpUmlgfBMDShgACqiPbGZ3z16CAl1
         Ih5TgZAEwwFNYQg701Ga9aWmK20aIYcvyjS+hCW1TUOAYD1hvvsMRG0LuiIAulpEnkEd
         nuL9OfMKniZ1XioZ/V7SeLxElymfDGLrGDdsVZJs92VJoswV98kGtu50aVO6lAtDceTQ
         1WsU19WO9GnWV6Whnf7l4So+SiBqfwdGJ/bV869fSN3cyMWQZPUf6axqgZD17adnj0DM
         cP6w==
X-Gm-Message-State: APuU4Z9OI1s7o3SujFrxOqv8K8FrfmYF3CXd+Fgmjz0h8k57/ZbEp03y
	I6mwM4kKl0xejhqha0cY75Mo+pGHAdtV+nzMpcnNr5mXZe7dWv6HnINXOQf0PQ==
X-Gm-Gg: AYBFou1UBPWM8Y6PQI5ByuGup8WudPVHJL6KXL8K3EvfzDmPV7mQzEyMh8IkEpks0V0
	WQgEPNOyvdtifZhGEx9RMJegk4Oivk3g8P53uFS2U0BiI3PuD1W+CiXzc6vTo5QyPVVwPpyVEdO
	RGnN5Rd0tCU4hbsczEMTXKfrB55HHsiLXTaOh/NDwSDrWlgOcI5u0llFA3Bt4/IF3r2JtGGUGwy
	7ewTPPupqVqjsPxEKsmAqDTJQRJfpkl/mWVLLbyx7kQ5zxTxr2YSi3Yo/62TRoRPys+V6siVqVp
	oEq+5NHDFlvyNTpU/C9sN/V/obOww475ci014x1XIkZfGnp1msuCnKt5nt1flFTXjc/kaLW3h9j
	LchYkg+l7ViTZg6093J4NJZdsCo1a0FdQdtdVWiCsPol4L4ml8KLwL8Kyf1uIw8HZwy66WnPiWq
	/tZLfgYsby+3fOZrdAI9ju+/cQbS92w5Jnx5tZGBTtc8oJUxEM+TkTg61Us2Ao1Wa4KA0Z4orlQ
	dixouNucX7hM3sxM7JF6LwVq8ZQgQIqQeouDvzYu5hhNhHDVv7TfLZbTiv2LrWRFISrE92m8TSq
	DeHEjyVZJdFLLsFbdxSiPLZPJ51PJ379pRc8pWVrYs1fRScHLY48SLfSROPi/m2dvolFTSWr4lh
	Ny3UM2JUlc2BSQ+rlJY1PJ7h3qee7X0E3UVcbGK0pSWsBzwn15ml0l7bK7yb2pRYiSAaDw1jOK3
	RpTdFM
X-Received: by 2002:a05:6102:605c:b0:7c3:c0b9:8d50 with SMTP id ada2fe7eead31-7d64d80d28bmr123383137.21.1794515618903;
        Thu, 12 Nov 2026 12:33:38 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm346627241.10.2026.11.12.12.33.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:33:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/6] doc/functional-bap: Document clearing a cached configuration
Date: Thu, 12 Nov 2026 15:33:31 -0500
Message-ID: <56433b054a2afd8eb992e7fd02541b97d1752208.1794515475.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515475.git.luiz.von.dentz@intel.com>
References: <cover.1794515475.git.luiz.von.dentz@intel.com>
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

Describe the test where the initiator clears an endpoint twice, the
second time releasing the ASE whose codec configuration the acceptor
cached.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index fc367e0f9181..eb04e6520aa8 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -230,6 +230,30 @@ test_bap_unicast_desync
 	single ASE of a CIS, so a failure of that one can be told apart
 	from a failure of the initiator to enable the ASEs separately.
 
+test_bap_unicast_clear_cached
+-----------------------------
+
+:Setup: As above, with both transports created.
+
+:Steps:
+	1. Initiator: ``endpoint.clear <remote PAC Source endpoint>``.
+	2. Initiator: ``endpoint.clear <remote PAC Source endpoint>`` again.
+
+:Expected:
+	1. ``Configuration cleared``, and the initiator removes the transport
+	   of the Source ASE, which the acceptor moves to Codec Configured,
+	   caching its codec configuration.
+	2. ``Configuration cleared``, and the initiator releases the Source
+	   ASE again from Codec Configured, so the acceptor moves it to Idle
+	   and removes its transport. The Sink ASE transports are left in
+	   ``State: idle``.
+
+:Notes: Releasing an ASE in the Codec Configured state is permitted
+	(ASCS Table 3.2, BAP 5.6.6) and is covered by BAP/UCL/SCC/BV-106-C
+	and BV-107-C. Without it, an initiator could not get rid of the
+	codec configuration an acceptor cached, as it no longer has a
+	transport for it.
+
 test_bap_unicast_duplex_enable_one
 ----------------------------------
 
-- 
2.56.0

