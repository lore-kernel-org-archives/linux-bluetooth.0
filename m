Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395789;
	b=FTGXbcf9VzC/CsKMFFs1OisBsqdojQROVNaOFLjFm8VgnTMvUjccbJnPwcF589FZoBRa
	 M/yFDa25PsD0pYOddfhqeexMQlZzJnhljQxjx0wRxCM7zcdpM5yX19TdOedMCcr2vMYSu
	 RD176ESO3aPjtMXUGiR6UKyhRA7+cgbtckTsaO/XFvh1Yi/fb2R5lCCDP2LegiylkkQ3K
	 G30OHf4ZRcctL3kOfPwkSoHu3IDi5zeiB/CntZDxmiuQkdlKMvhOh4LGTps5GpnWZVGK8
	 AXaYtVDD/RHRrmHV2+fEUFkSCAPRK2WpqKbzB/zYDRS8mWKoHKJVUFwpEuEeDteq62Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gp/dAcngbK6/Hvnl/jQrviAJOPJ310rn6P0SaToTUFw=;
	b=mXBWvDkWNpIX5VBLAmpPo+Qlhaqp5LmNoXTaXZhac2IgMNw0JVsY+5u5Kjy5JJZ9P0si
	 BtkqdpD4aLCZnJCG9t4wcbVleGXQKtjQHiR66bqOmO8/FRyQalLS6SGWruEPCY7ZMCrRo
	 18Fvl19zqVUmFPDmswGVZm1Qa3lRQhzaAd9oMzdkrV9XnqsNvIwkKD3I/8OcSMsAEsXRc
	 RWKw4maq88H3BrG14ECkO2MisBnkBwuXVty4QUCFHtRZNwAg4vvHDn0stpATfycVm0bK9
	 Bkp3JbzIYAv+Ln9li1ITMb/jZXzucbqlwqhEAbj6b05SWzF80eh+niGnPzsyF+Biq7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dfMKsu8u;
	arc=none smtp.remote-ip=209.85.217.48
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3D606A31F
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84E3D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dfMKsu8u
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7d06ecaf709so603974137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395788; x=1794000588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gp/dAcngbK6/Hvnl/jQrviAJOPJ310rn6P0SaToTUFw=;
        b=dfMKsu8uctIacioj0GLXJn7einwQRNWrivSnX6exvJbhPb4OzASUjOJsuosPeIUcLf
         VHvaMcEhKXKMQhEclNBrNIhyeB2UClV2xongD3079Q2a27fnVJUKGsNkjzWGZqjvvXo7
         /2/ku+0O4fp8nnNzj+IR2jLL4Dn91GigbElsN6Rl3jTBslIqtz+Im81n34PFqmZlnmzf
         3uK9ByCQlmrEBH068IQ+OMO2WOzzsftrmp4su8D7+9zEKuIrnlNgiSC1M0QuTXgp+2i7
         YgowRvESQ9K8NmsYMxc3DdHQw5BAMDGVa0QLnHjMbEyxkkrjaSeHnPaVMhgKs2l2UP0w
         NhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395788; x=1794000588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Gp/dAcngbK6/Hvnl/jQrviAJOPJ310rn6P0SaToTUFw=;
        b=zT0JMog9ZM0ZnAqJUUWYZpL/3O6gAB9EMdolxDQXy9uVuYmzeZzZkJEy6m3OrjnJ6F
         wITqzKezr3Hq5DNy+DuPyOGlCZ4/mbP9gBZnsenhV2FznJMq6shYqbemkEqVXTLRmOiV
         e/apV+sh53MOdymEenQ3LWWS7BzgKm4L++Vct9QU5BtDBPXfXipc/3LbP+uUGpQ+WSdQ
         vGZfeQFc0rVVR1z6p291ZEi9C2ivJ29f3TcFSnplJtsMQeti4grUENEg+sgzxo2pACKd
         IAovQKCkt1y/6Y/jJF3XECZ732xMtzs9nAmSBfVNVdrOYzCTJg+meSPi/AcCemEnmeGM
         0L2g==
X-Gm-Message-State: AFq9FYKDLdQhetZ31Itb12Zt1A81mSI5MOeohCA+4qP2PXU76mFVFX8E
	ukGB5vo2vTFXLunMft3igVeSpoFO6KBi9qYYk/mlBxO3KiXVELXL0ESNmMRAaw==
