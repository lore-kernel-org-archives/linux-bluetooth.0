Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643181;
	b=ajkZlzoPsdXqSiRuiZGIn3FVGVzNSKyIjcIOt8ywNI/vEhMaVNBo9V0tgr/aIFM8Sx/G
	 btvkNhX2L0MQ4aunhsX3L8WtSuM790v5J48kmtLTyqXwZA0VE8ontm6OazAwMFf5IJEuA
	 QEyE+hjVrSeqQWvuGnU2RC/oW03W33u9TR7t89dBkUyXX8+XcL69/I/2MSK/wZwgJPZ2u
	 qm22XboT4wjSP/pd5pwG9rpfOhmlLx/Z+k6iH+f+U97Auk1iAgv1JOzR0CzUASljzdrhV
	 gy/CSelWxx7dzmMWh+G+h8q9CePbWOC6jUrblXirWPhOreOShPp3b7PB5bLRErCbKLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rySAoxJ+1WNd8li5PbRdtmNYRQx4OzM2QNVTPoECwbo=;
	b=CEXKtkjemCD7fxNPl1y+/HkG1pWsxVTCS+cbQjjOQCOcyRZJzGKG00RrsCBjxbMvNSNc
	 66MACTv5VY1lyZ1NLqRPaNHY/O4As5vIq8U+u59uH/0ufW6NTfcZdib4h9feTR6kAVOU6
	 q7ypuA/gaOiy6TMf4eCj9g/7NhZ3J480uUtNk8YLGT1rN5cenPlHJYQbHCRNeYrVK0JAt
	 aNzNt1VsKugIyeR+UCdjhRQ0+YGlfpNgePqqtim0E9U7oGKbAjnp7bVTLLvZNJWtGQrdE
	 vNA/kHVNOZKJ37J2e0Y14q+vg5UgiC0tB+tYnYTlNxeedMmCWnRczjGLynAF2q+7bHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XHw6Eyob;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BE9606A327
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 18:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62BE9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XHw6Eyob
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eab93a9862so548474e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643180; x=1794247980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rySAoxJ+1WNd8li5PbRdtmNYRQx4OzM2QNVTPoECwbo=;
        b=XHw6EyoboY9xWP4DZ3LYn7QsWwLH+HJ7R2hCEJZuK8emF78v9v+cGaot+Z2mqaPdid
         p2dvgCUcotxEpLiTQwJjIUfCu6fXXG5B5Agw7r5VPx6a9Z/H48a36rlKpaJMvnQ7O5ci
         NycRd0mfDutKqJpTh99becpzqgQyw6g13ExzEKP5WAP4gG+w9mLfsDk2qPv7E0ruwlnR
         cgpf8IlwAQLMgxCkN8p/gov72jhIWNxRpM1XhRTzEyf7CiwTvawLAqcM7MHLJTgYmr6k
         NKG/eq9Xn9bt3TM9zmtn+VsOfFjLTd/L8at6W3xTDkHIZRN9V0Eq1z5lMR1APigeM/90
         LWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643180; x=1794247980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rySAoxJ+1WNd8li5PbRdtmNYRQx4OzM2QNVTPoECwbo=;
        b=1id2L8wB1fHwIxaDm8Ruja8IPxNxTVwvhniB1xrkyh+LYSJCdeSfxJEs0KgqpVQBOQ
         R4fgxJDo/dM7B7zFzvDutb1wzVuWHLQ1/DFTuaEK1fKhaEJH7fmqSKuhrNDEN8qNdFBb
         39FxHtmlo0D/CE8tlJfH/d5GMV5k0I4wjzQEayA2TScNCcti08Cr2RsQAOtr2afb+8bC
         HzNVzu97oByvyqXtjBHEd86cbfbRCbGXfsd2MK8uZNrzvGPG7z2zS5p3dNlkEdZvLqeO
         cuzEa5yeNmhEZhpEAQIBn4Li8vDN7b6csbT6oVOyGDJeMjSF3SUAbcToWIeWc5BmWfp3
         dwjA==
