Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B34266BF
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441783; cv=none; b=FwpS1RXV3mWiAeKvOlZQ/G9fYgvYhJlAvJVIYcELckktsQfPMFuJQ21YnqOyyYS0LgwMeIpg1bsMeRqrmEXCR/g1ZSYaFzw+QZ7BNDi3DrYubSKgDGIHGBe1qyzAVmUNjOPtj2vk3dYgupspauT5CF1vY0Ni9xwXkUCpo5Fiv20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441783; c=relaxed/simple;
	bh=o7am2IlZOgpUqeRwNOq4JSVKkAdENr3pLoCZmpaoa2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fn4NjW2Z+z2qgchKt5QVuigdvOqsx24pIBYruw+ES93WEJ/Rrv52iUKbPfEqNRa2WQbQb11RKGWmyUGm3Du5YEiqibsJyfwRyZJXkv2sJY9fwZshIqkS83rlAIz1Jh63IQH8AuF1b8S9WoHUCdy4uR7OQEIwOuLUyxaexXAyoj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlVRSSxu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlVRSSxu"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso2082750a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786441782; x=1787046582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J3yRgVneJflNabsodtY0c1glSbAUMQ1qmQUBSBHyhSY=;
        b=AlVRSSxutFhTgbv0TouYj7uILlMjhM2YFQuZ1wvN3ZLPUIEkL37C3WLQU8ic0Ii6nS
         kmMTcFe0hdjcPEjZR5bJOhiiMPbEfSAoeb6dvxg8iYpHr5acDOuSQxpBTl7ntXvhZ71r
         jwz4zMKrMsYmPlmRpLP2pbbRkAotVBPxxQCUAeknH9u67VHhGLcGRn+QRgAWKrNkEtQg
         b/dAH8InURhxj1nBBdojPpVwMJIB/UN+SnqRW/6Anaex2hqDemS5LF6SabK6REO4B1WM
         IPVQ83s/5mjeuN/ZBTdw8z2YccViDCuQ7jFFuSKXmuuiuahdUpyhKj3/qWzGX2GoZknA
         ZAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786441782; x=1787046582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J3yRgVneJflNabsodtY0c1glSbAUMQ1qmQUBSBHyhSY=;
        b=ct03TdIefvITYg8B7+Z9PktzbrPDAD58uuA/mvCk1vLj5VZR5+Az8jh4TtjXaqU6Km
         5YQwcgVyFecJMd/3P/jFYq+jIeiGjj7lZa4dzhB41gSN6b1dC8Qx+zDX3+PtVqjcKKSl
         TRuQ4VHQfmiuhOK3Y6o8YSKldVqLoLpqKAHurBK0i8Ju30Uqe9bKx9qZFjX4/nhqDBLh
         tZ5vV1vp/8DsVKqGSnJpLHTY3eL8JmGbVsRe/DEmUDOgZTZGq5m7RJaWBJAMrAYaHVKB
         e5OAbHO6Fszx9fcEW1xeXhNlHKIBOVJRwkR8phq4uZkgCO6QMTLjVny4sMPFKZJi/cGX
         23ug==
X-Gm-Message-State: AOJu0Yzspcxkhqi3k7dS4doOECOPQBPC6J0p1q9W44R9BLBQ7PXN0QKh
	o3Hsea2xYrqvnXFvIItbYLhDkSs7oLpV8LaDI0V1xOaCgEo8Xgc8oMKS
X-Gm-Gg: AR+sD11kb10U5RMu9OIGkVs/ie55sxJiumN5ueQI6HYI1zlXEa5DK7lYNnO4bXgSGqr
	9PfkexNuXchCUDNpfA5JX1LcIHSMxrXjWg+BlIy1y07WF1/cVtgY1gksIbpezy69kXTcCfrBZqI
	o88tzqRGyrbCn0gRRZuuJ7LeNnCyMyLNDe+sh6d+7HQX9DwcjMDd9kfdxxgU2yVvWWI3J+jjo+2
	MWl+/cmFMvtxZNFLSh5sEnak5wcgkV2SV9E5Xdk1F4QPMlBBXa7Elj8WqbT7IsyLJAopzRq0NX3
	n6Cw/cWkQNAnj2b8cb3Aye1Na8uFgqf0DpXsHmGx6+A0/x03na/14mcFS3+kmm+mD96VhEyB1ou
	F0QbkUXUwgbp4m8fP/2C7mJjHlPV4x7BN7FAbkHwAl+W68+4gFGwtpG0N5JIO/sTprzijkuX9Qf
	14wxfegihUrLv+D39On8O4rIqv/ojO/Su7gi481h8ZrCHJ5pVc3TBua9QWhtAwbxl8eGsfPYIfO
	YQ8
X-Received: by 2002:a17:90b:4cca:b0:38e:ad9d:1151 with SMTP id 98e67ed59e1d1-392ec39335amr1984499a91.4.1786441781525;
        Tue, 11 Aug 2026 02:49:41 -0700 (PDT)
Received: from ubuntu.. ([49.205.39.116])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-392d534abfasm3049728a91.11.2026.08.11.02.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:49:40 -0700 (PDT)
From: Ajith P V <ajithpv.linux@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] Bluetooth: bnep: refactor deprecated strcpy
Date: Tue, 11 Aug 2026 09:49:32 +0000
Message-ID: <20260811094932.86448-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strcpy() function is deprecated across the kernel tree and
moving towards complete elimination. It provides no verification
limits against buffer overflows and does not guarantee strict boundary
restrictions [1][2].

Replace instances of strcpy() in `net/bluetooth/bnep/core.c` with the safer
strscpy() alternative. Since both target destination blocks are
statically allocated fixed-size arrays within their structure definitions,
leverage the compile time sizeof() operator to explicitly pass the
destination buffer capacities.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 net/bluetooth/bnep/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index f7d88c33e23e..0dde82e9a085 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -670,7 +670,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 		goto failed;
 	}
 
-	strcpy(req->device, dev->name);
+	strscpy(req->device, dev->name, sizeof(req->device));
 	up_write(&bnep_session_sem);
 	return 0;
 
@@ -712,7 +712,7 @@ static void __bnep_copy_ci(struct bnep_conninfo *ci, struct bnep_session *s)
 
 	memset(ci, 0, sizeof(*ci));
 	memcpy(ci->dst, s->eh.h_source, ETH_ALEN);
-	strcpy(ci->device, s->dev->name);
+	strscpy(ci->device, s->dev->name, sizeof(ci->device));
 	ci->flags = s->flags & valid_flags;
 	ci->state = s->state;
 	ci->role  = s->role;
-- 
2.43.0

