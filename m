Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82413174EF6
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712350119; cv=none; b=ikwPLbNNOEg3CVdY+nqdhDUydXjQOcbk1yp3fDS+Z/uX6mLJ9v8/hwWneyxJahMq+sNCwa2MJRwWbYq5VktC0jpORGOn5mFWwh+sRooZOhkb+UiKlOIXc7o6zCWYgZu1PcR8wYQe43olcF/Qyu+lJQaH+287J4N0MOqoGwtpZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712350119; c=relaxed/simple;
	bh=ebWmWUWlJrRcVryG+Vw2AfIAuohn2aXjWy0rHv4Ff9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuoG+bHK/1KXib0Mn50oVY6pr+Pk2twKor1oy/Dbe2FNqMWhqIzshH41DNhBciKm1pzcR2HN/v5ZHPmpaC+uIy5WR1ebqf5fZz5As2LQafgQTqkQ3buog0pb0d4CPV5qqP+GSaHDXEgP6TdSVS/57rNJ8nSotabF2o2hEOyf500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJXAh8om; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJXAh8om"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4dabbf19e1eso337203e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712350116; x=1712954916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSAz+L9o6nEtGc+9BGwzzWHjTZpHBtpU2X0siDGpeT0=;
        b=NJXAh8omdUGhXdfdxiBHpHmXexEKsn5adIBCPGuG7pqM50ggBQZGabn7+5a+SCAdIg
         fr0yNhWuWRjDhZGUb7q0rXLBiOeVjqeaSvtWV7NKNKsiQt1X3AH2qr2bfI6CE8pc/X8w
         aBAHaz77kDo554jFwzbiaxjrDXFksIdOB9486SFhUPhSTznQCOaxqw3vtng271oDZ+DO
         IoQGo7IDkuHhHJ63leGs5oxrzRLPPwE4NE3Io7Q11roeVgUrEghjNCWe1zqQZxDYwCJ8
         Q4+ZOj+Y7Ls7o27L6mNoqZ/szB/cx8M2nwhzbSNXypL3Nob7vR8Pb3RsQs7K6Nkw5V1i
         JLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712350116; x=1712954916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSAz+L9o6nEtGc+9BGwzzWHjTZpHBtpU2X0siDGpeT0=;
        b=NYWQU6sdmz7btEh6esMCzFJXYgK9myV19jogQAJSvU1DoRLxY0vqpII//bW02MzWhd
         +cEh6CWkRSPlKopPAP4WIaTaxmDmFpyEeqtR21DAyN/T3GaNny2E31S7tv9fKNAqqtSt
         KzcX8oafAmWF69XH2IfkWUYujJ39faA/FgrsJ2yAzL7Dn3oi0XdtzmmZbqsRn2/4D+Jv
         c1I3fOg6C2l1cDhEtvMCWbiE2I0z9VBcCEoeO+zQtd01qC6V6S3f9rOYLf+CzEWHuXTw
         NdC1Pnb3Lp6LexYWa650MVJFYMlhTHPk+Nz+mI8gIcrXcajZyZXOcstsFbojbe8J9IE2
         WnJQ==
X-Gm-Message-State: AOJu0Yz/NH1OgjK/Rpu026du0w3Qcn6azJX54NOOaRk5xiZsuVsRsg2v
	wgS/GSfZ6N9wEPhMBk9TApmvCa07gBMF7FX/UwhGSRGXGm3XC1bn6aEiBu45
X-Google-Smtp-Source: AGHT+IFAJDo/Qkj7NckjRVbx0Bg/kLUm/YEXlMW2FNrPzuBhtL74eXRKa8j6WVNIXxAbLSYuGbBQGA==
X-Received: by 2002:ac5:cdd1:0:b0:4da:9bcd:b097 with SMTP id u17-20020ac5cdd1000000b004da9bcdb097mr2650481vkn.9.1712350115672;
        Fri, 05 Apr 2024 13:48:35 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id y72-20020a1f7d4b000000b004d8a496db23sm336004vkc.1.2024.04.05.13.48.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:48:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/5] Bluetooth: ISO: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:48:26 -0400
Message-ID: <20240405204827.3458726-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405204827.3458726-1-luiz.dentz@gmail.com>
References: <20240405204827.3458726-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check user input length before copying data.

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Fixes: 0731c5ab4d51 ("Bluetooth: ISO: Add support for BT_PKT_STATUS")
Fixes: f764a6c2c1e4 ("Bluetooth: ISO: Add broadcast support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 0dda77e2e52c..5964e2e87829 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1499,7 +1499,7 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			       sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
-	int len, err = 0;
+	int err = 0;
 	struct bt_iso_qos qos = default_qos;
 	u32 opt;
 
@@ -1514,10 +1514,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
@@ -1526,10 +1525,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt)
 			set_bit(BT_SK_PKT_STATUS, &bt_sk(sk)->flags);
@@ -1546,17 +1544,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		len = min_t(unsigned int, sizeof(qos), optlen);
-
-		if (copy_from_sockptr(&qos, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(&qos, sizeof(qos), optval, optlen);
+		if (err)
 			break;
-		}
-
-		if (len == sizeof(qos.ucast) && !check_ucast_qos(&qos)) {
-			err = -EINVAL;
-			break;
-		}
 
 		iso_pi(sk)->qos = qos;
 		iso_pi(sk)->qos_user_set = true;
@@ -1571,18 +1561,16 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		if (optlen > sizeof(iso_pi(sk)->base)) {
-			err = -EOVERFLOW;
+			err = -EINVAL;
 			break;
 		}
 
-		len = min_t(unsigned int, sizeof(iso_pi(sk)->base), optlen);
-
-		if (copy_from_sockptr(iso_pi(sk)->base, optval, len)) {
-			err = -EFAULT;
+		err = bt_copy_from_sockptr(iso_pi(sk)->base, optlen, optval,
+					   optlen);
+		if (err)
 			break;
-		}
 
-		iso_pi(sk)->base_len = len;
+		iso_pi(sk)->base_len = optlen;
 
 		break;
 
-- 
2.44.0

