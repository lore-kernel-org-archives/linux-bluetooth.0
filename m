Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3F395AD2
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507099; cv=none; b=HSrcymfL1rmS1nJ6FXCCTVBfS0v/QENOlBCNzGmToMy4i1N+VsjfTeBwDOqS4ba0w/5IkhLk9sHA9dab/i/aIKLQskQPifCDFfkPiDeDBKj9KUn+CAOmrmp/38X6hCFyK8UM1I2rzYj4YfWf3RkIgTwphqqnAdBXAgCrvqXuLaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507099; c=relaxed/simple;
	bh=KOl8jmrFfl+8h98tuqSGeaJ2dBRItGP32FRNaZsYlgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLIaQQb1vbasF+o5OltosC9ueVPBMAF+5slajeC+NZ/uoCg/0jE3FNlPsGTtOH1Ly3w3ZQkN30lHLvp0B8KMj1nPCRxQ+itk8X1+abuUffXWuZyPlDTEAucyuJYCllGslidEyIgAM/YtrB96FHG307p/V7au9SPWeLxrRdNlScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqMtaWRM; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqMtaWRM"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33bc6ff6cadso259829eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 04:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790507097; x=1791111897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z68JCcllfkB9N/J0fAQxTKvHFiY+2t1qnuCG8bIZkkQ=;
        b=JqMtaWRMIs3SBXcs+mQV+gza8Ks/mkyNOXDQysGx3DTDKA7KwfbWo5+tJISIIifLOv
         byMvt+euC3GJ0GgRTvlXKHTjt+4d8JPwDBzTu3swUNP8HXRceh2i1OGbCNuFpai16zbD
         JmihucHoh185egse7a8WP5VCYra1xx7AhIx8PjlrQeO3BC7mqNK1U0Q/mBFy7kde2SW5
         dyFKOePa5o4P5UGNpe4AB4WpdVRww0F+nP2NYtYmCob79NtV+KhSNQyWQcdV71hnUqLb
         DxnGB5IfUVAyLx8+LrVdncV9qGxWAzmgRAkjF2I6uis8ZEtRQlu2PiIGyYj2nWLQiS9R
         D17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790507097; x=1791111897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z68JCcllfkB9N/J0fAQxTKvHFiY+2t1qnuCG8bIZkkQ=;
        b=I7rd20mKFH8+cfBR2cH/m46QbxDswIkhzlkYDpwtY9UWFS2SSCSH5dM1dHhe0WCCt3
         9mqlPyxdCFYBVMGHIOxWT3ajRSzUizun7j92XeYXsWF6rsiuhgK6KoTEagPckxfrEjMc
         Qoz/bMJ17JpjWIeg57tPBHE1eLHGrpP/ZTL1FEbG7Pclqzzu5cgFQrWZJi9u38yuoZse
         liXYgvM/MkiAZwk1rsDF7K9JIVcOeqvxCRwIPQDvf292Tdlqpvl/iRezXeMHr7TXYVAb
         RRaX+1c53lrb1JlTmdhbiipTj0ecnGxZAOoYvtThmLbAu5+uEP6Lnl/ChZu+WBCU0v+U
         omSA==
X-Gm-Message-State: AFuF++ndn6fwTlmg9pjCQxG8NYfsnjbvUdXrQ06GJ7nUzCstfY06ppzG
	pFnshJ5EiYhakhsSRAtbP9Y7Rn7GiyBqka9U2ZfMdjlkDjNsClpOK2nb
X-Gm-Gg: AYBFou363dTDjPER7Ipp9o/YHCFj8B4PAz3ejeWiD1YeOxKhu96r9/ZIxfrCBzxHeTF
	2J/aalWALR9bvfQGnfw9H5a1ZajfkAMcCru3+Wm94tv7SGRH8BGPz1o0LUw7JyNJ37UWxStvd1o
	MqQQBhS8nbyEAlc1z4EgK/x0ItqfoaICrdi3b89C5Sz4TnO3uXzhb+wqFHrK+egiw/drbApwnDM
	sR3twOysv/tC9KetwRVp3l10R1gZh1Vs2IbF3zXP+s8Xfr0nVm4Pb4Ln+znHrxAUdVMhIuFjX1F
	5CfBosTuNG8Ojbu5ejBhjnw0NZxSoLGj4vkfc2eiCBI2kKOYXFdlbSYGRYtG5DglrPduun21l62
	cwJYi0bJ7Nu/rIKm6QP3MLH9vuCVdb7TGcWrdbxQOkAm3KCUGdeLzauuGHu21pcumONBrdb6bS9
	BVoMKkaH/sxXNUORqY1i7S6zHEvT9SvcsA6qtT/6nOkxtIzJUnWV/MdTAFE8lNWL3gZXyi/RtlO
	q/SlHLvwCF6qt7TAwiWrKzA4YOSJwZBrF6BqtqhCNI+fBinFDzSN3skKUzpeSyotsfM1foYCmrI
	LAOt
X-Received: by 2002:a05:7022:3c0f:b0:13e:5a51:148c with SMTP id a92af1059eb24-146cb31161fmr8647916c88.0.1790507096182;
        Sun, 27 Sep 2026 04:04:56 -0700 (PDT)
