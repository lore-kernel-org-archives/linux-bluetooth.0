Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DBB143875
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 21:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943396; cv=none; b=XIhjlRQBlvwAaGZsqJ/JzGPKF3sdQC7/eV9Fk/2g6o64tMkprgZ5LBNepEXbcnds8gpRaAJjvHe1kNk+bvCV6h0FiI7wUDbBzUB8zgUo1wIrs9WT1RVrf/cDrDZigZhKUITM9czFOfRK+esz8VXpI4/jbwAi1idBPsdkTtk4pU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943396; c=relaxed/simple;
	bh=/6fiaFYPGk52pE8tMW6E5oD/V34jl1mdATom7PA/2pI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2FTiZT8p8l17jhfFoOqCBZzjlb+Ybq7zYORU4k4beEkAwlX3/N0SsgjcfsRf1zUJXXkwE5nio/aVTboM5QPRVb5WGkRsodpZiMtNkB/vWMC4kZj+YWQRbsN4iWtZW8XLHl3iHYdIbw6INhMLFvB8DiOc/m8CzBrspp+gJSR9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byN/Y1fB; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byN/Y1fB"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-49299adf8adso401817137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 14:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721943393; x=1722548193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab3bkBfJ2vSs/Qdq8D4EzRJujCBT4LBhdXhndOigMgg=;
        b=byN/Y1fBGt+UlXqHMNdy/1/cvOsNtPUDjHU0NmnalaZfdjJ6B2YIiNo8r1BO0qRvCy
         p8QM8CgeNHoctF0D6X3S6PoP9rjiXks/wBWBjk4Uiz6dcuQNEoS+J1mBnytcYMTwcmdE
         kZzoApYruHVg4qTnlW/huGb6eOQLcrjunxFji1LPH3W/QB3XCQoENuhE9x62YCvbpTk/
         J5dCTkP4UjdnGv74miBqkrPYiq1LOuQNdb4S++TzF8Wepp8A2nwNFUJBG30oRUrq8gw5
         n7M9GSM6yXPFKzkq+hHo5KA2jWQAzDogyNls+49u2P/WXOuY8NH6qTv4E0MQp4KJckab
         3kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943393; x=1722548193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab3bkBfJ2vSs/Qdq8D4EzRJujCBT4LBhdXhndOigMgg=;
        b=AjkA4V0hH6jnYE3e+/Quj3QucLneeVZmzq/YAkYl9IkI0pdiEyPIdS/hitflUUlext
         4e9HYSnwYbKQ6MvEf9mfOQKFFkX8fv3YYaeuj5oZ7WmhY3yd8KWUH7L8kMCO0N19ana2
         qFRwiilb0xNbUrPZHhxIunkinabG6dNx3eMsobJBmF0nta6N2ZA8Hbmg5SNKqKsqVVSP
         BPp8G0TreUAwjuFDjx4GeQPF3IyxxbMjtTf8SCePR41GvNK5yLBQ0cBB3pYSpC7afdUL
         yON2euQ+sO8Vdjfb0eiIDQC5CBcN6Gy0VPeiyKu7yh4eeAliQe72tBxgUsyYRwL4bOvZ
         BRdA==
X-Gm-Message-State: AOJu0YySuRQqzGXQSzrUPpmAlm7KZ02h5FdMGWlQFXmdq0hY8LiXXw/j
	i5L7hysWMLJYs3My1UPOuw+T4j938xDyy48trSD1ovdzvTJsuRES2u2q1Q==
X-Google-Smtp-Source: AGHT+IEiCAkcRrzYzc1AcwxRwG+4/gz6MtI1a52YaObDJ9g8n1j+Y9Bk9IJNLcUE4qIO10fBsGG7Pw==
X-Received: by 2002:a05:6102:800b:b0:493:c3b2:b5ba with SMTP id ada2fe7eead31-493d99b419cmr4598067137.6.1721943393156;
        Thu, 25 Jul 2024 14:36:33 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-493d95f313csm377007137.7.2024.07.25.14.36.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:36:31 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/3] shared/bap: Fix bt_bap_select with multiple lpacs
Date: Thu, 25 Jul 2024 17:36:26 -0400
Message-ID: <20240725213626.3183962-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725213626.3183962-1-luiz.dentz@gmail.com>
References: <20240725213626.3183962-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When there are multiple local PAC records of the same codec with
different locations only the first was consider, also bt_bap_select
would stop doing location matching early if the location don't match
without considering there could be more remote channels.
---
 src/shared/bap.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 0aa89c2781ba..499e740c9162 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3249,25 +3249,32 @@ static void *ltv_merge(struct iovec *data, struct iovec *cont)
 	return util_iov_append(data, cont->iov_base, cont->iov_len);
 }
 
-static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint8_t *v,
-					void *user_data)
+static void bap_pac_chan_add(struct bt_bap_pac *pac, uint8_t count,
+				uint32_t location)
 {
-	struct bt_bap_pac *pac = user_data;
 	struct bt_bap_chan *chan;
 
-	if (!v)
-		return;
-
 	if (!pac->channels)
 		pac->channels = queue_new();
 
 	chan = new0(struct bt_bap_chan, 1);
-	chan->count = *v;
-	chan->location = bt_bap_pac_get_locations(pac) ? : pac->qos.location;
+	chan->count = count;
+	chan->location = location;
 
 	queue_push_tail(pac->channels, chan);
 }
 
+static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct bt_bap_pac *pac = user_data;
+
+	if (!v)
+		return;
+
+	bap_pac_chan_add(pac, *v, bt_bap_pac_get_locations(pac));
+}
+
 static void bap_pac_update_channels(struct bt_bap_pac *pac, struct iovec *data)
 {
 	uint8_t type = 0x03;
@@ -3277,6 +3284,13 @@ static void bap_pac_update_channels(struct bt_bap_pac *pac, struct iovec *data)
 
 	util_ltv_foreach(data->iov_base, data->iov_len, &type,
 				bap_pac_foreach_channel, pac);
+
+	/* If record didn't set a channel count but set a location use that as
+	 * channel count.
+	 */
+	if (queue_isempty(pac->channels) && pac->qos.location)
+		bap_pac_chan_add(pac, pac->qos.location, pac->qos.location);
+
 }
 
 static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
@@ -3607,6 +3621,9 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 	if (!pac)
 		return 0;
 
+	if (pac->qos.location)
+		return pac->qos.location;
+
 	pacs = pac->bdb->pacs;
 
 	switch (pac->type) {
@@ -5411,7 +5428,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 
 			/* Try matching the channel location */
 			if (!(map.location & rc->location))
-				break;
+				continue;
 
 			lpac->ops->select(lpac, rpac, map.location &
 						rc->location, &rpac->qos,
-- 
2.45.2

