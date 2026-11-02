Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656504;
	b=iYgvsemE7QJOtiM3xsqDYi3aHWQZ5BOYSF3f+6Wwhp905CCvWq7M/HdsbWnHUbk0U2Df
	 ZA6kt3T+A9ojbLxzrtvzYYxBOIDVFp36FTW1URl5jRTZ/i0+AFSK3kbLJqak1MqGDn/vP
	 xtoSsX5LgOq824e/4JWx6dlJmmzLYgar0NOgcy4A8X16ufeBdIPpkhFE8ns+p+R60u5cp
	 O4M3FyMI29aArKM8dMUv9a/g/WgPI6+R36otCqDMLrW28N3F2A3XIod6aR2IsScXwKz6u
	 6NyAZwS6V7JaS875Cbg/YG4v3Q6XB6Wzq2LZJf9Az+3KipsSRrhulJg9XtXmdb2lr3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GMRcYyDynoqGRkVE2BEYwHQ2SYNW7Eu/4032ACRLg7o=;
	b=FjTqt4dfl6W8BlbgvGFAFaMsceco4NNvJOG9ruZO3pnc2cG6TZdBpQFIiV2LqTEyu7tX
	 5y6vTV6Y2NFbgsNBNeaEE1ojyr++RSiYKJMia8iGWe1Y8jvSHqJDGp/Q/eyWmVDB7T8DK
	 TKOtcSw6rsYqIX9ltYjka+yI/aOAisslLrO37gsfVm7X9AbIBg6rIG6uOfCRB5HGg/3xV
	 SCZ/sYuu8Oo0+pfv8xc4x+hWCzrzEHlrOZPcnpMIILzN55J2yp2hxnbN1foRU0iMIiZfj
	 zEQBwjx1SL8Mz4zOWK+pytd4UNJGxwBa7c7/RGB/W2rlyaGej75a45B3GE24fdlynvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=msOkUiLW;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAC606A329
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 21:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77AAC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=msOkUiLW
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d06763335aso1145286137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 13:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656503; x=1794261303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GMRcYyDynoqGRkVE2BEYwHQ2SYNW7Eu/4032ACRLg7o=;
        b=msOkUiLWPPpwLKVShL2J80q1qTjl1MwK++Z/MN2PODqiPM8WMcinxkIGrUALgpx8nh
         W030sZ2IsgN/mOIjaoeOh0IFqpDOwvtszJXHKaz9YkloQWj/nabyWFozAkr45+4rkAvz
         vkEu1J9ndozEKzaavS/tB0k9px/WrqLzd5lB/MyIyD5KooGVmqXn6adTKshRJQrFakMI
         dT0vubXUi/3TKvZzgHAb/7JaqmddGqh8JdtWZ4CLikGSQLSUzaTm7AYmgd+9H0GQzs3N
         HGvk5VSvKTv80G7SgTRI3qw9BC0o84tDIZQWIaSGymhTsx3R8UF/mUbGe9S9BFCrnRXn
         DE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656503; x=1794261303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GMRcYyDynoqGRkVE2BEYwHQ2SYNW7Eu/4032ACRLg7o=;
        b=xC+DPIzgT0NzxFOcu/LylEOTgSS6khd7Y+oTj48y+ZQ3ddOVSB//ytx6RchVJHlCMS
         e6rzLif4Rc/gZrm+YV/9uZltzbU0zfxgACBXK+gnwDVC1/8Taqa3gNYN2UerpqMm++0l
         /TnaEev7NgLePO0GZgH4ZVpaSaXKeS9PanrcKz2Q+/+kBtQUkFFVUZVnfLqPnbWTeqg5
         H+aPwOmudjPDFpkBxDzbOUWv5Lm0uwu/sIc1OMNPGCcO+Bi9dvjyGncNxJKLp5WwHFew
         2YelzxhL4IEWEsdl9CW1TifY20vn/5qdhCW+wqYAy/UjqZxfNrDhgnC9nkboYZi+PdWx
         qYJw==
X-Gm-Message-State: APuU4Z/pUWC4rG3iMMNYeN/undrT2AFrBkUJ8Br9DD0lQfYS7FM5CGDF
	eb/0EB9vaJ9tqpJsoUQctSAgVRRk3MrzyDHDnCjMe2J5+70S3OMglGmoz4l8luVq
