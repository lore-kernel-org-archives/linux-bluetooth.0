Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8434217555
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007625; cv=none; b=ZQexFT9YxSQyr6w0WtrfdXtL0LN0mXuKVvKxzb5OUzLUFHVNSZl2SupyBsfVA5Y943vUFHezxxAa2KG5PdkUc4MuTQGDROlB/jSmAECEMBYZgFm9bTe7cQAGbfk2352iuMTQiA8tVv/hZRWRHdfU288Tmd998PkgJHa+LqKmzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007625; c=relaxed/simple;
	bh=v90+YziY6zlNZTSTREOi7DmzVF++lMNHIM0rER9eFzU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bya7rzwsskVWHrEUo5hl6Anl0EfYUcmpUtP3NqGHQwjlsECPAefUeM5Bx4zHkSjlbQ9mJSdp3dp2Lvgh0JhRN+Na7LWDwzcYV5Qkgkms1vc3RQBNVYBbQw2IlKjy9ridGQepM/YZluEGHBZDLGOBYownLlabZeyorW2KKX/ebpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip707k07; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip707k07"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fdb47d6131so349866137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 10:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771007623; x=1771612423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt7Z2AYgojeytWfJFUu6X5pzx7O88tua+7PhkC8sZcM=;
        b=ip707k075VRBDA0p23TeKSgCZ8TRscvEILL5c6/82upH8hC0Ly3kmEk4bzzHt1gjQ4
         c5fL/SvTLZvGkqWLdUN9F8KV+5LR4/k9HwhNYHs0SbFKVLwKy9nUTfJHTTBJtklt+koV
         Qyg6+CdMZI7qTF4BNvovZ/P+aZRocoLFOtHOdLep23WxFoiR+RSecld1cuUtJUnHFARI
         rRJj0+CDi++OtbwXOk++WXJ4zliqMI2lr+Cl33133seW0n+Jn+DKuV9+NRrsRHj74GbO
         yfPGr20efoIc8iU3IlTZJmDDaKS/FvqX0X1Q/1GVyqH/d6yNcWRde3dalnJw/RYrfUDn
         rtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771007623; x=1771612423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nt7Z2AYgojeytWfJFUu6X5pzx7O88tua+7PhkC8sZcM=;
        b=dFYuZXJxLNlpKNaNQb+5FCTH/i6vv2ki03TGeTDE+Q/oB872Bq7MLRYUjE/Q4444cV
         wE6Hr+GyLhuqrEBUUGqG4T11N2rV98dioRd/HYtRk3Mm7NNzi+7+IHP7sTEGZ4aFvbZ6
         h1dFTaXiUNkCM5fO0GKCzV0945oCWwMpcU86aum/Hpp3SwqP6tNQVkXsxdA2jkde/jyB
         0cVwFaLeZ2MdXclJg7ouw7MwJO/YIKIRLJ7/pJQN7b/2QzV7IGla/PYvUDdYsWBUanvF
         OkWuacV79CGAH55GRjLGEiRv3gGH4ZgfeXwaO7NYH2kyKGPlJjefX2oGbyowf05RlQ3L
         R+uw==
X-Gm-Message-State: AOJu0YwjR9sf3HtV6GEb1kqh5ToLf0qi+vmIpw6oVBklhNRousiJrFkM
	+c8fzwHDDATYhJRTNz79zYyA71EwiUA5aT+6qArJrxnz/W8FIzfXDcIDKQ1bVA==
X-Gm-Gg: AZuq6aLuZK1STa665uT+c8k0qfmQB024Ly1QfOh2C2+sHtpYjE5ohj35v0OrqCryNVW
	CM4cGHrYE//axUPdiyzfBlxCJq9tfHNSZ++eh3jOjAMnI5yDl812LK42wULUOYkBj/wuoZhF15K
	snzbugKxvc61WY5gz/uwgPnkGceohEde8XiT5owxdGUkAic1+H2NzD8BA0OxLzzuZ47YMBjBOJt
	wrAcTjkhb+kZL6LFBzTyNJNDWfID10ibrYx626M6EFY9+XhcwOntHWP4+q5OrCITb06FHt/s57W
	ekXYXNtIaLVKcjptwyaIsxuGjRhbXyqvd2YnOBrZgR3jPR01eQn4a6DKhDZR+7d6MM7wB86AICe
	lNBThyXgszpu2gtHvj8tOBYIgykT+V7425hZpmaOmmZWmhaPXQ6Ob9WIu092wqp5OIj+iyUfUm+
	4x9R+D04B38Kd1iC3RPSssy6SCq8dzVnBVpewdhKfLEMzwxqpOHnwbhtwm5Brvdkk2HxQR4SoD7
	xH5vBaltHsnCba4Cg==
X-Received: by 2002:a05:6102:3054:b0:5f5:3244:210 with SMTP id ada2fe7eead31-5fe1afc646fmr1051060137.35.1771007623135;
        Fri, 13 Feb 2026 10:33:43 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fde87fb7f5sm3995148137.2.2026.02.13.10.33.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:33:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ
Date: Fri, 13 Feb 2026 13:33:33 -0500
Message-ID: <20260213183333.1830534-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a check for encryption key size upon receiving
L2CAP_LE_CONN_REQ which is required by L2CAP/LE/CFC/BV-15-C which
expects L2CAP_CR_LE_BAD_KEY_SIZE.

Link: https://lore.kernel.org/linux-bluetooth/5782243.rdbgypaU67@n9w6sw14/
Fixes: 27e2d4c8d28b ("Bluetooth: Add basic LE L2CAP connect request receiving support")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9452c6179acb..f73506c35dc5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4916,6 +4916,13 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 		goto response_unlock;
 	}
 
+	/* Check if Key Size is sufficient for the security level */
+	if (!l2cap_check_enc_key_size(conn->hcon, pchan)) {
+		result = L2CAP_CR_LE_BAD_KEY_SIZE;
+		chan = NULL;
+		goto response_unlock;
+	}
+
 	/* Check for valid dynamic CID range */
 	if (scid < L2CAP_CID_DYN_START || scid > L2CAP_CID_LE_DYN_END) {
 		result = L2CAP_CR_LE_INVALID_SCID;
-- 
2.52.0

