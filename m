Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A92DCF67
	for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784478284; cv=none; b=jw/onkLw+lmZ6SWrotoo4nHSWyUchW2eApcw3nci/iO3FZU1G3ATP/Pq4AJrkLB3FZt98XBhkDo//00pk4HbIvK1N1dlneXkyfl/tK/0SyJXxV4abWkQ7lNRLch+gK2gyTCke0OfpZkJhCdlEotZ34XHiF4BCyUuDU55O/s4I3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784478284; c=relaxed/simple;
	bh=lls+axzfyfbPlmpiWP9MviDLbR2C1B2lrbGamHYgbyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2SutrtodYOtqOJNX1EybtjrUvXkdj5JhpGgIeMJf/IDUiCvIrO4bWsw5aXrZItq+qVLz0hSg5nU/i9k91cjunCgSxF3LfnUdEUb0TVQ+AWtsFmkBgHEbsd5Dp81k99yVt2UqsUJ4HAPnPsxj9l7rNuUpxSeRFpLqG2BtdYZ3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDCJG4rU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDCJG4rU"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf49dc28ccso2702795ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784478282; x=1785083082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8UqeMyxU1RhWc7nUD5ALPha2axtqfJyzgN4FsQvE/g=;
        b=YDCJG4rUAHt046iX/VBZz/dHGJYuky8JMQ9YP7a/IEIsIbO1/rcznZS6Y7vClq40+R
         T07hZwL9fukQHSBijpMsqjv3z6imV/kP0DGFomml1STI00LGKp568vkaK6U+hMXpXyg8
         s2LR0RqU0I2oALrZXnWQSpdhBrhDsz293cC4lxCle+1PMfjPrF5dnOvsvMpvdU3SZ7BG
         Kk+w+vA6rfA3PA8kp0QXwNsOEOmtnhR3qc/1yf3clF+Zrl/MFYUhhDrl6FNIBuQeFfJZ
         mDdScdqLoHkmkQlgVDoYwFP74c7FgG+jVBWWldCjFif42GopwOi1R0bPjTv3vygQKGwo
         LeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784478282; x=1785083082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8UqeMyxU1RhWc7nUD5ALPha2axtqfJyzgN4FsQvE/g=;
        b=IyIJFXWuvljcUsWIfcMNo1KejxBHJrNAm9gQsGJhqYQyvvwJxlTlQkcA3jp8FRRcJb
         lHR85ZlwZZhkYJOfHHuCEn3UUao/pQgoIHnIVyHElL4BZwCCR3rYg8Ge+HSO+fkzToq/
         XRiccGjK5I5HPKnUhEtl8Xe6lfVjv4vlBi6iI4nYXEWmSbfS4s5uH1XQKJf49Gv+gi1K
         m39Tsg4/0lMHAP4QwPGp4y4ilUaAO1JXYNWsrItjjHGRg5ZvXkQ9E0TgJdsEmHzd2t2M
         j9ESKsi6NDs69XpCbEruYQ76Zd2bnDT5EPUDVFJk6XSJq5EQmN4d25xEe34uOYQAypPD
         vpmw==
X-Gm-Message-State: AOJu0YyczDXmfPW+aP++Ki/Lige1/YkQR3iS/bcAfJ4DQZDSIxifiEqo
	gdMPyzo8yDBmg2Bqc/sMJYop0zf3ss2BcVFE3YWUBjDl7RcVrxaQga1R
X-Gm-Gg: AfdE7cnwm6GxKoUJvpesR6Vnhvq9TzRIZohy8Ri49Q6f58vtbBTvbuuPGf0JNoUzbq0
	IsG3lSl+nvlZ3S8ie9hF7gD5BySEf+vYd9z8Sgu+OchrqTuyHLCkgmP6Xr9uy1Halgrs84+hM4q
	LpbPOURGCVhVHAmqGdUIYYrbFRUTfHxaZrgN8tiEUlnM6UsPrtjgh+/R4XyFsgETFda+BPl8EdU
	hi4SJjj9UI6de2kjPFtMtiF1IMhB/rlG0+KGtYqGLrFAeSoHssOJhBauHnHy4N4JKoQKN9oztwO
	RoWRRRClDmr9dte+nfBAjlNomWQJYZS+/bMlpm4Lapz+FWz4AcenYIaqLbzBIR+3MoKy+jFgD05
	bdpfGUbFk9hGjFgHBXipFtL+lesnImsv7jwaEwZTcoMVX5NYwUmKM7hMmcpGFHKIeUEFmFA52WD
	BLoiVEWN/h+/yOG7I39j0Kr33ZrMR387APuSq4kt5upY0kzjiR