X-Gm-Gg: AYBFou3kNsq8MqKVcgUDwsNZwnTyKmnqkSVKGWJinpQEeRwzufV4/y540EGyCq1l7Up
	MX0psD78WK46E/FVMxv7MeQBwZli9Sl+UOTDO4CRZQa+NNOqhMp3WikgPT8SaWTu7aVlhytvpZS
	dBgWxVse9ys+/RKIkh+q4H9CW6TWkDCzr2AtBhpQDNI/Zca0aqaRMSzKbdkpCyVUNgVUuQcN6SE
	KQ3MQHOc0xAPN6do1cG6Gdc5tQjiy5CRnT7BAf/43JASKZxVzNk80VG/JbugbbRhrZAp3XaV2JC
	9ZDuehPIUO4q5qLW/HlFI77XFWVw1+Fsz4kOthguN/FpfeuX2SNVH72pbzm+yXdbLi7iP3PZPEB
	TiNpoxloF43fPQu4ND0Bu252a8wy+TQKlo0b2TG/ciHBYKI2BxYRKRrUG3RsnDF8NIFFoNoiOSe
	GgbS9UTYSUvIX1WIN5WEc6/+m+QSkf2oatL9vKfc1qqPSOAJXywmM85jNTePhuf+cX5/glvyJu6
	lO9n5k73m+A2sPna4JFAgnrLGRcgIrACpWkacZhvFPrGZyi0hbwLZp3Ggh5jlMocTFhe/+npSGg
	AutccV2abGNGyjSciFgLMBp7s6MZMgzweeY83lsIxjig3QxYW6LSgs5x4lUYG4swJhuLR0oYOYp
	fAjm8kbsWvMvno5VJHgTQvXL5RiIu51Ya5C4qEFoDX59DKdOUC6waP1XPEWhfvz9PRONGKienvg
	bxBf2zH1brveDUzwEW2SP0YbYF
X-Received: by 2002:a05:6102:c13:b0:7be:25d4:7ff0 with SMTP id ada2fe7eead31-7d072247a9cmr1781580137.4.1793395788372;
        Fri, 30 Oct 2026 14:29:48 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/10] test: functional: wait for BAP transports to be configured
Date: Fri, 30 Oct 2026 17:29:34 -0400
Message-ID: <20261030212940.753771-6-luiz.dentz@gmail.com>
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

bluetoothctl only selects or acquires a transport its local endpoint was
configured with, which it learns from SetConfiguration, while the
transport object may be reported before. The tests acting on transports
could then fail with "transport endpoint not found" when the call came
later, as happens under User Mode Linux.

Wait for the transport reported under SetConfiguration in the tests
selecting or acquiring it.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 7cd9466bd5f7..221efd982071 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -37,6 +37,11 @@ ControllerMode = le
 
 TRANSPORT_RE = r"Transport (/org/bluez/\S+/fd\d+)"
 
+# A transport is reported once created, and indented under the endpoint
+# SetConfiguration call once its local endpoint is configured with it,
+# which bluetoothctl requires to select or acquire it
+CONFIGURED = "\t"
+
 
 def dev_addr(host):
     return host.bdaddr.upper().replace(":", "_")
@@ -259,14 +264,15 @@ def unicast_hosts(hosts):
     yield host0, host1, initiator, acceptor
 
 
-def expect_transports(ctl):
+def expect_transports(ctl, configured=False):
     """
     The endpoint is configured for stereo, so one stream per location is
     created, each with its own CIS in the same CIG.
     """
-    _, m = ctl.expect(r"Transport (/org/bluez/\S+/fd0)")
+    prefix = CONFIGURED if configured else ""
+    _, m = ctl.expect(prefix + r"Transport (/org/bluez/\S+/fd0)")
     left = m[0].decode("utf-8")
-    _, m = ctl.expect(r"Transport (/org/bluez/\S+/fd1)")
+    _, m = ctl.expect(prefix + r"Transport (/org/bluez/\S+/fd1)")
     right = m[0].decode("utf-8")
 
     return left, right
@@ -292,7 +298,7 @@ def test_bap_unicast_transport_created(unicast_hosts):
 def test_bap_unicast_transport_acquire(unicast_hosts):
     host0, host1, initiator, acceptor = unicast_hosts
 
-    left, right = expect_transports(initiator)
+    left, right = expect_transports(initiator, configured=True)
 
     # The CIS are only created once every CIS of the CIG is ready, so
     # all the transports need to be acquired
@@ -627,7 +633,7 @@ def test_bap_broadcast_transport_created(hosts, source_script):
 def test_bap_broadcast_transport_acquire(hosts, source_script):
     source, sink = start_broadcast(hosts, source_script)
 
-    _, m = sink.expect(TRANSPORT_RE)
+    _, m = sink.expect(CONFIGURED + TRANSPORT_RE)
     transport = m[0].decode("utf-8")
 
     # Selecting the transport syncs to the BIG and starts acquiring it
@@ -682,7 +688,7 @@ def expect_bis_transport(ctl, host, bis):
     Transport a side created for the BIS carrying its own channel,
     checking it is the only one it has.
     """
-    _, m = ctl.expect(BIS_TRANSPORT.format(bis))
+    _, m = ctl.expect(CONFIGURED + BIS_TRANSPORT.format(bis))
     transport = m[0].decode("utf-8")
 
     # Checked over D-Bus rather than with transport.list, as the
@@ -942,8 +948,8 @@ def set_hosts(hosts, secure_connections):
             "Pairing successful",
             f"DeviceSet /org/bluez/hci0/{SET_PATH}",
             f"Device {host2.bdaddr.upper()} Bonded: yes",
-            TRANSPORT.format(dev_addr(host1)),
-            TRANSPORT.format(dev_addr(host2)),
+            CONFIGURED + TRANSPORT.format(dev_addr(host1)),
+            CONFIGURED + TRANSPORT.format(dev_addr(host2)),
         ],
     )
 
-- 
2.56.0

