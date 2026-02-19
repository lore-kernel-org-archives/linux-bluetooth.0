Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C6340285
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518166; cv=none; b=mQSHqNmV2smNjM/xuwIyGMarp27qaN9x8foY2cv05wKcsjQ1dmVrA6ygI721Pg+upNvzRzenkH9vZtJIrHuCTo1vl/lmM6jjZL2ZK0ib7VrTyXhywQyhAbn62nVvtUgeUbd0RR54jBM20H00p/E82T24Xo+X7dFHgJLQZQat/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518166; c=relaxed/simple;
	bh=JkYZP3JBz/ovYOwOjixhYUqk5jXGuD6SzRtYtu34UuM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMsbvggmWPKeT/xiZZMU5jmDg/g0X//T4keX0fAtNWBVFT4HWciXxjiZbGJWlggKx52aBqVFvEGliZWrAcuccMvztpBg7O0QYvk8mSfsT+7biBHU9vrvpHiFKq2tSXZreLaDWg1IacX4aEnzcYKQqLr9DaZAiApMGEbL1hLaUio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnGuNTiT; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnGuNTiT"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5670ea44187so875584e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518164; x=1772122964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2cJPOPF6syakadFoXXTnrP9LMIdS/ULz4KbpOEDK3w=;
        b=hnGuNTiT7+Q4vfzGX/zuuIGMGqzdoqhmkZ8v3EkPc2XlJC4hvXk8z6nzJu6KOHjfC1
         dk628bojZlgZu36NsYbHiSj2jQLxWkmF5Nl0pfDCUu3XceMRnVDBpG9jniPA2F0wgocy
         xVZhEu4Pw8g2P0CXfUyPTxhRCBmTHJO+DalT3lgePXYfBePWHYfK1ZxaooyBZ1INy7im
         XJrm2pX4LT9yKCI1El6OhxWePUQ/u0btcpaUIggmUM4MqMgueYxGvvplSYyIbANwQj0a
         iYjxj6crsJ6p7i8rwCH5klYajxR/X7x510P3NfA+nxcmDI1Y5aFxhbaUp16OKi6ggJ6B
         3eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518164; x=1772122964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2cJPOPF6syakadFoXXTnrP9LMIdS/ULz4KbpOEDK3w=;
        b=iwF8f/mk/AN+zzQ8iV0zLVAkYo8dQRVbqAzA/qdDkdj3RdQjomMkujujoFS5ix937d
         ETpjZ/DY/FhKDZuyh7SFeGSi8HbKCjPfUgGHv4rcFL9pyca46BA1scq7y0jplgOoqJq3
         xfayooXDQmmaDp6N2wxpxAsV9rYuULvOC0YAF7vySW0spAzlAj3wN+20PGQ5yh6PpX+c
         R/G9hGu7zuOlZ5SNyq+cm4p67vsyYfU57N3WZUF5xDbystq+6aGZCkxLY9u8+DVE+KqL
         +3OqboXzquJiDmxex9HqQR2ll79PJRnrBERI9lse4O0LmZsoq+XoVDKp27ay0EqeOtpU
         GNnw==
X-Gm-Message-State: AOJu0Yx3TR7kmmMiSOknXV5c3s+Kl6w0p5Yw6Tl/rFJGxNgso5T/HW+g
	C0qDyyfkB1z06bPgmX97Gw3uk11vllkOT/EsThdgIMokFU4Qr9/Vi5Clp1sg6LH2
X-Gm-Gg: AZuq6aLZ9EJeFeD3gex6TQ5+fxuZJyDJ3Mr1jpOPCe31E+P7N3QD58g4EwzpkNl61XF
	aTbJOZd5uko7tbd3lbV4YuLxQSiWoimXVmXqc3Akg465g6mLGQgX7/B3eoN66FcDuB/ZFCP4U//
	8ReYS1l3oYORll0IXjvl+MaZOumqRwRnmAb0lNnM5B2FETla+gUsNyqFwr0eDtdcHQ237XhSNcL
	HnwqsrZ8A/WFz2JJ0iSsAasmkZR6Xp2mfJHjGNcpF4QrP+7/GhZ6eqBnH1dE6/HFz8wlrvrPGSU
	IaX/SV0NNUGDTqDBjawD5YCqKAh58tSJVOLHBLvPZgjuqb2jLQRXcNwncoQtGN0fxCVrmRL27Mt
	FRy7FqEKnixji7PGq1lPV1McRLvyxz9MuWYvhPCXocznEzsq3AVLKCzUerE1gwcMoK81b2UPG2i
	Ti1YRunYetRU00JWtC8HthA/U8tEC6CxUwiyS1n8W6ULTgScbTke+uKFAuA6OpDO7SJxE0J81PI
	tTWQUdTztrhfk9/qQ==
