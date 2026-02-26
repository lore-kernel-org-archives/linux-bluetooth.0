Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0F3D301A
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 14:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772115599; cv=none; b=YKE2/U2RkOViFk7dLiAZRXQ7fu/ys/yyJ2J0ghcjqzImBCs4BiQjXo+vNQKQo4rE3dNM6KuWxZTDQAYU5erUpnKV2d8SwrzTneg+5/2Gzg5pZrJEnAPlyL+ZZvxFaNxd+ajRyIlq3+6ctM/4DD7T12cluRiHRMm6fj/6VeytdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772115599; c=relaxed/simple;
	bh=N8ucPhJAq2J/AOAJoY7CbW+hvZ1ZNsEAhjtFTedLwKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R7xCee7CqqdPpCUZBmB3oVZGOY3uX7Sf+UvDm477f2mZ5AVKFjmJVD+qnPLmDn/b74eMPUPBIPE01kQzfezsCT+EczgOu1oplFlQVc+d+k87qGoY+4zccHoXuuQpBalDQv2Asdwj+EALR/wrEAjJ+OhnauAnyqdvgafXaTEC7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6jZnk2O; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6jZnk2O"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4398ebdf520so1306311f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 06:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772115596; x=1772720396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e66o7qv/BHUyWGTGY5VRtirpPWECOX00cyQCyHK2/PU=;
        b=P6jZnk2OPIhht8ZLAlFpiTIU//MY9zaadmwh1QiuhRaM4umra4Y/hK1L2DqNPKM3fR
         Tb84Ln548SyyJRIAg/pj31oceSz4Hp6RskdNhICzdzKAsv19KC3i9hTa7w2HPG2NvPv6
         TWKDkdptJvgY2FpwNlMn0DaTEw5V04+xKeBlqE/vhX6Zq/gHRDcsYifRG3yK0kx77cZg
         rQgBUcSEvGHdEJ7XZrNIGxGzDkz14BdetgqJxbbwb7TfVwHgmv5kCiULPyDNbUAfT9mz
         ew3RO86HPQJNSuzNsQ9hD5JRcqUrgLnVIdV8sEUC3yuFAuNeWUvnmzqvmlq+x+cM0MWH
         5imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772115596; x=1772720396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e66o7qv/BHUyWGTGY5VRtirpPWECOX00cyQCyHK2/PU=;
        b=oIFzFkVNnmzLInjZo4gQJ50hVz8paJpecPZ5X2qfPQ/eYiCS6q6wf5X+Pn8UADhVp0
         yCOExmlkR/BrqQCvlE5NgmJX4BqlirZJFXxKWV27p9jmUIaBEYejWYFgHYWCFgGd2Swv
         SBHQx1OK/uBuGNYV8evrqPRPIMWd50qTKrdJrktGFzKrssa/rPgYbTzSir1I8KEoPVzY
         AMTKJLFEadNC6q3q+CZFYqHrfacgiMitr+d4XCcd0cql39Qb4NNIdaV5Aii1l1Njx6UZ
         LhSloN7Ge349jCwd1J1UqGTerPHBS5hH/9pk0UGnO2CGF4R7/Hjtwrg4dxUy+L3EGRww
         JtqA==
X-Gm-Message-State: AOJu0Yy4ALK3sYsS5UCbZJ5ko2IZq0IeXdcEC5dVak0PE9vk+EK0jJMU
	w5oJw0zVGIZ8CD9/o//6rpqcfEEcd1g2LkRKkfTXDmxXccsPC08OJXvDsAW8qN6Dj4v6Gg==
X-Gm-Gg: ATEYQzyBzofiMVmlc5fqP4X+3Ru2NpJgdv4H/lH+ACzfDnIgHjwCNSe8KQksAi7jIHh
	VVQXEsg77jW2jHBqGyu1tRyLJoNkzEWHrB9XuU7SRJsNSfD6qhNjev5LUPSUJnhMxNiAGun46Xu
	vTkHDzXmqjEqTOqqZtd1kYOBiXV7FBDSDWW2YO+ad4Sv0VlW5GFHVG8l2zlZrLpGJhACjlySci8
	5q2nr7/uJVLc5fVMXuxTB4vbU/8V80siB8y6oX/IQoxmuilc8r6NsYrGa0j67PNcsZedjOcDfWZ
	gWTBil7Cd+Hk+DbOzXqKSAm7xLgkxPETwZcIKk89Ho+dqKbvS9OGrL86/kpaxqp4RTUdaTjv07V
	z0SMgRMbN6GeIZvx0lrO+uX2ZzPm3GuW/MUA40AMnNYVDJgToKGikImia6/p7w2/DCUIeh4fTRd
	M3SPX4gkcb6BPb+fgfQUyzt6yzboLMDlNwhZ2jOoAb1EU0V9DpwaaO
