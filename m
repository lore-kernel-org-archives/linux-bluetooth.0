Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6752F7445
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951448; cv=none; b=mmyvPq8f6/jjGQCvefVhmdGDJxZAA4qRgaIAhw6nf2naUVeNr3+HSOXD6rQHmxs5+8juFmN3L4OSJEqMBJYAiQUGZbAteZH2kp5Xh8wosNSZoIcJsqx/ucSHaWYrFP17xSQlo7IUpMs0lmsCMXSAz3XBusAzIFWm0JInhDAOEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951448; c=relaxed/simple;
	bh=m2YiFunFFtKLfUBetGw/A1AcaxvVOxZnvxnNpKj/wvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVZPqWVDe8R1qIZK0U7iESizmQ+1AbdHuPB+O7AIb/px78Bb9CD1HtFK2rMGmtEQ9PtKcuS5EEw7M3Z4uwMhcCmZts8B2Apg0QQ98RkRNe9HsGdaw/zw/0UoN5Omx2bci7W7sB4HNKJEir61jORhjdOTsfc7TjdJAN4KrWZue2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jgf2eTrA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jgf2eTrA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1638779a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 10:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785951446; x=1786556246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TBAPV/2b/g7lSUR8+pBxxLAS3EoPgJm7uPmHbpLLVeI=;
        b=Jgf2eTrA7KaU+VvaGAel6HveF9m9UyNFSALgQ+cq6iOsBn2DXNkCy/nmte8+S5PNfi
         brTjllWZy79pYvX5878qnP9PtAXYfx8Ziu7SSTrdwFZbORW8qt+eAMPF0Dy0vhzRXv92
         11bXFezIpZVrBDdE4GLyvXua3JT/fj98qsYWKd2vKPVjPFFJR0iry0bDK2/M4QAH3DRD
         c144MrE3xTQi1/6CEF0Od0poGwSY3rvxqCBHS8O2rxskOlDhFSgTcVSqGCk2VmG0LaSP
         hS6Mnw4hzJBX9ZgzqkZS1idDB4nVF+DpSnQPbAQ9vwgwoRUli9m/jgMrnFfw0qpNC78h
         Ld5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785951446; x=1786556246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TBAPV/2b/g7lSUR8+pBxxLAS3EoPgJm7uPmHbpLLVeI=;
        b=sPt31hSoPoqSLg8+9jsUu3R7cpD/nN/5DofJu4JBjAd8OEsAkMyShvIRuBhNqKc6Bm
         m3HBH3COeT2rg3FhXHVbnW6WhZ4+ZY4mHuf4bQaIKX78/HZT5U1dpkWMyrnOQwQKhZRk
         thoUbqo9+ce87/1U7LKx7+oZUVJr+FUc6WjtK5P87x3ilp/k0R3R83r+1DkVsWVMWvTO
         ATX5eFcPcsImCkKLgEmpHbxqv9sCTRhuhplU1aoRGz8ygDxu4by8kvw0Is9vaiFSimMx
         5hrVmKptmed+C8axKrQ4hMJxlAkVk1HlscvLfxRzyGv8t6rnWB9sQFL5feaPSNdZamOb
         ghEA==
X-Gm-Message-State: AOJu0YwMdNQJOI0a0gIQ/cmlmbo7fk5fg2hv90tF0FH+n1mDZYanE/oj
	S8GhbUvkkOce0BYVOtDSm0uh+gqGWcaGrjrQv2oLrfCHRhXM6OUUXKaz
