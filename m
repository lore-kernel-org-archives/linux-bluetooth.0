Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429470;
	b=tmyPt+k4ahDZ6yK2OJhZJI2FriJ81KmP9d2pLaDAZl38TTEBZ3hhRUncQZXjRGrZenGA
	 IvGWgidjWuhT/oWulnVuXSjWiSsqafOtsJUSvqVV2Km9xzfQeK0olF2L4KeOT4cROfCUs
	 h+B2WmYFTh4pxy/4eLGtnfX8hS1gHKHCGJk3u7lFy4KiYcW9wAwpcTUNKkYmPK6mwI30g
	 Bex0TQHIzQcJo6J9m+j2Hw7ftPW0VdXkMfKKS/J0bxhkBI3iE0ktinI2Sm5jyeNVFdZbv
	 J/S5a9SeKS1o+MiJ+/U/TVAqaFUOEvqx4dzg4Zc/zRmAh6tqzT+H10WSLLKHlmq9k5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429470;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Y5QbS7sREIMO3lWhc3LSpjV2R8PytkyIb47hpdjibsk=;
	b=lcwv4/qPVM63VQ4eTmGpIUjMBA43Ochpdzit7jtc9SKgfIs44laO2ufFUjdPVUbueNdz
	 NsmWM8yPvdyDlIHr+2zuge017V1Pgel/KqU7EoVOlxn6f/nMQO1FRyvXaLsbiHZqjmlFH
	 6af0QjbaTxom+WuJGotSZomkg9ITahYwXUnSdzmUU2ixiO7sD9NsJ6VMDvqw5gz7rWGlk
	 dCeItFFf0exGT2wrAfC8k7T93bOb+3mKJeSZH9i7rCZReeeyxPpGm4Ypym/6T26QoKG08
	 b5hve64H3lpk1Ys7//3ryYjz+Zi3PJOsiGLiEmP6eezUVn3pELYqJyt0a9Q0j355kWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMXwCetm;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E360A2603
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 536E360A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wMXwCetm
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so1808969137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429469; x=1795034269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y5QbS7sREIMO3lWhc3LSpjV2R8PytkyIb47hpdjibsk=;
        b=wMXwCetmkM372Gm/DEWqAoYSf9MtQvAYkB7+LF5TyOa24Uqi1B8I6QpFOn6miomDBU
         0FtZnsMLtP8hMGSqj1/UCzD4cAnZxMy7tcqhJvs6wSwPjO94V6o9eVBEFKfe4ORzcKVx
         13hnyO87E7wvbT4SOTI/mHlw1VC8pwlzOg6FKe1MsPZGENPBHuD5R8PL5sfIeo7pXwbF
         7vu9gaoPclrMo0xMBPiCsNp4GOtOpujM0jxahpQuG88K9b+NOtsk97tgn+3KL4LAPxPw
         eYI4AScVheqWLlVg5f6b8h7blQZGJXdfTrNVtK3QmfMrMTR0zMrCpNx5PSxSUC6Hfn5v
         Z7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429469; x=1795034269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y5QbS7sREIMO3lWhc3LSpjV2R8PytkyIb47hpdjibsk=;
        b=0knOgB58ZJ4dx0V1xWVs1S1Fa62qk6t3g/1MUKqupHdKxUpgDOoA7GkDPg1N9FvBzy
         YuZIwvkDjBxoItSwyt1asy60Utr4CrCXHRBTnTuoIkiIAfKrAVou8n8740gg1m13Spfh
         30aS+rO9k6dz6f8f37mIVScCcDYKASSSIjt0c82RStFEcuF/gF/PFcdMkJsJvQUy3FK/
         E7CZRZrgcGm5aXapE1xpgGOB0AHbYBlSZPo/1mJf3STqxccqQue69PQ6SeSNJp3YkONo
         ReLU6pBFIUGhX6g5tr0o1NAbY/Bd9jvGr9H5iJSBI2PUE92JAJpsLQRlpDHTauQK+q2x
         W+CQ==
X-Gm-Message-State: APuU4Z+UPU7PxBU789WHP9vheyLAwoMJrIRPE6aCXWaHYnsEFi7zh0Xv
	qdvWfWWd4XY2Chrk+Z1h9BlzIRXVQVcZlwulialuejLQqnB6aRfHfPnxFpIGhA==
X-Gm-Gg: AYBFou3skJ17/z46IwEerfYrR4rm0UEKPZGM+ytpQMQnC3Tn3gmbWzjEOYV8fQioAX1
	DFga4trTx4iUeN/MNw51tUnhb3jGPI+ahSLVZVLtEAyCFnGPMC7nimIyASK+Qqq60fZy1KtVNGf
	SZs/QORzurm3lEIIK+5+PXCZbHgxx34DPnOhfmlL/osxg85WDaWz0NDjFOO8R6r2TYikW0mFKfF
	894QL19Ye0YllNiqdU/xIwVESP+SdupecAG+J2k7CBDFJjkf9dsjetxn5QwMtzEibL+XgZffzyQ
	D254HEy33GHQMBRJ4vuFHxQupgif45adOC471NEIvYLj8gnTYG/Buz45g5TEWDmiTDjY/1Fn2wf
	AseiKsKPwA5EEHpcACmU7lsE4KQDN+dm9C7ujiEz+Cw45OdReT7MTf6CQ+aF2ZtaK4NUdcqARcv
	YCgThV/Xrbuou5ZPKkwW4vXxn2MJJbAeQxwbnyY79r1Pdwqdl9041DyFpxpirdP/1JEFf96chP8
	zrvwCwGspqJyaI/ls6Gn0MSAvqn/llJXxIxnBxU7muzcM4WvTzWm0Fr9oSlLcpHoxKdCyz8dWaS
	fcNedpUBsZQY7Cj+XvoIam9hWXkcuSDZUZArraYvl5uoLG/UdeFJ73kkpflzwK08HVzzpiAHGQG
	xM22e+aqaoPClLslZbz/xGVW5pZmosgPypmnrBijpo2GigKk0m+sF1JTQxpsVSUWSa9G+j4Zzad
	WTHII=
