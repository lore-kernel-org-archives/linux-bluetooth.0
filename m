Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656506;
	b=OdJHhQ65FA/RllGT5/J6rH+TCAHIVIdZG8dBhJxBK1CGxDutL4YhIMZL4UmTWci6OLkt
	 9znVacRaoC3e+MgpCNsifbuKr90rVWm2AYB7VNFTExkSuAZeHs3O58V4jJl5kI4UUVtHs
	 aa779wKex2Qs0R6CnNcCSDX9bG81iqV96UfBf5IoGfBNPczyPVl1OPtPKMfYmcWaC7DY3
	 TiEfkGi/Ilz8gUdSIAnQceHMfT7MH4DIg4j316K5ixQjAYFJ3wvf7z27+NoMY+8ndG3f1
	 tcRNLmnGT2EpjmZbOYslE3opQ/L6uqYB5/NSQReS57ou7rc2JnOPkWvNcXtE6orlKyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mhQIeRuo/lS7pkbq+6yasVvd9lG4uqLlIpKAbMY14Ug=;
	b=sD37h9DA5oLT4maDtt5HLvwxBZLev/S0ehtYzwmTgdUeuMcESvirAY+dHwaGHcaziAc9
	 WM9v6blGmOzn1M8Bfdl5vhVUl0GsVUnD0oti9+ZePQctd7yQDEC6LKWzSHaIBJJjrok56
	 GWL93tmwhsKTBi4QiiRh/e2gxdOjjk4SwBBw4XYUg6tpZp2aEjkRPKd8//ueM0etrR/Um
	 jYO7hSx6xvkc+lz8liDMM4M6fyTO+qk6PaDfj7Nqz2WAQiV3y70J3ETuEhdZy65WpjaXA
	 6LV9CN4SVV9nup6dyNvt+SgBThQ34CjQeE2h3J4V39JQTWgMra2s3ovo8Uv6HeMIQGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLZ0p2lH;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52392606A326
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 21:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52392606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MLZ0p2lH
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7c3cecbda48so724176137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 13:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656505; x=1794261305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mhQIeRuo/lS7pkbq+6yasVvd9lG4uqLlIpKAbMY14Ug=;
        b=MLZ0p2lHIllpjKZo2CjWWDCSLidemMIA/C7KX3Kl9F1sUQmvysB+ouO+iVnvBTEAFg
         n0uybQC/3IGHo59qfYrpu136+07PBIK8TXnvTbdzD2d/d8y6GywTYJ+PT3ZBu/YJjRkf
         teMj3vR7pi1jV5djFRmg1UgMYDo9R8vmq3Jt5RvVKbkFecqWa+j6bL5YePSJ8SD5h5jR
         nl2s7fhGnmujq/8DCmCJWfWhfvf+M2CoyXj13yVBU1TkTWzC3407xxT+ERVJ5BBm9347
         Z2UI+pqG0LnM/6k2mXoST1sSTr6BW6NRvLGKAP9u3SPcx/T1xuYoPHyLTbenOOfX9gvt
         vMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656505; x=1794261305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mhQIeRuo/lS7pkbq+6yasVvd9lG4uqLlIpKAbMY14Ug=;
        b=vU7wGa1ZXfeUrhTcuFxAghtO5VF+0JFD1PThauLumjAzB5hoQ3AkFGpv5o9TWFuPwb
         rPdNJo/Di0R/xDYEYINI5kXEdKscn+YBfAbZ93vjoU9+RkrrHvJks2FwD5mQkMuzzVNd
         eVk7+0f2/7ddTOLbrdjPEiMg+RutTKI3O8MDYYSjmJUhPWxybOk7wtLdInj0ibxpWhWw
         pXTYsLo6+PCeYgjGUB+KxM2Vvx0AG174i1P4/ieIrlwIKdj25sUUIhsmM6MYhbzAksYp
         gvdzDUzLbuX9X7KMWrQ6HfVzSNjojw4sEzJCX/FAHxihN2hDTtdS7w1SzkgHkEBdQGvC
         LmAg==
X-Gm-Message-State: APuU4Z8Ox+COVeOPTYwS1FtsTM+D8CNOevFF5g36hW3SPZ1hLacs7LwB
	XGSBpDUTWXQnv/PgwWYPLjF30hrn64F1OBg1gx/eIu5QzlCllMhZCVdeFX0MQfC4