X-Gm-Gg: AR+sD13DRDGMJd/GHqv0jRfh1yzYxyhFE5WT+6donHFFw9S2q8mbeFm1i1JoufHMqQo
	+Ul0l/gbpfACTzksQDc8c3UjSeBsRF96FPqTNeKUDkxfrIQ/GtsYlmXyJy6VH8bNOLgM1ok7wYc
	AgZYZ/A71ifZ7O+VIT7YuujpfbqKot8Wef/K4j1plGLkb45EY597qUXr3DJ0Z7mX/671PvU+qva
	5Rove/0AFuYgtaOSJ1WPOtDaB8cBuQdTEGou4GmZ4oW3QzVsFpjPfaT+EQqiWsX5FyBzYf2lQFX
	rT+Ex6pvSeUdjT9vEH4DgBQ55lQkMhxpwNrFtjqsUQ59MXUBiNKLID29EnCI2IZTgF/ubyY1pyU
	mwDadA+omzdiO9bNMwTnxQ85FokaeMwOv5w5IiYXQy42pblu80xcGL/4bstpDGnWydA/5bxBo4N
	60Zo/qAUzwWipqdttLGWrejIegeRZyu6LIOulDPh0aKu1DK1BGEw+kJLN4symyVJYTdybC/ILLi
	aajvgU/06zfDE2Jd1bBbw2GjlgUP5QApW5nPtMlb7pm0+ItEzx9N5oOraY/r1t3ppGYA5TRBiMp
	fogGXk5BF2msU8ZqRYo86EULy0GqrDc+AJdIn39P/Yye4nEPHTRosu1Xlq3KHiFYkXPLQTt3Bj+
	RNths4hB9lsK33YEm3USPSX2g5fYI4Gk8ejkCDMei7oiwwyHfbx9rbq1F5kph
X-Received: by 2002:a17:90b:278c:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-3903c5bf6fbmr9464083a91.17.1785951445652;
        Wed, 05 Aug 2026 10:37:25 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:70f2:9802:a2e4:b516])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca50acddsm16109750c88.3.2026.08.05.10.37.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Aug 2026 10:37:25 -0700 (PDT)
From: Laxman Acharya <acharyalaxman8848@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Laxman Acharya <acharyalaxman8848@gmail.com>
Subject: [PATCH] Bluetooth: hci_event: fix out-of-bounds read in LE PA report reassembly
Date: Wed,  5 Aug 2026 23:22:01 +0545
Message-ID: <20260805173701.6649-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_le_per_adv_report_evt() is dispatched with a minimum length of
sizeof(struct hci_ev_le_per_adv_report), which only covers the fixed
part of the event and not the trailing data[] array:

	struct hci_ev_le_per_adv_report {
		__le16   sync_handle;
		__u8     tx_power;
		__u8     rssi;
		__u8     cte_type;
		__u8     data_status;
		__u8     length;
		__u8     data[];
	} __packed;

The handler notifies the ISO layer via hci_proto_connect_ind(), which
reaches iso_connect_ind(). That function retrieves the stored event with
hci_recv_event_data() and, while reassembling the periodic advertising
data, does:

	memcpy(hcon->le_per_adv_data + hcon->le_per_adv_data_offset,
	       ev->data, ev->length);

ev->length is taken directly from the event and is never validated
against the amount of data the event actually carries.  A controller
that reports a length larger than the received event therefore causes
the memcpy() to read past the end of the event buffer.  The leaked bytes
are stored in hcon->le_per_adv_data and can subsequently be read back
from user space via getsockopt(BT_ISO_BASE).

Validate that the event contains ev->length data bytes before it is
consumed, mirroring the check already performed by
hci_le_ext_adv_report_evt() and hci_le_adv_report_evt().

Signed-off-by: Laxman Acharya <acharyalaxman8848@gmail.com>
---
 net/bluetooth/hci_event.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 741d658e9..727545e0c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6604,6 +6604,13 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "sync_handle 0x%4.4x", le16_to_cpu(ev->sync_handle));
 
+	/* The reassembly in iso_connect_ind() copies ev->length bytes from the
+	 * stored event, so make sure the event actually carries that many data
+	 * bytes before it is consumed.
+	 */
+	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EV_LE_PER_ADV_REPORT, ev->length))
+		return;
+
 	hci_dev_lock(hdev);
 
 	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, PA_LINK, &flags);
-- 
2.51.2