X-Gm-Message-State: APuU4Z//1IizJZFmLGxx5aXaloxIEDPwQjvz4tPsTmY9wxwWdpLQBNOu
	cccjYg5rRdnIspluhtTkKt4uPmW9DTXOscU2SFDwUR1LZvvzRAwjqIzzClKInCt5
X-Gm-Gg: AYBFou0mzhI05Tc8nNdLzwdXvgsHvAPTQNsJnUzD0zHYHHD07c/kXBZ+v4/Ep/pvcPM
	LI+4+YQx4x5frhr0La2koTJHJx6/qPFJKGdl10cgzzRRbUqs5Dz1PbrCmEIcWrIehJsxWeEESYA
	zCgy044T7YVjRRxv8zLtPc00hB2y51/NsLGWqY+WFyZxxLS89YylXYHxrUQduy8EjewnD5anOb5
	OgDG6GCOCg8msDXalHUh85Q/20kEarSmEQ2kkWkyDyTMzfRBIhku71UhWwrwOD0di0iVMAsO7Bb
	Wbf5da89XDH7m3kko/Eoj7M/FXTjPvibs0fWu1lIyvxVQH3BVv5UqNId5vOCYRMNspfF3i48nuY
	DHPRrGRJvRttvCYlY0/EwBInzNq/BwqA91K3xGxIEDhzFLt4uzjpN/qnsHDXbL7bxWeqE2ixnc7
	skJaPiAth1s/cXaYHOp6DLpZgVl8l/zg/UyYds4hLUJMOPkyl22bga/jN4IZ9nuCahhw4QClMjr
	iggWIh4Kbplv7l2vdh86GMFZzqLe3o+A+l2ryyBcRwCMahamUG9d0WSly3FpA06Mi/IKwNGfWOh
	P3oCA8oMk4IhWXv7XCA1CgT7xQc77nmnnk/6Vc31qpv5hzI6Sig5V5NS2oQK2B/Hg2DAaGB5fJl
	DwDANS8AKQeE+FItQ1bZ5tDrxMtiAlsZuyFY0y06tI9H9PhuofYUvu6xwWnME0tlpUFniTIwPzT
	vDk7FDxtE6RXNOdULjd6d032bP1A==
X-Received: by 2002:a05:6122:3a0c:b0:5ea:ef43:b03d with SMTP id 71dfb90a1353d-5ec6870c951mr4362552e0c.7.1793643180223;
        Mon, 02 Nov 2026 10:13:00 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf220esm10300208e0c.7.2026.11.02.10.12.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:12:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/6] doc/functional-bap: Document the duplex unicast test cases
Date: Mon,  2 Nov 2026 13:12:52 -0500
Message-ID: <20261102181256.2321329-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102181256.2321329-1-luiz.dentz@gmail.com>
References: <20261102181256.2321329-1-luiz.dentz@gmail.com>
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

Describe the topology with a stream for each direction over the same
CIS, the test of the Desynchronized property used to enable each
direction separately, and the test of the acceptor when only one of
its ASEs is enabled.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 105 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 42fa7fda8006..ea0054ecff5c 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -157,6 +157,111 @@ test_bap_unicast_reconfigure_metadata[empty|media]
 	streams; it does not exercise microphone streams or simultaneous
 	playback and capture.
 