X-Gm-Gg: AYBFou0EBSgo499rI6atyM/+JBXH4pTwh5aKIGnQjdJB7rooSL51F2kPw6JaPlatBr0
	WnMTHKAoBHAp/06opLIxJghCQ9Qc+Iv0O4oAHTxZ93fLv8N1Uh8+Ch1WQ87dQX7m87eAIeKrN+O
	F7DgP9fLcdyooEp2DEELuqGEmXfm+SAlctq+Xsn76XzH0BwGVpFn5+xnkhwwqC/4iJazvg21BSi
	LJfDiM+eXW65z07bfAyiOe7BLJUQZc3EXiu0dXQfWr0jUEKT4BMefC5wS2LdsXHFJcywnYZ2aab
	jHlT6AGiwZMgoMMbMht70IC/K7PE8qcud3FE76b58k/A6ApZPNuKvzMDG0sZTwQ/Q13aJCUHmMF
	Y3I8v9sweDlp+a5EhBFQerPbAHwAW1uCkNJPosgujYQMHdgxks6oD4zdgv/UaXJflcTouJwBRhy
	/p574e9F5ss9OTE75LHYmUZvRSUFCkOOmL5I+Wqb1FhLQI0wdK3F1QF4NJD7PkgyyFU+sSYZRFN
	ziCA5HNAvqlsExMMvBPyRkWKKPKLDPpGDjAE3MG8xm3pb3ZmWsD9LV001RtYBFbFYk7nzrmm+yu
	clc0/ZCYTPo6Pslly0WSJk+Yi/XAUXAcvKYuD4FrMebsXDFdxU/71vwy7FBzJVfHYgp/8T6qVLp
	lgWiyVMWBz9VQpFz5iDOGENSdPaJeq/bjdKbkQhSfL1quByG731FgwoZhRW68PQSl4/mfowl1Uh
	Mvqns=
X-Received: by 2002:a05:6102:358d:b0:7a7:198a:c2bc with SMTP id ada2fe7eead31-7d072d5e4a4mr5598057137.36.1793656505168;
        Mon, 02 Nov 2026 13:55:05 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07738ebf2sm11066184137.1.2026.11.02.13.55.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:55:04 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/6] test: functional: Cover enabling one ASE of a bidirectional CIS
Date: Mon,  2 Nov 2026 16:54:54 -0500
Message-ID: <20261102215457.2553416-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102215457.2553416-1-luiz.dentz@gmail.com>
References: <20261102215457.2553416-1-luiz.dentz@gmail.com>
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

Have the initiator, in testing mode, desynchronize its linked
transports and enable the Source ASE of the acceptor alone, as a phone
may do in a voice call, then check that the transport of the Sink ASE,
still in QoS Configured, is neither pending nor acquired along with its
link. Once both are acquired, release the Sink ASE alone and check that
the Source ASE keeps streaming on both sides.

Also check desynchronizing the transports on its own, so a failure to
enable the ASEs separately can be told apart.

Everything is driven through bluetoothctl, so the sequence can be
reproduced by hand with client/scripts/bap-duplex-lc3.bt.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 147 ++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 221efd982071..5a96cdba6294 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -583,6 +583,153 @@ def test_bap_unicast_reconfigure_metadata(unicast_hosts, metadata):
     )
 
 
