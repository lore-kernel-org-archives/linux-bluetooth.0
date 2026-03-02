Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91433F8DC
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 23:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772495017; cv=none; b=FDjfVOiIRP/rRsc/+tIki4pr94ZSqv0JNK+dYvbDHDyq650TFUb629EUqL0T9PzWzhpY3fEXVnTGpLjo5Uza1mOX2Bs13016bzcPl0klmWyzXM18Bt3PFoIUmbv/j0QVH3md/t1D67Z7NPhYW7cxkCTulVUYRi8vl1JpmOfYQTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772495017; c=relaxed/simple;
	bh=AmeLaitYkM54eP+xIVxklpLyJl5p0q5Uvkbkzyvmbos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jpkEUvpVfyIbj9V5Z3mtrQbAFZ/P5gYAGpOWKZVe2aARe7oKTFtJRddrIA09njI3Arqcr+SN+cHHRFWYnzLWh9dV+KMUXlJjt6uDbDvuZ6fNpWKX/w7qeEUnqj8o6E6IytXBqFqpRwDgCx1Cb+qVXwXF1E3zWSOfeaSiQYwkUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItNdTX0r; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItNdTX0r"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4398d9a12c6so3904709f8f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2026 15:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772495014; x=1773099814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtUXje+oxnkL4Z4AONjXOELJ9HdmQ7g6ZPd3VHGl68w=;
        b=ItNdTX0r7NlbOfm/iTnVWAsJFNWb85PyG2lDkhIXLVMvNSqVzNe/paD1J2v7S4cUFC
         8+YyjdjHFxUzG83/r0+Ef3BJHle+eWRjYdkzGf9EuEWJ6QPAW86vDnk3KgxBmpLcjYC2
         UGMmyKvnqUbD2FHaCNBSrUqf/lE6YkCNwFkoEchHfkhPNQtelzAT03ZbbPPmcgBI8tnG
         CMyRhhczqU8s4UNN4yM9IcSwYLjRYtoaGta66s1jFKXgDySRJVfgkxHOB1NOrU2xDuCc
         J3UmIspM9a97nhQQ/S6pnyVXoJcAyJIvYCpRXGy7H0Tbr1pWQmBZ1KxzoCea+LeahkKr
         C3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772495014; x=1773099814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtUXje+oxnkL4Z4AONjXOELJ9HdmQ7g6ZPd3VHGl68w=;
        b=jlGQj4tehBHed1hX9I/wUiPenI9Cfq0r3Tjs46k/HfOmi/s/4IRa+4Mw8m6kP9wC4B
         g3deVvW92OwFsJIbPhXQA5jwEHdHKCCg1R5hCC99Zl0VbFoPHC8lhMVQ4i4BtfUSrBVu
         H/2wgZNC0ky0YCZ4QSU5fx/7ThhHTQ9L5BcvyolmRjTXlqvqKqof+7Er7sePO+J8oeRf
         L3bga0Gw6dDZMZ8Fxi0hzr8e80FjxkCH4PH2mfxKbrOVCq7V+/i89rm5Z8Ugdhkj4qdY
         iC4cmla5q67TUDFVEqUOgdfXceuVtOZ+Mp2DW6wWvGQvsCF5ZEumRvNs/1bOdXW4GscR
         yGFA==
X-Gm-Message-State: AOJu0YzBUN7PzCpgLh6HecZDBw8KU5nApFvCI0GKX7zUxMizFro53YBf
	4EmzfHMuEvGrpYIs6tu0b1y5q9VjEP7vLS5IjukBIWsKViXt3Hdr36U8dT3AMoVsWVJzsQ==
X-Gm-Gg: ATEYQzzthSWZyL+AppjCPTTWLzT6NM2XohPEdXGyU1W5GVsLD91ZIybTVW/QUeIl/qf
	OgrfiDFjp0POZZ5SjJaGn13UQQ4Wgp5XuRYcnQzICI/mOAivpq7L9Jb95yjPh+e7YIzvwUXJV7f
	ROHecLbmUnqNoe6DKmemNs1sgxnVXpSBPE4xVowW1UTB8sQa+CgjFbewmOpN0ljS7kdSlgaUtGx
	IOm+lLeVYYechSJz7/Zpc/6AGUhQE3l/PojUmQsN5bowiIRSaDalbZeA5zTX769RAKIudmy6plb
	Pi0TPSBXmTR0IHhcFaCLsfr0F/b9WyBZRPEf5ldX7C/dRv2g6y5P3tUM1cRBYhQbdvFZa8XzRqg
	qD8x5HGPioDKaL0kDZnX8Ejs1eV7kkUhWklPBQa9+eveuIyZIGtfhd124DtCPAQpmTc+PkZ7YNP
	Hk1ZIUdc3L/GjcalxxfHC4+pueVfIgfH1dLQ2Pi5+EZtEH+q8eUtczX1C3/AHjXQzbWCLYiy6pP
	i+XKi8BWTnO0g==
X-Received: by 2002:a05:600c:3d90:b0:483:703e:4ad5 with SMTP id 5b1f17b1804b1-483c9bde864mr235622955e9.22.1772495014007;
        Mon, 02 Mar 2026 15:43:34 -0800 (PST)
Received: from builder.. (88-182-218-160.subs.proxad.net. [88.182.218.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485135cfa25sm1583065e9.27.2026.03.02.15.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:43:33 -0800 (PST)
From: Dajid MOREL <dajidp.morel@gmail.com>
X-Google-Original-From: Dajid MOREL <dajid.morel@volvo.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	Dajid MOREL <dajid.morel@volvo.com>
Subject: [PATCH v4] Bluetooth: Increase LE connection timeout for industrial sensors
Date: Tue,  3 Mar 2026 00:37:56 +0100
Message-Id: <20260302233756.910702-1-dajid.morel@volvo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
I would be happy to submit a v5 that exposes this as a configurable
module parameter (e.g., `le_conn_timeout`).
---
 net/bluetooth/hci_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index a47f5daffdbf..7edce4126900 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1436,7 +1436,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	conn->sec_level = BT_SECURITY_LOW;
-	conn->conn_timeout = conn_timeout;
+	conn->conn_timeout = msecs_to_jiffies(20000);
 	conn->le_adv_phy = phy;
 	conn->le_adv_sec_phy = sec_phy;
 
@@ -1664,7 +1664,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	set_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
-	conn->conn_timeout = conn_timeout;
+	conn->conn_timeout = msecs_to_jiffies(20000);
 	conn->conn_reason = conn_reason;
 
 	hci_update_passive_scan(hdev);
-- 
2.34.1

