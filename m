Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429469;
	b=QIrqs4MoGBeVv+i8ZeEn+4gatpfy0px8D2SrmsX+1s1/evYZbpDhNXzsr6nfxPvpCO5p
	 iYm5OTctgMKK+fL7SIUu8At3ViSkayrd1sgBVVDLrHEdxBREz9BytrSEPJm/J0LPvNpcy
	 RSyPlTp2AFMw3WeaZ2nWXeX5n/NR0swezjV7b8kZVBE2nyCUIHEYp0dzCofQz7JQt8/Dq
	 imYJZHfMT3bHV742Ob/qNp0kVzLQEws1tR0jKqg2BnkRDOPfxBn0Jd+swW6nXINyxEaLz
	 UxvSB66OXzBl3Y3mBiQ7mJhtLmixbzeshQWWWnd03SGSdzGPoBO3PmVA2cZ5cQHOHFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NmE9WGTBaeL9z20zVANCRog6eqXt44f+Eo76fkQREBI=;
	b=Ma2Akl6f4nHbz4oOJAO80Ryu3QwzDSrfMD6BAHYpbgGLLN5KtF45dNpt8BfHC66rAusf
	 DIz7oecLqlHQy4JbgboGrMnzmPj2pzcjsMsSVsHw8HqT8n9FsViHAJG9V7U6RJYYwT/x0
	 5qNJ3BF3GpMQNUQW76xvrvfFtkhn5MqDDKD/vG1VVMXT1cTdXy/ucuSBYzSLHPYEmQ/J7
	 z/r6GWuay/8yRi9SMmRq7Kbeh6+t5uReYKmU7aHe4QMAGvRTGtVbzwFRTgU5gtVafHxqw
	 6uWov3n395u3uER1EcIdMIaS1oyJNnDg0axHW/OAsiAkQU+aLfbMtMf4MmLR9xswpcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxwS5roI;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CAC606C1FB
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66CAC606C1FB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxwS5roI
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9912c47367cso144126241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429468; x=1795034268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NmE9WGTBaeL9z20zVANCRog6eqXt44f+Eo76fkQREBI=;
        b=jxwS5roIPVVMCP4ycBtVq3ydF077k5kmF1xYa+A/wYDFbpxnyvV3KXRGc5nw6wO74O
         7a1TW5xuNsLkk9hikAboHKr1qGmHcyK0jiv+YVq01UOgQGEj4RwdKi3Q4v7OkuPHJkPX
         N1yZR6uhKZG8SsyiYahMPbEDPIxD4O4kaCBIDfukvSShStZZGB8mNFV2yHElILGUi/UY
         A9ZuVhZLNHn7mrpDSB8US1jgWzzYOqbHOKRmVLD42GISu9eI7ls5kl8fCd1uqQzXDA+e
         Qwr8i4QDsUgXhS0y4QEcBaBVdjE75qpfdDBqltvC/PP+ZM/lCH8BN5Z56bPvQCDX6nuR
         9emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429468; x=1795034268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NmE9WGTBaeL9z20zVANCRog6eqXt44f+Eo76fkQREBI=;
        b=OJZyMEw4MMdnPngZ35B53fUpvLYttxfK45SXh1N0rKHPdfXsalq+cIUqwnjQ6LttwB
         +iuOg7WWFAy79arWnnoRFgHgl6xGqvsgyCa6Cdd1hvxqF2mIFeDOGjZSEDxsCVI21D7r
         OqGEn+uAf9X6c/MNbUfdFP5AJhslDKzcUbUHvAjWgRr4JTTxBaAYtcsNc2srp3zEI3ox
         tlyVtYAx+HWXaunzirGeWFe5DVFtVAxGuCwRPLdJcZhj9ZE+Mjc1qZ+CVBLmen6SeAv7
         iZK/l220oegCtvHMcZCfeG9ziSr0jodkHhX3HuM6JxNdxNZCsk6Vx7jQ1GQAQhWj+tyd
         O0/g==
X-Gm-Message-State: APuU4Z/x4N8Vgk++f4Uh45527vM9Cw/Ld/mg6ybx5Z4KbRSXS4OsBfU9
	nXd0/kWONBRZBD81hhSVeHsuH8FMVJWhGnDVphVm9aBhDWLQZyJOddrduDq7yA==
