Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C585298
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719947525; cv=none; b=j5ZYoVtY4yzEcd9kx/aPoGXyGt24r+E4mi+sX858trX2gGmmYX3X2AqLC5y73/CxtBzpYCcYls9qKi7X/gYiUHGKeQpZyJYEdv1AosbTmElkOXnxrD1/jpwu1H/ffxnae2bzskKxLSeaHBs2WWkqmnFxM4pAR27SNEqr7+cWJ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719947525; c=relaxed/simple;
	bh=kySyDIvh0tkOm7W/K8T7x+WnGXGOtMh+VYoXf/frOEg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbCp+4XAVg1tdMGIim9X+uHfr56xqN6s7bd73FN8o5927G0nqS67+AERL1qBMkUnUQft6uUqnEmhi3vwqxhkjvo4SO4bVWV6Ny4b4GAVU3Ih1tMCGJ+//g2QAAWak76BMjvkjnTd0HAUzgVZ9NOIUqyawnuCZuSUZcfm04l+aT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYNS8Jkn; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYNS8Jkn"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-80b76c5de79so1182505241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719947521; x=1720552321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i2rioZdxIGMEaGcJQ0WuxK8KC6brQA6zqkeyjDE3Uw=;
        b=kYNS8Jknkw3/6QskDxOPV85oFBvxPOPa3eW4omQuF8fwJdH/vAe8Gaqj3WE2DPdskh
         fOdVSDIlzZ9omtyZ/wP/r1BAVNZATAajO9q9pc3O9Xk0GNKN6scu/km0b3SkXJcmBH7n
         kOQzjJytdpt0yTbfQ/EbTGL3e/P9Y7heAWoLM/udMvAzlhvtWTbMVkvC4wxlv3Sv0JOj
         +ycyFRef4ZT301Vj9zddq4BFJbmsbC/G/9zSdgTiF7PvgjHGcsx3zPaqRCX02wqMnU2V
         Jewy5pBFuSLmI+t9xjdaj+9AcJltzNhn8WEhhpmyDXT5WxsuA0UTEMuah1jmP/jx7OyT
         Ipaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719947521; x=1720552321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5i2rioZdxIGMEaGcJQ0WuxK8KC6brQA6zqkeyjDE3Uw=;
        b=Ezx/5eC9upaLWBgCUC/OXICuM6J3O7tIDwgg5/M5ZwfT/hrOyYQmkNEBL7NvCMU7YO
         NIrp9bBB06bpp+zhDzLV/za1nMKryCGCAuYaSsLdz+6fc7utLOcrS+uiLtkDa28yrAwH
         yTCM4Dk3m+yRpI5urYRRbuo59qYoTWrlIMQaS+IGJDCMT/+oCvvmKeVSvSxmw0QzkIQy
         jgVsM01O1upCCzDMgSaT6FKg94CbtT55e/nPr+9US0+qaa6SXE4C+j9RXHRgdT6bB2Ja
         in48NAZxlxbr7+c24v46ldijRsnoAe23HBq7dD1Y+Bnwe8B5Mbr8Hxbsrf/QPzH3rPz2
         8y4w==
X-Gm-Message-State: AOJu0YzWDgEI1icpW9/ZZ0QDJj0C1mKMQzRUAjxEl0eaUSDN5tZzldDR
	mvBx4caUI5sP75WE/by9AScD4rRbEsg833d8ETJPUq04WT538FHAqw5y6w==
X-Google-Smtp-Source: AGHT+IG1TQO9p1Pfmn6G3r5Tbr9+xAeE86bFK+GOnx5hyHDmJrK5PiTUjXYx2ucMdvjpRKwOoBDaXQ==
X-Received: by 2002:a05:6122:4014:b0:4ef:5e3f:599a with SMTP id 71dfb90a1353d-4f2a572cdd2mr10182697e0c.14.1719947521419;
        Tue, 02 Jul 2024 12:12:01 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f292259618sm1383232e0c.37.2024.07.02.12.11.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:11:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: hci_core: Don't use hci_prepare_cmd
Date: Tue,  2 Jul 2024 15:11:54 -0400
Message-ID: <20240702191157.1722089-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702191157.1722089-1-luiz.dentz@gmail.com>
References: <20240702191157.1722089-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the instance of hci_prepare_cmd with hci_cmd_sync_alloc
since the former is part of hci_request.c which is considered
deprecated.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h | 4 ++++
 net/bluetooth/hci_core.c         | 4 ++--
 net/bluetooth/hci_sync.c         | 5 ++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 620e6014beb2..a8d88247ac89 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -20,6 +20,10 @@ struct hci_cmd_sync_work_entry {
 };
 
 struct adv_info;
+
+struct sk_buff *hci_cmd_sync_alloc(struct hci_dev *hdev, u16 opcode, u32 plen,
+				   const void *param, struct sock *sk);
+
 /* Function with sync suffix shall not be called with hdev->lock held as they
  * wait the command to complete and in the meantime an event could be received
  * which could attempt to acquire hdev->lock causing a deadlock.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cce755a84ea7..9bdd3e1f8cfc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3054,7 +3054,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
 
 	BT_DBG("%s opcode 0x%4.4x plen %d", hdev->name, opcode, plen);
 
-	skb = hci_prepare_cmd(hdev, opcode, plen, param);
+	skb = hci_cmd_sync_alloc(hdev, opcode, plen, param, NULL);
 	if (!skb) {
 		bt_dev_err(hdev, "no memory for command");
 		return -ENOMEM;
@@ -3089,7 +3089,7 @@ int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return -EINVAL;
 	}
 
-	skb = hci_prepare_cmd(hdev, opcode, plen, param);
+	skb = hci_cmd_sync_alloc(hdev, opcode, plen, param, NULL);
 	if (!skb) {
 		bt_dev_err(hdev, "no memory for command (opcode 0x%4.4x)",
 			   opcode);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 46b394842a27..0c8888448d3c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -49,9 +49,8 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	wake_up_interruptible(&hdev->req_wait_q);
 }
 
-static struct sk_buff *hci_cmd_sync_alloc(struct hci_dev *hdev, u16 opcode,
-					  u32 plen, const void *param,
-					  struct sock *sk)
+struct sk_buff *hci_cmd_sync_alloc(struct hci_dev *hdev, u16 opcode, u32 plen,
+				   const void *param, struct sock *sk)
 {
 	int len = HCI_COMMAND_HDR_SIZE + plen;
 	struct hci_command_hdr *hdr;
-- 
2.45.2

