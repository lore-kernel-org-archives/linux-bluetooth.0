Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414339;
	b=n2nDQ58q+c/Umqham3WDlIe0uIH05LYgk0DJHqCIKT9vSOeVeuWAMmvzpSvbgj4PiMXh
	 ck51LYC/036VFSbkiH8cK/YKO12Xpr1fIFtZ6fW0zxrNv+yfpFGJGstLOa4fNrtlj9R3m
	 DJUr4ltgjf/55RkUzBpj100XgwUXwxnJ5sqsrfGxejrGiyI5kv/LsmmNEVDSzfzihST22
	 JEcB0y2OqHltYgMufFYkAwWbVmcLDkKHj+3i+l9F8/o3g/GuQsYm5smqTFAOh/PTbOIs0
	 BjZrvWbMw48DAaAc1xPiiEMsbtLcQ9Vg3U7ejLl9JL/O8Y9MpaTA4nnUJjT+6Qol5mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h2a3lEDqJDeuHYVlnbEcRteuBYly6owVVVK7Yu2i0o0=;
	b=BImHhkBNOGWwWcwiVgimGU8Sl71UQ4s681uqHPkvWyWlTHiTeNP9993v9ZQ/SEE66nZh
	 vZhVR5mkJQTVl4YvhAi5pIVeAX19qaSgnbP9tGQE3NgE5pQaYSbyg4Eie/voN6gqGU6j7
	 4++SkGh35CiNASf6V1lmpLoLZHV7liPAe67qEpzFT2aIMdADSpKysJLkiOITLMHIMWq7p
	 v9d1s7b8oOV1U5uazEALUTUdaxOsaNSsE705Vb1CzkY2w8ixuA/NeR4jsB0nn0weJapZa
	 JvznIr2U08VL9PpSatLkJ7iUc6Rwone3Cmeef2FvUgTtTk2p9IhxvFAcD9mb8SP5SjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nQ63z40K;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A9A606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A9A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nQ63z40K
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2db1b9bf2so1077752137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414338; x=1795019138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h2a3lEDqJDeuHYVlnbEcRteuBYly6owVVVK7Yu2i0o0=;
        b=nQ63z40K8tc1coCXGpo1J7nr6FWiIM/LzeHxOiPB1fCHJ+pBKPrUQa/1btTFa0GuEQ
         fXyFjKY64t4YLF8xx8sJNo2IUus3TFf2Vz1DvEN41SqSwAwGF/eSFgATdBzHTwW6IvPd
         KEu9j7GnUW/2558/9GSoiaae4WzzK9eA7p382hh9zLtH7oCy/4gyOLRx/7uHb8PKfwKd
         GwESSNZ9+aErn61ycNymruBE6mkyDisYLmBNckBHEiLpJxwx+VJG6wT5+gqMwZ7+tJ3T
         wq4HPmJosQOD9kgND8FabZ8lBZFxXPqQMGac03gCFXSpkxn3Or3ap6Tfna4o8qRi+8W1
         6OJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414338; x=1795019138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h2a3lEDqJDeuHYVlnbEcRteuBYly6owVVVK7Yu2i0o0=;
        b=ydjaj/tlBeNnW7fBGr1IgHSSzW+AQsMBK9fmAhRd5TazgcEhumqjGYVNCdSRSocMDP
         EFT/fi8gR2f/Rabnfq1b/Kl+8in0saF4gqrN4I+YAXSnuhPp35nxviXOZ//5Tohe8rEt
         9LcK8CKRkkMkB//jf13YSLy0HBf4ElSMXafy65/tyc9iMIJ6PUQSTFu+2WStFV8/0w1A
         YNRVT/2gGoPjPcqiTcpPZaT1sLZ5w2bozXQQb0b900FT1WPszCuVrxADytH2G7YtEnQT
         6My/29xqJkOjOayrnhmBMQJKI1xgStmkkc7r061mAjKRE1jPDUEqE/8NY0I6PkzbkjGW
         gGbA==
X-Gm-Message-State: APuU4Z9PpLNwTJvffV39yvVC66tUNUvdBcHSYaP5j6C5Jy/qQ5iDeeN4
	1RpNhvgkSfCb+8Bl8JF38ANOCwEMt0LJ6Rgc0d4MN/L/ItRaaA06HoxB5sen6Q==
X-Gm-Gg: AYBFou238mkrVGTI4LwCPcJAuJPTFvC0+euj+Me2TYsCGRruvPa5bBomWrWL1ijEcFW
	Q624zMACbIdxm6fJMzSJ9gQQ8LWeOzLTmjeJpgjUOF0gy5ol8xNtYvjj5nR0+dmif8hW8poe0QD
	jfd7I/88VxMb2aGWq11TYgogWgf6Ec+XdnUvCAVl3PmTn8N6INnmT4kXIuHdiek+edzyi2GhJNJ
	bzeXZsW6QtnA8WuixN/UxnFWf+pMF4UkuRO06GVbPCZgtme4BtxYEYyWPpSnlUehTEDdEj5uAfP
	yJ0T6kfQ/oI5BTJmk0q4cSjXQWu62cm+ATp15p2awnvLA+f4ecEpji7Mak+8KYkcLnaWJULdjdQ
	uOt0SlGEPMK/2aFF9DoTyeYDDGaUZofOvpIcWcHS/xM2ZbkhSEYO66TsuQvM2/7hH7Q1yJdelWy
	f1KFv13pGBz95OSRYZVPSjKQueksW/Q4nD2AwCeaQNMtGCCJy3+3aJDR4AUXpgHo1nD6GVlM7T8
	QiY1O56VjuZ4dVHEXBD3lwuvQDnVnqNjjvlgp4yDcDXt23xzIMiOYODuVtqTtZOy4Q3p91Wn1+6
	gShZFSvi+DNgac+P4N+w2r8Ph1odF9b9/YZewfDVQvf1jI/RR4kqeOMMF0BcbeO1J/C+2KXFuvf
	kAHI+OCdRjbnR/RcQNDtpB2s5xSLFnE5HY/KXdGO0WUWxDjxj3jd7n0BUy56yj0sUn0Gs1eCMNe
	CgJ9g=
X-Received: by 2002:a05:6102:6045:b0:7b3:8f0a:f76c with SMTP id ada2fe7eead31-7d4fb2d928fmr885082137.13.1794414337844;
        Wed, 11 Nov 2026 08:25:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/4] doc/functional-bap: Document switching the direction of a CIS
Date: Wed, 11 Nov 2026 11:25:14 -0500
Message-ID: <1e70f2fc15d615a2dddee8f8d2a7bae5642f283e.1794414122.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794414122.git.luiz.von.dentz@intel.com>
References: <cover.1794414122.git.luiz.von.dentz@intel.com>
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
 doc/functional-bap.rst | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index fc367e0f9181..8f3f8e62cd4a 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -269,6 +269,43 @@ test_bap_unicast_duplex_enable_one
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
+	3. Initiator: ``transport.release <sink transport>``, then
+	   ``transport.acquire <source transport>``.
+
+:Expected:
+	1. The Source ASE transport moves to ``State: active`` on both hosts.
+	2. The Source ASE transport moves back to ``State: idle`` and the
+	   Sink ASE one to ``State: active`` on both hosts, over the CIS
+	   established in step 1, which neither host disconnects while the
+	   Sink ASE is still configured for it: the acceptor is asked to
+	   accept a single CIS up to this point.
+	3. Once neither ASE is enabled the CIS is disconnected, and the
+	   Source ASE transport moves to ``State: active`` again on both
+	   hosts, over a new CIS.
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

