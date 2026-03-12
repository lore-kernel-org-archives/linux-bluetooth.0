Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4DA3E5585
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335762; cv=none; b=fXIcGMADkSmvozugFIqnTXqdFA1rleCMiACSZpR5JXcQz/bBsrMk9FRMhfRyiIKBnOlnbYzDIZrSXzfbIgIZkp4lIkhn4FKkmlc+lCe6EuG5or/ot1FDvcb8Pmuq63KQkvRvYdlrkwMkoyt33xfwOvbixPgq3v5hOp3LK4XJzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335762; c=relaxed/simple;
	bh=T/qrEhB2B0tDJ510iQ1uKhS+ObjX/yA38UMbRV4scZg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKY0mm8AXM2/GDnS1k8m/47oXfKY/pUjZzoyyo06Y2xdnrw0vtCPkPnSPoiNpsurRBNs0RF3kTSdaxRXpjFXvpPBXcAmsO0ELGF2VOCu2858fnDCtdXOXbcxRS5HDd3AaYSubkH90A1sBPvE7nN/LoPWlHP2R4OxmS7/7W58lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2scbtN3; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2scbtN3"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64c97997b0fso1071975d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 10:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335757; x=1773940557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ds5IHmvBqk0CmCKgOPrUsJ7B0frrkdxPl4q8owCaeHc=;
        b=U2scbtN3ARx9NDsIRxp3GqjPiUb30iW0kv89XhH8M5lwrzUHCNzI/K2EoTn150hbqx
         e4lrRAwhCAnCgaWJUrWx3cF90zF2bxHCunNbbPQ5xEfV17KhtCmIaY344En773Uo60aM
         Svb/vlpqwIXYI+qlfoxmhS+vaZvMERZOF/wdr1fwrXSGbh5NGrtf1ioG9Z2UU6HhsiFs
         dcjG3OGaqW6iwfoRLVtSUg0ycahaFS7Baiuy4cgcfiT37j79YQooKdGj08by02O1T2lj
         ILl7HQVs8KsvBfC2pVrnLiJezpENRvbOABCO51bXymn/JYQJx33/rEEPLhGvWty8FqGx
         u1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335757; x=1773940557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ds5IHmvBqk0CmCKgOPrUsJ7B0frrkdxPl4q8owCaeHc=;
        b=HG/5h8YgwAbwHicNkGmnZMj0zEv2N0p5EYD3BYAt9JiqIublDnH2IEFMaEsT/To2kN
         k0df91f2cmGMaseli+1v14cFyAxF/AlCXQBFQKymUzmH5Bv7CPqKbgRloA2yl29b6vQ4
         eozhs0m8+D9TEstomuvK8XP/4uyw6S6kxkTDSvpPUtQIn24ZoKzE8twqIWWh8MjCKq1R
         k6Q/UOkiewqsAmApstfiPjEjmcbPqtI7nl11xnbz4bCM6RuWOhchEdXNQWwW1AIdiVbd
         iIhgh24wW7r16Z1T/RrS/lZyYD/t+5zEu5vJYNr19A7DwO25Jd9FeWVNa9Cgc+Gqb+Fc
         59Ew==
X-Gm-Message-State: AOJu0YwtEu/s6lYGt5y5Tgl7aTcWuA0dWT5g9k6Razgdelzx+fYz61vT
	Zm4OYEE79v0P4JZn48EIAt6PhC/rZxyG8a2dgNx0kuVscotf5DaUzb9DksJEOw==
X-Gm-Gg: ATEYQzyXKMizIYv9YHhbD56zqstzAdQ7mloSf6r0PDuYrzAoVsfrr9AlGI1E4Rom2Fp
	3YYJw2uDTzDghiuJVRxaaHB0j6EahUT01rkXf9ORjeP/a4WlH9ePfAdVbBKju0DcdPb9Zxrpsk+
	AfrWSgH/KnCsqntZQMtwV+iQQKLnE/XOciGibP6uidgbNIbRgFtLe9INMol+fXIwjW7ESpmz/t7
	Qit+8XS2Ze+q+Ly93C9qqWuDVIuoAWzCG9hsTLj6cZhz1Iy5LdMMtxEgmJuTy/JBP/35usnnV0p
	kyW+NVFh1cxpl3DfJaRzByz1+evu/c2eueZ31V9KJlPmV5xTM9lXCDZEpAZppe2MRpT/vMKC45E
	jPcC5p0jEzSpNgCegBZ4D6dbMbQUm93CKjYyIVIzLsXpX+V/RgME1kOysADTTPveUxn0/bXum9C
	bKQQHC5ueeXcR10n+2FNOiOb10OxMlmFKD9MPDqhvrN1xYyUw2ohBqAjlAXpuIFBotq6L9QY+tG
	yF4IK4nUDjx4FSaog==
X-Received: by 2002:a05:690e:4cc:b0:64c:ef6e:ef7f with SMTP id 956f58d0204a3-64e62f797bbmr252126d50.28.1773335756572;
        Thu, 12 Mar 2026 10:15:56 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d65117a82sm3442572d50.15.2026.03.12.10.15.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:15:55 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/6] doc/btmon: Split Connection Tracking into btmon-connections.rst
Date: Thu, 12 Mar 2026 13:15:39 -0400
Message-ID: <20260312171540.1065212-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312171540.1065212-1-luiz.dentz@gmail.com>
References: <20260312171540.1065212-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Move the CONNECTION TRACKING and HCI ERROR AND DISCONNECT REASON CODES
sections into a standalone file and replace them with an RST include
directive.
---
 doc/btmon-connections.rst | 146 ++++++++++++++++++++++++++++++++++++++
 doc/btmon.rst             | 141 +-----------------------------------
 2 files changed, 147 insertions(+), 140 deletions(-)
 create mode 100644 doc/btmon-connections.rst

