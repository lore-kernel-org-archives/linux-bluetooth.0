Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47413BC0E;
	Sat, 22 Feb 2025 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224903; cv=none; b=ZKk5sEXYux2menZefQWlbgvN9bv/6AvqMh6J/kB2Ac5iG7Wbe40lxgbPZ7xUEU28E63fBtYxrvk7TW2L6vfoIr7nXhphD7n2WGYMgMB4OrHd1KvBv1O9rfJBEJW5LxzCGoGI4BaQ+jmVbx5QbwYZgWZ5labYky5HjtGCo7b9p9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224903; c=relaxed/simple;
	bh=llOMEnBvv4FjSXu1AHc31rLyEPC85lLXOI12wEHVGVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pw5w0Hob89br7Gr41ac4dI50B/2Rk7EgwqEsxB1EmHClU0xgtZU6IIS2s/SI+o8/HMqE+315eO8iqQ0tifas815tI52l1q3hHvcnLgXQneAEkAV6kZCBR4bL2yuv6uGQB4ZP8TsIbVxQBLWXl14raponRdqAQcRYivGMFjjd9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHi3k9VK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHi3k9VK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c2a87378so51588605ad.1;
        Sat, 22 Feb 2025 03:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740224901; x=1740829701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXNRnSKpi7fRGl3/7ZoxWtBGdf8G9XNDTYl+0OWPab0=;
        b=ZHi3k9VKUqGw+paeoQhKBAtGt9JFIj6YcQNakouxw5nXYQRQ5bFlk7O3FInxr8FNNr
         uWg230UjxHdq9SgRwC+1EBdWVQlhtVN6zr1cngxACWM9zVbxAlMmC/Xlf6mhwttdHRBI
         L88rpJxH5KCsjy+m0IojUlLYY85LlqZgF9f5W2VW3LinnqqVk6vku+5qjyedOze9R6sX
         GbPmVs5Ws1Gx+Gyj6sjB7Od1kG56mXqCUJX/MR6w7SgGs9qRwn+lbtQruJt69vgxd5vH
         xFV76Mgv853E1AXM5fo3msJE0cWPPlWjqvhFTIwovIM5GGGFZTrQmT9Opagw5pCEYuHA
         1ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224901; x=1740829701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXNRnSKpi7fRGl3/7ZoxWtBGdf8G9XNDTYl+0OWPab0=;
        b=NVVx5pxWrS6XOBsZyfX2kcJFOIW1ZyIh5eTyVAoLx5l29V08mf9B7IRyRt4ty3Q6M5
         InGgrz0tmpZWwZCaOxwfkeTTGRQS7+1IijTr6lHPBNYSRC1bVh5Sl5T50JMSoOzS5WGy
         CiN5XQENOmTBNAX2SCbxz+c+auQLLOgDN+rHqVxf2X10qc9+Z4ErMY8FlBSyHVNNmKas
         wG8tY2gkaNiJmPY0s4ypMosIv53/gQlwElLidsgNpGREzCZsoasEp17yfwahJXj+yMuI
         W39zAK60sOOjxu+AcfDk5TXqP+2Tf6ibSTjk0G2N+tgVdTkYOyRmAHPxftYxVIxzUnYk
         PBYA==
X-Forwarded-Encrypted: i=1; AJvYcCWSR9WpDPBX+Ly+3Zc6P/4cs1rwaJjCTn98ikr11VbLCyMueEQcPp61UR9uVGr03A8+AFSr28RdomhEwosZ@vger.kernel.org, AJvYcCWvjTfRMgsBY9kGMGdSDi8fPXuISSetzbZUk4ha33Y4Z5KV62fTJ/7ZGbnXb5elfJkitOrbH5vt9eYx6Q9NDzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweR/cVEZhhN4y9DvPREH25alj3f0eeTswoistar1ZEzv6cez0u
	B/pkqiZwLTzAos+j1PJ48/FaV+McM3Tml0X6IEjKQBnLh73zewZMvKWuXdf6
X-Gm-Gg: ASbGncuK9Z+uJo9MuDmEMTCOtbudVHpCDV4FjSiIQZxmph6jRG+BWY3xFNjSDDvCrlG
	r5jqOZutOaEqGr3kRVw5di9p3y5zNAxTJs+/qOHhjHPvW64844RdRC9zUMemwXThg03hIu02Dxx
	8TGhjhIxS8se7xgT90N1haweSdcZ3frKCnZlIQxTC5towSpeTjcWYKOR44Ht4K5fIavPUknjAFQ
	DXpGJJIrKq3XSfIYPDCpt+brysxVLSpIcLmt+ZXQdIh6iZd1Hsgef2a4uksPPyTGM06YkgjDLvz
	dVdBgxIU3xhK1el6Yf1blR/FfNEvcMWW9mpZiJcY4OwOMmOKx7gqNy8=
X-Google-Smtp-Source: AGHT+IF0RXstXO0QEvVkta+IxjqApKfejk0ClddGOZ8TLyOk5srGNYabRc1ylGSgsl75/XifP7aVWA==
X-Received: by 2002:a17:902:e5c4:b0:220:c813:dfd1 with SMTP id d9443c01a7336-221a1192a83mr100232225ad.36.1740224900878;
        Sat, 22 Feb 2025 03:48:20 -0800 (PST)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559614dsm151610715ad.256.2025.02.22.03.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:48:20 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: gustavo.padovan@collabora.co.uk,
	andre.guedes@openbossa.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] Bluetooth: SCO: fix ABBA deadlock in sco_connect_cfm
Date: Sat, 22 Feb 2025 20:48:09 +0900
Message-ID: <20250222114809.11634-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caused by previous commit 405280887f8f causes ABBA deadlock. So we need to 
change the lock order to prevent deadlock.

Fixes: 405280887f8f ("Bluetooth: Reduce critical section in sco_conn_ready")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/bluetooth/sco.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index aa7bfe26cb40..8f1377f4a27c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -289,13 +289,11 @@ static int sco_chan_add(struct sco_conn *conn, struct sock *sk,
 {
 	int err = 0;
 
-	sco_conn_lock(conn);
 	if (conn->sk)
 		err = -EBUSY;
 	else
 		__sco_chan_add(conn, sk, parent);
 
-	sco_conn_unlock(conn);
 	return err;
 }
 
@@ -343,11 +341,13 @@ static int sco_connect(struct sock *sk)
 		goto unlock;
 	}
 
+	sco_conn_lock(conn);
 	lock_sock(sk);
 
 	err = sco_chan_add(conn, sk, NULL);
 	if (err) {
 		release_sock(sk);
+		sco_conn_unlock(conn);
 		goto unlock;
 	}
 
@@ -363,6 +363,7 @@ static int sco_connect(struct sock *sk)
 	}
 
 	release_sock(sk);
+	sco_conn_unlock(conn);
 
 unlock:
 	hci_dev_unlock(hdev);
--
