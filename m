Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414340;
	b=nfCSoVYFiJ/5KHnOMmIwiaJzVvhVNXuZJoSTuDqeBy3cozqJY5QLnXpdPlu30D2vDSSL
	 SBbe4ByVoKEI/k4811NhWMgUiUDZxlCSKsPAN/WuriVrnMMbfdmdjuysM6nX6DKWbqBLb
	 z+i9sUc1o9DuI1S3DgDbPq39wZddyCxNVULfft0+1kkywq6xFXXjhTIhVsSKpOdzxVMpc
	 WmuzJzmjpPOICrRhLl/b+V/ojquBi4LcwCr7pKkZzbKwYMr4JaG56Y57NJlRlusF7bCCJ
	 7gZiG8HgF1YR/yijb7IdluyHveJ3/mTJD1y2wKAi8lgc7AKhwEH05tc+9NT+KRxVE2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VQ9XIKkCNk3fozE5f1r68DOd14g401yrqdbfdhrwG8o=;
	b=Vthc5AMinS9uCmMwum1WgPpMTJ0LZLeewHQ+dY5cGPkPqqkPmaLMvSA6ru23XBw4fv+n
	 IoSBuaTqo/6s1lAFnGnS09pJVQzhzaNkl773yPEmPY5DGvM5p2T2xQcu/W3ifx4LCbVjA
	 gm8wJS9Kq7Ib5x4aB90P3q/G08aB78KhYnBmF5xyaMQx2OTHTb8aQHpRWI6eWgKZlz8uS
	 I/I0W04yuGlYYLW4cBoufh16EHi40cAf4y45UvLxSUZuBVIwlpo6osfUe2ZfA1eqw7qbb
	 Bjrr2VGB3FTWTRhV45Kz8+FIXE0LJXSHdgzxZLR2cALTvTNjO4GmyBLWPPxZGjxNcHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dd3F+C4k;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561F6606A33F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 561F6606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dd3F+C4k
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-78fb1fb9508so2359224137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414339; x=1795019139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VQ9XIKkCNk3fozE5f1r68DOd14g401yrqdbfdhrwG8o=;
        b=Dd3F+C4kBCeLujFLLAq5srpjPVF6OANrBsSpa1Rxwo2w4lTsvsyVzEYbqQDj99bDVJ
         5VPDr1QGbftWRp6m81vAOgfdzL7VM4KSZ0ttB9woatEs+q6rGR3tQ7DHM7T9Of5RqNvG
         y00EWJ/SBeIrB4jzwU8e9d0W4Kbi8zE9yspkRn0i+7PoGhenfkATjlYt1VYWhN3PZUXR
         ixFuDreHqQVbPIoV8mzEpxncAg+t3ec/9RpxWRf68t+0DNMOmMpIDT0ZLDMITF7bOVMg
         1fUXvoMIp8N/Qy1U9uQASfjA6mzw16huzv/hLwhrUsd75OllTuVsJDBX4FvPdDWvzCGQ
         1xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414339; x=1795019139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VQ9XIKkCNk3fozE5f1r68DOd14g401yrqdbfdhrwG8o=;
        b=hs7x67rDtkkwnZ57eJWBXAwLLGSB8BdTzX1nMWGrJwjVZejCJdkhWPSf5CBKY3CnqW
         kkFGZbnEh3hRemPnst9RxdgEyaGH8tPLdK/w5TmQhoL5vRNzDR17GmmEQaNdyCE3i4S7
         NZRYUB837UPvw+I1W6H3nL8Uy6yaOQ1NnuVkQwPwwmO2v/ndEW5XdCD57WLLEcu85Z1R
         OKyiZNuwY2Aqf3EFhat73kWF9tQhjDI3RDXqUlR6H53C9Wq1mt+czoVGzHJgDDn+Yabs
         B5Yqk+k5Rx+EDSRoRegqbma5S7Eo5FYl5z2m30piJYR5UbnoDs/W7fPK/hgDFCyW1XHc
         h4iw==
X-Gm-Message-State: APuU4Z/qM+P5An1c35l+DCBssXzsxtTe0dltbhi8O/yeIgorgVXiX6UP
	wNO+BJ0ISctGm8CKiRG6VW/A/oiECHkDKSWQBAFKKZhX+w15+Rmcj4SS1tey3g==
X-Gm-Gg: AYBFou2e/blSk01a63DeI+V6UcmENrRIO/gKLpY2mVgUlUyXtvvd3mGjjTPmdHqsXoq
	/+nmN82wrxU06eTLi6zkG+cAgNxChii/yRrrjcfS9I085ctytCUVHUOPtO/QAbzcd5ceT9kvxcp
	guFM3Ij2He/gDHhmMz0D7ahSzPlpAJWAWxsFKxZ8Wp2UjQZwHpU3tUN6EOt9gwOzPG0YzbSuP4+
	9hJ49Rdx7oRW0haJpWrnezGpDiFdzLkGPEA2H/lfYS+tV6R+7DNBIuBXXKnKXlBcUpp/kfKwNGL
	oHMBmjwPiOwaZfOg26aBBKVjIQE5/dSICVpaDyptf4myB4FM1VYt0b8hiejsMSsfp7nS6JWsx1X
	Rhrm7sd5trwEE/XaiF9qN/qzyywR43FaipE7DzMtnjxRo/7MmRkF8O4g7e1nou/OL6tZNLXxqx3
	+UCyWRBizJiftzM+bpxG/cb0cLS8xbZGI0QWsWKRFHPp9rnGFLHFuuPQhBuUAeDEBnhLn4YB5dG
	IbjbE4fpGYl6p+sjLmkvrS1UkyNgeSo0hi2OH42FVj+ieYe2ABWRazU9nawwP/rVvqtpQinilXP
	BGtYAj6Dj9nhD05AuGOk0pQsxD+pZezWf5FcO2vv2wq76WwSiLQT2H54DFPTXYn8hb1tj1dOd1M
	i4Dil1dL1PpflNmk8Hl+951XqVl1v/GWnhYikbWk/rbqZUZ8PBu4IptIc7CfLUfR/tDgPb2zwY/
	1KYv4=
X-Received: by 2002:a05:6102:290b:b0:7b9:5abb:eb17 with SMTP id ada2fe7eead31-7d494cdfadbmr1012526137.3.1794414339164;
        Wed, 11 Nov 2026 08:25:39 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/4] test: functional: Cover switching the direction of a CIS
Date: Wed, 11 Nov 2026 11:25:15 -0500
Message-ID: <1220e86b130d5e1fe9b29f0eb39a3cf13016c863.1794414122.git.luiz.von.dentz@intel.com>
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
 test/functional/test_bap.py | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 324304204caf..56205a61e61d 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -733,6 +733,74 @@ def test_bap_unicast_duplex_enable_one(duplex_hosts):
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
+    # Once neither is enabled the CIS is disconnected, so enabling one
+    # again needs a new CIS on both sides
+    initiator.send(f"transport.release {to_sink}\n")
+    expect_all(initiator, ["Release successful", f"Transport {to_sink} State: idle"])
+    expect_all(acceptor, [f"Transport {sink} State: idle"])
+
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

