Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548C4F3937
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569108; cv=none; b=ffPruqg7yFV10c3tS0pyRdSASpbX8qQvV0iwXsW3vOGTBcbJTTrHYld/ptbeRHuqiFzmZAhxm7qivbNCNlvh0rJGjllc5H5qRB6c6AyMqzZUNevNiY05/Wm17v0Zm7pge/ORPc/zOpJWW004YLPuZp42iVX1BesNqyaIV4sToPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569108; c=relaxed/simple;
	bh=4OjW4S4qKsylhMeqMyUnVcGtULxdF/El6D2UCaNNLO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVikOlkrXVWiZwR+90ed1EJmfCWdByDRh6WJsa2PE6VIyQHHvygqidklx3+DeBm0dPnJ3CzOOZeKTFqNKte6QjyoH0OJlDCrmfcjDDp7cxpEZxFxdhlS+iVYMQd3DgNP7950eukTMezUimq5JmMx9j7hGNC9R52jKDoNHVIyO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=Ox+1BkBK; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="Ox+1BkBK"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so4680201c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791569106; x=1792173906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LFEzyoS4WB/tT+FiqbGyTZ41B9ZbiutrOGzR2AoeTOo=;
        b=Ox+1BkBK+qxvyzlvKZI0Ez+ubuK1h9NfeOAU3i2j5JQUKNUhRQG876sBFlKIhyPSmp
         HkE+f+tEzdKhHBChtSLrOqD1wowWOLCLdphej1PzvicXDw/kTP1MdkpXT6zWjpr+AsKq
         wmU5RjE+MszHLi1h7+u2RGm0y8ACI41FBW1aDmWsr+3PIcXCXnOPCnWlpiJbtFqXmFLF
         jvxzMcNRdPUlgXIsNSQHWSCSnX51Z8NUz8NGUl7H18fy6O1UbvgGglc8PMi342OLAlNH
         wn/dNW2Nq0LS8aIKYv/YkzmA4z2Y09ox1qcyE/qVrbOcVFI1s5wBzIPqxHOiQ64dlz5C
         1brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569106; x=1792173906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LFEzyoS4WB/tT+FiqbGyTZ41B9ZbiutrOGzR2AoeTOo=;
        b=TC+SPj5AzKBY1rTQyKFYUlSY8qeWrbejT1lRH51KmRSg1B3dB8Ui/MQxv3BAxRep17
         b5z/CEXs10vWvdEz7DMy0VJ/dwAnooaDZu47NuwbcsOkNGEktlDXlagEWMJdMSmUOnHP
         j3uLPu1MlUF662+v1BZehJo4djpjALMs10YDeN3sjBFijP0djSiYBwPr4iVrZCgvojU9
         M8X9sgDEErQXUhO8hyuZyYzqlMNSQinGkwaV2EXTNX3WabbKqHgtAGsuhr34wv0UUQtn
         n1A8BXNiYwystx5xB6aG7SaSqCUHQalH+nliOI+571lEFHYbUNG88WV/x3RwfnCqbZJQ
         gkzw==
X-Gm-Message-State: AFuF++mXnwcg2QAt8ehAfR1iJa+GFfv4jL067uA6I9OLDKR48K8lwI+W
	cta07CvdZSc/rsXvm1+/Eehci8Mz9JEJUsyVoVS/JL1c04UiPkwZA3B3sUmGl4us2UCW4u/5+Ug
	XDxIz
X-Gm-Gg: AYBFou2pGV/H24LEvbqGn6+5Jd8K//H4/Md4Vm8apkpoy34v4O1rFR/2IAEIJ9uE/Qw
	rnqUJnDPvkgWQgE93hZdDrc5VXSJA/mrLdgsNY7/r5i6Ja0qdzd7pHwesxnu2Pie37wsbpW0rDt
	Yl8c/qmUkaEz0jDpqzcd+R9ekuvXUHDy4EgDXXUZD8M51JXWZcfy0eCQ28c1LqQMdznlPvzQ2y4
	XKc5UPd2XTRVFjqStyNrw4WoFo8M8KR+2DBMfJ55dLEmTweElcF55RzYLN5m/AO/DxbqVDcf2GJ
	blgEjhpwFAOAfEkBRInLsWb0WQotDX1mLSIx2uWk8+Y9ov64RwAEKFPE8iwociCCAQHo+MPU5EC
	lb+/x50YPUD9r8C4dzZnCJEUyABivILXTL2yeer3npU42vcmmbJKS8lImChpaKTcjsq1JzQad2J
	6SQUmlVHugJgLt1AQrV/vkajuKOhXqBa+ShNEJ/5i12HFfPkOwScE2+FvMCsMaILQwYlfTEo/RQ
	msSXgc/8pXtJjU6l/0IORcV+p9XutU9qap6eT22txzcDdX7fQYTzXF84ac4Cz+Q7vX1Tm2vdtre
	/riSzBlFQCqM9x8TmHj1PLYLXMn8Hmxbcx7qscSvZstdfDIeDw==