Received: from localhost.localdomain (95.169.12.199.16clouds.com. [95.169.12.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145adcc5b00sm17970541c88.15.2026.09.27.04.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 04:04:55 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Brian Gix <brian.gix@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_conn: Lock parent access during enhanced SCO setup
Date: Sun, 27 Sep 2026 19:04:50 +0800
Message-ID: <20260927110450.3902328-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bluetooth: hci_conn: Lock parent access during enhanced SCO setup

hci_enhanced_setup_sync() runs on the request workqueue without the
hci_dev_lock held by its caller when setup was queued. Its CVSD
capability check and find_next_esco_param() dereference conn->parent
while the receive workqueue can unlink and release that parent.

The following interleaving can cause a use-after-free:

  hci_enhanced_setup_sync()       hci_disconn_complete_evt()
  load conn->parent
                                 hci_dev_lock()
                                 hci_conn_del(ACL parent)
                                   unlink SCO child
                                   drop link's parent reference
                                   clear child->parent
                                   release ACL parent
                                     bt_link_release()
                                       kfree(parent)
                                 hci_dev_unlock()
  read parent->features[0][3]

The reference held for the queued SCO child does not keep its ACL parent
alive after unlinking. Commit 42de40abe25d ("Bluetooth: hci_conn: fix the
SCO setup context lifetime") protects the child stored in the queued
context, but leaves these parent accesses unprotected.

With a 40 ms diagnostic delay after loading conn->parent, an instrumented
kernel based on fd179f8a05be, which already contains 42de40abe25d,
reported:

  BUG: KASAN: slab-use-after-free in hci_enhanced_setup_sync+0xda5/0xdf0
  Read of size 1 at addr ffff888102204047 by task kworker/u17:0/93
  Call Trace:
   hci_enhanced_setup_sync+0xda5/0xdf0
   hci_cmd_sync_work+0x13c/0x290
   process_one_work+0x6b4/0x10e0

  Allocated by task 92:
   __hci_conn_add+0x304/0x1df0
   hci_connect_acl+0x349/0x3e0
   hci_connect_sco+0x3b/0x9a0
   sco_sock_connect+0x475/0xca0

  Freed by task 94:
   kfree+0x121/0x3c0
   bt_link_release+0x79/0xa0
   device_release+0xc8/0x240
   kobject_put+0x14d/0x280
   hci_conn_del+0x524/0xe30
   hci_disconn_complete_evt+0x403/0x8c0
   hci_event_packet+0x71b/0xb20
   hci_rx_work+0x293/0x730

The accessed address is 71 bytes into the freed ACL parent, at its
features[0][3] byte; the queued SCO child is a different object. The
diagnostic preserves the loaded parent across the delay, matching the
unmodified compiled capability check, and does not change the parent
references or teardown path.

Hold hci_dev_lock() across the codec switch, including every call to
find_next_esco_param(), and release it on all selection errors. Keep
configure_datapath_sync() outside the critical section because it waits
for HCI events. Preserve parameter selection and existing return values.

Fixes: e07a06b4eb41 ("Bluetooth: Convert SCO configure_datapath to hci_sync")
Cc: stable@vger.kernel.org
Assisted-by: GPT-6-Astra
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_conn.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 96195d2fd10f..cf44452e0766 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -302,11 +302,13 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
 
+	hci_dev_lock(hdev);
+
 	switch (conn->codec.id) {
 	case BT_CODEC_MSBC:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-			return -EINVAL;
+			goto unlock;
 
 		param = &esco_param_msbc[conn->attempt - 1];
 		cp.tx_coding_format.id = 0x05;
@@ -332,7 +334,7 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	case BT_CODEC_TRANSPARENT:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-			return -EINVAL;
+			goto unlock;
 
 		param = &esco_param_msbc[conn->attempt - 1];
 		cp.tx_coding_format.id = 0x03;
@@ -359,11 +361,11 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		if (conn->parent && lmp_esco_capable(conn->parent)) {
 			if (!find_next_esco_param(conn, esco_param_cvsd,
 						  ARRAY_SIZE(esco_param_cvsd)))
-				return -EINVAL;
+				goto unlock;
 			param = &esco_param_cvsd[conn->attempt - 1];
 		} else {
 			if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
-				return -EINVAL;
+				goto unlock;
 			param = &sco_param_cvsd[conn->attempt - 1];
 		}
 		cp.tx_coding_format.id = 2;
@@ -386,9 +388,11 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		cp.out_transport_unit_size = 16;
 		break;
 	default:
-		return -EINVAL;
+		goto unlock;
 	}
 
+	hci_dev_unlock(hdev);
+
 	cp.retrans_effort = param->retrans_effort;
 	cp.pkt_type = __cpu_to_le16(param->pkt_type);
 	cp.max_latency = __cpu_to_le16(param->max_latency);
@@ -397,6 +401,10 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 		return -EIO;
 
 	return 0;
+
+unlock:
+	hci_dev_unlock(hdev);
+	return -EINVAL;
 }
 
 static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
-- 
2.43.0

