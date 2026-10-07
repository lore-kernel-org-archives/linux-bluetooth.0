Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDADB35DA61
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402740; cv=none; b=pe/kJlq7O+fgquw18QjtSfo81qNnbjQ2O2U97cJQLEw6iFpjwA8CC4+t6TVCCLlM6AmtSCJRLzjroymaOIN1n+NAyWvDQapWIy0Jp3cX/2C4T0//5zovIb/tEtQggT78zMxLkPWyPo1/o9DeyReEch4nTO0hiqld9YdC2I7G4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402740; c=relaxed/simple;
	bh=CsF+xuJRDLVl0QLE0mZXmQMtjDVuFk/FYrKrMhYsxFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAJ/nkCQOIeCngNq1kk6wDEABPBNvvPC9FAkB6rSVWVVgmY3oAdNPRhVH5Vh3tYeC6Xp7S+E1C2i2dgqETYHsia9w/6pylYyXg5ae9imihUk6dHtTMzkJ3LGaLrGVURzCg0JuK1gXsQq+fNYfvquuviKafNP4nQmiIefgrjjtJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3HtqMJf; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3HtqMJf"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5e39cd2a795so1015137e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791402738; x=1792007538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qk3np+hRczl6RX2VW+ACWVOIGyXtE5kSmhklhwxHhHk=;
        b=j3HtqMJfhGhcG+9zvBMZKGaXWfHEQD6xr0pPqavy/FpGuc/trLBN+Lm5N74ejWyN9c
         lcx0kE4uLnfWvTvphxC5sEcm0/EK21eecVFu8LSDXClNOZlJa6T+uSjz0VN4C/Mjjsba
         2Jv7i+Z/7mKthcUEtF+t2QkUfWU1vNvT2ABvg+TwV2T5TlieopJWc5H/w56ZtTTcSbZH
         S4Yosn5sDFFlk3J7TfDZNjBu/8yhNsS8H8BWyyMvbdudq3RnnDdn2qECq/11budyEJ4k
         9PBwGtSdw/9wcsq7luFJCtF8kybYb8GEPrShEnK4wvLRFy1dZSha8i26mrPPwvTusWUn
         Osjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791402738; x=1792007538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qk3np+hRczl6RX2VW+ACWVOIGyXtE5kSmhklhwxHhHk=;
        b=wI186UTgB5zFrsyyQaqHIIOtCgE+uq2T2wEeZFHOZ6PU4eqgvrQ+2Tndim+5bqIT/5
         WDQLTPhMGYedz4SXnI1D8QUm7I4O3+E5cGpfdf+XTbUFXgGMXcsRhdJ2yzDPllqPayH3
         26uDd24omn/o5YGw9Hpj61YDrzwwYeVdzGDWGw/GLxClD3r4VAQUykGY4rGdW7w26fEu
         C/R4CUtQ5F17Gtkyo1jvGx+nuneTTXid5D3CVBIhjrpnYMob9qaonmJBwaXSDf5mPTpq
         djVUXOYP4VYOBJyfqdl99ckSuvzgS7nRnms5jgTg7C14u2VQd5IqvtSi4VvZui2NOpEG
         LqlA==
X-Gm-Message-State: AFq9FYJV2iWHlAdjdVJscfIDbp0oJcSWDIj6ORtOm9ggBjqA2cMLgFv8
	K358GDQznxzcvdxHmLMhg59wZfrWNQYXq4vAAPUohYRoJEEn50Hu4+iN8QoRK2dKnqrNtA==
X-Gm-Gg: AYBFou0rjE6Obj8DWcAvLCDq0zn80nmJP6VmNUDA3yS8WsLoJf2XrDyU/k0YIoi5n3T
	i+bjJLcBB+y0xDwB2xUeXVdlr2WykyFOtTbczatxFWqhR1yMOnMnG7xzM66KzkXyFdq6ZS7HqBe
	W/nbHmOktWFuC/qpj4LDzQKk+/8XDI3SLpXcor0hrbkLfe+DNDKtfrmRExFvS+s78ySlzvkVZXs
	q1DKdP5C30BA5tbnAnNiMYZE/EYaNJJn75+fdWJfwsC+MGFUChsqS9NotRtL9PkWTPH2ShDPQa4
	EUmmpd2c4FORsk9ECn6/bxnfm34mHZ4P+0QBvfwCPHlIHt28GA8iQU9BeBV8qFmBw2dy67UrvTr
	WTNkJYn8lH0MCaATnRwuqbUoCvrnauad5cCvwb2+iemObhqrba/+4nurxrGX0Ze8kixW+O/NvMt
	XdRkykHU1cYZD0Xbn7F7FL2uRKZkK+mbuN9vhQDnK/riKXL1FwPdoX+VHCb4Q5+AfLaOFTTKJVL
	XzPx5IVqc8uDmdRZXCMNZWLnREorgVYFRG/v3m/fVtI4ILt3XUawzn+Acr2sPLr
X-Received: by 2002:a05:6122:4f93:b0:5e3:315:b62e with SMTP id 71dfb90a1353d-5e6d32085a6mr1284181e0c.15.1791402737628;
        Wed, 07 Oct 2026 12:52:17 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e6c409aa8fsm2775177e0c.4.2026.10.07.12.52.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:52:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] test: Cover A2DP disconnection during SetConfiguration