X-Received: by 2002:a05:6102:6052:b0:7c1:62d2:e18a with SMTP id ada2fe7eead31-7d4fb2b00b5mr1329569137.16.1794429469181;
        Wed, 11 Nov 2026 12:37:49 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 5/5] test: functional: Cover switching the direction of a CIS
Date: Wed, 11 Nov 2026 15:37:26 -0500
Message-ID: <5c6a80fbbe81049d8bbef465b76ef7a85e176ec8.1794428234.git.luiz.von.dentz@intel.com>
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

Have the initiator enable the Source ASE of the acceptor alone, then
disable it and enable its Sink ASE right after, over the same CIS, and
check that the Sink ASE transport becomes active on both sides. Then
disable it as well and enable the Source ASE again, which needs a new
CIS.

bluetoothd as initiator establishes a new CIS when needed, so the
switch also succeeds when the acceptor disconnects the CIS. Count the
CIS requests seen by the controller of the acceptor, recorded with
btmon, and check that the acceptor is asked to accept a single one for
the switch.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 86 +++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 324304204caf..086fc8e44d23 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -733,6 +733,92 @@ def test_bap_unicast_duplex_enable_one(duplex_hosts):
         assert state == "active", f"{path} {state} once the Sink ASE released"
 
 
+@pytest.fixture
+def acceptor_cis_count(hosts):
+    """
+    Function telling how many CIS the acceptor (host1) was asked to accept so
+    far, which bluetoothd does not report to the test: btmon records what the
+    controller of the acceptor sees.
+    """
+    btmon = find_exe("monitor", "btmon")
+    trace = "/tmp/acceptor-cis.btsnoop"
+
+    host = hosts[1]
+    host.pexpect.spawn([btmon, "-w", trace])
+
+    # btmon has started recording once the trace has its header
+    ready = f"until [ -s {trace} ]; do sleep 0.1; done; echo ready"
+    with host.pexpect.spawn(["sh", "-c", ready]) as ctl:
+        ctl.expect("ready")
+
+    def count():
+        events = (
+            f"{btmon} -r {trace} -P | grep -c 'LE Connected Isochronous Stream Request'"
+        )
+        with host.pexpect.spawn(["sh", "-c", events]) as ctl:
+            _, m = ctl.expect(r"(\d+)\r?\n")
+            return int(m[0])
+
+    yield count
+
+
+@duplex_host_config
+def test_bap_unicast_duplex_switch(duplex_hosts, acceptor_cis_count):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    desync(initiator, to_sink, from_source)
+
+    # Enable the remote Source ASE alone, as for the microphone of a
+    # voice call
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
+    assert acceptor_cis_count() == 1
+
+    # Disable it and enable the Sink ASE right after, over the same CIS
+    initiator.send(f"transport.release {from_source}\n")
+    expect_all(
+        initiator, ["Release successful", f"Transport {from_source} State: idle"]
+    )
+    expect_all(acceptor, [f"Transport {source} State: idle"])
+
+    initiator.send(f"transport.acquire {to_sink}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {sink} State: active"])
+
+    # The Sink ASE streams over the CIS of the Source ASE: the acceptor must
+    # not disconnect it, as the initiator does not have to request it again
+    assert acceptor_cis_count() == 1, "CIS requested again for the Sink ASE"
+
+    # Enable the Source ASE again over the same CIS, and disable the Sink
+    # ASE: the CIS has to stay for the Source ASE, which still streams
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
+
+    initiator.send(f"transport.release {to_sink}\n")
+    expect_all(initiator, ["Release successful", f"Transport {to_sink} State: idle"])
+    expect_all(acceptor, [f"Transport {sink} State: idle"])
+
+    time.sleep(2)
+    state = show_state(acceptor, source)
+    assert state == "active", f"{source} {state} after disabling the Sink ASE"
+    assert acceptor_cis_count() == 1, "CIS requested again for the Source ASE"
+
+    # Once neither is enabled the CIS is disconnected, so enabling one
+    # again needs a new CIS on both sides
+    initiator.send(f"transport.release {from_source}\n")
+    expect_all(
+        initiator, ["Release successful", f"Transport {from_source} State: idle"]
+    )
+    expect_all(acceptor, [f"Transport {source} State: idle"])
+
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
+    assert acceptor_cis_count() == 2, "CIS not requested again after teardown"
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

