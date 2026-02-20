Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AC35F8A7
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608697; cv=none; b=qyM8QaEdM2obDRv/ZePBCMlkTbws1Kt+EwZ375YObLp00VbmN79n5Qz5HY1FXOduHFjg6JqBAqtS3pIIid7oqpsWZ/fPGEyjXHXqOaIm2q+/81J0SPYztP8NkF3ETspxofLWJsjswB85p2cYNwfylxD0NuhcNPWh9MwZmkgvv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608697; c=relaxed/simple;
	bh=7nDIgYFc0zNgYPlCWDkEt46KuR8qj32AkcJ8ho/0oXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYs2pX9NsiNBE1fq80SezyRYGMpFj7ZNYEHPZc2UuCBmmiQBN9C8y1dCPJRMi2KyLvvEmXu7xjSJovxLQg+lplviwa5FBzP1eQ6rZfNh8waKH8eh0iNJvinSfevEQYlWUEGFMEvlcz7vykZI/lN6WA/CQ68RpYcyvAgJQia4L8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QumlTqqs; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QumlTqqs"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5674d8be45eso888746e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 09:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771608694; x=1772213494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9sE2Xoy1YVjrIfnn3Em1zqxFG2O+agQ2uDrTo2vRyE=;
        b=QumlTqqs3zIVxcGYY/mGxSPrAQP1t0e4MZLnLA5cXhGRtZyVlJtGWZ8oOsgFNggycs
         0pa/EViO0JMuH5kbqlUX+DUD55jsV49EdQA9FCq4ybAn4q7nCqGr0G+7XzqPgygETgoo
         vhaGLAtay23k4fFpZ4h0RlKebrfxoXPGQOORIVgCLmVT/QlSk5otLUXsSLQ4kB13ssDp
         2SypHZx4QteqhF0aYsahr7hCo0mTMwVn5v+v8cg4tf9+kYLp0k2fRnfoejPcwSfKn127
         npNpsF0l3khB459luYNFUOK9ybI8/rStq51hNmqoQcRrUzq5LJFxm8V0tp1r+OqAbp15
         vCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771608694; x=1772213494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9sE2Xoy1YVjrIfnn3Em1zqxFG2O+agQ2uDrTo2vRyE=;
        b=Uboyexr/HUkbqtqt/slGWq5v3wHnG23iKbGwz7rf1a7mYmfcADvyGIcQR5qrvUAMrg
         O8nafV45vv1b3cak4fE5dgItB3Fv/oMsUqD++is6VRyAM9cxI+nmQiNJMa9s1VCoQRXI
         D4ZrM01xEjvRag8Wq9BFFkX0Yjk7Tqyd2c/EBlN2s6eCxhLEQiF1UIlGWbGGeDvJhiyy
         yvNRSeDWIrVDD9++6oYT9PlWWpoioir9d61H+OVt86/r4Rk4mNuuIHrNTuB0LRdzdZeT
         BfsyuZ3NHL9wtZ0QUJgUPXF9xFft4VYd7gaBuuik05TNdK2xOvk2TVOcl9ZHpaacHOIJ
         04TA==
X-Gm-Message-State: AOJu0Yw9fKfr0HySq6XBuxG13/o/Nc3YXfAI6HrTPHMHEYpCB3FKOHJ4
	FceIi7j/ZmGZJ+DDTj4jRS/uIRabk4gzsi9vOKMeOb1NUWXeCI0gsn1BamswPQ==
X-Gm-Gg: AZuq6aLH5hUjh3wXwVMlzt7zhA1WqiJD3OygqlfAu2ft/uYebOrrP+/7PRRtC4HBiBV
	UNWlev67miSB6L7WDOIyezycMh4i9lhuKzTBjiGUQAKjRVUxm230ZJp+1NlQWWxNL3JStz9qRT5
	wAyO7LdpTJoSQxjrQ+b92GRN3dLa5/47AIl+gm7VMt/1OvooerQyNsml2x36qxLWrs6GG7QeD9I
	0uIo7+3MQNyw/alD92axUwJGdTY/wI7SD0j1uF893muAy9T81wMMw15T8Z+iJh9+3W+oEX/Lfvu
	8W943v3ERyFgldbSg+CjvTzWJ9p99qUr4PwPZQQTmHSzfDXM/E9eurbCerNpSezcchCtEUEsPL0
	/FUf/phZdT/3vbA0F/hinVBUGjFs/Imvg2Hir/oKLXf65MmmrzRsu6xJUWm2A393krOHP/sKazY
	6e84feG8hhx+jKvebw978ZzG150naUii1A2SfHSXufbi6yI8dqhZeylTGjWTKxliTrX9epv+iI9
	aHmFFZmidWa52AC5g==
X-Received: by 2002:a05:6122:2191:b0:563:72d8:ea6 with SMTP id 71dfb90a1353d-568e488c2c1mr230297e0c.10.1771608692264;
        Fri, 20 Feb 2026 09:31:32 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da8b3eefdsm77864241.9.2026.02.20.09.31.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 09:31:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/12] doc/btmon: Add connection tracking section
