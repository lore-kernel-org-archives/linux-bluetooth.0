Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85F44D682
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053563; cv=none; b=lZcJAtUvu99v1YwlLTMyCm4jhXrS4Mb6odYCkuXriLiDkOsGsid5JohONJFWyFQhbEIFQVAV4b5StovWlldcRUMfvSo2SAJJOTvw+h7PGRqc1+RKkYwWqzXA7l28hc3pTgCffoxifhbGuMQmXhkPr8L0lxc1kZ+T4LmM679CxR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053563; c=relaxed/simple;
	bh=wCtJXeMN/g0N6gt6I2pmfmBv7Bsj4ouXITSjAFlvgGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bx2Op/UrC0fPG0v+MGiFbLxoEds+WeRJfeUKTpjxteJukIpzkZClaF3/zTK+VsDTofDYhnjotC90O21WJ1x1pLhx9mXvcrYpYAZBHh2wZgjeL5Jcz8CpquK3S+828z9xdnOSe/a/AMfYkWorbVQ7c/PcNdS7KDgTkSCoQU0DChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUB4fEXl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUB4fEXl"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cd9d0eceaso1613566b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775053561; x=1775658361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JweEkOW0ui0iKBUM9x4AI5mDbXGJCNIyw1IDqaTCLtw=;
        b=pUB4fEXl7MrtIBoZNHL4ob6nMby+Vif3DkuKb5RvxQL3WzZWw3jhMenuHpSNfhwlsz
         y3sBCvvhC8OUIvV3U0UsUDBFwdD1pn2xgtn/PmHP43wLF++rdZZZTpf7grQoQWn5vojr
         0iXLq1bVEV4UhoXu8omKrcZ7f868FiAKAOwXAoTR20bEy47nI+6XE6Hj4AAFtJuWGcAr
         GYlD7N3HlcZioZqNcgSEC9jdmHSGjui0zUb+KELqWoAYErzYxq1VL0HDEdd3f/4b3zMK
         /GmyfTI8cJ0jWyvUAD+FO9JbJ/aumYXGGSOTaCrph//0u5cC4WknI0qHNlsYOM1tfC9v
         b9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053561; x=1775658361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JweEkOW0ui0iKBUM9x4AI5mDbXGJCNIyw1IDqaTCLtw=;
        b=H9oFF7BbniXhEmYpQ9BUxsusJ2oFwOMejCTuzaLAThkiq7abmmxeX2bzZY2m7hX3qe
         cmGg9Rl+4YVoIgLbHwWJtL4LalesRZ/wcNLqcRxXIWk7NenRDcRnAZcEMaB7TIgrBXyG
         cLj0fKDzqYoVsXRWPyyD6aTHnCQgcvaGBmp4+UfQ00p37hsovjqG4m9S2VG2RHQ0aimB
         SQSgCkLBff8dKkzbbq2D2Gsit4TuO9L8cNqzSf5p9eMkBW9sIcgyhGqLytdvo3AOosgP
         gZVcPlE7hHr7f8iMwghHNhoYKtEg+H2M+/a98ahHbQ9sJIsfBQfoJajLa0MM067wMDfv
         e51A==
X-Gm-Message-State: AOJu0Yxql1CUVBvE8k/rFLpRgr3K5Kzf1nxFbXLW4qOZ5A4qw3GWOi1I
	YDGEFTm6vqPcnkAMc5haKGYpHRDrmL5bZ/i42xM+G4wl5iODzgR5fWHZMPhMlQPY
X-Gm-Gg: ATEYQzx5p4nnSLa3qcx0oTn27sNeKNELi1iKVRelVuyISIxUpVX1HBtqoz8tD6GY8VT
	YeImU+s18Su7i0tg/4/YeTQu7nuz3sSpwX1X7wI7o4SoCtrXfIEMY06vfz4hMrmve02Zog5nAZG
	8pgH6yULY9jEvaoy9Y/PBKhVhlrD15+cRodyjO1DovBp0SVnFLstZ24TSLTI7Cbll6uHhEqC7rp
	zAdni3xdEtaTUtOKQ0kPYHxlwiTj0sTDtNFQrFDDg2CP/02llI/i5w4Zsm7FhgCuT/pO3Idl763
	6XvZJlVWXAWnEYnJXrb0MRbDmYdRjR/JqfIOr1SV6e6rLco/f+CaHK2wvDwaSiOPYgIbJS73I2J
	qLiH4hdhuHPL2YiyWT/w1Y7WMxFPbGWG4m6Mx8hZmv5DboVnvOknmXzlEVTsZJjmUBMS0UNS+pb
	IiZi/L/OQfrY0dmZ9O/2oCNq2mjXT2KGZP8MSZp28h9wB2BZ5Cjdog80TfzwstO9aG
X-Received: by 2002:a05:6a00:8d0:b0:82c:e0d7:268b with SMTP id d2e1a72fcca58-82ce8979587mr3996524b3a.23.1775053561337;
        Wed, 01 Apr 2026 07:26:01 -0700 (PDT)
Received: from LAPTOP-KU1E7KI5.fudan.edu.cn ([202.120.235.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c4126bsm83663b3a.36.2026.04.01.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:00 -0700 (PDT)
From: Keenan Dong <keenanat2000@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Keenan Dong <keenanat2000@gmail.com>
Subject: [PATCH v2] Bluetooth: MGMT: validate mesh send advertising payload length
Date: Wed,  1 Apr 2026 22:25:26 +0800
Message-ID: <20260401142532.332943-1-keenanat2000@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328084648.51158-2-keenanat2000@gmail.com>
References: <20260328084648.51158-2-keenanat2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mesh_send() currently bounds MGMT_OP_MESH_SEND by total command
length, but it never verifies that the bytes supplied for the
flexible adv_data[] array actually match the embedded adv_data_len
field. MGMT_MESH_SEND_SIZE only covers the fixed header, so a
truncated command can still pass the existing 20..50 byte range
check and later drive the async mesh send path past the end of the
queued command buffer.

Keep rejecting zero-length and oversized advertising payloads, but
validate adv_data_len explicitly and require the command length to
exactly match the flexible array size before queueing the request.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
v2:
- replace the raw total-length range check in mesh_send()
- keep REJECTED for zero-length and oversized advertising payloads
- reject len/adv_data_len desynchronization with INVALID_PARAMS

Validation:
- vuln kernel reproduced the field-spanning write in
  hci_set_adv_instance_data() with a minimal direct-QEMU initramfs
  repro
- fixed kernel rejected malformed MGMT_OP_MESH_SEND requests at
  ingress in the same direct-QEMU setup

 net/bluetooth/mgmt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e5f9287fb..18cee19aa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2478,6 +2478,7 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	struct mgmt_mesh_tx *mesh_tx;
 	struct mgmt_cp_mesh_send *send = data;
 	struct mgmt_rp_mesh_read_features rp;
+	u16 expected_len;
 	bool sending;
 	int err = 0;
 
@@ -2485,12 +2486,19 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	    !hci_dev_test_flag(hdev, HCI_MESH_EXPERIMENTAL))
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
 				       MGMT_STATUS_NOT_SUPPORTED);
-	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
-	    len <= MGMT_MESH_SEND_SIZE ||
-	    len > (MGMT_MESH_SEND_SIZE + 31))
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_REJECTED);
+
+	if (!send->adv_data_len || send->adv_data_len > 31)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
 				       MGMT_STATUS_REJECTED);
 
+	expected_len = struct_size(send, adv_data, send->adv_data_len);
+	if (expected_len != len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	memset(&rp, 0, sizeof(rp));
-- 
2.43.0
