Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDCB48595E
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217288; cv=none; b=UY3Le6qapJrWp0gHiDkvAy0g+R5sKFqEdcERGBWzcuyJKW85oZWRmFq42Pfl4VaBWsmhOKbPsIt8KKGm/GdKRspDqCDfJhpU8P+njF37FzpyTwa3hxfP4CLw+grE9ZQFuW7uze+38SbM3U5+3IYxCnjl7ARcAWJA5sGdjZxbvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217288; c=relaxed/simple;
	bh=W1H0gzF3roNOGQBG8h/e+KZVzY/A/FuldzS4K5+fDV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPVbLuZUKuS8xNO/xdyeuS2JlKih9MUBNADZUTlbkfn/Gs2vKi0zWPpWxGH0Q6c7ajnS9/P0tcynMkCAzCwPzCaP4G0TjP6oGeIvpI09Wxd4C5gg90Nkx8yug33uokeVZ0581xID1y6eVbusxPy28xkGiXOCxybMP4qBo7irh2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=cPgx+WAz; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="cPgx+WAz"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c0b552ccfso1528174eec.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791217286; x=1791822086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gj704BQ3G24WGzzMqddchw10G/ib4WetzNYgDWnn64Y=;
        b=cPgx+WAzkrT2HWUowHI8QYqp5DS3RVIuVz2rcYQpJ03iiJVIIGZA4rOeTzT1tJpfm9
         Mc4GLBnm888Z4YL3cSTujoK/u0vaFNPJfz7GWBYHu+6gMi02qMT9BnRD4K+sQaPbWapw
         a3XtqW+WUg52C4asoXX+hrWKhgeLxPtEY/ryqIrDXYik+4sXqo0Xq+0mgibjqt62109I
         INvQBsjAdZqfpql+boBKbuY2eHE079yhPU6wnBs63k5ipgFSS2G+JCcQ5vQhtKjp0bbf
         5nLdGRV6Xoj8FHFi5HP+KKBuzUdP2ePY6mraACAFBjUenNorg1IZN4VLCo9TTKBzGd1Z
         Mrug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217286; x=1791822086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gj704BQ3G24WGzzMqddchw10G/ib4WetzNYgDWnn64Y=;
        b=uoN4U+1t+5MfFxSUBXwVJGP8iLCCD/s9OMLtqf1UFQVaHt7idHAGsViITpBdiFzrxd
         1CT75xuXnUHHMevp2qq8mgzYBTLN20gqTbAHSGzEVSdd8iLD/+dPoEhy01CQD9IUsSUU
         PEjvj02bYDjq9JDs2pZIf7wFAv+dvGO8r1pSD8xFAX4V7kNubyN1FGowsOdSevFnvN3X
         68D6kOIzTcwhNNUFqL+b9FcsCwM34NYDbwRKmK0mJd+kL6UPrBSYo9l9gyU/OzzwFoD5
         /YqnAgncQ2Ip7a5R2Bx6aMqpVUU4vj5DPVi1smgR6QZ+Z2tVTnzaN1QLWA6Mxsm/rcWR
         2J3g==
X-Gm-Message-State: AFq9FYLGl+H8sFAKiTi71ZoJIt9yUV+mSLRHDJ8Cye4MtERg5S5nmGa1
	Qrnuld9MviOf7xDrlApyWWXngFjvw20c7bcW4mOLMQpa+L17d7CjlV5Mo+cMUVIy5Ltk8jpLvWG
	PEeXQ5Gg=
