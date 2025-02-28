Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7304A27CCCB
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767820; cv=none; b=KKQ1ux9ZZcz2lQBiP0S1L2izSKaeoibT3OQCAlJu4wH0mojPVHRR7kdec+XxGaTA413zeeATBR+5Meq2gos+dW1Ag7oWyexfyenC6iYTI8c1YQfm+Z6buBtbEZ5+qygd4of+mdPK253Aes3Z0EocZ6WNQbXtGShWqsINWFSQF9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767820; c=relaxed/simple;
	bh=7LQxBZRw5kqstjXd77yAUQaNvNUeI8Yd4uBHZQAZELg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aCtJy3LB1cJDaMOPB01ewRiR1a1QZtwHj596damAk6cP4CEKnmx2DhnYuT4IOsuIk30T1yYvuOg6HYtO2NwWKl81B3px9KJ92ioGDolyvSaKTOwNrr3uPHgY7jVaKOm0Gy/A5OUqIY4hJSq72xdpepkd5BQDjB6EwQGST/RsGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGabGBSB; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGabGBSB"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-520aede8ae3so1163698e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 10:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740767816; x=1741372616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/e+GuBz4FwoWisEC7JWze6A5nxI8m85ib/YZzX4jZjk=;
        b=SGabGBSBNbe97Ym+SZJrXZOe6Wfy2LbTThyrDMLx6cXcdhFZVgpSeuqZdedpgx7TE5
         UqPmLhY8Q+D5RM9e5SWI32EC3IqdJJvgWuIzFrVZCRjMwAO3hbBIr2Ma5hbt4D7j+rA5
         H9TDFJzk5c9ZknvfB3BOGRd7QI7DOLALbsJ59gsoZOb+62T6GpMozqGdDbPt3DdZGcxL
         iNsmNuuvAPw78xwobSQCCXETuw7xXej6FMar1yrhI4Y2Ilad4A3vsokKlPTyoQhrLu/0
         Tag6hb7N+Wf5o016u5F+eErp42yDdTdqhLxkGsojwlS39tz54xCUNKnqgRSVDZZwDBOm
         31AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767816; x=1741372616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/e+GuBz4FwoWisEC7JWze6A5nxI8m85ib/YZzX4jZjk=;
        b=YUTC7qEe4fmae1S2D/7OVRy1auYeYfcqLkiDyhnNv37MPhku1OnPnwPGjc5GQZLTlV
         nFeRaI2f9+mQgg7iL1+uQDECIAAAFW/MUJHQYFQCZTgcxl1Bg5Sy8iUTKFaUs3LVmUco
         NvJGkhOXftzV7FtLnZAl6hx7KlP+gmoErPdkt0KNTjEfqe+XIsuKvTbXU1BpAWFalN/T
         +tHO837Td+Fcc5UUEH+XN5A30sYpdRiq3Dpc0LydCbKIQ7ASdJoLwUlPp/j95Ma+6mBy
         4c1ppdlgjnmwKE2hP8gS3khzULVATuGOP7gc6EQ7vUxP2aKC9hRTdcpFvIb/n3s1sEDA
         +YSQ==
X-Gm-Message-State: AOJu0Yyqq97p4OqDmN7l4IanKOEIQg0oJ4Isj4/7c2bfUktvJ3Xk3bAk
	r1ALGQzGlkE6L6tC/BFR4YStBHqzhMhmFcCSk807cqGvn6RAzLIdjwjvnvWc
