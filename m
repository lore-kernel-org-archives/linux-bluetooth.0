Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827412874F5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849405; cv=none; b=GmZuQjOlOZG6qZGKsbe7nMGkLm3Pxf2HSKMcnn5pxyvG0fj3ilft8G6Z1x+7DIp8vZBPxtj4yLooLfkROSUWExRhMEh/vtjdJyasv9URYA51f/RAFFOz2URJNhQjeUAtBp/iDGqIkJylBSwFywxQo4cSnCT3RvpoFjDlAY5uKvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849405; c=relaxed/simple;
	bh=t0TD4IXyQG09IYnTPSMI3Ji9EedzqSuTtm6RaHyV1Lk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z88A6U2ANbbxQb2ti2tfgDjuYlK3uWUuN3N60ZP5JnBiFg5xaNlK2EnNSPtOvgnhjTf8mWVJT6PoOlBwOK6+1PwFtesM3Jk9zoeRXntLBD+U62Wod+YHtcRdZlg0nuXwJJFkTcZbhj0UsZuq3W+zJhx1yVqcu2CtLr4lFdbl6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LThQG9ss; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LThQG9ss"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56a9076813bso1319588e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775849402; x=1776454202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OU//K4uMAIHZeUCTTJ9WF6RSvdsPzswiTLGCmSL873g=;
        b=LThQG9ssFG2VlQpY5EjTJ7shmzJe3RvD/sMbHrJe63MquCaKul3eRcTK7oYiK0YSK+
         vKNgsbTYXCVDXjHxk1uFXLuftIQgFxNyPAXoyPa2/BR9uZKdbHbe7snoWtqYUcs1qs98
         8Xh+Da4ECSw/dti4c9xsDpbSWiom/7/4Kan6UDywTeODduS+FrEiiAaysPVFvtMnsqOI
         Ll62TQx9T7jgSQXd0alCRrIVecXSsOdqF2VNZvhTyTY9E50Bn+jbTlSOdRXxuMoFuJBz
         VCuh87d3QVLm7FbLgLLre3Hoo+INc7znpufjU2aCo4s1sOxGAcbmclR4ogkAEAVH+F7A
         LqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775849402; x=1776454202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU//K4uMAIHZeUCTTJ9WF6RSvdsPzswiTLGCmSL873g=;
        b=kLGjrpCz1oVqW31EYZV9aOYfvQfMgAb7eJAa3y+ZvMn77DInCi2O4DgY0PC3szQ7mO
         K7b+ZicjpG4U/vdkyuIEwtPRj+/OalB+gtxfVTWTSOQHZfyAbvI1VJJyezY9hoOuCWyF
         +hbL6FM0ox4pDRZp9491H9IsDbPO77TmcyOXKw5AqB+g4LKHOM6mEuYW/MJZT+dgZxdJ
         IkmQMYQvpDxVTw7KQ7rdiGxz/CuBIc4l+kUAkM1IVK9e/IsCFwV5aRiO+sllNFePFNMD
         B+7lCNhw733MhZj8DmHUJfLb/zDJfUSoeUp0LoimWyvDxvfjaA9hsS7JwKmNggN4yaHH
         CXDg==
X-Gm-Message-State: AOJu0Yx10Kf+sbnhwZ49yI2H+3hwkQx8i559tElRuVUxR2BTwPadAOuh
	a+eMTJPNaHGM8FQ1Zaf8cToc4MjSrY4X8dXj7wZmK+Y/pDr6LCtKXK5QFlD1iu+m
X-Gm-Gg: AeBDieu0tZmKvRhbvA+nx4NQ4s0JL/6bVFUDSdXjzZ3GCXfNEMmz2ce7aK9CdfxdHd8
	wlQUmy/mBsAhw4W06R1GjQ8iCRZdZiwKYGxUykywPu3UBNTLDlWuW7wJd6nkrEIQxsKjPNDtZPr
	9M1Ml9fGBuGwpHXorCCQNOLly8setbkH4IeUxNgKU9Uf1CMa8bbShjRcyUOrZeiyIAsYjcPbJ44
	JCELcuE2FrAD9tmU+fOG/hHzExYQGG4mGZcendl41ruV+8mSBchSsSeh2U+ZY8MdfJ2DeJ7wZ6J
	E/jpN5amEQv0MiAtvitVlBuhkNmk4vpA+nD+7bsA53Gc4i1g18suVO5QiBb847cYo4Dl9oL0c4M
	pEODPi//fursz+nYTohbSJdVBUTGk3k0mBfjdJ7C/WWqsPZChuBy2HmN0wgM0a1jcT2HuXPcNsj
	6JchEBqN0XbaoVI6ELxjGBoUsIUR81P/hA5X5DeJKoRUp0z4izNNxgra6s7PY7I8Kw65al7nQX2
	qCerFHinfx6Ou2OcA==
X-Received: by 2002:a05:6122:e149:b0:56f:2609:cd95 with SMTP id 71dfb90a1353d-56f3bc85f50mr2577789e0c.9.1775849402064;
        Fri, 10 Apr 2026 12:30:02 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-954bf072463sm2242007241.3.2026.04.10.12.30.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 12:30:01 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
Date: Fri, 10 Apr 2026 15:29:52 -0400
Message-ID: <20260410192952.206735-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_le_create_big_complete_evt() iterates over BT_BOUND connections for
a BIG handle using a while loop, accessing ev->bis_handle[i++] on each
iteration.  However, there is no check that i stays within ev->num_bis
before the array access.

When a controller sends a LE_Create_BIG_Complete event with fewer
bis_handle entries than there are BT_BOUND connections for that BIG,
or with num_bis=0, the loop reads beyond the valid bis_handle[] flex
array into adjacent heap memory.  Since the out-of-bounds values
typically exceed HCI_CONN_HANDLE_MAX (0x0EFF), hci_conn_set_handle()
rejects them and the connection remains in BT_BOUND state.  The same
connection is then found again by hci_conn_hash_lookup_big_state(),
creating an infinite loop with hci_dev_lock held.

Fix this by terminating the BIG if in case not all BIS could be setup
properly.

Fixes: a0bfde167b50 ("Bluetooth: ISO: Add support for connecting multiple BISes")
Cc: stable@vger.kernel.org
Signed-off-by: ZhiTao Ou <hkbinbinbin@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b2ee6b6a0f56..3661ec0eab62 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7118,9 +7118,29 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (ev->num_bis <= i) {
+			bt_dev_err(hdev,
+				   "Not enough BIS handles for BIG 0x%2.2x",
+				   ev->handle);
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
+			break;
+		}
+
 		if (hci_conn_set_handle(conn,
-					__le16_to_cpu(ev->bis_handle[i++])))
+					__le16_to_cpu(ev->bis_handle[i++]))) {
+			bt_dev_err(hdev,
+				   "Failed to set BIS handle for BIG 0x%2.2x",
+				   ev->handle);
+			/* Force error so BIG gets terminated as not all BIS
+			 * could be connected.
+			 */
+			ev->status = HCI_ERROR_UNSPECIFIED;
+			hci_connect_cfm(conn, ev->status);
+			hci_conn_del(conn);
 			continue;
+		}
 
 		conn->state = BT_CONNECTED;
 		set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
-- 
2.53.0

