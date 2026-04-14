Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9F1C01
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193511; cv=none; b=X3c78MLReMh/ueBdZbp3nEgTp95c79XZGboIjGeOtHOCT+hHu9uLvy/ZqAm1hU/j7hEXHs+GUEwidNmInDU0SzcC1ZmZY3x7UG5ZLQCG7t9EG/yArRNCIV+0k095uOcEzMjiCoWEztxJYGo0zewhbO07SsRzgIbLeNwZnxrCYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193511; c=relaxed/simple;
	bh=bDioenjEItxFbX6IG6Unwb7xF8FE2+H/oIqlW3uBQGY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PvSMEqrgQNav2fBR8timyTjrrHKatidTmvyq5Fi0y+lkXTrAobMI7iz5u3Q9f8Og/dzgsGbkZJGJM4SYerzVfaRzb3RGLNAFEfF/4vPQeRWKvcM6WCCs0pxXLkIDxcFAcZy5QlRrKkXARa+VyKFQfJiR64CoA2T1WjLF5q5M51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o57U1J96; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o57U1J96"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56d8d479149so2042438e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776193508; x=1776798308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcMZjp4BmNxvYubmFnzNdb/WRJMCiuI0z0hkQ+/23HE=;
        b=o57U1J96w/w2um9BwlmNK0uD5vV3S/bZoeww+Y3dK7+eNKzc1KwfFKVoqE+t+siRqu
         tKmGX0L36DceoMV9d+Z97MgCULtvXCuZJ6frstsck7jfsl5+7C3TVj8pwD+i3cUdHO8e
         86rWllz77LePJLhYVfZksMgxbK/QcHf8KdfLr/c/+oLgXqS6lkjLO2C5vZp4YNiMnnLo
         r9Vmg1u6clhy27ttUsFJpz2wZkmdlEpjlh1oAmcJziGF0BmSRFzwOeJhJzxQft2B3N8V
         BRZog+7lLJFfVclTXS2lMI1yvGwOWCg2j6voVZ+yOQuCo92eSlz8FIPB93b+8+N6TUdy
         p8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193508; x=1776798308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcMZjp4BmNxvYubmFnzNdb/WRJMCiuI0z0hkQ+/23HE=;
        b=cRxJjc7nT5P2yQNjrN1sR8QL70zUR3Sa51bt4m1rfOoxw5vqYjZ49NFY0RBlPxq5so
         yNvb9wSAq5nkZ7MaDn2mMUGgXkX/LVk8cF6NRVxsG7+MvjfGNXjwirTre1a9d9VbU0Uj
         9PCJzf1rhsOWXhpKbRjMO+r7+2RMbg41wuh4NYPDNbt9JGGa9ezW4Qtw2B+zJt5tbtpO
         TuKGfdZ06+LbjXrD6lTGgrmZAAqLvrMn9SRgdXDW82xTkPIxpprWPAu2QmeC8gTyFH73
         0HvUBlbNpQv0/LAaY6NVpVRdw3Ey3C/fQv0TqdyJ3+GXxREYgJnurqg7XQ4K4JcXav7X
         g4Cw==
X-Gm-Message-State: AOJu0YxehoH72ZOOFOuqwoluqUEKyefCn6An1om6025lhkZR29tbR6cS
	3tfNGfkp+4N1Go+QGXbzk5ukFhbiIWYf78ajh8zeV0KIN8ev9aYC1SsMzuJAjipt
X-Gm-Gg: AeBDietdgWxBo6vOMeEl8ijS3icrGVUYWxI5NMnQbTYCQkyhuKgsRQJJ80+Rm/HnLuz
	7Z/HeeSKmsG+FInDzAZ4tUSBy07953X7Gf6N2VCLXyJS+o3+mUQnSpyH1tZAkhvl0ut9YbIOXAR
	tNyDN9YWkOsfQ3TicNXUfGkiSBxOuIThU1QxyqU8RLdmcLLw29NQXZE8XV8W/dZkeKPyKjvTpwk
	huLZFF7nnbH4EMka/D/mUNEmkANMG5Y82oYsd8WqfcxgMCwL95zS/Am3jgv8oc3LGdc9UMUULO9
	SsxFR911376mL4b0JxBrqMft0tRc4K83Kujsnq76I/8OconeUAwjHzlkBUnbAIuvfPaEri3a7BF
	jmb3NPv4RvM3LRFY1B9VX8HRhILgy+adByii5WakzJzWH2EOv7kEFALMEVfEFtxJDjK8VhWOk0J
	PkLqRwn0AXnJ///TT25s7kd1twjXV9QF4nc0tsv1JT8TWFVb6zEPMJIJ5X1lbZ5PnO8l4Ss5nI3
	k3MKnAHRvW9wN1/L/UWQtKjZsSu