+# The initiator runs in testing mode, so its transports can be
+# desynchronized and each direction enabled on its own
+duplex_host_config = host_config(
+    [
+        Bluetoothd(conf=BAP_CONF.replace("[General]\n", "[General]\nTesting = true\n")),
+        Pexpect(),
+    ],
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+)
+
+def show_transport(ctl, path):
+    """
+    Properties transport.show reports for the given transport.
+
+    They are indented, unlike the [CHG] lines of other transports that
+    may be printed in between, and a command with a known output is
+    issued after it to tell when everything has been listed.
+    """
+    ctl.send(f"transport.show {path}\nversion\n")
+    ctl.expect(f"Transport {path}", timeout=REPLY_TIMEOUT)
+
+    # Up to the end of the line, or a line still being printed would
+    # match only in part
+    props = {}
+    while True:
+        idx, m = ctl.expect(
+            [r"Version \d", r"\t(UUID|State|Desynchronized): ([^\r\n]*)\r?\n"],
+            timeout=REPLY_TIMEOUT,
+        )
+        if idx == 0:
+            return props
+
+        props[m[0].decode("utf-8")] = m[1].decode("utf-8")
+
+
+def show_state(ctl, path):
+    return show_transport(ctl, path)["State"]
+
+
+@pytest.fixture
+def duplex_hosts(hosts):
+    """
+    Initiator (host0) and acceptor (host1) each with a local PAC Sink and
+    PAC Source endpoint for a single location, paired over LE, with a
+    stream configured for each direction over the same CIS.
+
+    On the initiator, the transport of the remote Sink ASE is under its
+    pac_sink endpoint and the one of the remote Source ASE under its
+    pac_source endpoint. On the acceptor, each transport carries the UUID
+    of the local PAC of its ASE.
+    """
+    host0, host1 = hosts
+
+    initiator = start_bluetoothctl(host0, "bap-duplex-lc3.bt")
+    acceptor = start_bluetoothctl(host1, "bap-duplex-lc3.bt")
+
+    pair_le(host0, initiator, host1, acceptor)
+
+    # bluetoothctl only acquires a transport its local endpoint was
+    # configured with
+    paths = [
+        m[0].decode("utf-8")
+        for m in expect_all(initiator, [CONFIGURED + TRANSPORT_RE] * 2)
+    ]
+    to_sink = next(path for path in paths if "/pac_sink" in path)
+    from_source = next(path for path in paths if "/pac_source" in path)
+
+    # Each transport is reported when created and again under the
+    # SetConfiguration call of its endpoint
+    paths = []
+    while len(paths) < 2:
+        path = expect_all(acceptor, [TRANSPORT_RE])[0][0].decode("utf-8")
+        if path not in paths:
+            paths.append(path)
+    uuids = {path: show_transport(acceptor, path)["UUID"] for path in paths}
+    by_uuid = {
+        uuid: path for path in paths for uuid in (PAC_SINK_UUID, PAC_SOURCE_UUID)
+        if uuid in uuids[path]
+    }
+    assert len(by_uuid) == 2, f"acceptor transports: {uuids}"
+    sink = by_uuid[PAC_SINK_UUID]
+    source = by_uuid[PAC_SOURCE_UUID]
+
+    yield initiator, acceptor, to_sink, from_source, sink, source
+
+
+def desync(initiator, to_sink, from_source):
+    """Desynchronizing a transport desynchronizes its links as well."""
+    initiator.send(f"transport.desync {to_sink} on\n")
+    expect_all(initiator, ["Desynchronize succeeded"])
+
+    for path in (to_sink, from_source):
+        desync = show_transport(initiator, path)["Desynchronized"]
+        assert desync == "yes", f"{path} Desynchronized: {desync}"
+
+
+@duplex_host_config
+def test_bap_unicast_desync(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    desync(initiator, to_sink, from_source)
+
+    # Acquiring one transport leaves its link alone
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    assert show_state(initiator, to_sink) == "idle"
+
+    # The link is acquired on its own, over the CIS already established
+    initiator.send(f"transport.acquire {to_sink}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
+
+
+@duplex_host_config
+def test_bap_unicast_duplex_enable_one(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    desync(initiator, to_sink, from_source)
+
+    # Enable the remote Source ASE only, leaving its Sink ASE in QoS,
+    # while the CIS they share is established. bluetoothctl on the
+    # acceptor acquires a transport as soon as it is pending, as an
+    # audio server would.
+    initiator.send(f"transport.acquire {from_source}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {from_source} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {source} State: active"])
+
+    # The Sink ASE has not been enabled, so its transport must not be
+    # reported as pending, nor acquired along with the Source one
+    state = show_state(acceptor, sink)
+    assert state == "idle", f"{sink} {state} while in QoS"
+
+    # Once the initiator enables it, it is acquired on its own
+    initiator.send(f"transport.acquire {to_sink}\n")
+    expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
+    expect_all(acceptor, [ACQUIRED, f"Transport {sink} State: active"])
+
+    # Disabling the Sink ASE alone leaves the Source one streaming
+    initiator.send(f"transport.release {to_sink}\n")
+    expect_all(initiator, ["Release successful", f"Transport {to_sink} State: idle"])
+    expect_all(acceptor, [f"Transport {sink} State: idle"])
+    time.sleep(1)
+
+    for ctl, path in ((initiator, from_source), (acceptor, source)):
+        state = show_state(ctl, path)
+        assert state == "active", f"{path} {state} once the Sink ASE released"
+
+
 # Broadcast code used by the broadcast scripts, see BCAST_CODE in
 # client/player.c
 BCAST_CODE = (
-- 
2.56.0

