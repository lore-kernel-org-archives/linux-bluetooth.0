Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7D0215F56
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895897; cv=none; b=U9BcZDz/jD2DEVnMFNhnax33FtXONKV4ZVwcC2Co8ard6Q47hGzgBf1kbFgrv5z6FaqHyEJaKIT3J0OV1OHo+Of26/KbouTCSZXNgC/TrY3ZZm/ewheRkUlg0OBine7MyTJlDiw0YZhOWeqrBqFwKagSkHRXwzky7yH4srBRcgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895897; c=relaxed/simple;
	bh=vdLvZE6T5N4Va7quS/qCS6/ogwfHVdo/HKU2tFczTQI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SeTPkdPnX9G32cXivq9nhOO4Fi8TFgKnq+fv1HQKRUckuw+9HTEJKJxLbj77eprKbjaot9bvVaPhsKQ/JVwa4INVNHvDBDG9nvV+VBBIyAXiRgdPWhonZwkMHootSYb7T7ghdVjgfFuNKgrqGOlAD0aTACOun93WXTWpeeG2c7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nzq52q/4; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzq52q/4"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-710e1a48130so94219a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Oct 2024 12:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727895894; x=1728500694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDuWa1XXlIv1QuZPwCpHn+oqtG7kEK1PGhNu4EkxMLE=;
        b=Nzq52q/4e3gpQOJUHUD0FeNJcxwoQU85YuRiivrmmnyuJWIRVcCS+GnoFB/jY5nfAr
         nTDTX8QWsdmBsaDh6Wez2ywT4o2yZZbxonGdEBAREbvOCy06apzvCFb/270eX/sBTO6k
         Dv4BtyrTLdvJ5L6VQu3K7R2hmOVc9Ob/XBFkrfkmAED5Hyg+DFm5MuNe3R1adm8aoKRp
         zeWDPG6mfOr0p3e6QoY4fR5YLUNaiOmzMf4ytovSipsRD0BC7PKLq0uv1vCb5LxJkqDa
         CdpEz/eoszuFtzy5r5/sbxIZJwGpcpLJo7mXvaKwtTVGHYYl0OlMeqjDatbhKCwczT/l
         wobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727895894; x=1728500694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDuWa1XXlIv1QuZPwCpHn+oqtG7kEK1PGhNu4EkxMLE=;
        b=W/hc2GhDdYT/g4VvQ9//YDh/ANzyRtsB7xoPNXKm/QaQuSfz6h0tT1ysinpbdVOL2b
         6z1+nuwmA3Opwr6nQMOX+paWWvEpw9y9hXCjNLvucChs3PpFibRkTzlWicVQVYPNGqMR
         9kpJyQL9CuQo6Xy7ke4g8tfrpGpg50IZWnsgRnAVRHZ534xvnj1wnF9kpMKtnkACD1MJ
         IfXUJtVEP7KodD48KOvdGbomA/hhZriHk0sS3oilxDUfdN+dliyCuo4SnxnpEdDwCRH7
         P+i8e2UbbIazYONqEEJA3H6KyZD8NfL0PLyS2djJOUvskE+LtGl5KaqpmQl7U53y+Atp
         yPLg==
X-Gm-Message-State: AOJu0Yx/SCtZeGNEucI6mXUzjarRyPJpwAu5J3qhq2eboHWwIy8p7ysZ
	37Z7u5UO4JIMH48oI/cyySH/2AoaGoshhBxkHAyGoE+TOSbj8j6KX/2NCg==
X-Google-Smtp-Source: AGHT+IH30QeH9bHH/P+SiqH5bBRIrXFETrqIFNE+3rKXVmIn5lMjZznlhevFm7cYzcqeFVoTesMwgA==
X-Received: by 2002:a05:6359:5fa6:b0:1be:acbe:5141 with SMTP id e5c5f4694b2df-1c0ced4fb44mr290131255d.11.1727895894215;
        Wed, 02 Oct 2024 12:04:54 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-84ed07e7765sm1216377241.23.2024.10.02.12.04.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:04:53 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: SCO: Use disable_delayed_work_sync
Date: Wed,  2 Oct 2024 15:04:52 -0400
Message-ID: <20241002190452.3405592-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of disable_delayed_work_sync instead
cancel_delayed_work_sync as it not only cancel the ongoing work but also
disables new submit which is disarable since the object holding the work
is about to be freed.

In addition to it remove call to sco_sock_set_timer on __sco_sock_close
since at that point it is useless to set a timer as the sk will be freed
there is nothing to be done in sco_sock_timeout.

Reported-by: syzbot+4c0d0c4cde787116d465@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
Fixes: ba316be1b6a0 ("Bluetooth: schedule SCO timeouts with delayed_work")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/sco.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index a5ac160c592e..2b1e66976068 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -208,7 +208,7 @@ static void sco_conn_del(struct hci_conn *hcon, int err)
 	}
 
 	/* Ensure no more work items will run before freeing conn. */
-	cancel_delayed_work_sync(&conn->timeout_work);
+	disable_delayed_work_sync(&conn->timeout_work);
 
 	hcon->sco_data = NULL;
 	kfree(conn);
@@ -442,17 +442,6 @@ static void __sco_sock_close(struct sock *sk)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if (sco_pi(sk)->conn->hcon) {
-			sk->sk_state = BT_DISCONN;
-			sco_sock_set_timer(sk, SCO_DISCONN_TIMEOUT);
-			sco_conn_lock(sco_pi(sk)->conn);
-			hci_conn_drop(sco_pi(sk)->conn->hcon);
-			sco_pi(sk)->conn->hcon = NULL;
-			sco_conn_unlock(sco_pi(sk)->conn);
-		} else
-			sco_chan_del(sk, ECONNRESET);
-		break;
-
 	case BT_CONNECT2:
 	case BT_CONNECT:
 	case BT_DISCONN:
-- 
2.46.1

