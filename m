Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A6192B66
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751037548; cv=none; b=eCCtmi+wMuV9FjB9KMv7e380UolA0lu0PyfNgcmS8rDLYW9Y0WPIfAsq71AxB9MK147VHf84UcK205jtv6FWJKV8/LFMtjOB4K3fpyDTiPrTIeWNE2FK7+t4sdRivOWUmRxlT4VV+iNjDVsCJzja2VL5WMOOf69EjgEN1PcLVRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751037548; c=relaxed/simple;
	bh=F8f1zoZ7nZSp/BvR0doIWPH+dQffR7i1rsyOsDlwZJQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hCfHztACrA+VF26ewzV698aGywFqUfrit6+YltBErofjfIxfJBbsvmmeyVDxRws0+R964wI3lkkY9LgyXQgKi+bbUKh8QFUCLh6EQQa3Rj9PgqxbQSvMkEXbnz3S55sM4KS7tvnJ/79WjZ+hT0di0/0FLrMpPlkoftVVa/JO/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhduI6e1; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhduI6e1"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-87edd8f4e9fso567106241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751037545; x=1751642345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2aa3GIrxR3/zoBbl2iRQg9ELtMsEiqPgcI3juimWL64=;
        b=LhduI6e1lan+LmJHt8AsoDCNLa5qa6ZfIJ6kg7T5axapJqkFS50jCFxjt2h5roLJaj
         8Vh2B6rse/jR3uda9me8UKHn+YRd96G3CufuGzuuh+nZ/F94esoH7aWCggLOKs/X7WP6
         Ni/ovjWHwZD95ltQuRh0gYthC42bid3QPe4ILbvBpZ7LDlwAuFOv1Sm6ZW7AwzQYs7EA
         M66/zlrH3F0Q9rlxjpKG06G5oO72+eUV+Zt1hime+GJ/KrXPbx5448GrPJLH3KdqpGgd
         IWvxPxFguXD7tg4PBtnnKckjmH1r6mTHZELh274PA6jKE8UiD1ferUucKfMnoYHmjQyC
         QNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751037545; x=1751642345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aa3GIrxR3/zoBbl2iRQg9ELtMsEiqPgcI3juimWL64=;
        b=bCEgGMDWogNsFEw/tG/6jgTexmbJvr5UpoFj2KY4cATq+geDhWkGZ/X9ytexQfs0Uj
         TVA8JuTwhyqxa2r8aMl5u6TqcUNYm8xuzvfFAqKscZ5CgiqVTEHE30saVD7pTisgbPpQ
         FCl2hGyEE0WRI9jL1XpyjmuP1D0bo7oPAxW6jS0a5ttqyjaL9fHOWJo/7KebLkcepLa2
         sC39TnV5fdum1aCO85q4999fgDzfl1qVGigdqflr+FNIgXv4Y9lC+N5HeEZB/gGZhAmx
         MmDKPEROrtO+qc8hSARzAsTu3XK0EiT2iNXpwK0AbCTkc+he+xzJqmpQw7KDsuZ1OePa
         jUPg==
X-Gm-Message-State: AOJu0YxRvAAZuYuxNEDa/CNFcuJ/Ip1s3FhhMEXaz4xKNAw0WjAH2oT9
	npovLzSNd3zD7u58wUFF8+jAvttuDDpe4t7mryIRbiW4fiPHBbETgSV3rtYQT82S
X-Gm-Gg: ASbGncthCJIoHpTRG1j9tvKV9exzTh5f8HpvCtYhPSrqNt6zxKUcUEuxr7cUSbV70Gt
	V2asIguD6+YgABgyFE35mDzG7D+ytB1byGJnI7ahkrib4KZsCn3X6ZNlZKc+ePlCy1RnHFmOq6z
	YbFPhmVbq12L/WUpare524u8HaNwzbqZjrZ45hX0HcCA2I1fnNneGwfo7X2kYTtNoNejM+NEi/v
	ujXT+vNGxxOR/vhwh3cL7QiXxv6qARfjk/DAIDL0wWaRQybaTRKlY+G/Aa3B42SAUlAPX8BxyW/
	+sthPdeI6OnnAz3ppxuUdUP0B2CZFJ5mEcW3FDGkJYHgLbE8sJNit7lekx1uKqLAaRifcGdSJfO
	23m/KGIzW6laM9pqB6meryrl5tyLwRdc=
X-Google-Smtp-Source: AGHT+IHZH5/ur9zx4Fb+yjCBxkwUOarti+WvlVI+B/MkCdHrHvCOEcfA81fzthsx7MY6ij06dKy+QQ==
X-Received: by 2002:a05:6122:6609:b0:531:2906:751e with SMTP id 71dfb90a1353d-5330c040ea2mr2983062e0c.8.1751037545015;
        Fri, 27 Jun 2025 08:19:05 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-533092120fdsm392630e0c.44.2025.06.27.08.19.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 08:19:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_event: Fix not marking Broadcast Sink BIS as connected
Date: Fri, 27 Jun 2025 11:19:02 -0400
Message-ID: <20250627151902.421666-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Upon receiving HCI_EVT_LE_BIG_SYNC_ESTABLISHED with status 0x00
(success) the corresponding BIS hci_conn state shall be set to
BT_CONNECTED otherwise they will be left with BT_OPEN which is invalid
at that point, also create the debugfs and sysfs entries following the
same logic as the likes of Broadcast Source BIS and CIS connections.

Fixes: f777d8827817 ("Bluetooth: ISO: Notify user space about failed bis connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ef5fa8ecd56d..ce6ac222546c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6992,7 +6992,10 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
 		if (!ev->status) {
+			conn->state = BT_CONNECTED;
 			set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
+			hci_debugfs_create_conn(conn);
+			hci_conn_add_sysfs(conn);
 			hci_iso_setup_path(bis);
 		}
 	}
-- 
2.49.0

