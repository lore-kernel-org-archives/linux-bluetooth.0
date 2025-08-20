Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3469F275B0A
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755700508; cv=none; b=W/t1LI/k3linE9Mj2y5wvo2jIr9ge7X2oVi9zV6mYt8LVfABncwMD0tcpvEPgv5YibNZN7Pob4QZWF9ZNjMOhGnsGlx5q+wHQbyt6mqx0XsxsAzc1afFUiP8EI0PUKrGF3rWNzfg75f1MF9nshoTi4XjKgRRxpz/xR7aXKHYqCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755700508; c=relaxed/simple;
	bh=QeF7s8nSWRxsUuwkDQNJYO/O8qvLvFyZR+DZfZRO2XM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RLLJocce31qzF0C3jfJDx/7JCON0a0Wjb52HunpQc5W6PnvgE0SoAvmjamOYupuNTb/Z/jfrUd7b0gK0bzUrL23mKBB4H8nTrJsf5TcfvPPjpWikQ5HxbwB3T8LYwzXQsUSZ6UXtts4N1r5g/ZuE/JIHECapLBaa3Kp3H77Lwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 4194C584B8C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:16:00 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0564544407
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 14:15:52 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] profiles/audio: Fix uninitialized params.subgroup_data warning
Date: Wed, 20 Aug 2025 16:15:44 +0200
Message-ID: <20250820141552.800720-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeffleeuffejvdeufeffvdejjedvheekgfeltdejhfeitdettefgjedvuedvhfejueenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdrrhgvughhrghtrdgtohhmpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: hadess@hadess.net

profiles/audio/bass.c:923:2: uninit_use_in_call: Using uninitialized value "params". Field "params.subgroup_data" is uninitialized when calling "util_iov_append".
---
 profiles/audio/bass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 055d51b8927e..efa58e62b62f 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -918,7 +918,7 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 {
 	struct bass_assistant *assistant = user_data;
 	struct bt_bass_bcast_audio_scan_cp_hdr hdr;
-	struct bt_bass_add_src_params params;
+	struct bt_bass_add_src_params params = {0};
 	struct iovec iov = {0};
 	uint32_t bis_sync = 0;
 	uint8_t meta_len = 0;
-- 
2.50.1

