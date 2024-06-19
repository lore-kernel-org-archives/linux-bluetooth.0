Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882C13D297
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798682; cv=none; b=GYI5Adti2KpMNIcF06sHhvN+PpUCGd3yKH/OsLC2e3fKF95Y1+Q4hDWZR6AqVe9VYg1Lxpg7Qx6h5ROGqfEv/SDVqCBBupMrtS7u+ppJ8h/eQC0yVBjwRl/+t4Zoin2CM5S8OXDdAgrLIjxNX2Ktj97T3Fw/F4oljqulnpznAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798682; c=relaxed/simple;
	bh=Hzmm2X9ZsAtLHQgEJ0+uQPOi444AyI9gn8CcZs9UKfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KU2WkoVuj1+lKue1XNBsSPVt1GxkYe2UHqgsQUN2AdooKT/32GpO9EIdECR1l7AVSYm40YPE4Itid185+PIT1TmqcPpzxe/X6hVfb2r7Z+HINswvS1LejX72AI7TR7GS2fsuNvTdDJQJrknO19eNBsraZ4rUl9R6S8nRNPDAX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softeq.com; spf=pass smtp.mailfrom=softeq.com; dkim=pass (1024-bit key) header.d=softeq.com header.i=@softeq.com header.b=GJKuv4tA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softeq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softeq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=softeq.com header.i=@softeq.com header.b="GJKuv4tA"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d07464aa9so1061567a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 05:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=softeq.com; s=google; t=1718798678; x=1719403478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIgKGIZV3FNdrgf5uufsmOq00ghkEMVvp7wBfjZFcsw=;
        b=GJKuv4tA5nYVrCEvCzHcijl61kcFp5lH0e5sKqN6OVmlB4dTTrNSrLDv7QV5pM+PGS
         TuvElzl5FJ4R9XM/cy5y60zkn22sY+0qg1jj6R15iEfUe6iwWej/6F9P4IlHVerZ+sM1
         FarJC23A1IGMOGCp95nUy4POwjm/I6UwnW7d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798678; x=1719403478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIgKGIZV3FNdrgf5uufsmOq00ghkEMVvp7wBfjZFcsw=;
        b=GyW6r4pSKUVznZB2Fa0ydp8xwBUEnB/Jm9eexTW+fyvPtoNPZH5XNWO5zhew7l24EZ
         o7Ha3COaobpjTtkSp5MAJdR8n+GkMyqKU6dAsTMyfv1K32af3A+dFAsvcQKKF7jcbMdT
         kguJd5qHNRwmZFjai9rFsShaKcR+pqTel1hmMvYqsofxrscea+5ChnvUMaQf73xE2Egk
         ajNiZDRCPqgHfSWD/vYplVFzacoOCxOAzqSslHRKpUQBstKfCdNa93Ld+fLHtFu+L2fl
         LQ6hCmdMKJTSeM3/l+WvfgbK18fFuWawb+D62mjGGRzLzz7f4RFiK43CbYb17BjN62S6
         bTbg==
X-Gm-Message-State: AOJu0YyfzMLTxYQBMUrvMDyICU4TcuHsDedrm5HthZ8RSyd4tC0izCRC
	0N5UCENgsOhz3XmWCQQfZAN0fnAQ2QsSnIDHvcOewElPPTQGv/h+ph7Vtyi5AGPBkOKghIa6nYE
	I
X-Google-Smtp-Source: AGHT+IH1OoiyaXbq/SSexfE0dRyItrKCAvL+Nq6na+mDPhPd/xCrZTMBF48oLwTz8nx2XUP2aTdP+A==
X-Received: by 2002:a50:d4d8:0:b0:57c:8105:b9a7 with SMTP id 4fb4d7f45d1cf-57d07eabfdbmr1287044a12.29.1718798678229;
        Wed, 19 Jun 2024 05:04:38 -0700 (PDT)
Received: from localhost.localdomain ([212.59.15.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d0d9c3b7fsm406365a12.55.2024.06.19.05.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:04:37 -0700 (PDT)
From: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
Subject: [PATCH BlueZ v2 1/2] shared/mcp: Implement next/previous track commands
Date: Wed, 19 Jun 2024 15:04:32 +0300
Message-ID: <20240619120433.3666313-1-yauhen.kharuzhy@softeq.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bt_mcp_{next,previous}_track functions to shared MCP client
profile code. This allows user to have basic control of the media player
in addition to simple play/pause/stop actions.
---
 src/shared/mcp.c | 20 ++++++++++++++++++++
 src/shared/mcp.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index b3726ebae..71fc2d151 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -628,6 +628,26 @@ unsigned int bt_mcp_stop(struct bt_mcp *mcp)
 	return mcp_send(mcp, BT_MCS_CMD_STOP);
 }
 
+unsigned int bt_mcp_next_track(struct bt_mcp *mcp)
+{
+	if (!(mcp->session.cp_op_supported & BT_MCS_CMD_NEXT_TRACK_SUPPORTED))
+		return -ENOTSUP;
+
+	DBG(mcp, "mcp %p", mcp);
+
+	return mcp_send(mcp, BT_MCS_CMD_NEXT_TRACK);
+}
+
+unsigned int bt_mcp_previous_track(struct bt_mcp *mcp)
+{
+	if (!(mcp->session.cp_op_supported & BT_MCS_CMD_PREV_TRACK_SUPPORTED))
+		return -ENOTSUP;
+
+	DBG(mcp, "mcp %p", mcp);
+
+	return mcp_send(mcp, BT_MCS_CMD_PREV_TRACK);
+}
+
 static void mcp_mp_set_player_name(struct bt_mcp *mcp, const uint8_t *value,
 					uint16_t length)
 {
diff --git a/src/shared/mcp.h b/src/shared/mcp.h
index a2cd6fc45..ee57ed4bf 100644
--- a/src/shared/mcp.h
+++ b/src/shared/mcp.h
@@ -59,3 +59,5 @@ void *bt_mcp_get_user_data(struct bt_mcp *mcp);
 unsigned int bt_mcp_play(struct bt_mcp *mcp);
 unsigned int bt_mcp_pause(struct bt_mcp *mcp);
 unsigned int bt_mcp_stop(struct bt_mcp *mcp);
+unsigned int bt_mcp_next_track(struct bt_mcp *mcp);
+unsigned int bt_mcp_previous_track(struct bt_mcp *mcp);
-- 
2.45.1