X-Gm-Gg: ASbGnctiTq7XxokTf87gby+svw9mQ6gA1/uYZsHnqwcNh+M2NePP6QxvBBui1YAteJ4
	fV54ZF7CKfO1UF1fP1cvs7uyFiD9cD30VqsduOaZAuXJ48uEd/iB+jHq5VszNEViy49f0nJ6saD
	cneyLuo4h97kN8pzStoxtZq//8rcB8CTG+vItsqkwBYCh8TK07JQeZVLOZB1sGv8e5dvyjRE0Rw
	JYs1j4tKpKTmv4zvorlpbeFRj/myrgFOe6H/7HTk3IXqR+V7OCLBW8VEsTx2KkcRk55MzfrlulJ
	Iv43xeCOUpMY3K/onWK9/bOjgc1YgkAmw3h6l83RzGANesbMqPQR4gj1UR1PZwPt/hMN3Mg=
X-Google-Smtp-Source: AGHT+IFaxzYssF3feFHnO6qRXSHy3Bi1YtkWHuG1mjnZncbFydLX/GPgolwJWP1soTAkmF0JrpIYvg==
X-Received: by 2002:a05:6122:2491:b0:520:5a87:66fd with SMTP id 71dfb90a1353d-5235b844533mr3436887e0c.7.1740767816019;
        Fri, 28 Feb 2025 10:36:56 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5234bf420desm653538e0c.25.2025.02.28.10.36.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:36:53 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix enabling passive scanning
Date: Fri, 28 Feb 2025 13:36:51 -0500
Message-ID: <20250228183651.3492826-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Passive scanning shall only be enabled when disconnecting LE links,
otherwise it may start result in triggering scanning when e.g. an ISO
link disconnects:

> HCI Event: LE Meta Event (0x3e) plen 29
      LE Connected Isochronous Stream Established (0x19)
        Status: Success (0x00)
        Connection Handle: 257
        CIG Synchronization Delay: 0 us (0x000000)
        CIS Synchronization Delay: 0 us (0x000000)
        Central to Peripheral Latency: 10000 us (0x002710)
        Peripheral to Central Latency: 10000 us (0x002710)
        Central to Peripheral PHY: LE 2M (0x02)
        Peripheral to Central PHY: LE 2M (0x02)
        Number of Subevents: 1
        Central to Peripheral Burst Number: 1
        Peripheral to Central Burst Number: 1
        Central to Peripheral Flush Timeout: 2
        Peripheral to Central Flush Timeout: 2
        Central to Peripheral MTU: 320
        Peripheral to Central MTU: 160
        ISO Interval: 10.00 msec (0x0008)
...
> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 257
        Reason: Remote User Terminated Connection (0x13)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)

Fixes: 9fcb18ef3acb ("Bluetooth: Introduce LE auto connect options")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2cc7a9306350..903b0b52692a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3391,23 +3391,30 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 		hci_update_scan(hdev);
 	}
 
-	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
-	if (params) {
-		switch (params->auto_connect) {
-		case HCI_AUTO_CONN_LINK_LOSS:
-			if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+	/* Re-enable passive scanning if disconnected device is marked
+	 * as auto-connectable.
+	 */
+	if (conn->type == LE_LINK) {
+		params = hci_conn_params_lookup(hdev, &conn->dst,
+						conn->dst_type);
+		if (params) {
+			switch (params->auto_connect) {
+			case HCI_AUTO_CONN_LINK_LOSS:
+				if (ev->reason != HCI_ERROR_CONNECTION_TIMEOUT)
+					break;
+				fallthrough;
+
+			case HCI_AUTO_CONN_DIRECT:
+			case HCI_AUTO_CONN_ALWAYS:
+				hci_pend_le_list_del_init(params);
+				hci_pend_le_list_add(params,
+						     &hdev->pend_le_conns);
+				hci_update_passive_scan(hdev);
 				break;
-			fallthrough;
 
-		case HCI_AUTO_CONN_DIRECT:
-		case HCI_AUTO_CONN_ALWAYS:
-			hci_pend_le_list_del_init(params);
-			hci_pend_le_list_add(params, &hdev->pend_le_conns);
-			hci_update_passive_scan(hdev);
-			break;
-
-		default:
-			break;
+			default:
+				break;
+			}
 		}
 	}
 
-- 
2.48.1

