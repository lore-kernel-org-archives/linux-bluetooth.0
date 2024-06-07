Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0F719066B
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762538; cv=none; b=ryDqZoHYsM8LSQWUYfDVuuAGCGMu5XXAN5TRyZnQChurT7XM+ZHoOjvj9HWKRlYHwhtxoh/72DrTi3X6ccJhCxNT+WrvyY4+9pYckN+av154lrXVaMVt0lHoztXmsfiySyG5KJmmRON9oVYvpIAFIbPBii1Nr2Tim3Ds+ui8rGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762538; c=relaxed/simple;
	bh=VOEUb8voVayi8QnVWFI4ngc0v5f/UkJLKvigg18rK+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3tb3yDQMdIuKdazWrasAID5y6KBxf8NXTbp3Ntw0qDvoFRZAJlRxQQdliP5pxTvmzNq3BktIhq+x/MuQFIOq+Rw1GrB7OTh4bYTjdpbkIJOgOQ8R7NhRF4YZdqhUNdFpcth4vtM2uChyaQr2dA3fcn0I/RmgmEmndzNTJNEttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softeq.com; spf=pass smtp.mailfrom=softeq.com; dkim=pass (1024-bit key) header.d=softeq.com header.i=@softeq.com header.b=urX8JFdU; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=softeq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softeq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=softeq.com header.i=@softeq.com header.b="urX8JFdU"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a63359aaaa6so303450766b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2024 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=softeq.com; s=google; t=1717762535; x=1718367335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bHVfM+cwOCYmUx53cVhI99Tg7c6z6QcHTy/UKcNIjxE=;
        b=urX8JFdU1Vj9tjaFDCQIseiXytcx6InTVDrWTA6frRrUIGusq5vXzIlByI4XpDbB7F
         nCy+xYchXfySpwJMgYiVIDZmunwIbqpMOfUsfceZyCeuA1aG3sbbCCyVgIhXTvK+HHoO
         rJAy41NmV4aKUAfoH6G8XtJUJu/Sk2HDVQFxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717762535; x=1718367335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHVfM+cwOCYmUx53cVhI99Tg7c6z6QcHTy/UKcNIjxE=;
        b=AUiQM2ZVXkG9YGvgTSdAkx97HXukpqseOlbYiWUIsr1lbkYPXddaROxUig452W7o6k
         /e/aDJ5SIxdBGDOBLc/+OTC9fdO7lZjLJ/qALKmzwsYyKBMtBCHprPTyTdpeMpAE12ZI
         1XNjXFLZ5dc23uHz5uqovQKM16G6AQbc5E/mmWQtAUiLZwZN7uqz+sTRQzgOL+m1yxNT
         DQZ5Pqf/ZTqJ4tP+JVd4Hhtnxc2+7X2y+huTDSdo+HZqNRxlpldxsuMbMVkphjCD3s92
         JuI1m6OnZ24RV0EUTlnqAtwJJuweMkTyIsKCd90ppMe20IapVBBja5HrFR0GBfmTwAJ7
         4TgA==
X-Gm-Message-State: AOJu0YywO57UIpOY5TM8j8oaa6cjmPeReCdPosSs6x8niRHUDPS23L3y
	e5+QfBXU0PIQ0acaYrWZD3k5zHFgJGCc8Qd94x91UagIc3FQHFsy2bdV/mW4/WkbSjMfmiDMv6F
	S
X-Google-Smtp-Source: AGHT+IHuXfoxAq0EZ7nljeaMI7eNygxw7r0z+aUCUBB3iKMbvAFsARsUAQDgzvfRbizRMHY5mXfpGQ==
X-Received: by 2002:a17:907:2496:b0:a68:c5e4:8f67 with SMTP id a640c23a62f3a-a6cd665e03bmr150930266b.29.1717762534690;
        Fri, 07 Jun 2024 05:15:34 -0700 (PDT)
Received: from localhost.localdomain ([212.59.15.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805ca421sm238741466b.63.2024.06.07.05.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:15:34 -0700 (PDT)
From: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
To: linux-bluetooth@vger.kernel.org
Cc: Yauhen Kharuzhy <yauhen.kharuzhy@softeq.com>
Subject: [PATCH BlueZ] mcp: Implement Next Track and Previous Track commands
Date: Fri,  7 Jun 2024 15:15:22 +0300
Message-ID: <20240607121522.1255175-1-yauhen.kharuzhy@softeq.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add implementation of Next/Previous Track commands to audio/mcp profile
and shared/mcp.{c,h} code.
---
 profiles/audio/mcp.c | 18 ++++++++++++++++--
 src/shared/mcp.c     | 20 ++++++++++++++++++++
 src/shared/mcp.h     |  2 ++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
index b410b3d2a..8d1b7588e 100644
--- a/profiles/audio/mcp.c
+++ b/profiles/audio/mcp.c
@@ -224,13 +224,27 @@ static int ct_stop(struct media_player *mp, void *user_data)
 	return bt_mcp_stop(mcp);
 }
 
+static int ct_next(struct media_player *mp, void *user_data)
+{
+	struct bt_mcp *mcp = user_data;
+
+	return bt_mcp_next_track(mcp);
+}
+
+static int ct_previous(struct media_player *mp, void *user_data)
+{
+	struct bt_mcp *mcp = user_data;
+
+	return bt_mcp_previous_track(mcp);
+}
+
 static const struct media_player_callback ct_cbs = {
 	.set_setting	= NULL,
 	.play		= &ct_play,
 	.pause		= &ct_pause,
 	.stop		= &ct_stop,
-	.next		= NULL,
-	.previous	= NULL,
+	.next		= &ct_next,
+	.previous	= &ct_previous,
 	.fast_forward	= NULL,
 	.rewind		= NULL,
 	.press		= NULL,
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