X-Gm-Gg: AYBFou02I45/ID0IwafL3aCVGGBzKmMuS+VZGeijm7ayACvkCv46x/iB+qzFkdpCCcC
	qIGAcK8Rl3jM4n+XVVaJo/yQCebO/6EuRSCS+ogQwn6hgfy14Sknpfb/2kXjEwhRfHrTqHYTSM9
	IfRsyftxoDl//LSngr0D3LjqcGxrjHgURi3HA8T6ASKb3iI206/pe32yBpSRz7+QWAN+5d4w8cw
	b0wCAChjnv61Ds2075vmSh2PheGCkPgl3RWhkoHuTeVDIzf8dceD0cYjyJQcLZsvllBvyd3nN87
	nBdHJjBB125nKsjZ5MFn72KQvAXJaIvQjZbof6Wi2mWDma6ROiz2pIqMe2eD2lGO9nfhKkppxw3
	jAQrLfxDlYCWw/7GeD8tgdzrFXFL7leLU1SdesrjggSvora5wAMo++WZJ/NhVZ58IKxOzS91EYl
	ClljYHsOrxH8B94isckWP3XhmtG0CbgObu3j3+xQfvH/+ySjwvKeQlG3IjZ6APLA6+WuTR7whCl
	k1iC27aneHeFhMzrdW/FY1DDl8oqeRuhRZvirfU37tTrUDQ1khRRYzZvKqnrbNa03EY2iQRLD/c
	ZWk3ytLdvoKOkogZBEoPdIJSG8k8DQT3GZrCRFcFQ5+EXm0VUv++jIwZeeU55tIVpZ1OCcxs5hO
	Em5hYoew4otGpwJ2OWKze7cEZW0EJoDj6nklzcLt3EUkyKl3S1xbbH5Xx9yZ6o4zuXzCJkCzczn
	i/zwG18VJpDqJQYffy9LvbB8BU
X-Received: by 2002:a05:6102:148c:b0:7c1:bc57:c7f5 with SMTP id ada2fe7eead31-7d072bb320cmr4454772137.12.1793656503435;
        Mon, 02 Nov 2026 13:55:03 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07738ebf2sm11066184137.1.2026.11.02.13.55.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:55:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/6] doc/functional-bap: Document the duplex unicast test cases
Date: Mon,  2 Nov 2026 16:54:53 -0500
Message-ID: <20261102215457.2553416-3-luiz.dentz@gmail.com>
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

Describe the topology with a stream for each direction over the same
CIS, the test of the Desynchronized property used to enable each
direction separately, and the test of the acceptor when only one of
its ASEs is enabled.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 112 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 42fa7fda8006..fc367e0f9181 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -157,6 +157,118 @@ test_bap_unicast_reconfigure_metadata[empty|media]
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
+**org.bluez.MediaTransport(5)** writable, through ``transport.desync``,
+so each direction can be acquired, and so its ASE enabled, on its own.
+The acceptor does not run in testing mode.
+
+Everything is driven through `bluetoothctl`, see
+**bluetoothctl-transport(1)**, so the sequence can be reproduced by hand
+with the same script. On the initiator, the transport of the remote Sink
+ASE is the one under ``pac_sink``, and the one of the remote Source ASE
+under ``pac_source``. On the acceptor, ``transport.show`` reports the
+UUID of the local PAC of the ASE of each transport.
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
+	1. Initiator: ``transport.desync <sink transport> on``.
+	2. Initiator: ``transport.acquire <source transport>``.
+	3. Initiator: ``transport.acquire <sink transport>``.
+
+:Expected:
+	1. ``Desynchronize succeeded``, and ``transport.show`` reports
+	   ``Desynchronized: yes`` for both transports, as it applies to the
+	   links of a transport as well.
+	2. ``Acquire successful: fd <fd> MTU <read>:<write>`` and the
+	   transport moves to ``State: active``, while its link stays in
+	   ``State: idle``.
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
+	desynchronized on the initiator.
+
+:Steps:
+	1. Initiator: ``transport.acquire <source transport>`` only, so the
+	   acceptor's Source ASE is enabled and the CIS is established,
+	   while its Sink ASE stays in the QoS Configured state.
+	2. Acceptor: ``transport.show <sink transport>``.
+	3. Initiator: ``transport.acquire <sink transport>``.
+	4. Initiator: ``transport.release <sink transport>``.
+
+:Expected:
+	1. The acceptor's Source ASE transport is acquired by
+	   `bluetoothctl` and moves to ``State: active``.
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
+	`bluetoothctl` acquires a transport of its endpoints as soon as it
+	is pending, as an audio server would. Depending on which transport
+	it acquires first, the Sink ASE transport is either rejected or
+	made active through its link, so the test checks the state of the
+	transport rather than the result of the acquisition.
+
 BROADCAST
 =========
 
-- 
2.56.0

