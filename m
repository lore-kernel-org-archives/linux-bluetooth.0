Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515870;
	b=dDQNUdv6UOTXEzkmgzL0KpBG8UbnMr11S5e09PkR+Mxhzz7UBmQ+W8WT8rGgrM3JkVLg
	 zzEynRemrFiWRxAhf2YrMrNi1nB1riU+0pNBzmMA1kIH1uQoG25fJWiNNpN3r4a7Zqigz
	 8p/FBMxR33UM2HX3zSviDaQIfHXJ01eApm1G3GLJr2P34nOBSXsJNMZ8rcXTqTTNJUpmB
	 XQKav6pzounNpxIgMQ9CZ7D8m1Hru4VNKgoa1HQz/PW6GHC4RAEIZH7fC4deRK8OVJ2jw
	 VUM0Hx6f+NIbl1fYBCOOtEl/DUf6b22TKfZxZVYRoumIUWfmk4N6Kn6zlfCzvkbS0vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
	b=meS3/54sLYW+vnscG/HHxej73atVegJYCGFhky4JkmEo41oyksRNvtJ5NxElMOJGB1at
	 HiwjEgl4lCeGvEH4/5v9Idv7hmX4G7sHNx01+jKe0/Si5nZVW0fqfMQTt4Iy2MCNNl2tS
	 +XpGqp48xJSIAy8SyI48c7gAj+v+Makp0uTiYus3BPHoNBCycY1t55Tvg/Cnfxo/6D309
	 +dSOubwlBMLw0rQWawwPdi79sfR32yYUiqJS0ad9nQT+zddiy7TlkeXA+wEwFN2dNMdmx
	 Dw1AVUgYCzFEb3sT/5nwoKhTMxgkqM7V3LMGXoy8zUC9GiB9dTloxJ9+VTBvXDZ5Yjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T5optMUd;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C3606A884
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D0C3606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T5optMUd
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5ecd9a400cbso259483e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515869; x=1795120669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=T5optMUdDjJuK3vP7BQNtSHhB83UXWjFjGQu2APhiIDpT8dWtmMLimzUzGlREwPpq1
         iDUoNST+TY7DFw1PnCvU9DABFWccMxr0dcp1++l02wzYwuI6MRmglXXR7X5+m/W3fa3M
         e4l0gmaZKAqwloHx1BmAxPYhDpj2UZygpTaOAwa3knUTRUH7kYbgixpohuoNH2AkgTBv
         Fz5/nUcwQFmr+LSwuIpJHGjMGA+YYzFiopWJmfsNNkVFYd7WVTMvitTLWOlbkWSdFC+h
         6e3UySkwQpFCtWSgQw96hx6JzginGDJirdbQARxTUqjNhHcaaP8bJmE517g51GNqWsoN
         Kj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515869; x=1795120669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=XDmSx3dKU0XK0mKMHUqGZgGaArJECK8KRytsm76G/WiIO+a6YOPLX3vPiUraZz1O+4
         w2VxzeAHGWHQjSC9ng5BMhyxpoMZtfc7R+6A90wFKiw9KiqEVhecSt/GdIzUvr8qHgCx
         M6G3Rviy7HnrgRH5LNX9fv8sykcoZNPQZcWXMLnkmQHUYGfXAoqINHxeGZ1X5YaXTsyT
         Smag1ArId0yxvMCm3DUvqORa9tNWXG1QLgUzKRyuF04rCUpwo9OBRgwnc5NXapSGeL8V
         v+17ncdcws09u4WfHx1JeMxS3/H2RQdpxMMCTkJOB+Q/UEw4iL490tOKBEkF1RoC1CVt
         qwNQ==
X-Gm-Message-State: APuU4Z9+1F9Y6RN+YXFKZptyO3N5Xnrun1OQHJ/aeFrsdnl90QmHmmzK
	k0T1di8mCD1BnzmGJpK/4uHjEToX2NUYujT7QT+0WVp+NT+eWd5OWRNgY0MuDQ==
