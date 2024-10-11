Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156C1D0414
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672447; cv=none; b=B2VV3fhFh5S1qqez82SJb9BEpe6FuboL4NaWxAqvV3vFpMUvq1vHO/p9JTH00nUwvJ9dsgA+k9LGIgE3Wt4Bl+tHiac1Abl4NOGLVcqIQncXUeQZlItIJsJWJTeDkYaDoGILK6lv5hqM9IWQeUjZ/yeintKCPG5w+NEVdaEjlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672447; c=relaxed/simple;
	bh=1/ZW2t2o0LKxPgVHNZKhPMUmGGFBWyb/W60AbIKvJtI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TLyqrn0BNOyZ6Y68mTkRDpPlkiCWV9NV3VoBq5B+7MBW48D8COjh+R44MelqDcJG80INHT9vSkNf6jrRLiytbVyCt0hLmPdvWRmIHim3bIH9vH1jX7FoTUUhFb5Vr7MY9Y6n47LhOxh332BITju534fd/ihT3Ttg4fKvI20t/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrK0XIHS; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrK0XIHS"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e22f10cc11so18820957b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672444; x=1729277244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hyuMjFD9nbAgsPk3OpVaBao+hWhQU4b2k0eiz+DL/jU=;
        b=QrK0XIHS1N6hw0nDsayW5Z3AirHdK1rQeY+VJw5McuWnC5mvWVa5+nSR+lAMRt2KQw
         qdDakfeQR6MpO7zskSqKrX2xZoXCMMCbEg1KQFlSib6IMI3RPc9IX0wtMpUSaw4fll4c
         YvXR8lze8TR/zZfyp8l+L1V1raKemnlP7pGl5h1gtykk6GrqnW1H7l9/IO5Cj8qrYkjn
         0vkw3z37i+i6tPR4ESbL47z9GNkr685ZpbM6EFyYWj1+wjwUfxtLX6S7ovCup07QAC2y
         HsZEfWFUd3IpdhBZZQGeQvF+0Mc9fkWrQhy9ivJZOPlbE6AbZThv9MvIry35QIwj4quI
         3YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672444; x=1729277244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyuMjFD9nbAgsPk3OpVaBao+hWhQU4b2k0eiz+DL/jU=;
        b=xAwbxAw+ScHDOJBw3M3FzRsxV4ch2thp6QgHcX32oHvveAXwQjwnq74l+oQQW97msE
         H4pn92G2hQfH8zv4vG4oULwEAk2F1x1MUohCcjued7Xme/PLI3nB10U67kEZ/toBqgVb
         g5Zu/Q0TaeeiL/i93epIC9w+GOIjST5/5CNb7C8XuBwJEXrjC9FJhMCwCUVSr08f8Mqn
         AlDhbbrjJGZyQ668yRUfVSxmUkEzSAd1T0Qy53gjET8Fc65eLohGOovpMxx1BPggDUfI
         mIj1fuFZjti39Y1yWUXAkWYDTyYqbPf/bJZms2AdENQUCpdeydsDcjcprX4TVs62znc2
         23TQ==
X-Gm-Message-State: AOJu0YylV6TBTK0bB3DWjZPSbEi5Dv/eDrev6fgPrI8AyEnTxTyTU56n
	N83LjOEM07hMQk82NLMluZqobI3sRE//AuFT+dZfQwa3sEKiGLnU+PmrEQ==
X-Google-Smtp-Source: AGHT+IH0ynphUunQFAEJ5pWG7mo+lm0WqvnOTxwqNWLxiP7SwulhY57SX+1H9HVByXYcxGq07gOoMQ==
X-Received: by 2002:a05:690c:660a:b0:6e2:1467:17c0 with SMTP id 00721157ae682-6e3477bad60mr26668197b3.8.1728672443964;
        Fri, 11 Oct 2024 11:47:23 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e36544bb72sm298847b3.23.2024.10.11.11.47.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:47:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix not restricting bind to fixed CIDs
Date: Fri, 11 Oct 2024 14:47:22 -0400
Message-ID: <20241011184722.38617-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fixed CIDs are also CIG assigned and subjected to qualification so they
shall be restricted the same way as to fixed PSMs.

Link: https://github.com/bluez/bluez/issues/972#issuecomment-2407919977
Fixes: bfe4655f05d7 ("Bluetooth: Reintroduce socket restrictions for LE sockets")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_sock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ba437c6f6ee5..1aafa6a5566c 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -132,10 +132,15 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	bacpy(&chan->src, &la.l2_bdaddr);
 	chan->src_type = la.l2_bdaddr_type;
 
-	if (la.l2_cid)
-		err = l2cap_add_scid(chan, __le16_to_cpu(la.l2_cid));
-	else
+	if (la.l2_cid) {
+		/* Restrict fixed CIDs to CAP_NET_BIND_SERVICE */
+		if (!capable(CAP_NET_BIND_SERVICE))
+			err = -EACCES;
+		else
+			err = l2cap_add_scid(chan, __le16_to_cpu(la.l2_cid));
+	} else {
 		err = l2cap_add_psm(chan, &la.l2_bdaddr, la.l2_psm);
+	}
 
 	if (err < 0)
 		goto done;
-- 
2.47.0

