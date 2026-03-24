Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A4314D06
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381799; cv=none; b=Fe4Jzff+tcfumKAr/OOF6qyeDivAkfSF2C9VHf9YCC4u/CX5rBecg7etzSHqZSC1A1M6/2bFh9FsqZUk1JMwzCX0DQ+b9C2lpz3KkRzrbcLMxckJtSul11Ld9aI7NEJKbYdqXWD1TLtS8EH6DSL/VflUNvIcF5fJHfsm2rC8qXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381799; c=relaxed/simple;
	bh=WaVq6IeaSMynunyfREzdSNtstZMSAOM/yxY2aS31tJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VloADTJRsHBvKt7/SS3bGqZkzFHwbUPL6yYQex7jhA0pBC8jn7hX43TDDwbzpw3dBHD/8FLM1pAzgnz9zKlDg1zXE7n98G10iElcHmaCGWvp1oqITPN/ukfkNIG/RHtR7bIOJMTlF0YQyOv5MbhbXKQf1lDyV6A5NijTcMEYtgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siBZjzdV; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siBZjzdV"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56cde28a9b6so1718336e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 12:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774381797; x=1774986597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18kFo5kSBWxG9tnWxmeyz9jjXk38ot5DKUWNikebwxE=;
        b=siBZjzdVjEAYMfuCLGIITnkl4+zioiCv2Wmuf9WXdLpFwxsVUevUlUQOnoRnNPGYEq
         yUyvk3YF3XUBuLFUbs+alOAlyOw++D157V08wswtHyGLe+aLxH6hjCTjLXqCygrPhKS+
         HUP2qmtUuKWo6GyU+f9/3jk1VuKmL/mobv+Rf04h49ntLvML3zAA5aawB+II91LdqCfl
         J7ufmzO+XHz2i41vHDaA6i3bgyG2m7hVerqLDaP6KjUNj5S+xYi9PPDYHY0168VOHHy2
         BQva6+kRFCJNJkRTjFjSXEfC7UoeRO/wRjJXM1DBpGaotjHvVOSz42EP85a7v5fttoag
         VdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774381797; x=1774986597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=18kFo5kSBWxG9tnWxmeyz9jjXk38ot5DKUWNikebwxE=;
        b=X0MrMMAZ9+/w0i2oHDIcYCFB7evQ2bj5VmJ06eVOEnefYQGJBPKxaTjMMbbB1vI5XM
         099TTegYC9SFEjVIs9wu5mdWeB2iXAbsFVL02ltnphosT7GcLROnGD9fG9LMJMmZTl/+
         8aobk1bwMf1JG4gGz7bHHB1/4cqxu2qZWBqmhMVoQj8fkJymmNVXFTKBsR0nNjItLXcn
         X5Z2Hecq6+bvWkIcxRSHSf5yFnme1jT+M2GPrjSZ2PPJi8L40OfHjGaYNbiIboK2dt7k
         En5GbqIviGi+5g3+PQZ8UxsWWCK3gxnwhw9vzWGqKWmmxzjpGbvDqoG2HM+8NrxT8yWH
         Vejw==
X-Gm-Message-State: AOJu0YwNi1SFqvhssEhXaHmK9lMib+jnnhnXbGd3VTfMXTzAveN3YZqw
	4kI3R6IuZoxNt7X9JD/x4tEKns/Ai3LoBIHXftWSeZkpHd7TGviFrFNk/dEvZ+xE
X-Gm-Gg: ATEYQzy9mTNHM+HPmyHA+cl68pTpxaeXJbwJPKeC/u5B6cQq3rI5WdOvBjOepKabDP/
	6VfcBDvhSuwuZ4EBgPXPiO+5A9c/Ry+oj8+Cz1FrwPPXrIzOcYDUywsWooJBL7uFphwSl/83YHo
	lb/qUGoJb01lflclHyUeHCMu/4ehIQ8/fJIf0CqQsKoBUeFmO520QAdKG7ZTreDWLy3GNGuVHMa
	uCEnazHRLx/Yr/3Kk96Dd+H02Rpq404RrEfM7W8ibmD/UamfYOhIzGwBdUfOMgW3TPT0zZFlF5U
	IVLr2hyrNCjjfuiTHKq2R8rRu/HwxOj4RV9FuRCgw5qm1Gg5d1s3Kw2mF2YbI1EejfjKbcV+sT7
	9DcafbbtsQ7ksYhBdNsFKUa2Yj83C1YBrEY1Pgjuggu/qHIs/7+yRRHsXIF5n98nNeM8huERbw6
	E9BCxraERceCT0QRS8iqP92POfJBpUGwPGGxwjOjj2TGlll3xeBPIlVZsBhrov1iocNbkmNir4K
	cpr7g/JErb0B2UkA3IBzDuSP3v8
X-Received: by 2002:a05:6122:681b:10b0:56c:ce8a:b07a with SMTP id 71dfb90a1353d-56d21f78414mr478054e0c.7.1774381796817;
        Tue, 24 Mar 2026 12:49:56 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136de3e33sm13759671241.9.2026.03.24.12.49.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:49:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/9] doc/btmon: Split Connection Tracking into btmon-connections.rst
Date: Tue, 24 Mar 2026 15:49:42 -0400
Message-ID: <20260324194946.109349-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324194946.109349-1-luiz.dentz@gmail.com>
References: <20260324194946.109349-1-luiz.dentz@gmail.com>
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
 doc/btmon-connections.rst | 142 +++++++++++++++++++++++++++++++++++++
 doc/btmon.rst             | 143 +-------------------------------------
 2 files changed, 144 insertions(+), 141 deletions(-)
 create mode 100644 doc/btmon-connections.rst

diff --git a/doc/btmon-connections.rst b/doc/btmon-connections.rst
new file mode 100644
index 000000000000..d0d4e799d7e7
--- /dev/null
+++ b/doc/btmon-connections.rst
@@ -0,0 +1,142 @@
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
index c2309fc30389..9cf1464eae63 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -534,147 +534,6 @@ The kernel forwarded this as a MGMT Device Connected event. bluetoothd
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
-
 ANALYZE MODE
 ============
 
@@ -896,6 +755,8 @@ Errors often cascade across layers. Common patterns:
 PROTOCOL FLOWS
 ===============
 
+.. include:: btmon-connections.rst
+
 .. include:: btmon-gatt.rst
 
 .. include:: btmon-smp.rst
-- 
2.53.0

