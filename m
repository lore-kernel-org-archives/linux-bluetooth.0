Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279F2EFDAF
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183381; cv=none; b=J9LY1Yf6nfR1PED7UKRQT6I3birmcxJPDNobzkdb4jR/NWgJwhdNeLujQI/V51k+koRovLL1q/ROsx8ECfvrido6apMzLY8y9lZ5syMSqClnCf0ztUDHwmN6Y0N+gd+52kLCpTn9YeaPu44QXjjkRTAatxrBTE0+WRcUTM23TAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183381; c=relaxed/simple;
	bh=xYNUjCzfzbDI9A+qtTE3WHtDeBmLHxBx6MzAiYLMKo8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lUCdHVqO1qxyapAFoA5BLz4Tmfk5Tk2LujA/fec8fp4DcqRCF1irEsDzyvJPtbhIgYeXAn4mSdJL3R9LUuQnbXyDyISZZqUNrRjZQ3tg5GEqmbQEit/85h3/T8jX5MISj/2a8gJRz+jwdhEpdn4VR9anS8+9S8G7cptEpvW+/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEekph0k; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEekph0k"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56f6afbd205so1072552e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Apr 2026 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776183379; x=1776788179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k1ZgZ0s4i4vzs5R3xPF3qO3IEEuCKj9rv2U2Bw55YtI=;
        b=cEekph0knQ9rNMz2Og8aAYY2gDZA5Syfe0uZVooxUCdKn/gN81BwT8yVSxCVS/DFi4
         QJLgRshPPERwNzSNXv+gRWxSALy89XJwF3zKp08NdYwv7sgdEMVO6kKWYh6/MMUxkNM1
         3IgB/thVVHCIUYR8TrVLSG1bWN0P9otOovdyjbtTmDqQ1rp6LXIy6XfPtY0V+2LIxa+7
         82WdWg1Jb6GPoNjStZA2HvH558mJdDAjiz1d0gJbRGAbiE/4WuUaN2fGnLqFYRtN6rQ2
         Ba6v4HrzepEg8Wq0ZyE7sHUwVHeTvDLvo7Je1OTidaCPgdK8SwYD86MHRT3BfnRDa2WE
         52nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183379; x=1776788179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1ZgZ0s4i4vzs5R3xPF3qO3IEEuCKj9rv2U2Bw55YtI=;
        b=jrIDRFkoReO7kSNeus40dxrliAKy2EOi13I1zKi4Lhs1XXBv3/I/4l2HYkdKtfYUJo
         Pq9+NT6gqvP1phQ3/6la2YW6nWog/qIgoNdZ5doqKIqFhWkfxuYYKuv50MuzaysvHcwM
         5Z+qGzJt8JAmEWZ2TBsuL9L9R4mC2AQJs0AzVFR7sx43LVCWUNEUWr5k2hj6caOpTods
         aOG71BS80GzA3XNbS1Ui4biBbLXjx2W01NXoj4R2f3INiykuc/jNB2v02ZcX8IpIVQV4
         Ps14B5XXxS9BtFdXCzmMnIWwEpHTTL4GOSAAZ8X4irbkFXzbc+gLkYA3Hrlkez+qPPel
         XVZA==
X-Gm-Message-State: AOJu0YySBV4uuyD4gzqr71Mr9oZ6SYmdF3FR62uyS0lJYqqtrqIpwjM2
	9LlBCowWqj4srHM7aM3KTJmkRUuG3w43WpbW/X4uTdtDYo8Om4eyJj2TqLnHCd9E
X-Gm-Gg: AeBDieswg9kSOqlGQVBG034A0e6wZJgaF0+/GZmBCOOokd5tXqdWtAKJ4CdN3++0RcC
	kHm2ahkKrwPIWc9/e0byM5E0jMrQGEQ7c0XZKWimdrgiDFLL+XrBcqU+jXjKC1XtBX+varFlxed
	/89oBCRT9uQicBdTFbI/zbSir5sxMolmODbgenJ/gWcHuL+k0YiyG9QXVQuBeFwBByJ4kq5JpuE
	uhsw0Dh6TMWS6lx1bauT0vS5p+SU7eZx3JgGubONp4qR0PrLyhc4t6da70kSfkE4F+VDbD/4mO0
	YCp55K1c+pYFcRJzEM1CJajGg8WdwKAHdXcTVOPBjgL5wwUZqYSXCImhVAx4n/TTyXL3riSh2FR
	4MC6NnsTAhAVc3771sK0ZK0GpIrJo1YFAaRkv0fRJVHmzEmtOe/MSEI+GG5d/lV6dWQAkd5me0U
	YvD/HuMwV7Fm9RLoM+gWr9LCMbr5u9qKGCnlEAq9dRFbjGcBFnLh3doVNFUvY9+NrmOqRECGiuQ
	r1QBjX8QeUyY+U4/t7qn2KjbPI7
X-Received: by 2002:a05:6122:82a9:b0:56d:3451:4cc0 with SMTP id 71dfb90a1353d-56f3cafbba3mr5769650e0c.7.1776183378162;
        Tue, 14 Apr 2026 09:16:18 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56f810253e4sm636373e0c.16.2026.04.14.09.16.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:16:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bass: Fix crashing on BT_BASS_MOD_SRC
Date: Tue, 14 Apr 2026 12:16:11 -0400
Message-ID: <20260414161611.67225-1-luiz.dentz@gmail.com>
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
 profiles/audio/bass.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index bf0db0555963..e3710ea04c2b 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1865,21 +1865,21 @@ static bool setup_match_bis(const void *data, const void *match_data)
 static void bass_update_bis_sync(struct bass_delegator *dg,
 				struct bt_bcast_src *bcast_src)
 {
-	for (int bis = 1; bis < ISO_MAX_NUM_BIS; bis++) {
-		struct bass_setup *setup = queue_find(dg->setups,
-				setup_match_bis, INT_TO_PTR(bis));
-		uint8_t state;
+	struct queue_entry *entry;
 
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