X-Received: by 2002:a05:7022:170c:b0:16b:fa6d:b121 with SMTP id a92af1059eb24-16bfa7cf6c4mr1724640c88.0.1791569103792;
        Fri, 09 Oct 2026 11:05:03 -0700 (PDT)
Received: from localhost.localdomain ([12.158.218.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm16111163c88.13.2026.10.09.11.05.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 11:05:03 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 4/5] doc: Add functional-bearer documentation
Date: Fri,  9 Oct 2026 11:04:47 -0700
Message-ID: <20261009180448.29117-5-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009180448.29117-1-kevin@simpleble.org>
References: <20261009180448.29117-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the bearer functional tests, where two hosts connect or pair
over LE or BR/EDR and each checks the org.bluez.Bearer.LE1 and
org.bluez.Bearer.BREDR1 properties of the device object it has for the
other:

- Connected and Role on both sides of an LE connection, and the
  Disconnected signal with its reason on both sides
- Connectable for a connectable advertiser and for a broadcaster
- Paired, Bonded and Connected after LE and BR/EDR pairing, Role being
  only reported for LE

Assisted-by: Claude:claude-opus-5.5
---
 Makefile.am                |   1 +
 doc/functional-bearer.rst  | 141 +++++++++++++++++++++++++++++++++++++
 doc/functional-testing.rst |   1 +
 3 files changed, 143 insertions(+)
 create mode 100644 doc/functional-bearer.rst

diff --git a/Makefile.am b/Makefile.am
index 71f93d2f1..f742458d1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -499,6 +499,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/functional-a2dp.rst \
 				doc/functional-avrcp.rst \
 				doc/functional-bap.rst \
+				doc/functional-bearer.rst \
 				doc/functional-hog.rst \
 				doc/functional-mpris-proxy.rst \
 				doc/functional-obex.rst \
diff --git a/doc/functional-bearer.rst b/doc/functional-bearer.rst
new file mode 100644
index 000000000..79fed9db3
--- /dev/null
+++ b/doc/functional-bearer.rst
@@ -0,0 +1,141 @@
+=================
+functional-bearer
+=================
+
+DESCRIPTION
+===========
+
+Bearer functional tests, `test/functional/test_bearer.py`, covering the
+**org.bluez.Bearer.LE(5)** and **org.bluez.Bearer.BREDR(5)** interfaces
+of the device objects. See **functional-testing(7)** for the conventions
+used here, and **test-functional(1)** for how to run the suite.
+
+SETUP
+=====
+
+Two hosts, both running **bluetoothd(8)** with ``Experimental = true``,
+as the bearer interfaces are experimental, and with the MIDI plugin
+disabled (``-P midi``), as the MIDI profile would ask to pair as soon as
+it finds the MIDI service the other host exports:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |   LE or BR/EDR  | host1                  |
+	| bluetoothd, agent      | --------------> | bluetoothd, agent      |
+	| connects or pairs      |                 | advertises (LE) or is  |
+	|                        |                 | discoverable (BR/EDR)  |
+	+------------------------+                 +------------------------+
+
+	--> connection is initiated by
+
+The LE tests run **bluetoothd(8)** with ``ControllerMode = le`` and have
+host1 register a connectable advertisement, as bluetoothd does not
+advertise on its own in that mode. Both hosts register an agent with
+the ``NoInputNoOutput`` capability, so pairing is Just Works.
+
+Each host reads the bearer properties of the device object it has for
+the other host, and records the ``Disconnected`` signals of the bearer
+interfaces.
+
+TEST CASES
+==========
+
+test_bearer_le_connect
+----------------------
+
+:Setup: As above, over LE.
+
+:Steps:
+	1. host0 calls ``org.bluez.Adapter1.StartDiscovery`` and waits for a
+	   device object for host1.
+	2. host0 calls ``org.bluez.Bearer.LE1.Connect`` on it.
+	3. Both hosts read ``Connected`` and ``Role`` on the LE bearer.
+	4. host0 calls ``org.bluez.Bearer.LE1.Disconnect``.
+
+:Expected:
+	1. host1 is discovered.
+	2. ``Connect`` replies.
+	3. ``Connected`` is true on both hosts. ``Role`` is ``peripheral`` on
+	   host0, which initiated the connection, and ``central`` on host1.
+	4. ``Disconnect`` replies, and the LE bearer emits ``Disconnected``
+	   with ``org.bluez.Reason.Local`` on host0 and
+	   ``org.bluez.Reason.Remote`` on host1. ``Connected`` is false on
+	   both hosts and ``Role`` is no longer present.
+
+test_bearer_le_connectable
+--------------------------
+
+:Setup: As above, over LE.
+
+:Steps: host0 discovers host1, as in test_bearer_le_connect, and reads
+	``Connectable`` on the LE bearer.
+
+:Expected: ``Connectable`` is true, as host1 advertises connectable.
+
+test_bearer_le_not_connectable
+------------------------------
+
+:Setup: As above, over LE, except host1 registers an advertisement of
+	type ``broadcast`` that is not discoverable, i.e. it advertises as a
+	broadcaster, with the service UUID
+	``6e2c1d84-7a3b-4f50-9c1e-5b8d2a7f0e13``, and runs no agent. host0
+	runs **bluetoothd(8)** with ``FilterDiscoverable = false``, as
+	otherwise it only creates device objects for discoverable
+	advertisers.
+
+:Steps:
+	1. host0 calls ``org.bluez.Adapter1.StartDiscovery`` and waits for a
+	   device object advertising the service UUID.
+	2. host0 reads ``Connectable`` on its LE bearer.
+
+:Expected:
+	1. The device is discovered.
+	2. ``Connectable`` is false.
+
+:Notes: The kernel sends non-connectable advertising from a
+	non-resolvable private address, so the device object has that
+	address rather than host1's, and host0 finds it by the advertised
+	service UUID instead.
+
+test_bearer_le_pair
+-------------------
+
+:Setup: As above, over LE.
+
+:Steps:
+	1. host0 pairs with host1, which authorizes the pairing.
+	2. Both hosts read ``Paired``, ``Bonded`` and ``Connected`` on the LE
+	   bearer, and ``Paired`` on the BR/EDR bearer.
+
+:Expected:
+	1. ``org.bluez.Device1.Pair`` replies.
+	2. ``Paired``, ``Bonded`` and ``Connected`` are true on the LE bearer
+	   of both hosts. The BR/EDR bearer is not present, as bluetoothd
+	   runs with ``ControllerMode = le``.
+
+test_bearer_bredr_pair
+----------------------
+
+:Setup: As above, over BR/EDR.
+
+:Steps:
+	1. host0 pairs with host1 as in test_agent_pair_bredr[accept], see
+	   **functional-testing(7)**.
+	2. Both hosts read ``Paired``, ``Bonded``, ``Connected``,
+	   ``Connectable`` and ``Role`` on the BR/EDR bearer.
+	3. host0 calls ``org.bluez.Bearer.BREDR1.Disconnect``.
+
+:Expected:
+	1. Both agents confirm the same passkey and ``Pair`` replies.
+	2. ``Paired``, ``Bonded``, ``Connected`` and ``Connectable`` are true
+	   on both hosts, and ``Role`` is not present, as it is only
+	   reported for LE.
+	3. ``Disconnect`` replies, and the BR/EDR bearer emits
+	   ``Disconnected`` with ``org.bluez.Reason.Local`` on host0 and
+	   ``org.bluez.Reason.Remote`` on host1. ``Connected`` is false on
+	   both hosts.
+
+:Notes: The ACL link is terminated a short time after the profiles are
+	disconnected, so the ``Disconnected`` signal follows the reply to
+	``Disconnect``.
diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index 7b3cad1c6..371258261 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -15,6 +15,7 @@ are documented separately:
 - **functional-a2dp(7)**: `test/functional/test_a2dp.py`
 - **functional-avrcp(7)**: `test/functional/test_avrcp.py`
 - **functional-bap(7)**: `test/functional/test_bap.py`
+- **functional-bearer(7)**: `test/functional/test_bearer.py`
 - **functional-hog(7)**: `test/functional/test_hog.py`
 - **functional-mpris-proxy(7)**: `test/functional/test_mpris_proxy.py`
 - **functional-obex(7)**: `test/functional/test_obex.py`
-- 
2.54.0 (Apple Git-157)

