Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674238B7B0
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346526; cv=none; b=cyjjOXjlsAHt37FSKrohFNrXhp9fe13ippZDDUNmRGw7QdoPXc+HKvO9tIDK7l1WAB48ak7g0mMqszk1CQpPBY8dzeRaKlhnD0JKW2ZH80vDd/do1smZyhk6Y6aVY2VFf9ZlVFlAJvVTF3Roj2p/Igw1zP4yxc4MUhpQaWlunLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346526; c=relaxed/simple;
	bh=Jc7nPdBr5NtAafLfGnIWO3Mt8fJszSD4v6E6CSweyAM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FIAfHQKC1WvmsqxW/YxKalXkcRq9bRmBvhBt0CSHNjme+6qtkWSKCOJDLH2WxNYsOmG0qFhONvx4Vyz5lwvfv+ak5+PT6fhLwwzMgopEyTYH0B8oh5DXHrcUMn/LQlw5MA2s62PtjLnYeO7wAl7EIVCr07AZVUk4OH/qlVcl/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvl26Zvm; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvl26Zvm"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-59ebde7d704so667524e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 13:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780346524; x=1780951324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXPB4Qlwbhxwt4mZy8x2L4biioqO322+hQT/ME4CXOs=;
        b=Hvl26ZvmGUxi93c3IdFZK9q3c9RyH1e2OL1PkkFY6+KE4RY28trbqq/wAAQw2xRIWU
         Bj3f4HBrPF5rRqJ+hYsARrIp6uu41xeIYHTxgRHmYZk1pDcqkF1kUflypm9r/r69lzmt
         SNe7p4Y7r9oozP0CkBCieI7nzu+ct2YtgdLB6AbtC9UvYXkQhlKJQq3yIWCTHVj0VRPc
         hWJqc4Og3iSnXaX4fzepRLCXVQeI9HJOYzvAiIhaCOJ3CRNbSlKoupfJLMTvnNN7UCF5
         VTCWh4Puz3xQZ8JLi8H2zaI35og9aucprRyZOP5m2W13ojVuIw7KkAJnWn4JbH94i2Eh
         mZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780346524; x=1780951324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXPB4Qlwbhxwt4mZy8x2L4biioqO322+hQT/ME4CXOs=;
        b=jIYsVfu/BwFsT6E6D8CwAdVty96OHgpGTfy+C6j4gtihJf2xzI6nyUSBdpb5QkPs6a
         OSbRrYQWYaCzkzpdbWNuuCxNlxtg2zS3/LNEGafpcaAbHApoCuX6DRkiybpomgm515ZD
         K1Wg4c1OJqoNHZi4263ziQsGs0ig3XNAYAu4jNlp/Imd2KsJTTOl7gAxoqi3mbxKSZv6
         JJWzN5JQT/YmTkvaFyMntOrafVXgcd0ncCDW8v1A8Ci4LgoeffvCM/PWvLW3iW8yfroO
         kq8Ge52DESQnyK9xPwYHmndkTMdw4kslX5WOW9epBiweiaivWScUlBZARDA4qTO+fnE5
         ujNA==
X-Gm-Message-State: AOJu0Yx4od0+dUsN/J5gbVDqc3NQGj/o8YkRxM7dpyd6FX7SScqzU1SM
	ClLEGhvY0iReeq+W3T4gAl8y/3wIUUPZc1ihBSFq8Lj8sD63ufAqdKyMO+VS88y8Gqc=
X-Gm-Gg: Acq92OEDBNZbZDOxUGHKV006GnChsYkdWgkoBJn0DRmnIEq8+y2M1GFHvKLPf5ji3fV
	kiX9VSrtaCuvCr1wH92GGRBZKoYFx49OZ+KcEgTx8KGA5TsFigwiSBqHleBRo/OguyNFOHwfQnY
	xep4uSrThbMj5nZul/cWrW/shtss3WhTejc9ZbRliBoJ9QNEobmdOeQfoaBOyWGt5Nlqp2cukgW
	IiLVO7dGZIHjOqH3PHua3JzB4URAxFfUYPkI+gSj7PJK6/T8ZsgL+NBSpL2wkWzvyOv/VW23zaV
	ZxO31R0GFADXn1Ew+tZab6ZesBOlWxUUr81IGRBAJ4Pvr2y9u6JdLhyNmoJH9X9qhdfKWbaIb45
	jpKWLG4AC4UhLwGSy7SzWZKFxWP2QVodNDBgD5QL0zAAFrlLASrSAOaBHaPTyUxhUT4MyfwozoB
	ayBhwVBbcrWq9ne7vMlzvw6L6TkFBnnQmSK1tMMS8DFae7/qDqB0jZih5VGI6v9kAnjmmaRueEF
	z0kFyuOyYnMoxZlNrk6RI+k5fr2dQTXFzSA2n0=
X-Received: by 2002:a05:6122:81ce:b0:59d:7def:17ac with SMTP id 71dfb90a1353d-59d7def19fdmr3417408e0c.3.1780346524365;
        Mon, 01 Jun 2026 13:42:04 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a3a9818c89sm1598442e0c.10.2026.06.01.13.42.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 13:42:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
Date: Mon,  1 Jun 2026 16:41:56 -0400
Message-ID: <20260601204157.13923-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

hci_get_route() returns a reference-counted hci_dev pointer via
hci_dev_hold(). The function exits normally or with an error without ever
releasing it.

Fixes: 07a9342b94a9 ("Bluetooth: ISO: Send BIG Create Sync via hci_sync")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/iso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index eef3a1332893..a93269eb53b7 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1596,6 +1596,7 @@ static void iso_conn_big_sync(struct sock *sk)
 
 	release_sock(sk);
 	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.53.0

