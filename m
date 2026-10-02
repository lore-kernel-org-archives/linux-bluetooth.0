Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F203F4DCF
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969293; cv=none; b=VbLWsbflMc99p6dqMXi9jtqTA+pWVfGgAGysAuFrhWEGqlKXFuAr+spB5DkhsMY7zupt0b7BEw4OBEnC98a3sB8xKruYV1N5YUzqtMMJE5zbrZcxs5WvMm524ZCqy8dI+Xy9x+n53MMzN9yTnKxHReS6iRwFcxeZotGok6RDrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969293; c=relaxed/simple;
	bh=knMHCL0ihyza2QYIGtNiqSwFTmsJbTY7FwOchw9y61A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPBK/VoFIsKApZmDNY2nLeZ0zBBkP8cAvgWxgsP3QfBjlQ7gbrl+b86istkqEndaD22oOdmQXFyLR5LMOS0CHr2Xkrz4GmhDuGE3L182r/lwDSgF8Il2dyZ9KxXZlqYDURNzqZ8+vjuU5HXn5goji7KqT/v4p+dZYZp6G7hfQrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcXgrQUP; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcXgrQUP"
Received: by mail-vs2-f39.google.com with SMTP id ada2fe7eead31-7b24ea11274so1278541137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790969287; x=1791574087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w5vD1IV1E0gtrjp048byCrmdJ7uTmWrUBrkPOWRtUPI=;
        b=bcXgrQUPu0UCjGL8+c8Bv19rE4P9lR/4EsnuT5D+zJmEBL+AU2n2H4y1eVpptQS5uH
         JdgaIDOxulpHsh4DwNhR+kmHTLoG5mjDHrtg7e4/RtaNRE7qdzD4FH4rcaEiWk2f4fpK
         WdJrdvsVthqaKfEhpaYvKNM9Uk15z6kGRzXKiQOhtJni3VK9RTVMCIBXxcqi9amZkwHF
         5pjPgRzsszJJsqzgK4CgngXPtrNXlxiSeeNTszMSdU+CK9oiHQ4QfaHFM9/HWZvNeJhr
         9dBFlcmwXyngFJEbR7qkIiCQuMkEcA9ayGwFKMHZQtAp4dKYHjVrNBTq9FR7Bl1SaRpI
         xGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969287; x=1791574087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=w5vD1IV1E0gtrjp048byCrmdJ7uTmWrUBrkPOWRtUPI=;
        b=gRQ1LFJhAnsKfaheL3o5mtl4n9s3k9dyCvhSKqKRkHanlF3oFvLCtRfcZw5N0WQg5G
         /WJc+tkf9Qph9PefSldmb7wr4xShBDIlRcH4WV7pzj/9HKCHf4E1blqtY/Z3Z56iWXAJ
         /0oSmMPqiLQhwqWOzikacyeONvdEfDCL9LzW+wJeLCaK/gZIWz+fxsF15JOld5qpbBSr
         nej27oY17epMMutfsavGl/om1kIsiXYqSWZP0NoqJUaFItk7o8sYtnceAZ5Gdd6PJWhL
         wGmhBUlrtr5R2l6TVASfg/aOGdRF+va7RsNDK6cmu6eRo69VQlCVNZdOLXt4Yx6L71Lw
         Ab8w==
X-Gm-Message-State: AFq9FYJVpUi8KmP+y0KA1Lp2d+pzflGPfdtbW15GZo59n9vn7aTyoTkS
	51patVItAcDh62EEGZJ6SmQWizqXKCNjragTwZYTsFBOZxRZn4nu3Rwd9JkHAi9n