X-Gm-Gg: AYBFou2iMPdaZu5XHMZifRhHPtxZJY2sDwXEYil5wGzNRBKpZLxm67fydrrKjboPNWn
	+/mhJ1yLA4JLsDer2DAwbglci6lCt/2PtSfjGgwl8Hn34uz6gIGfPAbykil7d0UlJCgnIZmiq0U
	MdBJzL7lfwpiMT+QrEMb6F9Ky4FTRkncBLxthuIEpwhGpcVVDmQwSaEHOIrx5ju3YWjvBlJ2Nu/
	CQa8VIeevpBSKAzprh6u1pamBIhw9xvyS0hItegR8FNkhjN6SUmJFtGTkhqw7SJReHKf4m49m/2
	xYCz/yuNF9t5ONnRTmhcPYgJcOPJyhfeMFvP5wA3IDya7iq8ATDJqBJ/kdW6d5sPkcGCzMN+pI2
	/gBWGk8TTRkv7ngW9fntrEtniNeJv/p8RR+rRvKObiFUU4I+CXj741bZGRVoPmuVjZvqDkHXfdA
	0ahHBZZ8UAGjy4heFr/PNHCYPjsK2WOmVIOC4xgyWQ1m3Dp9Wz6KEvAyY71k/TS/WwsSa8OJqYf
	nN23t0Hlk5rNjCbaQ2faVGarU2HnoZiUwerTR/I29O9IMWgGCtUkqjz8IqgS2GIj68Af8OS+6O+
	rWNwEfPN8eRdfJr66JFMncRlBgrLxxL3Ro5uEnyo
X-Received: by 2002:a05:693c:66cc:10b0:34e:e479:723 with SMTP id 5a478bee46e88-34f14f12d95mr12691849eec.5.1791217285261;
        Mon, 05 Oct 2026 09:21:25 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512713809csm15646567eec.7.2026.10.05.09.21.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 09:21:25 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 1/3] emulator: Remove unused le_ext_adv_type
Date: Mon,  5 Oct 2026 09:21:15 -0700
Message-ID: <20261005162117.4606-2-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261005162117.4606-1-kevin@simpleble.org>
References: <20261005162117.4606-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing has read le_ext_adv_type since advertising sets got their own
struct le_ext_adv in commit 5145b1ea2e95 ("emulator/btdev: Add support
multiple instance of extended advertising"). Remove it along with
ext_legacy_adv_type, rather than fix that function's mapping of low
duty cycle directed advertising (0x04) to ADV_SCAN_IND.

Assisted-by: Claude:claude-opus-5.5
---
 emulator/btdev.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 26a8aff62..30eb183c0 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -269,8 +269,6 @@ struct btdev {
 	uint32_t sync_train_timeout;
 	uint8_t  sync_train_service_data;
 
-	uint16_t le_ext_adv_type;
-
 	); /* reset_group */
 
 	/* Real time length of AL array */
@@ -3773,29 +3771,6 @@ done:
 	return 0;
 }
 
-static uint16_t ext_legacy_adv_type(uint8_t type)
-{
-	switch (type) {
-	case 0x00:
-		/* Connectable undirected - ADV_IND" */
-		return 0x0013;
-	case 0x01:
-		/* Connectable directed - ADV_DIRECT_IND */
-		return 0x0015;
-	case 0x02:
-		/* Scannable undirected - ADV_SCAN_IND */
-		return 0x0012;
-	case 0x03:
-		/* Non connectable undirected - ADV_NONCONN_IND */
-		return 0x0010;
-	case 0x04:
-		/* Scan response - SCAN_RSP */
-		return 0x0012;
-	}
-
-	return 0x0000;
-}
-
 static int cmd_set_adv_params(struct btdev *dev, const void *data, uint8_t len)
 {
 	const struct bt_hci_cmd_le_set_adv_parameters *cmd = data;
@@ -3807,8 +3782,6 @@ static int cmd_set_adv_params(struct btdev *dev, const void *data, uint8_t len)
 	}
 
 	dev->le_adv_type = cmd->type;
-	/* Use Legacy PDU if the remote is using EXT Scan */
-	dev->le_ext_adv_type = ext_legacy_adv_type(cmd->type);
 	dev->le_adv_own_addr = cmd->own_addr_type;
 	dev->le_adv_direct_addr_type = cmd->direct_addr_type;
 	memcpy(dev->le_adv_direct_addr, cmd->direct_addr, 6);
-- 
2.54.0 (Apple Git-157)