X-Gm-Gg: AYBFou1fssaVj+20tz3EIudtXhM4ShPGJlraMSdVmz/KbKFlA33hAXkD0IT20GYQNkF
	kEKQCUTP20euNgQ9+pinuy6zwsuhfMqxoQmFZVcPjZY5fZCfLwFdtfazOeoSlHqNWIWWAxdH5Lx
	nmt7h/ZU7xAqi9ORXdxfVcZZDsgCe30Lm8Z433PvIrwpztitFtuRdaUM03QHcjOKubb4EeZsgi5
	V7nnjVujvMmYcDMD1GLrdFmLkrUtxKMCHtYIIMZf0KCsWzcdqOWPqtqy3T/6hTmlEKAoogyTg8Z
	Z4s/WuAgt3G+TH6RGQHJ4/Cw1K5GLYFfxrShwV1Nk6rSFHKYMr3BLPRch7TW+B3DXX0KdgMFg1D
	Qu6ZbHSa6dfJwQ3hrMZ1U2dsNuXUKTO5CAjlGDOjrvgKn5OXQ0y0e6BeFERGYAcMqBG/pqTHWR0
	S7vMYW+9rAapopD152+IgBqyTTWQa0bjp9ri2aIAorCs2eAoG7ecVa6FfjFmSxpP1rNq7jLpXP0
	hTKOXJNhfutEvmz/E0ufaqgqjfMAjVEpY64tYosjHpEBdtOEL9DMAlm2tVKiG8Kpn315goAvyWJ
	+IsMDqKvpL02eh5yYuB+S9B8hhp/D/CUfcT86e0AO329xvx57OQDBgi2hCdLRjI5lPNL6ohxAB7
	sa/U0o8l5KKJwkwqq80HC/AupfKAEj8YDTiE0y2eirLa79rAWSXiiDCgBoAtdyh2C1b4X56vDPR
	iPSUQ=
X-Received: by 2002:a05:6122:420e:b0:5cc:4a63:4a01 with SMTP id 71dfb90a1353d-5ee34a7a24fmr131371e0c.11.1794515869408;
        Thu, 12 Nov 2026 12:37:49 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34bff0d2sm145765e0c.0.2026.11.12.12.37.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:37:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 6/6] test: functional: Cover clearing a cached configuration
Date: Thu, 12 Nov 2026 15:37:43 -0500
Message-ID: <f0682dffbf9c7705726f28babb16a03fefaa922a.1794515788.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515788.git.luiz.von.dentz@intel.com>
References: <cover.1794515788.git.luiz.von.dentz@intel.com>
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

Have the initiator clear its remote PAC Source endpoint twice, and
check that the acceptor removes the transport of the Source ASE once
released again from Codec Configured, leaving the Sink ASE alone.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 324304204caf..02f203b68667 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -698,6 +698,29 @@ def test_bap_unicast_desync(duplex_hosts):
     expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
 
 
+@duplex_host_config
+def test_bap_unicast_clear_cached(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    # Releasing the Source ASE removes the transport of the initiator,
+    # while the acceptor may cache the codec configuration of the ASE
+    remote = from_source.rsplit("/", 1)[0]
+    initiator.send(f"endpoint.clear {remote}\n")
+    expect_all(
+        initiator, [rf"DEL[^\]]*\] Transport {from_source}", "Configuration cleared"]
+    )
+
+    # Clearing it again releases the ASE from Codec Configured, so the
+    # acceptor does not keep it configured
+    initiator.send(f"endpoint.clear {remote}\n")
+    expect_all(initiator, ["Configuration cleared"])
+    expect_all(acceptor, [rf"DEL[^\]]*\] Transport {source}"])
+
+    # The other direction is left alone
+    assert show_state(acceptor, sink) == "idle"
+    assert show_state(initiator, to_sink) == "idle"
+
+
 @duplex_host_config
 def test_bap_unicast_duplex_enable_one(duplex_hosts):
     initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
-- 
2.56.0