X-Gm-Gg: AYBFou2kQ7j7bZZHSELMItHbJPGH3icIjs/hm36KvZqkV7CfWxOFtdooJeC9IoXRYVU
	Ew6iMmUot5Z3DKIJsibynDv2mCyb0xw4eawYIHQSlQ8C6prGWF31Jhr09DJXXUkQdqlSKAaZiKf
	RN+g24Qx7+C+AA0sdDeCAbCb2euo+Mb2PMDk4/Zg9ZZo/D0uNDD75yo4IZF60PpJ2r7laGUhAFq
	X0Rdn/hr47EX6eERXIauwkJb3/8+dFhHVBNRO3SArQcYWmXjk8bGBi3Bm1vs2pDgXJYrjt2SXax
	Kfb7OLQtZdzyhYSEXIApxCKbONnBcSNc5LV9VDvIatpl+qQNWn+J8Rs7vNWrPybdNaVMTwsQNvV
	BER58+/UL0vx3WzWoYQLDMoMQNxJpJqqYAJTOJ04vgC4Ej5B72gAg+HFamOmVyQryEmy2LeDaqw
	8gaIggE/y8Izc1NRIcr8wUJzc4e0OEBejcNby3yQ65ySqWisBXmghuZyBCgtWTHUqy/w05Gceql
	+GhxcxHtKg6JF3a+D+xbkMb+MhXi+BL8KCLDHQhq/aIO5Wx9RgonkJJziGaS3Fa
X-Received: by 2002:a05:6102:5711:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7c0f427ae55mr1084139137.14.1790969287297;
        Fri, 02 Oct 2026 12:28:07 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98b2f15ef60sm3857759241.12.2026.10.02.12.28.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:28:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 2/7] monitor/analyze: Fix a new connection for each BIS or eSCO packet
Date: Fri,  2 Oct 2026 15:27:54 -0400
Message-ID: <20261002192759.3071262-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002192759.3071262-1-luiz.dentz@gmail.com>
References: <20261002192759.3071262-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The lookup of a CIS, and of a SCO, allocates a connection when the handle
belongs to another type, so the fallback to BIS, and to eSCO, was never
reached and each packet ended up on a connection of its own.

Fixes: 8157e2fde5d3 ("monitor: Print connection type in Disconnect Complete")
Assisted-by: OpenCode:claude-opus-5.5
---
 monitor/analyze.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 13d470ff566d..168efdb4b882 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -463,6 +463,23 @@ static struct hci_conn *conn_lookup_type(struct hci_dev *dev, uint16_t handle,
 	return conn;
 }
 
+/*
+ * Look up a connection of either type, only allocating one of the first type
+ * when there is none, so the packets of the second type do not end up on a
+ * new connection each.
+ */
+static struct hci_conn *conn_lookup_types(struct hci_dev *dev,
+					uint16_t handle, uint8_t type1,
+					uint8_t type2)
+{
+	struct hci_conn *conn = conn_lookup(dev, handle);
+
+	if (conn && (conn->type == type1 || conn->type == type2))
+		return conn;
+
+	return conn_lookup_type(dev, handle, type1);
+}
+
 static void dev_destroy(void *data)
 {
 	struct hci_dev *dev = data;
@@ -1386,14 +1403,8 @@ static void sco_pkt(struct timeval *tv, uint16_t index, bool out,
 	dev->num_hci++;
 	dev->num_sco++;
 
-	conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
-							BTMON_CONN_SCO);
-	if (!conn) {
-		conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
-							BTMON_CONN_ESCO);
-		if (!conn)
-			return;
-	}
+	conn = conn_lookup_types(dev, le16_to_cpu(hdr->handle) & 0x0fff,
+					BTMON_CONN_SCO, BTMON_CONN_ESCO);
 
 	if (out) {
 		conn_pkt_tx(conn, tv, size - sizeof(*hdr), NULL);
@@ -1481,14 +1492,8 @@ static void iso_pkt(struct timeval *tv, uint16_t index, bool out,
 	dev->num_hci++;
 	dev->num_iso++;
 
-	conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
-							BTMON_CONN_CIS);
-	if (!conn) {
-		conn = conn_lookup_type(dev, le16_to_cpu(hdr->handle) & 0x0fff,
-							BTMON_CONN_BIS);
-		if (!conn)
-			return;
-	}
+	conn = conn_lookup_types(dev, le16_to_cpu(hdr->handle) & 0x0fff,
+					BTMON_CONN_CIS, BTMON_CONN_BIS);
 
 	handle = le16_to_cpu(hdr->handle);
 	flags = ISO_FLAGS(handle);
-- 
2.55.0