X-Received: by 2002:a05:6000:2012:b0:437:71b2:6f1a with SMTP id ffacd0b85a97d-4399716cdb4mr5644617f8f.0.1772115595839;
        Thu, 26 Feb 2026 06:19:55 -0800 (PST)
Received: from builder.. ([128.77.77.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43995c4b726sm7862628f8f.5.2026.02.26.06.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 06:19:55 -0800 (PST)
From: Dajid MOREL <dajidp.morel@gmail.com>
X-Google-Original-From: Dajid MOREL <dajid.morel@volvo.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Dajid Morel <dajid.morel@volvo.com>
Subject: [PATCH v3] Bluetooth: Increase LE connection timeout for industrial sensors
Date: Thu, 26 Feb 2026 15:18:21 +0100
Message-Id: <20260226141821.885997-1-dajid.morel@volvo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dajid Morel <dajid.morel@volvo.com>

In an industrial IoT context at Volvo Group, we use TE Connectivity
BLE pressure sensors. These sensors exhibit high latency during
the initial LE connection handshake in noisy RF environments. The
connection systematically fails on Ubuntu Core 22 (BlueZ) because the
connection attempt is aborted too early.

In the v2 thread, it was suggested that userspace (via setsockopt
SO_SNDTIMEO) dictates the connection timeout (defaulting to 40s),
suspecting that userspace was cutting the connection at 2 seconds,
not the kernel.

To verify this, an empirical test was conducted using the following
Python/Bleak script to force the application timeout to 45.0 seconds:

  import asyncio
  from bleak import BleakClient, BleakScanner
  import time

  ADDRESS = "E8:C0:B1:D4:A3:3C"

  async def test_connection():
      device = await BleakScanner.find_device_by_address(ADDRESS, timeout=15.0)
      start_time = time.time()
      try:
          # Forcing 45s timeout in userspace
          async with BleakClient(device, timeout=45.0) as client:
              print(f"Connected in {time.time() - start_time:.2f}s")
      except Exception as e:
          print(f"Failed after {time.time() - start_time:.2f}s: {e}")

  asyncio.run(test_connection())

1. Result on UNMODIFIED Kernel: The userspace script patiently waited
   for the full 45 seconds before raising a TimeoutError. If the kernel
   had actually kept the radio connection attempt alive for those
   45 seconds, the connection would have succeeded around the
   12.5-second mark (as proven by the patched kernel test below).
   The fact that it did not proves that the underlying HCI connection
   attempt was aborted early by the kernel. Userspace was blind to this
   abort and kept waiting in a vacuum.

2. Result on MODIFIED Kernel (with this patch): Using the exact same
   userspace script (45.0s timeout), the connection successfully
   established at the 12.51-second mark.

Conclusion:
This proves that the underlying HCI LE Connection creation is bound by
a strict 2-second timeout derived from `conn_timeout` in `hci_conn.c`,
and that userspace socket options do not override this hardcoded HCI
abort in our stack. The sensor physically takes 12.5 seconds to
handshake, making the 2-second kernel limit a hard blocker.

This patch increases the hardcoded LE connection timeout to 20 seconds
to provide a comfortable margin for handshake retries. 

Note: If the upstream preference is to not hardcode 20 seconds globally,
I would be happy to submit a v4 that exposes this as a configurable
module parameter (e.g., `le_conn_timeout`).

Signed-off-by: Dajid Morel <dajid.morel@volvo.com>
---
 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d177b7f49..8aeed0962 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1131,7 +1131,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
-	conn->conn_timeout = conn_timeout;
+	conn->conn_timeout = msecs_to_jiffies(20000);
 
 	hci_req_init(&req, hdev);
 
@@ -1301,7 +1301,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
-	conn->conn_timeout = conn_timeout;
+	conn->conn_timeout = msecs_to_jiffies(20000);
 	conn->conn_reason = conn_reason;
 
 	hci_update_background_scan(hdev);
-- 
2.34.1
