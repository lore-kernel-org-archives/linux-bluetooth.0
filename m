Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313B28C00B
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 03:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154798; cv=none; b=GD6DZJc8hEhIMmM4ZA0HAnJv17YYqTwOFNa43O1dYFi4Oevza7Vd23pow3wxwPPe9Y0gF0OJ7TawtkJz1kPczRxnteOAphj849DikpFUZrc1Fqub4vgaOQC2f5HlHWWpTtL2elLDDMvonwL2mUAqHOTX7FBVyGKmSKi8+z4eepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154798; c=relaxed/simple;
	bh=pUJNTLRBfnrN5YCwZiQzV5HzV2d62rKv6mEE9POHkcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ugxeh4CJwcbXSKoS3tS4FsT9/P+HyBVQMXZHlidZX9+ovWOHViLciX3e7+LKHbDQDpr9zfs8RS8Fwp3crvZXpU898HYxgYdLs8uSKjGKcEaDyGiv+FbL//vKgAph9pAIN7tRp6KjxuprYRbczsEZf8UGah3lykXud3vtSqyEgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ao/YXox5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ao/YXox5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F60CC4CEF1;
	Tue, 22 Jul 2025 03:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753154796;
	bh=pUJNTLRBfnrN5YCwZiQzV5HzV2d62rKv6mEE9POHkcg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ao/YXox5T2smMqhq6fH1YDb15sv3TgzmbkRmI1Gsauph+mYLIBYKcbO8Jv84d2QTK
	 9X6QTHF22DRUhDqRgPWvhoczxb8mOj7vQpfA5GcicaiCh8aI8A4ArfXYAxbJtz1IEu
	 epXZbq6+Qn8hPi/ZLz/t22jpbNoD0qCvdTeMCznWQD3NxXWOqTQ5v03pnDr/GVkKZ0
	 ka8zcjYcJROiCaXmysk4TbH6WGGxUO7uCak+PZTVcI+qdw+c3MKDbx7n/GEWoDtZnd
	 eBV21nzgI+4PxVwnAoaw4yOFfEgHsH7bkpJWM05055Dc3U21qjADcdeDEa/uTIGQJp
	 NlZE5ZoUtAWNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CABFC83F26;
	Tue, 22 Jul 2025 03:26:36 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Tue, 22 Jul 2025 11:26:32 +0800
Subject: [PATCH BlueZ bluez] bap: Add NULL check for stream in
 iso_bcast_confirm_cb()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-bap_crash-v1-1-35ae54484d29@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAOgEf2gC/x3MQQqAIBBA0avErBNMsrKrRITalANRoRSRePek5
 YPPjxDQEwboiwgebwp07BlVWYB1el+R0ZwNggvJWyGY0edkvQ6OtUbzRtaqUbKD3J8eF3r+1wB
 mu/CFMaUPbaHHUmIAAAA=
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753154793; l=1774;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=fX7AxuzzkxlRpa30i25a9aHSgSlE+PKR3zUtGaW3+Kk=;
 b=Fdl75lc93o28YCVyq9svuLbpC0Od5j3VPdii/AH05Xk7e1mOZSSZCUHQf3lHnkhlpmiDdynJh
 109QbinOIjsAmbdJ+TgXFBuBANcg9GipgKrQ0p3fOgj9TkN38NHMVXf
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When a BIG sync is established and then immediately terminated,
the associated stream may have already been released.

backtrace:
  (gdb) bt
  #0  0x006d16c0 in queue_find ()
  #1  0x006d16cc in queue_find ()
  #2  0x006edd14 in stream_get_io ()
  #3  0x006f0bdc in bt_bap_stream_get_io ()
  #4  0x0064a440 in iso_bcast_confirm_cb ()
  #5  0x0065c36c in server_cb ()
  #6  0xf7878c24 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
  #7  0xf7878fb0 in ?? () from /usr/lib/libglib-2.0.so.0
  #8  0xf78793ec in g_main_loop_run () from /usr/lib/libglib-2.0.so.0
  #9  0x007055d0 in mainloop_run ()
  #10 0x00705a34 in mainloop_run_with_signal ()
  #11 0x0061484c in main ()

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 profiles/audio/bap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index f39a40458..022b5ae28 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1370,12 +1370,17 @@ static bool stream_io_unset(const void *data, const void *user_data)
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_setup *setup = user_data;
-	struct bt_bap_stream *stream = setup->stream;
+	struct bt_bap_stream *stream;
 	int fd;
 	struct bap_data *bap_data = setup->data;
 
+	if (!setup && !setup->stream)
+		return;
+
 	DBG("BIG Sync completed");
 
+	stream = setup->stream;
+
 	/* The order of the BIS fds notified from kernel corresponds
 	 * to the order of the BISes that were enqueued before
 	 * calling bt_io_bcast_accept.

---
base-commit: 52de8da1a99cd33b517284f87d231055a0dee6bb
change-id: 20250722-bap_crash-7ba065496958

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


