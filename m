Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07A3469E6
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439486; cv=none; b=jkMI8QkHZbtF9VxnQus/FIRhqzWWA6CqL48eDx7ItlDujZmK+JzNGH6hu46fCtSh3lWHTfQPq+k2LfnqdKFxhKVDBrDZzLL3egEJyhHu6BBSpA7c+F9eHczOV6ZXCc0dImXiGIaL4yx3y/LyhnV3jEXNmrIYz2wjXWMBiGWPBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439486; c=relaxed/simple;
	bh=7nDIgYFc0zNgYPlCWDkEt46KuR8qj32AkcJ8ho/0oXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCoDnVwLuOLRN/KQ1Cpm/E88XUx0QwtYzmtT08h3etJrtWxl1kL5BlDHa1mfoJJEmgdRK6ZhTdJAh0GNhdEEBb7SAXrOWi9IuHHTZJJ2HL2XUdy+izFBeaI9lwO06+0cN0rqTNO2gYr6fzTFK2RXJPIGGCzfKlg71IHttdqRy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj9BvQAK; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj9BvQAK"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5664340e14fso80787e0c.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439483; x=1772044283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9sE2Xoy1YVjrIfnn3Em1zqxFG2O+agQ2uDrTo2vRyE=;
        b=aj9BvQAKBT0zzS/8EQa5xJtHlcXGFIsEEiK933BqaEC/3SQdRBpLOBzv/yRpYmIJWR
         lGYR/ThFZE9WE5qtxX6/lVoj2xU+9JhEWnw90c/jz1S78rHJ9jiXn4Y3pushPtL9xs9T
         uNF4X4PYBbdEyaiVbESeBcjl1K0psCd/CZEoBeHVgz1V1jKd4eSPKMBiHZL5doEcF9FD
         qC1r7mafNT5h+NOqrLr1LqHinniRaza1kERuoM8kNxaDlFNBfeyWqWcNj8N1qA8/WwD+
         ct26k2PcGmc4KF6eYbpyquYAlm8cKTGpORribqVphUyyWFFKDhgrfw2q6dza3spNho3a
         5F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439483; x=1772044283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9sE2Xoy1YVjrIfnn3Em1zqxFG2O+agQ2uDrTo2vRyE=;
        b=r4gvkRinix5RiSsTI7UK26bc/94fj9e7EGVty3UkjIRr90txO5k+WBAQ6hg+2c8+a4
         6pMF0Mf2WkVovGBzRWEnC0UklfKL4SElxFGKqleSKfbbO50lTzCf/AKgbHGUwqqO072u
         LBXZZ0GpCwnPIr5jSzWvI1knCR7fqhBsHEymNE+Nx1Fi74bsg4CHrILAK/ndKQxWrbBO
         v6idFZ+1qK0++VJrQj6lYutZgNb4Gm5N7eIhAU4Bqytn0NkvhdXtT0fK0XPcx6aeSPI4
         Z+YY6xUPq0fyufhOEOKrZyLDeS6vaBPya6lLNwaSpSgcgl0fkeLufaXNLTIUd34sSRYY
         R/6Q==
X-Gm-Message-State: AOJu0YyjJYJ4nsgivq8DeS5q3iJxvpp8rUkxeRIpr0Tu/XdXtiqfhqYa
	S7X28B9gaRrCVTqgQQPgs65dtip1lcPgSmR4R4YgdZs2VfgDHLELHJC0JK7ZvLWz
X-Gm-Gg: AZuq6aKiESIXkMkUuaxP7rVfDfJm2bpHpl0hOj79LZnOwLs0K+UEtY/f/CBn315hZ5B
	A4XDwrCDHfkKQ0jr/OM6U/8Wo/sg2cfPns1CUsOWYH354nmbuIRyG4nsQytdN+GzcHSXdu1qDtA
	UliEMpbDbo6RkYrqt944sQSHXi6kHS2afX4OUBi9JjidlfYNLq0g/ItzbGZ3EZcAi2rtqk9XHZj
	RksbbGbfvx6iHWhjxfYP0upJMhXNQR/axNPRMfc91X9VRc24NeONCC/L1ph/m0PYVt0pesItEFu
	akNSIhmUkzep1eiHqI6VieJgz1jdvZQlbdddVXtJgKSdmh/dw+GaGRsZpMV272HtefdIllRqUpR
	cqQ0qHIMRpXdLs6XmLgNsJOafmxE9gK9YebjslG2H6kI89wjox2TKUbI4z2vJW0199hLKrPzn/n
	Ziqhyuuhh3SZS8/cAs2FykjGWjs6CX3MJiMPqWfLkPHwFKR4GunPKIn3AH0aBvC0BQBWSBOPT9O
	CF3QASZriqm3VAlWg==
X-Received: by 2002:a05:6122:65aa:b0:53c:6d68:1cce with SMTP id 71dfb90a1353d-56889c2a979mr4916401e0c.16.1771439482509;
        Wed, 18 Feb 2026 10:31:22 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd1f1f82sm10959316241.8.2026.02.18.10.31.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:31:21 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/5] doc/btmon: Add connection tracking section
Date: Wed, 18 Feb 2026 13:31:08 -0500
Message-ID: <20260218183110.2840582-3-luiz.dentz@gmail.com>
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