X-Received: by 2002:a17:902:f68b:b0:2ca:d803:5c8f with SMTP id d9443c01a7336-2cf3485119amr90372745ad.1.1784478281838;
        Sun, 19 Jul 2026 09:24:41 -0700 (PDT)
Received: from localhost.localdomain ([14.218.106.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347119dfsm41881925ad.56.2026.07.19.09.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:24:41 -0700 (PDT)
From: Chengfeng Ye <nicoyip.dev@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <nicoyip.dev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_sync: Protect UUID list traversal
Date: Mon, 20 Jul 2026 00:24:27 +0800
Message-ID: <20260719162427.2902105-1-nicoyip.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hci_sync conversion moved class-of-device and EIR generation from an
HCI request built under hdev->lock to asynchronous command sync work.
The worker holds hdev->req_lock, but that lock does not serialize access
to hdev->uuids against add_uuid() and remove_uuid(), which update the
list under hdev->lock.

The following interleaving can therefore occur:

  CPU0 (command sync work)       CPU1 (management socket)
  fetch uuid from the list
                                list_del(&uuid->list)
                                kfree(uuid)
  read uuid->size

KASAN reports the resulting use-after-free:

  BUG: KASAN: slab-use-after-free in eir_create+0xb8f/0xee0
  Read of size 1 at addr ffff88810dbd8620 by task kworker/u17:0/87
  Workqueue: hci0 hci_cmd_sync_work
  Call Trace:
   eir_create+0xb8f/0xee0
   hci_update_eir_sync+0x1c0/0x330
   hci_cmd_sync_work+0x13c/0x290
   process_one_work+0x63a/0x1070
   worker_thread+0x45b/0xd10

  Allocated by task 86:
   __kasan_kmalloc+0x8f/0xa0
   add_uuid+0x18a/0x4b0
   hci_sock_sendmsg+0x1033/0x1ea0

  Freed by task 92:
   __kasan_slab_free+0x43/0x70
   kfree+0x131/0x3c0
   remove_uuid+0x25e/0x560
   hci_sock_sendmsg+0x1033/0x1ea0

Hold hdev->lock while generating and committing the class-of-device and
EIR snapshots.  Release it before sending an HCI command, so controller
waits do not happen under the device lock.  This protects all UUID list
walks in these paths and restores the serialization lost in the command
sync conversion.

Fixes: 161510ccf91c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 1")
Cc: stable@vger.kernel.org
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
---
 net/bluetooth/hci_sync.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 532534bc601c..c0b1fc293b49 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -929,12 +929,16 @@ int hci_update_eir_sync(struct hci_dev *hdev)
 
 	memset(&cp, 0, sizeof(cp));
 
+	hci_dev_lock(hdev);
 	eir_create(hdev, cp.data);
 
-	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
+	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
 
 	memcpy(hdev->eir, cp.data, sizeof(cp.data));
+	hci_dev_unlock(hdev);
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp,
 				     HCI_CMD_TIMEOUT);
@@ -966,6 +970,7 @@ int hci_update_class_sync(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
 		return 0;
 
+	hci_dev_lock(hdev);
 	cod[0] = hdev->minor_class;
 	cod[1] = hdev->major_class;
 	cod[2] = get_service_classes(hdev);
@@ -973,8 +978,12 @@ int hci_update_class_sync(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE))
 		cod[1] |= 0x20;
 
-	if (memcmp(cod, hdev->dev_class, 3) == 0)
+	if (memcmp(cod, hdev->dev_class, 3) == 0) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
+
+	hci_dev_unlock(hdev);
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_WRITE_CLASS_OF_DEV,
 				     sizeof(cod), cod, HCI_CMD_TIMEOUT);
-- 
2.43.0