X-Received: by 2002:a05:6123:125:b0:566:2302:f317 with SMTP id 71dfb90a1353d-568bf5faa72mr2958409e0c.20.1771518163538;
        Thu, 19 Feb 2026 08:22:43 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20a659sm14435235e0c.11.2026.02.19.08.22.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:22:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/8] doc/btmon: Add a section for automated trace analysis
Date: Thu, 19 Feb 2026 11:22:27 -0500
Message-ID: <20260219162230.3074355-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219162230.3074355-1-luiz.dentz@gmail.com>
References: <20260219162230.3074355-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a section dedicated for automated trace analysis which can be
used for analysing traces programmatically or with use of AI assistance.
---
 doc/btmon.rst | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 66a97859a49e..70cdb90e37ab 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -740,6 +740,81 @@ Open the trace file with full date and time
 
    $ btmon -T -r hcidump.log
 
+AUTOMATED TRACE ANALYSIS
+=========================
+
+This section provides guidance for analyzing btmon traces
+programmatically or with AI assistance.
+
+Recommended Workflow
+--------------------
+
+1. **Get an overview**: Start with ``btmon -a <file>`` to see packet
+   counts, connection handles, device addresses, and traffic volumes.
+
+2. **Decode with timestamps**: Use ``btmon -t -r <file> > output.txt``
+   to produce a text file with wall-clock timestamps for analysis.
+
+3. **Identify connections**: Search for connection establishment events
+   to build a handle-to-address mapping::
+
+       grep -n "Connection Complete\|Enhanced Connection Complete\|CIS Established" output.txt
+
+4. **Track disconnections**: Search for disconnect events and their
+   reasons::
+
+       grep -n "Disconnect Complete" output.txt
+
+   Then examine the lines following each match for the ``Reason:``
+   field.
+
+5. **Identify LE Audio**: Search for ASCS and CIS activity::
+
+       grep -n "ASE Control Point\|CIG Parameters\|Create Connected Isochronous\|CIS Established\|Setup ISO Data Path" output.txt
+
+6. **Check for errors**: Search for non-success status codes::
+
+       grep -n "Status:" output.txt | grep -v "Success"
+
+Key Patterns for Connection Lifecycle
+-------------------------------------
+
+A complete connection lifecycle for an LE ACL connection follows this
+pattern in the trace:
+
+1. ``LE Enhanced Connection Complete`` -- connection established,
+   note the Handle and Peer address
+2. ``LE Connection Update Complete`` -- connection parameters changed
+   (may occur zero or more times)
+3. ``Encryption Change`` -- link encrypted (may show encryption
+   algorithm)
+4. ACL Data with ATT/SMP/L2CAP -- service discovery and data exchange
+5. ``Disconnect Complete`` -- connection ended, check Reason field
+
+For LE Audio connections, additional steps appear between 3 and 5:
+
+- ATT operations on PACS/ASCS characteristics (codec negotiation)
+- ``LE Set CIG Parameters`` command and response
+- ``LE Create CIS`` command
+- ``LE CIS Established`` event (note the CIS handle)
+- ``LE Setup ISO Data Path`` command
+- ISO Data TX/RX (audio streaming)
+- ``Disconnect Complete`` on CIS handle (stream ended)
+- ``LE Remove CIG`` (group removed)
+
+Vendor-Specific Events
+----------------------
+
+Vendor-specific HCI events (event code 0xFF) contain
+controller-manufacturer diagnostic data. btmon decodes some vendor
+events for known manufacturers (Intel, Broadcom, etc.) but many
+sub-events show as ``Unknown`` with raw hex data. These are expected
+and generally not actionable without vendor documentation.
+
+Intel controllers emit extended telemetry events (subevent 0x8780)
+that include connection quality metrics, error counters, and firmware
+state. Partial decoding is available in ``monitor/intel.c``.
+
 RESOURCES
 =========
 
-- 
2.52.0

