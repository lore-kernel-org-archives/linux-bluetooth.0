Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617BD256E
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Dec 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509053; cv=none; b=W+Ni/uP+F7RfDuCqs+M7XklXgmzj8uIfhidOf6HmOFDR42xOKzslN0Xkq3zwkdhlmjgIZREbKlccTfoK6z6BO0CzJRsgQw5w58uRa3S3x/OwflcSwXbnbEEeX03pzMldMb2BUjgzGA4/QU4TU86PROKNmA6slT3xVy1djEY1YMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509053; c=relaxed/simple;
	bh=iKbQ5Zz2EX1HypXZoTy7yoKIegOoq9VlUYxOxca8n/8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9963M0pRSMyDtTtz2evHmMn+F8CqrwBrnYpQ+KkboXrQaoEm8/3AJeOprLtUlUphA0IUQ9VqGaG9uWPWK9aTuZ04I80gvySc23jQiRx7LSmk7Be8SmHHh8Fm+tBMFpJVj2HNZD0NX0CyZKDMfIvb3dUG6S4QZVHmFgPQBX/P+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAafaNKy; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAafaNKy"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6efed201f1dso5276647b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Dec 2024 10:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733509049; x=1734113849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzwxJBOQTOasHNRchOR1IDP6G9eZekTtdNcfNhyx/Zs=;
        b=nAafaNKyo5Nilv4/yFA0iE/JIyUa1fCaHQlvRwXV3bkZcx96j5+aBIuwTUShKFdckN
         8DvCE1xlLRSjX6WNiK3khsWdmnDN1nOpmd5r1fRvsDbirnPEQUbwaClqmKA6aP/U0ucD
         0ZsTB1RFAwrh+wqcLqmrhPI6z10GDYbUtLdvJg376gWIxiNsSI92nV6FzhhqWuHXXxag
         lt9KhKxXc+Mr6R4wAGeWhTdJVoVK69HQd69NfgzoSMmQAN7m/MlJuCFLn7Bq/d6A5oQn
         tycGgM10lvWHsV1xEjyeYDwgm2tgq1+km4PSbl+it99hSQDXx94BzRHMKu2ocLyecfsJ
         3WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733509049; x=1734113849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzwxJBOQTOasHNRchOR1IDP6G9eZekTtdNcfNhyx/Zs=;
        b=Eqp/LwnY712X+HGF8MOlR1TH43EytOETfGqjPYZq92OTLeOX8wgVYvyi9d7GvSTQC6
         FeXSCK8H1hmhK9DhX3TJ8cWGye8K60ROHnK06rM6XXrmf4J/VrkJDRj3Li1AURxvXmUr
         mtIE6abrXKEynzz2VyJMVVJDgVWPlUt8NfNKDteKJp8BJ97hssBQe7adXzs/4GT9ZPd0
         NRDfjWCArGEvdgHZlmIwyzDe2B8aEjIi9yMwgLiiRf3lCYsepruOgusJnv5EQgPkH1xM
         cQykLU7LZIlQ3D7wr8BrnpgFE5UeqcqzeqvFUHsaQMvRkDTYDL0bdCL6zZpPQoes56Mu
         XnXw==
X-Gm-Message-State: AOJu0YyyWuPuXXGir8y8fFj8p7mPOhh3myXDnUek8xJva7lgrc3emzhu
	2dbosulhnaesv28TUM4h438CiMzYEEE0Pa106pf2juR9l7O2Ilkp7lVt6w==
X-Gm-Gg: ASbGncuzSxn8qJSX4/stZCxuZ+cEU65k/btVP7LNqBXXT9W3r27U1p15BXmlHBRtKrV
	4KSb9vRcJ6WcCPwki7ONYMRJj8zMGRnRUYXUxn8yAd/mSA7eMV+wz1eHWYNskXUEaFkoilDBE9V
	sEk2jr0xd13lfCaowzAb3crrXr4qq/w3FDdDhBmKXhgm/7prSt5SzfnI5H0VpS9ed160A5aps/V
	U1wTljkhKExUCnFuQ5KL2U1awlqpkLs9G/4ezKIq8c39tvskg71lVkgFG6/DlgPKjGIqk3OzXh3
	Tvu5uo/TVE0Os6q444V+Qg==
X-Google-Smtp-Source: AGHT+IH+EkURFOJHpSLgy11DsjlVRpJdmUmuY4SuwzgHNVLMzfRL7wr73qeuLT74gfsCz7xgU5bzWA==
X-Received: by 2002:a05:690c:4d85:b0:6ef:5119:fc2e with SMTP id 00721157ae682-6efe3c8bd94mr30690327b3.42.1733509048940;
        Fri, 06 Dec 2024 10:17:28 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6efd39da664sm9839027b3.117.2024.12.06.10.17.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 10:17:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: SCO: Add support for 16 bits transparent voice setting
Date: Fri,  6 Dec 2024 13:17:27 -0500
Message-ID: <20241206181727.928963-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis@collabora.com>

The voice setting is used by sco_connect() or sco_conn_defer_accept()
after being set by sco_sock_setsockopt().

The PCM part of the voice setting is used for offload mode through PCM
chipset port.
This commits add support for mSBC 16 bits offloading, i.e. audio data
not transported over HCI.

The BCM4349B1 supports 16 bits transparent data on its I2S port.
If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
correct audio.
This has been tested with connection to iPhone 14 and Samsung S24.

Fixes: ad10b1a48754 ("Bluetooth: Add Bluetooth socket voice option")
Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/sco.c               | 29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e6760c11f007..435250c72d56 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -123,6 +123,7 @@ struct bt_voice {
 
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
+#define BT_VOICE_TRANSPARENT_16BIT		0x0063
 
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 40c4957cfc0b..aa7bfe26cb40 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -319,10 +319,13 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	if (sco_pi(sk)->setting == BT_VOICE_TRANSPARENT &&
-	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
-		err = -EOPNOTSUPP;
-		goto unlock;
+	switch (sco_pi(sk)->setting & SCO_AIRMODE_MASK) {
+	case SCO_AIRMODE_TRANSP:
+		if (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev)) {
+			err = -EOPNOTSUPP;
+			goto unlock;
+		}
+		break;
 	}
 
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
@@ -920,13 +923,6 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (err)
 			break;
 
-		/* Explicitly check for these values */
-		if (voice.setting != BT_VOICE_TRANSPARENT &&
-		    voice.setting != BT_VOICE_CVSD_16BIT) {
-			err = -EINVAL;
-			break;
-		}
-
 		sco_pi(sk)->setting = voice.setting;
 		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
 				     BDADDR_BREDR);
@@ -934,9 +930,14 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			err = -EBADFD;
 			break;
 		}
-		if (enhanced_sync_conn_capable(hdev) &&
-		    voice.setting == BT_VOICE_TRANSPARENT)
-			sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
+
+		switch (sco_pi(sk)->setting & SCO_AIRMODE_MASK) {
+		case SCO_AIRMODE_TRANSP:
+			if (enhanced_sync_conn_capable(hdev))
+				sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
+			break;
+		}
+
 		hci_dev_put(hdev);
 		break;
 
-- 
2.47.1