Date: Fri, 20 Feb 2026 12:31:07 -0500
Message-ID: <20260220173120.3418666-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220173120.3418666-1-luiz.dentz@gmail.com>
References: <20260220173120.3418666-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds connection tracking section which explains how connections
and buffers are tracked.
---
 doc/btmon.rst | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index de05a5fcd6df..d93aa34a9412 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -531,6 +531,147 @@ The kernel forwarded this as a MGMT Device Connected event. bluetoothd
 logged its ``connected_callback()``. Then data exchange began -- an L2CAP
 parameter update and ATT MTU negotiation over the new ACL connection.
 
+CONNECTION TRACKING
+===================
+
+HCI uses **connection handles** (16-bit integers) to identify individual
+connections. Understanding how handles map to devices is essential for
+reading traces.
+
+Handle Types
+------------
+
+Different connection types use different handle ranges, but these ranges
+are controller-specific and not standardized. The connection type can be
+determined by looking at the event that created the handle:
+
+.. list-table::
+   :header-rows: 1
+   :widths: 15 25 60
+
+   * - Type
+     - Creation Event
+     - Description
+   * - BR/EDR ACL
+     - Connection Complete
+     - Classic Bluetooth data connection
+   * - LE ACL
+     - LE (Enhanced) Connection Complete
+     - Low Energy data connection
+   * - CIS
+     - LE CIS Established
+     - Connected Isochronous Stream (LE Audio)
+   * - BIS
+     - LE BIG Complete
+     - Broadcast Isochronous Stream (LE Audio)
+   * - SCO/eSCO
+     - Synchronous Connection Complete
+     - Voice/audio synchronous connection (classic)
+
+A single device may have multiple handles simultaneously. For example,
+an LE Audio device will have an LE ACL handle for control traffic and
+one or more CIS handles for audio streams. The ``LE CIS Established``
+event includes the ACL connection handle that the CIS is associated
+with.
+
+Controller Buffer Tracking
+--------------------------
+
+Buffer tracking may show a indicator in square brackets::
+
+    < ACL Data TX: Handle 2048 [1/6] flags 0x00 dlen 16
+
+The ``[1/6]`` means this is buffer slot 1 of 6 available controller
+ACL buffers. This reflects the host-side HCI flow control: the host
+tracks how many buffers the controller has available and shows the
+current usage. When the controller sends ``Number of Completed Packets``
+events, buffers are freed and the count decreases.
+
+HCI ERROR AND DISCONNECT REASON CODES
+======================================
+
+HCI status and disconnect reason codes use the same code space. These
+appear in ``Status:`` and ``Reason:`` fields throughout the trace.
+btmon decodes them automatically, but the hex values are useful for
+searching and filtering.
+
+Common Disconnect Reasons
+-------------------------
+
+.. list-table::
+   :header-rows: 1
+   :widths: 8 40 52
+
+   * - Code
+     - Name
+     - Diagnostic Meaning
+   * - 0x05
+     - Authentication Failure
+     - Pairing or encryption setup failed. Key may be
+       stale or devices have mismatched security databases.
+   * - 0x08
+     - Connection Timeout
+     - The supervision timer expired. The remote device
+       moved out of range or stopped responding. This is
+       an RF link loss.
+   * - 0x13
+     - Remote User Terminated Connection
+     - The remote device intentionally disconnected.
+       This is the normal graceful disconnect.
+   * - 0x14
+     - Remote Device Terminated due to Low Resources
+     - The remote device ran out of resources (memory,
+       connection slots).
+   * - 0x15
+     - Remote Device Terminated due to Power Off
+     - The remote device is powering down.
+   * - 0x16
+     - Connection Terminated By Local Host
+     - The local BlueZ stack intentionally disconnected.
+       Normal when bluetoothd initiates disconnect.
+   * - 0x1f
+     - Unspecified Error
+     - Generic error. Often indicates a firmware issue.
+   * - 0x22
+     - LMP/LL Response Timeout
+     - Link layer procedure timed out. The remote device
+       stopped responding to LL control PDUs.
+   * - 0x28
+     - Instant Passed
+     - A timing-critical operation missed its deadline.
+       Often seen with connection parameter updates.
+   * - 0x2f
+     - Insufficient Security
+     - The required security level (encryption, MITM
+       protection) was not met.
+   * - 0x3b
+     - Unacceptable Connection Parameters
+     - The remote rejected a connection parameter update.
+   * - 0x3d
+     - Connection Terminated due to MIC Failure
+     - Encryption integrity check failed. Possible key
+       mismatch or corruption.
+   * - 0x3e
+     - Connection Failed to be Established
+     - Connection attempt failed entirely (e.g., the
+       remote device did not respond to connection
+       requests).
+   * - 0x3f
+     - MAC Connection Failed
+     - MAC-level connection failure.
+   * - 0x44
+     - Operation Cancelled by Host
+     - The host cancelled the operation before it
+       completed.
+
+Full Error Code Table
+---------------------
+
+The complete set of HCI error codes (0x00-0x45) is defined in the
+Bluetooth Core Specification, Volume 1, Part F. btmon decodes all
+of them automatically in ``Status:`` and ``Reason:`` fields. The
+source mapping is in ``monitor/packet.c`` (``error2str_table``).
+
 EXAMPLES
 ========
 
-- 
2.52.0