X-Gm-Gg: AYBFou2fDau8Vj+svrofIK1GCWR2FMRD4br2ZgTkgL0ke+FyoJW3p4hKUNVXmU0ClXz
	aoPr2C3IMgdomvtVkTgmZhw8ALuO/au30Bjf8xFg64MigpL38okKlvVBhpg+PYiwsR7uGQtGYHc
	dJa+3E6ZOEKAgW76nOVD4a9zIjOLn81KI/mvU/li065vbKi2kvzFycy6P+QGJyJCgFKQ7hc+ZQT
	Wc3LsjT0FXKSOWH5j7FLW+r050oyqpEBhm0XTAkXs6eGVcqSXlYCMhQF04+wHlLDUnU05Le34Rf
	ClKwb20AtC6JTpMKQuS/zNw9nZOX8H8FN1t0oVzL1iZQwx9rEwLscrFmngPPvIVUPVUhyKjU0uA
	FtV5+nTNPPutW6ZyPS03vnTogsnsP3teDVTJwe5LimuLFyswsLP92fbc4/l16CchpYR/75a1xIU
	lnBsRQQnvN9UaIei9jwFab+m69BgrEawH6LZjLmKmj0xEmOKLqrHYFJQn77K+54n6aB4JdfKxB7
	mVmaJuqPOmCsVi94fhoOqjtfpdPSiHEMVMd62OPQBm8faQKE/w/gGJaFVd/Jc2gLHie/znENhgW
	j9pHOY4HJxqWXneX9bZJh8Bj3WbAuYK2ocqJ6RbW+401+LqU0gWXy44tJcFAzh7gA/Ep69oyHmM
	DNUxc4qkKHGirXXh3rlscAX9d/CBcdgnl82oYlkd3qm7yIkgboKsBiGtzr81kXH7zKzCBawVlSe
	B6MTM=
X-Received: by 2002:a05:6102:6445:b0:7cc:2a1:42ed with SMTP id ada2fe7eead31-7d631629f6dmr248527137.1.1794429468371;
        Wed, 11 Nov 2026 12:37:48 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:47 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] doc/functional-bap: Document switching the direction of a CIS
Date: Wed, 11 Nov 2026 15:37:25 -0500
Message-ID: <344a94607dfe636e32a8aeebf68c71ab7f8f3a62.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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

Describe the test where the initiator disables the Source ASE of the
acceptor and enables its Sink ASE right after, over the same CIS, as a
phone may do when switching a headset from its microphone to its
speaker.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index fc367e0f9181..5bbae3817062 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -269,6 +269,50 @@ test_bap_unicast_duplex_enable_one
 	made active through its link, so the test checks the state of the
 	transport rather than the result of the acquisition.
 
+test_bap_unicast_duplex_switch
+------------------------------
+
+:Setup: As above, with both transports created and linked, and
+	desynchronized on the initiator.
+
+:Steps:
+	1. Initiator: ``transport.acquire <source transport>``.
+	2. Initiator: ``transport.release <source transport>``, then right
+	   after ``transport.acquire <sink transport>``.
+	3. Initiator: ``transport.acquire <source transport>`` again, then
+	   ``transport.release <sink transport>``.
+	4. Initiator: ``transport.release <source transport>``, then
+	   ``transport.acquire <source transport>``.
+
+:Expected:
+	1. The Source ASE transport moves to ``State: active`` on both hosts.
+	2. The Source ASE transport moves back to ``State: idle`` and the
+	   Sink ASE one to ``State: active`` on both hosts, over the CIS
+	   established in step 1, which neither host disconnects while the
+	   Sink ASE is still configured for it: the acceptor is asked to
+	   accept a single CIS up to this point.
+	3. The Source ASE transport moves to ``State: active`` again on both
+	   hosts, and stays so when the Sink ASE transport moves to
+	   ``State: idle``: the CIS is kept for its last user, and the
+	   acceptor is still asked to accept a single CIS.
+	4. Once neither ASE is enabled the CIS is disconnected, and the
+	   Source ASE transport moves to ``State: active`` again on both
+	   hosts, over a new CIS: the acceptor is asked to accept a second
+	   one.
+
+:Notes: Reproduces a remote initiator, e.g. a phone in a voice call,
+	switching a headset from its microphone to its speaker over the
+	same CIS. An acceptor disconnecting the CIS when the Source ASE is
+	disabled leaves the Sink ASE enabled without a CIS, as the
+	initiator does not establish it again, so the Sink ASE transport
+	never becomes pending.
+
+	`bluetoothd` as initiator establishes a new CIS when needed, so the
+	switch still succeeds when the acceptor disconnects the CIS, over a
+	second one. The test tells them apart by counting the CIS requests
+	seen by the controller of the acceptor, recorded with `btmon`,
+	rather than by the states of the transports.
+
 BROADCAST
 =========
 
-- 
2.56.0

