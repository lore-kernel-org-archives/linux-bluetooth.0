Received: from mail-vk1-f196.google.com (mail-vk1-f196.google.com [209.85.221.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8462638BA
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439486; cv=none; b=gUdvYjiv9YdvmVIOyVn1ywHM2eR/tnaRE8YdSkxAWf9ma5lAhyh4r8/HjCFz7GnUZKap42XXrRcGq6gUTy+05V6+Z1LU+ljU2iebkxmx8k4LbX7gW+Ym0aqq8ljjSvfDZXr5134IhClb3LPjg0XpCYtJzJiT8nqNPvNQv4WDhNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439486; c=relaxed/simple;
	bh=JkYZP3JBz/ovYOwOjixhYUqk5jXGuD6SzRtYtu34UuM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbNGumKBJT1pni4dWaIhNZiRbVQd0M2x/0c0QBwMPpAFndZURIIvND3aYqDKN7xK0hEjXU5+VQTYKt1Pa93P981rcpEYLrPMHQn+UI7dYZ+LzP4AaiB/RL857gCrONiLSog1k35njNISo/HWsViXM42MEKYElvf6b4Nn32eOQsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVX375Y+; arc=none smtp.client-ip=209.85.221.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVX375Y+"
Received: by mail-vk1-f196.google.com with SMTP id 71dfb90a1353d-56636dc53a6so60421e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439484; x=1772044284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2cJPOPF6syakadFoXXTnrP9LMIdS/ULz4KbpOEDK3w=;
        b=kVX375Y+5CK9XNxcRkqKf/mURGrpd64yYrzyerjtPqXB3K+C53fyNzd6Li63N+eK4i
         MG1Vr4sqMqSCSWi+GBDxij06lXbYkeivcuaCJ1PCyOyB5x7+h6DuOLUMhBKgOk/8G6Bf
         GVNMkJPPGfuQ42UmME3MWTDeFEhsbcNjOMYGTstyJlDNIyi9hcgZeZg3IoUzvj/rEFwH
         /ONlT88CkuMHO47JKIe24x+Sj8A3m9U6bU1AKmGXgb3daBR2nZjYtdRB66HiLaoYILSV
         tJXtIQcIuGuhguRTAsKQlG/oTWHl9JQwFlYJGeW7xxFrB9g8UVMoan61c7mg7Z/72oVK
         Nizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439484; x=1772044284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2cJPOPF6syakadFoXXTnrP9LMIdS/ULz4KbpOEDK3w=;
        b=AL9DmxEJdrVpwIXC8/4HRfYImyz9uOvY8UvikCKZ0uUaUAKl5pe47Dv4eBhIax056+
         f+zGly7f5TpvvhtTxgpjY/jmIgySfHhBFLRohUMkPrcTSXeP0o55wqTkcti/UviPYerK
         YAQoQgF6oVJQfxITf/aDvxlxADKekfiuQhh/GKZ+Wj6jX51d6Em807mN3D/L08w8i4tY
         DWbBasgQq+gcecdkPmYX9FdRU9M+UlYYU7fL1du9zLEJw2Kio774dE0m8+1dEokdBRbB
         vt6+WVxCJqFyyoAAQFOwW8uki+o7TJuMlZUDR79I+MLM7OHvyACLEqAdRbP+38U6x+k5
         Z0zQ==
X-Gm-Message-State: AOJu0Yyz67KL/BsVusk0Mrs43rBnC7YVROZyUw1JuVsoSCvemCdOQTKn
	C5KNoU0w6Uu/PwA71/nGo9pTQuhVVV8nmNKvTyFTNRnCWPpuJ4CN1jaqgzKipd9QUHk=
X-Gm-Gg: AZuq6aK0LJQHcgKnPZSybUd1fLs06lNiJzKHhxp3PYsuDRZvY0bXSrEoOzVZDSg1WVO
	I9uWrAHknmrxWtOjZqDVOMo4DOrd0e6En3KoFJUX/oElnMe/mvksexyDH+q3o1DMDhCTVAMvsQf
	8VaRr/ufiM8ybmcq1enPjRbdI6loPwHkDK427T8DAGoHEth6VOWoxvBtwZRghVfo2UFtv96YpU7
	Nx70ObKDO/26CKB+JKgzc3f1LKqfRCuUupscL5yU6zVpe3LusB3p5rCQjV2HGR2s7RzR9dzQbyq
	zlXZpibM7ogTyopWufSBX/hwUI568ECmoBD55X4VIkzOI+W6EwENoGarE5g19eVC6Xuwm3wRltg
	wLyL+QrO6tWPe+O6FOVXVn+OThFoBCRyhxT7lCRDzRW3ftD9ySodu3Ai6/8qCDeS8f5zDHF2Yt7
	qsknSqaS1WWWkoVug10a1SWOezzYf1r84sHCK9FKINuG3p5ZvzMRfZfcKOze53lOyHYYpS+GFoQ
	/sS4+SCLZqlYitxYA==
X-Received: by 2002:a05:6122:658d:b0:566:36e7:8934 with SMTP id 71dfb90a1353d-568ca1702e1mr97794e0c.16.1771439484264;
        Wed, 18 Feb 2026 10:31:24 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd1f1f82sm10959316241.8.2026.02.18.10.31.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:31:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/5] doc/btmon: Add a section for automated trace analysis
Date: Wed, 18 Feb 2026 13:31:10 -0500
Message-ID: <20260218183110.2840582-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218183110.2840582-1-luiz.dentz@gmail.com>
References: <20260218183110.2840582-1-luiz.dentz@gmail.com>
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

