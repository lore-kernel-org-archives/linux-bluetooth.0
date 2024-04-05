Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A39174EDF
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349671; cv=none; b=uDoKzevSpcuZDmDx38FVLJAhtQVznNdr1pnPARpbRFx9mCPwzYfHS1y5WfB6dJTpgvflsPZXduHPIeuAiSQ+9hoZlqogpMVIF3ZAN4wFQSJt1VXT1Fm2jI5OzcO9NSH/oP2EthjwNQ5VEYmN2Ja01RIodqMBfn2muVjJDG7GdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349671; c=relaxed/simple;
	bh=ebWmWUWlJrRcVryG+Vw2AfIAuohn2aXjWy0rHv4Ff9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+Nh3I7Suhk9n3attmI6/d86OT0KJ6OgRMepJYuZ4vezlo36Jeffqme8Gh+w8NIwXSyyo6yKenk9Nw1+Z+OzCOZ5w2ZqUSN0iDPTSjW/MphsmUgWmyN1A9zSPQ5VUxst2zDVRTtp+5I5Oxs1saPAqD8PTl7PRunmreDQDdAft6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsRiDxCp; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsRiDxCp"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4daa5d0afb5so608086e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712349667; x=1712954467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSAz+L9o6nEtGc+9BGwzzWHjTZpHBtpU2X0siDGpeT0=;
        b=YsRiDxCpj5mbCrGeYj+4qhzASR4tv3RUrbbuqxRpgpWvG2/MrTC1LTLUwDBHoupRjC
         jWVDxiZFEjHhM1dmmFD0iGTFlrfTe46g66enwovjd6iMGtR71ckopkor5/g4998lrXoY
         GWERJArTNICDmEsHsqk3WrISY1eGXMrJBelHI88RxZQoS54RM2W82uIo3Rknqfl6VBey
         yJwLe14G54q0i7zEHktcRR3feiMcCiLvY05doLqTCxcDk1NfvDBvljWykSgvn1eV1n4H
         4yvtjpkGlIpo9LNlgUanUQcUKXuwOBu+xqwjN6KO4vVwMh5Dc8bXfdrP+L/IaSuO3Cv5
         PDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349667; x=1712954467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSAz+L9o6nEtGc+9BGwzzWHjTZpHBtpU2X0siDGpeT0=;
        b=wHaLqqNUONjbV5CvxwtYPdoq6v5rJg6spFJefKrim7uDWbOTc0st+6oQdSTj1nfT7T
         GNZSSMZYEJvkuGR4/1mYP3oxpTv5XfDTXHmpTZh7pHHbfEZ9CFe5dII6qBg+XJ04XgAt
         +MfSSpd69Q22IMv5SRkCqnI1UU376EQmN4SY7MOGz8cnuEVjJaMAi+Mj5sH1HCp5YGub
         JkP5cH3UPfifzqBfAr1dfkdNeV6Qlpsazi/0ns5D9bTYw5sCteVMndqm2C/rEqgxNqPI
         Mb/UrYysEvt0zQVFNRx2uFUj5sUZS67ixd1NtSlEavuvno9qziLfFtZbFQz6FMucauLC
         FORQ==
X-Gm-Message-State: AOJu0YwkP6ScJAz3jYkI6bYCAtIDiVvQwNROA1dDs1znTG162QeMwbQR
	4epA3ONd4eHpUFF7qnDjyOQZwdMF9ogj7wvOwKP+21BxoKoxXq57vMq/2jER
X-Google-Smtp-Source: AGHT+IGjHc0cNtXUNdJYt4Q70nPFUK89syYLeZlMMDBADUG8zBhA1qcT4BytrpGBSyvbTatj9kuUGA==
X-Received: by 2002:a05:6122:45a0:b0:4d8:7970:28e6 with SMTP id de32-20020a05612245a000b004d8797028e6mr2993162vkb.0.1712349666589;
        Fri, 05 Apr 2024 13:41:06 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id l76-20020a1ffe4f000000b004d89b77e45asm326510vki.51.2024.04.05.13.41.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:41:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 4/4] Bluetooth: ISO: Fix not validating setsockopt user input
Date: Fri,  5 Apr 2024 16:40:56 -0400
Message-ID: <20240405204056.3451243-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405204056.3451243-1-luiz.dentz@gmail.com>
References: <20240405204056.3451243-1-luiz.dentz@gmail.com>
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

