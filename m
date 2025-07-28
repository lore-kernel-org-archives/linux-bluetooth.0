Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1122275864
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725510; cv=none; b=ozOX53n6ANnDbsrGHHMZFsssLyDv2YW7o7IN0D/Rb2t2OHGOsKmBSgGlVdoA+WENBp7HbT8LCTHp0kl+IpwluVrltxKMjrNlv1XRAR9X3ID4hFGQcjYj8+zNyJ39xA0FJgpiVvcHo/Kzgpbrhelln/r8lntQN6t831FyEBjelH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725510; c=relaxed/simple;
	bh=5m8Di2jD4jeL8fmoOcPYjNUOaNVnUdnMvqqpNo8TO2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TCCqRmGkAawFaRkPluB89Z47eqVZDAOyN90N+MAMBx9lSs0TQC1LM6uA1tLArsKLdw/ffHI7/doVP4NLw67f4KxA629a0q++UdXW5PvTuLSC9RVrlUozxkoovvnyikL5KDEBRr4Tq+HA3dIA8vmUcRJI7CosViIfEmQVO7m9jnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEU6Qt7e; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEU6Qt7e"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-531a1fad7faso1645582e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753725507; x=1754330307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aye5Mrfkh9a0VC5X/To1UMzasgjfumSsPFqNeTOWcB0=;
        b=dEU6Qt7eZVMbtjcQ3wFV4Dx0A4NXCYcAu6EPtci6LRHJNxna7S1FIf0rTJasM9+Ij4
         3ngIEg2VQKbVTCNzgnah1DQxsAJ48l1t+PwULmqSJfAddjMU1vrjTvla4+uJmK+MAg06
         +dTEkizHAAZmwIRyNsYxQJBTa3MMh1ukjpB5KLs3AOUPeYcOrcqpGBtm05U+cX5Imxow
         FHp8zG/DyNHno4rpzQCpFBRmRvNQLfXTffYIrBs3DlFGbU/aFYEN32kjZRbWcO8FkgZL
         PewoDEAPnQ35dytkVeSBwGVJ8ufN0SByjBI/1YCFf1o7srgiVX3q055Y7RAkNeex2+C3
         3JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725507; x=1754330307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aye5Mrfkh9a0VC5X/To1UMzasgjfumSsPFqNeTOWcB0=;
        b=AAboovASM2pHbsz7oS+TNXPqphi3WpJX7NNzr4/0p8lwTmb4J+5TSIMJ9TLIkrxDjW
         5p128WB2fKl50K0+QOW2C4qRz4ZLJanIT3wRrlDU33KQIMuOkHOJYiV11iNlTwPOfOtv
         /M+2UgpUFpnkWb7drc3ip7GkearSZUC9wbvMgkmYK9RhMZ5a+Ik/IaVVCoNdMUcPK3t6
         oY3hy+zpkF4wK5PNyrd9UphAmQIvL+BEAQUXG8trnhkzEeysO0O/Mrh0+KXM44U0YPf6
         z/fTtQiNUfVbKgkEumkyXF+OMSMpLCSS637wG70hLqTQBkEGBRzXGPkS2WFxZaaznzSI
         NlUg==
X-Gm-Message-State: AOJu0Ywv/zMBwBiCQuB7Ymg4P/pBsmL+NjY8lm3Z52v+e6M4pcVYWifJ
	jCnRqwbfey2y27qx9zdjDyD03E7yyATnr6MelTYjw3O/fk9LMeGrVkFGXJDwFx9e
X-Gm-Gg: ASbGnct4/V/SGZ6HKuWFxKwj6jtuSXjAGJe0LlMcEqdtIbbSqaWSj9HaRvDtzMDHQaq
	4WSCD9HQSAu+SXWjjnlk8rxyyXOQA7hioXfwYtwbDpAKwf7o7JC8/o/ptiYkX3RFTz/7pEGSoeN
	8dfmF0svcn8M31Q7hg7g7NLlV/+WOFSDT9kSTvz4tkJAIeJCehoddf2xDNvNYZ11E91dLsd9O+a
	9nqE8VcTQL+GNNT7f+8rrqwiBtisVHAaP970iAH5c0MjmfqBxF75EjHxYPvR78Buh5miG8W0/fn
	TTRKGw8xWrf4ny/KyV5R3kcls9iUOFVHL/lBt7VD9qaRXBtN5f5WunrJIZbA/nQkUaCc11VT/SV
	E900vNQ+fafpQDQeK1ZA3lYh8x/knl/9x518KGFBl1+po6CcTeooVU7u1SlxmWND6
X-Google-Smtp-Source: AGHT+IFsGIbbLYXbZdH5bfpHaMSHEHLj+y2rP/00jGp3rBXjblxBD7/3bSuazTuZZRFEb6l2gKGUGA==
X-Received: by 2002:a05:6122:178c:b0:530:6bcb:c97f with SMTP id 71dfb90a1353d-538db5d6cfamr5104447e0c.8.1753725506217;
        Mon, 28 Jul 2025 10:58:26 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b8de03ac7sm1393940241.21.2025.07.28.10.58.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:58:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: hci_sync: Fix scan state after PA Sync has been established
Date: Mon, 28 Jul 2025 13:58:14 -0400
Message-ID: <20250728175816.850399-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Passive scanning is used to program the address of the peer to be
synchronized, so once HCI_EV_LE_PA_SYNC_ESTABLISHED is received it
needs to be updated after clearing HCI_PA_SYNC then call
hci_update_passive_scan_sync to return it to its original state.

Fixes: 6d0417e4e1cf ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 2b4f21fbf9c1..ae165e693533 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6985,8 +6985,6 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_dev_lock(hdev);
 
-	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-
 	if (!hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
@@ -7080,6 +7078,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 		__hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANCEL,
 				      0, NULL, HCI_CMD_TIMEOUT);
 
+	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
+
+	/* Update passive scan since HCI_PA_SYNC flag has been cleared */
+	hci_update_passive_scan_sync(hdev);
+
 	return err;
 }
 
-- 
2.50.1

