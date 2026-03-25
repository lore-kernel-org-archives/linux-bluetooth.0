Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A32DC765
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774464865; cv=none; b=PvVNG8npXowl+7mjB01I+EOORqhYAwM64+T7sChtVEYFmcaTziDk/xjzqYSXyfkBiqYjQ/uAUD1eYUHkZx2IOEpLjAXPsnl0XkgxXk7MhRjCntTX/bdjtZ/AKDD0EiJw/Gp0sKsEubCkZ3uEMpWo7UkbBB9qNPCZ+zEHvt2t2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774464865; c=relaxed/simple;
	bh=ySEaVohUDEA/yROIc8BAh0IXBpJ7dwr6bfC+K13bv9o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ2m+sPD7PevwxWA1CQryHsxqlIm5s61UB5C3o2D27W6ZKbFvNcelP/+Klrg/9C62z5CYTRhAH9Qqs62viuWZUilQBfmGaQmDqhDi5zx0t+CFOsgGo85Y0lF8esBZxREtex1zdeQDZs4V/4nCOdPVGZYa/AzAJ4ij53l9xau/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nus30fpx; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nus30fpx"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56b65ffbda3so230346e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774464863; x=1775069663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/gL552kKGOHPmPoZTV9FM1oBITxWlgXo1TbgmWw9Zs=;
        b=Nus30fpxpZKw968IWevYBP8eprbdqBzL+uZcEXMkOdcm51OwQeLLC1PQU+vgy+E5Ww
         W9PQw/8OFP2wwufxSHsx3Ys83kzsMP4k2ENyMWwd9ce9VIANCreTBwh+guU2CfE+4ess
         F7ZppMIzrmegdjBpuZEG1D+DwJc22ZG3ujHf5FFYMq0QDM1iNTOLXUlesSUzKEpSjYL/
         HruBnxz931MKWDgPXYSgsELT6uaUNpj4LYWCJMJ6YJxB1pUSNqKNxxPpRVHGfz4/fQGr
         yNfXCWoLw1kVhnS1ZetalXtPNJxAqKt3s3VW2K5/Hl0eFzqi1FJWRrI1Txv1vTsUwfui
         vPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774464863; x=1775069663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/gL552kKGOHPmPoZTV9FM1oBITxWlgXo1TbgmWw9Zs=;
        b=Qwc15VM8vK64rF2ArXf6lbc8yzZQPfgbZruAqUwxu7KuHB19oURtzq6zsq0eQc10VW
         Wpnkmuedq9flkqXuH+mrhR9rIkwtdTWx6PAxh8wNAq94szjOJfaIA7L3uCiyHYtVD3CL
         xW4sBykffMkRDPbrq7LNJmKS1pBPc/zIFPSmMb+N9Tec3MjSGzYLZjMhkC0zakW9Nfeh
         DibeVMtO+C7CVf5BeN57NvtXEjYxJAQ5z5N+lBVdN8fjdoFrK+m0+FZgAD/+HDs2fGVd
         SCXEe3kM8ZKQAE6+IO5b6HsCxnk9dlPjmJCnkTZ12rj9LdyyEpd4YP/dSVKxjjxoY0Av
         b7ew==
X-Gm-Message-State: AOJu0YwAdYJc0mISMzlFsJVZGvB32gHnNhVfbTfZ1hw/Fh8J85da725N
	hn8XmE/xEFaQTYOLuPF9GxTHg5TnUaN5bQ4R62MuFKW+BdF1A0PM/zxfgHAlVsgc
X-Gm-Gg: ATEYQzyi9QYlUEqpCmPw3ulmuKWDz9JRT5buecNcqZVTYnMm+ZMNlt9n8UZMo5laRHn
	M3dAV2jjGNZni9JlPsJY90pCqSYVXSEMnmC9HJ9QewBbuwnwX8Rf8e4qtcGsB2xjjIXJi6+ZuWN
	W6mYqpED38cwdC56d8ISMyi321W4trLkhBAEu6xU/dZXpclRYm2mPUxTgwo0IyBkhiUI3Pdi9WD
	wvEdzDcShUP50CroBtRzNTIBguRr1ah0SFAZjFUiP8xAwMSlM/Qengi2aBZnnkaM6T1yr2Pfxfo
	SJKe8IvDVDWA85y+b6vsw2LbnOhzyxjTquXtNK9nbold/boOn8YTXVdlPOjc/7V+xAdOIV4RvSO
	DzsveRXo9iw+iC6OGBZVlWvB/Mthm1dfVF5XqdB4F8DnaJcUw4TqTyh68scpfi2VVo/zdzNg8uA
	NZuXTxTX0l+6XkGLPmZDa8XZzVpj9Uxr0OARm5dglb/99r9M+MmOztK0UR0xJav/JgSVpL1i5QM
	FLtLtezueOeC5L/Ig==
X-Received: by 2002:a05:6122:4210:b0:56c:d582:42d3 with SMTP id 71dfb90a1353d-56d221061f9mr2442180e0c.14.1774464862832;
        Wed, 25 Mar 2026 11:54:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d31d71947sm921438e0c.14.2026.03.25.11.54.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 11:54:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/9] doc/btmon: Split Connection Tracking into btmon-connections.rst
Date: Wed, 25 Mar 2026 14:54:02 -0400
Message-ID: <20260325185406.568078-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325185406.568078-1-luiz.dentz@gmail.com>
References: <20260325185406.568078-1-luiz.dentz@gmail.com>
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
 Makefile.am               |   2 +
 doc/btmon-connections.rst | 142 +++++++++++++++++++++++++++++++++++++
 doc/btmon.rst             | 143 +-------------------------------------
 3 files changed, 146 insertions(+), 141 deletions(-)
 create mode 100644 doc/btmon-connections.rst

diff --git a/Makefile.am b/Makefile.am
index b36da8a803e6..a8473127cf66 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -548,6 +548,8 @@ EXTRA_DIST += doc/btmon-smp.rst
 
 EXTRA_DIST += doc/btmon-gatt.rst
 
+EXTRA_DIST += doc/btmon-connections.rst
+
 EXTRA_DIST += tools/magic.btsnoop
 
 AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(srcdir)/lib
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