diff --git a/doc/btmon-connections.rst b/doc/btmon-connections.rst
new file mode 100644
index 000000000000..eb6a88ceadbd
--- /dev/null
+++ b/doc/btmon-connections.rst
@@ -0,0 +1,146 @@
+==============================
+btmon: Connection Tracking
+==============================
+
+.. This file is included by btmon.rst.
+
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
+    < ACL: Handle 2048 [1/6] flags 0x00 dlen 16
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
diff --git a/doc/btmon.rst b/doc/btmon.rst
index c9e13c839026..7668bcc5a9c4 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -534,146 +534,7 @@ The kernel forwarded this as a MGMT Device Connected event. bluetoothd
 logged its ``connected_callback()``. Then data exchange began -- an L2CAP
 parameter update and ATT MTU negotiation over the new ACL connection.
 
-CONNECTION TRACKING
-===================
-
-HCI uses **connection handles** (16-bit integers) to identify individual
-connections. Understanding how handles map to devices is essential for
-reading traces.
-
-Handle Types
-------------
-
-Different connection types use different handle ranges, but these ranges
-are controller-specific and not standardized. The connection type can be
-determined by looking at the event that created the handle:
-
-.. list-table::
-   :header-rows: 1
-   :widths: 15 25 60
-
-   * - Type
-     - Creation Event
-     - Description
-   * - BR/EDR ACL
-     - Connection Complete
-     - Classic Bluetooth data connection
-   * - LE ACL
-     - LE (Enhanced) Connection Complete
-     - Low Energy data connection
-   * - CIS
-     - LE CIS Established
-     - Connected Isochronous Stream (LE Audio)
-   * - BIS
-     - LE BIG Complete
-     - Broadcast Isochronous Stream (LE Audio)
-   * - SCO/eSCO
-     - Synchronous Connection Complete
-     - Voice/audio synchronous connection (classic)
-
-A single device may have multiple handles simultaneously. For example,
-an LE Audio device will have an LE ACL handle for control traffic and
-one or more CIS handles for audio streams. The ``LE CIS Established``
-event includes the ACL connection handle that the CIS is associated
-with.
-
-Controller Buffer Tracking
---------------------------
-
-Buffer tracking may show a indicator in square brackets::
-
-    < ACL: Handle 2048 [1/6] flags 0x00 dlen 16
-
-The ``[1/6]`` means this is buffer slot 1 of 6 available controller
-ACL buffers. This reflects the host-side HCI flow control: the host
-tracks how many buffers the controller has available and shows the
-current usage. When the controller sends ``Number of Completed Packets``
-events, buffers are freed and the count decreases.
-
-HCI ERROR AND DISCONNECT REASON CODES
-======================================
-
-HCI status and disconnect reason codes use the same code space. These
-appear in ``Status:`` and ``Reason:`` fields throughout the trace.
-btmon decodes them automatically, but the hex values are useful for
-searching and filtering.
-
-Common Disconnect Reasons
--------------------------
-
-.. list-table::
-   :header-rows: 1
-   :widths: 8 40 52
-
-   * - Code
-     - Name
-     - Diagnostic Meaning
-   * - 0x05
-     - Authentication Failure
-     - Pairing or encryption setup failed. Key may be
-       stale or devices have mismatched security databases.
-   * - 0x08
-     - Connection Timeout
-     - The supervision timer expired. The remote device
-       moved out of range or stopped responding. This is
-       an RF link loss.
-   * - 0x13
-     - Remote User Terminated Connection
-     - The remote device intentionally disconnected.
-       This is the normal graceful disconnect.
-   * - 0x14
-     - Remote Device Terminated due to Low Resources
-     - The remote device ran out of resources (memory,
-       connection slots).
-   * - 0x15
-     - Remote Device Terminated due to Power Off
-     - The remote device is powering down.
-   * - 0x16
-     - Connection Terminated By Local Host
-     - The local BlueZ stack intentionally disconnected.
-       Normal when bluetoothd initiates disconnect.
-   * - 0x1f
-     - Unspecified Error
-     - Generic error. Often indicates a firmware issue.
-   * - 0x22
-     - LMP/LL Response Timeout
-     - Link layer procedure timed out. The remote device
-       stopped responding to LL control PDUs.
-   * - 0x28
-     - Instant Passed
-     - A timing-critical operation missed its deadline.
-       Often seen with connection parameter updates.
-   * - 0x2f
-     - Insufficient Security
-     - The required security level (encryption, MITM
-       protection) was not met.
-   * - 0x3b
-     - Unacceptable Connection Parameters
-     - The remote rejected a connection parameter update.
-   * - 0x3d
-     - Connection Terminated due to MIC Failure
-     - Encryption integrity check failed. Possible key
-       mismatch or corruption.
-   * - 0x3e
-     - Connection Failed to be Established
-     - Connection attempt failed entirely (e.g., the
-       remote device did not respond to connection
-       requests).
-   * - 0x3f
-     - MAC Connection Failed
-     - MAC-level connection failure.
-   * - 0x44
-     - Operation Cancelled by Host
-     - The host cancelled the operation before it
-       completed.
-
-Full Error Code Table
----------------------
-
-The complete set of HCI error codes (0x00-0x45) is defined in the
-Bluetooth Core Specification, Volume 1, Part F. btmon decodes all
-of them automatically in ``Status:`` and ``Reason:`` fields. The
-source mapping is in ``monitor/packet.c`` (``error2str_table``).
+.. include:: btmon-connections.rst
 
 ANALYZE MODE
 ============
-- 
2.53.0