+DUPLEX UNICAST
+==============
+
+Two hosts, connected over LE, with a stream for each direction sharing
+a single CIS, e.g. a voice call to a headset with a microphone:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |      LE ACL     | host1                  |
+	| initiator (central)    | --------------> | acceptor (peripheral)  |
+	| bluetoothd, testing    |                 | bluetoothctl -a auto   |
+	| bluetoothctl -a auto   |                 | bap-duplex-lc3.bt      |
+	| bap-duplex-lc3.bt      |  CIS 0x00 (LC3) | PAC Sink, Front Left   |
+	| PAC Source, Front Left | ==============> |                        |
+	| PAC Sink, Front Left   | <============== | PAC Source, Front Left |
+	+------------------------+                 +------------------------+
+
+	one CIG holding one bidirectional CIS: the Sink ASE and the Source
+	ASE of the acceptor use the same CIS, so the transports of each
+	host are linked
+
+	--> connection is initiated by      ==> audio flows towards
+
+The initiator runs `bluetoothd` in testing mode:
+
+.. code-block::
+
+	[General]
+	Testing = true
+
+which makes the ``Desynchronized`` property of
+**org.bluez.MediaTransport(5)** writable, so each direction can be
+acquired, and so its ASE enabled, on its own. The acceptor does not run
+in testing mode.
+
+``client/scripts/bap-duplex-lc3.bt`` on both hosts
+	Registers a PAC Sink endpoint
+	(``00002bc9-0000-1000-8000-00805f9b34fb``) and a PAC Source endpoint
+	(``00002bcb-0000-1000-8000-00805f9b34fb``) with LC3, both with
+	Front Left as their only location, so a single CIS carries both
+	directions. The host that pairs is the initiator.
+
+test_bap_unicast_desync
+-----------------------
+
+:Setup: As above, with both transports created and linked.
+
+:Steps:
+	1. Initiator: set ``Desynchronized`` on the transport of the remote
+	   Sink ASE.
+	2. Initiator: ``Acquire`` the transport of the remote Source ASE.
+	3. Initiator: ``Acquire`` the transport of the remote Sink ASE.
+
+:Expected:
+	1. ``Desynchronized`` is set on both transports, as it applies to
+	   the links of a transport as well.
+	2. The acquired transport moves to ``State: active``, while its link
+	   stays in ``State: idle``.
+	3. The link is acquired on its own and moves to ``State: active``.
+
+:Notes: Checks the mechanism the next test relies on to enable a
+	single ASE of a CIS, so a failure of that one can be told apart
+	from a failure of the initiator to enable the ASEs separately.
+
+test_bap_unicast_duplex_enable_one
+----------------------------------
+
+:Setup: As above, with both transports created and linked, and
+	``Desynchronized`` set on the initiator.
+
+:Steps:
+	1. Initiator: ``Acquire`` the transport of the remote Source ASE
+	   only, so the acceptor's Source ASE is enabled and the CIS is
+	   established, while its Sink ASE stays in the QoS Configured
+	   state.
+	2. Acceptor: check the state of the transport of its Sink ASE.
+	3. Initiator: ``Acquire`` the transport of the remote Sink ASE.
+	4. Initiator: ``Release`` the transport of the remote Sink ASE.
+
+:Expected:
+	1. The acceptor's Source ASE transport moves to ``State: pending``,
+	   and is then acquired by `bluetoothctl`.
+	2. The Sink ASE transport stays in ``State: idle``: its ASE has not
+	   been enabled, so it is neither pending nor acquired along with
+	   its link.
+	3. The Sink ASE transport moves to ``State: active``, acquired on
+	   its own once the initiator enables its ASE.
+	4. The Sink ASE transport moves back to ``State: idle`` while the
+	   Source ASE transport stays in ``State: active``, on both hosts:
+	   transports acquired on their own are released on their own.
+
+:Notes: Reproduces a remote initiator, e.g. a phone in a voice call,
+	enabling the Source ASE of a headset before its Sink ASE. As an
+	acceptor cannot enable an ASE itself, acquiring a transport whose
+	ASE is still in QoS is rejected with ``NotAuthorized``. An audio
+	server acquiring every pending transport then fails, and with it
+	the linked transport that was working.
+
+	`bluetoothctl` with ``-a auto`` acquires a transport as soon as it
+	is pending, as an audio server would. Depending on which transport
+	it acquires first, the Sink ASE transport is either rejected or
+	made active through its link, so the test checks the state of the
+	transport rather than the result of the acquisition.
+
 BROADCAST
 =========
 
-- 
2.56.0

