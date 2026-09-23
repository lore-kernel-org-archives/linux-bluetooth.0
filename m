Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52672568525
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191928; cv=none; b=O24ILhNDd0CthS7+H14UeQOK/M6qQy/LWuEenOaV/hdzVxjh2Ekd6ELwGSltzFEPu4uWGqyWW4R9UzzgMbpQHVWFPR2+daTOX62bTQ0BJFmvnvyUNog0K0GgVcgBHuSCYISUXrCNQZinawnI9Q7ZdggLWTfRr/wVfNhkRDmcQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191928; c=relaxed/simple;
	bh=7BOZKfZ+GnZAQxZiXzYwEQT7sy53zo5/6siQw6a47b4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQYHk8kT6qvO3ggDxtAOL++z8Nhtgp/JdNja0/ERCmdKuUrmcu9X+dCXB7mlcRNaaYS2nQnHJhZlbg2u80JO5YPPuaWfPlth9F7Ng1/jSk7u32DWQ7GrojQXuDuF6/OmWXYLq7Y+Rj7SnFiXcXdS3Lz+SCXUYOC69IBKL+9+Sxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGT4kGqO; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGT4kGqO"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-98514b4115eso689987241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191926; x=1790796726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZwLAizyG/WdQAb9JvN+54XnZGBSA+5/OIgjagYnKtPM=;
        b=EGT4kGqOlooqV6Zu8WB96ILgOYpmzw17/eR3hMaYMuuW1T44/aD70JhDL86GLickyW
         hLf1f9UEJ7kaPES8Tf6dL6hVESgSkWb91Syee2LmsFHtTPZcK54bZvJNRa2PCuPTfCUt
         XjZGWrz7GDEep3hxV1QMJDjJGUJonNG3wM6HtbLXpWfTzj0hMu0MzHtwokIIR99+paEt
         dVRtLonxIEGm6ko23fwq1Hi2280pLTDTRCzuZtbricxDIl8gVHb2jHzjwU1qnhBwLXIU
         nRIMKXPFdsDFT0N/JCJzLmTQq6kFkJfDqD7hxZwTGoRMMle9lXOl+6uht+Rl+6J8O/nX
         WJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191926; x=1790796726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZwLAizyG/WdQAb9JvN+54XnZGBSA+5/OIgjagYnKtPM=;
        b=L74l4F7tqqy8sKI2+SS7gDATSwRgu7KUrgutQMvfmrOt8Ggu7jysC7E7L6OSeEgh6c
         HHPKM8x1eFGxP6hwVBtE2Lg9ZEXbDYsrUkWa4Tg57uwDqxl+buWBGdsJmAy6XZp4qYSS
         hxZVi1p0MvCAPRLGOXFV5plPfM1zztRx7rSOloV5dGRk2nkgtvXjimVOR18hxxYdG8Fz
         e19yReo1cSeDhtqFF2e37PZew8SQnLj29c23cRxD7WdrOp1BhGffmaYXH5L40s+Edy+F
         R7axoGlEBVwzboOQ1cPl1lpLQT6oUCqgGrRT3ZErIxZQlxrGfgaAriBdItLqhCJJkKSB
         Z3Vg==
X-Gm-Message-State: AFuF++nrvxWELSSjIrZLbmPIkjMmwv26prM0KMFH7Zr+1nQthhGtLf/3
	XVAGn1BmbbvihDeT4WJ+DAvISOioAHS9GoQIJVQXiPeEWKW0fCMf2etSG9FfpBUWNhwh7w==
X-Gm-Gg: AYBFou3K59cRIOivoxMPt4imPop+wdHy7UCKRUqEKxgHD3bmMNOw6nYyXbJDQQuh0dn
	9x3YE6QShkuxFEpQ5qxVVxur4qI/T9Ln1puT5v3hyngWoW1bmIWcamcnLqvjkP5W5W0nlz13R1L
	jLxC/Ddz71918FUaIqaVOQL0W/GJTfiGChiHiijbmHqRXz4M+NP/ZBqKCUVjxBMvCWAQGWxhWoc
	XVWvzh4b7BLUemtx5K2MdxIlkIaidUyDRHzikt19USN1uDboD5H5ULvM9i+2xpZ/gnQHFpt4qlS
	nUAs2ApGmCgpBWDW46fFDQyqiWO6/lWtxhAHpMhXE+M2Fk1yLm6/BenCV49w1CkGlxppFQkGi+G
	fPQ7/MlNbogMA3uLPXbFFl15VPErWvxzf6ea6gvatEu2+PKqdvDtFl71AuObk6Q7/Upjs/7fz5L
	FAQ4Y0ABVWAVL4Sw4ca2q7cgocCxfbObvf2HoZy34grqdIEjYOKm84ZtblAsqdZAxxOr3L/KlUL
	oN2hD9YUt6aatqYas3M6YMwypOEvnDvvCFoohMkGSgOlvQg1qUNNmBfgA1arkCNlQ2vsX3TzJY=
X-Received: by 2002:a05:6102:6a83:b0:7a2:2068:6b67 with SMTP id ada2fe7eead31-7af1dddb820mr185577137.25.1790191926077;
        Wed, 23 Sep 2026 12:32:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851691693asm4666266241.2.2026.09.23.12.32.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:32:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/7] client/mgmt: Print Connection Subrate event
Date: Wed, 23 Sep 2026 15:31:52 -0400
Message-ID: <20260923193157.249636-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193157.249636-1-luiz.dentz@gmail.com>
References: <20260923193157.249636-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print the MGMT Connection Subrate event, generated as a result of a
LE Connection Rate Request, e.g. after mgmt.conn-subrate, or a change
initiated by the remote device, so the new connection rate can be
confirmed.
---
 client/mgmt.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index cd2ef80221ad..a7069e5bbb37 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -499,6 +499,35 @@ static void disconnected(uint16_t index, uint16_t len, const void *param,
 			index, addr, typestr(ev->addr.type), reason);
 }
 
+static void conn_subrate(uint16_t index, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_conn_subrate *ev = param;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Invalid connection subrate event length (%u bytes)",
+									len);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+
+	if (ev->status) {
+		print("hci%u %s type %s connection subrate failed status "
+			"0x%02x (%s)", index, addr, typestr(ev->addr.type),
+			ev->status, mgmt_errstr(ev->status));
+		return;
+	}
+
+	print("hci%u %s type %s connection subrate interval 0x%04x "
+		"subrate 0x%04x latency 0x%04x cont_num 0x%04x timeout 0x%04x",
+		index, addr, typestr(ev->addr.type),
+		le16_to_cpu(ev->interval), le16_to_cpu(ev->subrate),
+		le16_to_cpu(ev->latency), le16_to_cpu(ev->cont_num),
+		le16_to_cpu(ev->supv_timeout));
+}
+
 static void conn_failed(uint16_t index, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -6006,6 +6035,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CONNECT_FAILED, index, conn_failed,
 								NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_CONN_SUBRATE, index, conn_subrate,
+								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_AUTH_FAILED, index, auth_failed,
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED, index,
-- 
2.55.0