Date: Wed,  7 Oct 2026 15:52:06 -0400
Message-ID: <20261007195206.350586-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007195206.350586-1-luiz.dentz@gmail.com>
References: <20261007195206.350586-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add test_a2dp_disconnect_during_setconf, where the source disconnects
while the sink endpoint has not replied to SetConfiguration yet, and
the late reply, either accepting or rejecting, must be ignored and the
stream configured again on reconnection.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-a2dp.rst      | 37 +++++++++++++++++++++++
 test/functional/test_a2dp.py | 58 ++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/doc/functional-a2dp.rst b/doc/functional-a2dp.rst
index 03b18a7201c2..f38a458bb7c2 100644
--- a/doc/functional-a2dp.rst
+++ b/doc/functional-a2dp.rst
@@ -97,3 +97,40 @@ test_a2dp_transport_acquire
 
 :Notes: Acquiring on the source side starts the stream, so the
 	peripheral does not have to acquire its own transport.
+
+test_a2dp_disconnect_during_setconf[accept|reject]
+--------------------------------------------------
+
+:Setup: As above, except the peripheral registers its A2DP Sink
+	endpoint manually with ``Auto Accept: no``, so that `bluetoothd`
+	is left waiting for the reply to
+	``org.bluez.MediaEndpoint1.SetConfiguration``.
+
+:Steps:
+	1. Pair and trust as above.
+	2. Central: ``connect <peripheral bdaddr>``.
+	3. Peripheral: wait for the ``Accept (yes/no):`` prompt, without
+	   answering it.
+	4. Central: ``disconnect <peripheral bdaddr>``.
+	5. Peripheral: answer the pending prompt with ``yes``
+	   (``accept``) or ``no`` (``reject``).
+	6. Central: ``connect <peripheral bdaddr>`` again, and the
+	   peripheral answers ``yes`` to the new prompt.
+
+:Expected:
+	1. ``Pairing successful`` and ``trust succeeded`` on both hosts.
+	2. The peripheral receives ``Endpoint: SetConfiguration``.
+	3. The prompt is shown.
+	4. ``Disconnection successful`` on the central, and the transport
+	   created on the peripheral for the pending configuration is
+	   removed (``[DEL] Transport``).
+	5. The late reply is ignored.
+	6. ``Connection successful``, and a transport appears on both
+	   hosts.
+
+:Notes: Regression test for a crash of `bluetoothd` on the peripheral:
+	the setup of the pending configuration outlived the AVDTP session
+	and the late reply dereferenced a NULL session in
+	``auto_config()``. A late ``yes`` used to also leave the stale
+	transport registered, failing the next connection with
+	``Resource temporarily unavailable``.
diff --git a/test/functional/test_a2dp.py b/test/functional/test_a2dp.py
index 1ab712cd0da1..12348ea05ae2 100644
--- a/test/functional/test_a2dp.py
+++ b/test/functional/test_a2dp.py
@@ -142,3 +142,61 @@ def test_a2dp_transport_acquire(a2dp_hosts):
     source.expect(r"Acquire successful: fd \d+ MTU \d+:\d+")
 
     source.expect(f"Transport {transport} State: active")
+
+
+def start_bluetoothctl_manual_sink(host):
+    """
+    Start bluetoothctl registering an A2DP Sink endpoint that does not
+    auto accept, so that SetConfiguration is left pending until the
+    Accept prompt is answered.
+    """
+    exe = find_exe("client", "bluetoothctl")
+    ctl = host.pexpect.spawn([exe])
+
+    ctl.send("power on\n")
+    ctl.expect("Changing power on succeeded")
+
+    ctl.send(f"endpoint.register {A2DP_SINK_UUID} 0x00\n")
+    ctl.expect(r"Auto Accept \(yes/no\):")
+    ctl.send("no\n")
+    ctl.expect(r"Max Transports \(auto/value\):")
+    ctl.send("a\n")
+    ctl.expect("Endpoint /local/endpoint/ep0 registered")
+    return ctl
+
+
+@pytest.mark.parametrize("reply", ["accept", "reject"])
+@a2dp_host_config
+def test_a2dp_disconnect_during_setconf(hosts, reply):
+    host0, host1 = hosts
+
+    source = start_bluetoothctl(host0, "a2dp-source-sbc.bt")
+    sink = start_bluetoothctl_manual_sink(host1)
+
+    pair(host0, source, host1, sink)
+
+    # Leave SetConfiguration pending on the sink
+    source.send(f"connect {host1.bdaddr}\n")
+    sink.expect("Endpoint: SetConfiguration")
+    _, m = sink.expect(TRANSPORT_RE)
+    transport = m[0].decode("utf-8")
+    sink.expect(r"Accept \(yes/no\):")
+
+    source.send(f"disconnect {host1.bdaddr}\n")
+    source.expect("Disconnection successful")
+
+    # The pending configuration is cleared on disconnection
+    # [DEL] is colored, so match around the escape sequences
+    sink.expect(rf"DEL\S*\] Transport {transport}")
+
+    # Late reply must be ignored
+    sink.send("yes\n" if reply == "accept" else "no\n")
+
+    # bluetoothd is still alive and the stream can be configured again
+    source.send(f"connect {host1.bdaddr}\n")
+    sink.expect("Endpoint: SetConfiguration")
+    sink.expect(TRANSPORT_RE)
+    sink.expect(r"Accept \(yes/no\):")
+    sink.send("yes\n")
+    source.expect("Connection successful")
+    source.expect(TRANSPORT_RE)
-- 
2.55.0

