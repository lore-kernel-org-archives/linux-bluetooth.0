Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A5226D18
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518164; cv=none; b=YNsdKURVEDs5b310uniSuL7vc9wokHxkW4q6zdMeQKyoZJ7Ax2F926bNT9sPHjJUAStik8UQgPOiDkQZBhniSrbwjysG+P0d0dDkx/kluNJZVIiNp4IKeooy2tI541DTopWdF4o607MbIYvmt7TZGWbZbqruKGRCFMr5MS6M0Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518164; c=relaxed/simple;
	bh=7nDIgYFc0zNgYPlCWDkEt46KuR8qj32AkcJ8ho/0oXg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejSPnn2/uqEwfGVOt8AzXFQk6I7nx1W40dYStGNioSGS7Kc5p56DDJuf7CbjkNnd7gMkYFSjSqNVVRe04Y8MbwdEl7IdodiVQa18DuS7IQ3wCR9DKB5Gx92YJjIwKofwmzJ8IxLjtxis5etxhLiQBHjpqA0it0VZh/sXJBdj85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muXuVwuF; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muXuVwuF"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56706fd623fso778381e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 08:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518162; x=1772122962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9sE2Xoy1YVjrIfnn3Em1zqxFG2O+agQ2uDrTo2vRyE=;
        b=muXuVwuF/Iq1wRG8yc0Y0K7rJ2bD6n/omCQFCwZy5FohPHxPYdxWjLMJ2Dx9SbO4MT
         qJxJj1P+kh/vhgiXn8d//1BgA7EZWfRlY55uwu9jikeF45yhjm1Jxw70a0wtECOE0lH5
         ThQP5imnkNUhJfm8llDW7njIA9+ovZgbgFr8E6igmI1UtU2klmiUamKjlZeg87pf6POW
         6Sg7mnXENCxXEpyK0sYkYShVnrQuAGv2w9xzcDJ4eP/1Bw7k3ls9/XxMs/dKQC3vjzsV
         5m4b8eBepzYFXyR5EpJR9DgwirjiFmFx/TRc/QWfRE/If5EJowKmOt7JegqFwlNP/KK6
         2u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518162; x=1772122962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x9sE2Xoy1YVjrIfnn3Em1zqxFG2O+agQ2uDrTo2vRyE=;
        b=U1XpX/XcsEFfXfNSgS1an6sp/nmHChWmz0oW/6GJGm1UrN9dwRggZrp19+SFMFI/kM
         BwECpZLReGep0s4jvRhNPrizlphLZgZ/UBhf08utzo9AOlIRFPmx4S7v0xUQIiTW77uT
         LTh2POY9duqp1pL00UrK78zN0WjDrS1/iV3+Pbv18SQrIo6KGMzuHt1DIfc6PzijiSHA
         VEy0NoJ/QcXMmeAHLRhZROioIDa7R34lx4OuzGNMHLoJt6xxKHQaw2uy4mj1ycPZce5U
         R6lv1SMBIPqXrD4UPFE0hrIo2/e+9lMlN5J6zPzCIv0xb5BUImNQV4Bh0eOnIw1R0PV7
         ArSA==
X-Gm-Message-State: AOJu0Yz5OV3ta6+HN/5eIngMNGRPIz+ffavItHufEMTyHBzSJKHYDDOR
	yQFaYAbRS4YC2ibEn0ejlUMecgo6S5RvxwYnN9MDHmMnpHNc9YEgnY6wjuMWlw==
X-Gm-Gg: AZuq6aKnslSFeisLo1jPe6XI7+mVJx2pUAW7zx+CsTL++7tHQy92yU8vjmZ4G5HHwBR
	LRHL0PHiBs8RmAnAZ0gxMu1NsTf4/1Je5R9X9y91X+ApVzfHe4tVz0pZsGcjLYtxoXNbv1uCDKb
	Ye6w3biBZ9R+onIPIj8yL0+7M7vtXGuqYexspOfg3gKPDTvDDWHxrCppgeJK0WWqjqeoKF8c6cB
	DbE5Vkmbo5RF5RgRCxevKdW+5y2LqGUsO31e/EqKfzmjqQR3vmIALDuN8qV9MljT9Pma+YhQJF3
	O8+OBjJtBLFTKdK5PcrAP334nHlY6EkrGQQvNsq51KFBSc2M00Emv/TsUijdih1M6U5p/yaW3X9
	b01EczCLvKaA7MRaMDjqEjyHKK64edBclZ1j3VfN1GdiAR8LTImN09GR1LHZsamaAK23V9niZnv
	o5Z1zy3sM+mn4r25W6zk18B3MSPcmwrmvQiBTsrOnkb6Ke/WZGoA5oCFex0HwZy63ZThm5/O18k
	/udjOLT3ifO4PJczw==
X-Received: by 2002:a05:6122:4b8c:b0:567:42dd:7dcb with SMTP id 71dfb90a1353d-56889d3d876mr5877051e0c.20.1771518161540;
        Thu, 19 Feb 2026 08:22:41 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674c20a659sm14435235e0c.11.2026.02.19.08.22.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:22:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/8] doc/btmon: Add connection tracking section
Date: Thu, 19 Feb 2026 11:22:25 -0500
Message-ID: <20260219162230.3074355-3-luiz.dentz@gmail.com>
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