X-Received: by 2002:a05:6123:102:b0:566:357b:ef25 with SMTP id 71dfb90a1353d-56f3bd13359mr9559296e0c.15.1776193508498;
        Tue, 14 Apr 2026 12:05:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f861e1650sm270525e0c.12.2026.04.14.12.05.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:05:08 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] bass: Fix crashing on BT_BASS_MOD_SRC
Date: Tue, 14 Apr 2026 15:04:59 -0400
Message-ID: <20260414190459.161947-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If assistant attempt o modify source the code would attempt to iterate
over all valid range of BIS indexes which may lead to the following
trace since the delegator maybe freed in the process:

 #0  queue_find (queue=<optimized out>, function=function@entry=0x58b8761109c0 <setup_match_bis>, match_data=match_data@entry=0x3) at src/shared/queue.c:230
 #1  0x000058b8761127fb in bass_update_bis_sync (bcast_src=<optimized out>, dg=<optimized out>) at profiles/audio/bass.c:1824
 #2  handle_mod_src_req (data=<optimized out>, params=<optimized out>, bcast_src=0x58b894661be0) at profiles/audio/bass.c:1862
 #3  cp_handler (bcast_src=0x58b894661be0, op=<optimized out>, params=<optimized out>, user_data=<optimized out>) at profiles/audio/bass.c:1910
 #4  0x000058b8761bc978 in bass_handle_mod_src_op (bass=<optimized out>, attrib=<optimized out>, opcode=<optimized out>, id=<optimized out>, iov=<optimized out>, att=<optimized out>)
    at src/shared/bass.c:1069

To fix the code will now just interate at existing setups checking if
they match the BIS index then adding/removing the stream so it is no
longer possible to free the delegator before all setups are processed.
---
 profiles/audio/bass.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index bf0db0555963..1fd7704a77a2 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1854,32 +1854,24 @@ static int handle_set_bcode_req(struct bt_bcast_src *bcast_src,
 	return 0;
 }
 
-static bool setup_match_bis(const void *data, const void *match_data)
-{
-	const struct bass_setup *setup = data;
-	const int bis =  PTR_TO_INT(match_data);
-
-	return setup->bis == bis;
-}
-
 static void bass_update_bis_sync(struct bass_delegator *dg,
 				struct bt_bcast_src *bcast_src)
 {
-	for (int bis = 1; bis < ISO_MAX_NUM_BIS; bis++) {
-		struct bass_setup *setup = queue_find(dg->setups,
-				setup_match_bis, INT_TO_PTR(bis));
-		uint8_t state;
+	const struct queue_entry *entry;
 
-		if (!setup)
-			continue;
+	/* Check if existing setups if BIS needs to be added/removed */
+	for (entry = queue_get_entries(dg->setups); entry;
+				entry = entry->next) {
+		struct bass_setup *setup = entry->data;
+		uint8_t state;
 
 		state = bt_bap_stream_get_state(setup->stream);
 
-		if (!setup->stream && bt_bass_check_bis(bcast_src, bis))
+		if (!setup->stream && bt_bass_check_bis(bcast_src, setup->bis))
 			bass_add_bis(setup);
 		else if (setup->stream &&
 				state == BT_BAP_STREAM_STATE_STREAMING &&
-				!bt_bass_check_bis(bcast_src, bis))
+				!bt_bass_check_bis(bcast_src, setup->bis))
 			bass_remove_bis(setup);
 	}
 }
-- 
2.53.0

