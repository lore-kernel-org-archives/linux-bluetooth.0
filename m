Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F215B0F9
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837178; cv=none; b=uWZ35qbFjgJr91aOaNHUVFwKK3xmcjEhPQjoKhJ4oPsROHTsUOVyKIVkh8rP9qgtS5pcvcScT3uy2CO0/Egoa8U2/f5rbuPNoOhxZFLMpOuw4S7JMcvJpHhvlKCVLYB2MWHuQjisxKR+jKbupe+BBn4wIfD+Xnu0AiuCSwfd9H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837178; c=relaxed/simple;
	bh=CO2ydq6Bonfbi+93zJp+cU9RGwyDIzmOoFozwAeCnyY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YykszidzkNBwELE+YBo8rgE1xMRb3tHTooEq+wKlVaqoTSoUxvRGE9BqGlKy3bidImggKUFunbv59hN/af6GyH6OYbuI1tITsvp3qPGaDxRzTmXTqDGZzQ+dUZEj9b99QD9BVSjvc7qohfH6IKRyNwFdcwwsFaSKXsdFjw4alO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0h7LHvc; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0h7LHvc"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c6661bca43so16124eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721837175; x=1722441975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ynihtN8SdZyULuagk08lb8XUdipxxZ3D5lZogfn/TUs=;
        b=e0h7LHvcuxl9gsSZM5AXOVIPpRQKZQi0G5tG3bx6lL555CHDTt/loexYgT/8e+qPW8
         XS0cM7bA5wTZQvDjVWC0K+8e3A3Lfh/QODImgVeplaRcjU0+huCPvz1SZBgSRTICsuO8
         4hOi/V0wqUdd1RB+yZH39rsjdmAfHgFkiqAIeZDToXjoN8ygpnVehscKmy7OC3JYIm62
         U3xxS4l4+SRef7ibpkaq8xlqW4HT8P3+9Fbrgr7/fP3oVTSmIDiaV/agyHi0kirN46dU
         Wvgvmm8tHNimuoep0a5BVykvkr2m97C1+o6s6synJ9RUNkfXyrYas05UaatHoa7PyXyn
         z3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837175; x=1722441975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynihtN8SdZyULuagk08lb8XUdipxxZ3D5lZogfn/TUs=;
        b=ZDfXhWh2Ko9g3JGnl3Pry94zDje7I5VF2jOV4QJC/iOPhH3jWb5S2Y0kmsM7HiHDe9
         GmujQlvnN5P52ghGXzLHVNoQfRkz9Ixw6nShUOjXvQbyjUHamqEoa7+uZUAIqiYwwh4S
         TvpnfN2tzW1s+ZZPwTAxNMTyCsJdWbyn35ZDH/64CTSu7ds0Ksk8P/acPQ11PgAhFr6Q
         ayD2vJyfHg/WrQoVszZhLFzVvoQMnTHHwpXzDfqP9PQ1EyA6FA2ZqLbwweWEUFSXGnLb
         YhGzgtycSb+hyVjL9TPV4HEpUFntc28UqJeyg4HwUTJa/RI4JTR6xgaxN9GF0G99M7D/
         46zw==
X-Gm-Message-State: AOJu0YxjdvLceeLya/hA2jc1QXye3/7xN6z7wT8b2LuvOyLst+5h7k1M
	PBDcHYEdcgvxyHRQgwRU7O63HOMtPB/Ff5Dgt3MSEV6iEZ/rIPLFtD+Nig==
X-Google-Smtp-Source: AGHT+IH5giNAH2qOBE9d9wFhoeW6azyWpgHlNWm4pkL5Xc96Z1efX5Nl1vo2hOAdgR63/Z6EgA6cfg==
X-Received: by 2002:a05:6358:7323:b0:1ac:660a:8a69 with SMTP id e5c5f4694b2df-1acf8a25558mr30772355d.18.1721837174449;
        Wed, 24 Jul 2024 09:06:14 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-826dcefcc28sm2445485241.10.2024.07.24.09.06.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:06:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] shared/bap: Fix bt_bap_select with multiple lpacs
Date: Wed, 24 Jul 2024 12:06:08 -0400
Message-ID: <20240724160608.2779282-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724160608.2779282-1-luiz.dentz@gmail.com>
References: <20240724160608.2779282-1-luiz.dentz@gmail.com>
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
 src/shared/bap.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4bec51011469..499e740c9162 100644
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
@@ -5420,7 +5437,7 @@ int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			selected++;
 
 			/* Check if there are any channels left to select */
-				map.count &= ~(map.count & rc->count);
+			map.count &= ~(map.count & rc->count);
 			/* Check if there are any locations left to select */
 			map.location &= ~(map.location & rc->location);
 
-- 
2.45.2

