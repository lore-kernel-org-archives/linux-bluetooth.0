Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD08E378813
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784887054; cv=none; b=nQstFEuDdid3Sz/zVxFCTyDQpfWV1xcQ6MhG7Vnl1v5y2eWNbhqK6S7qybjo+RF07LuZ9UQFFyk6rn/fpbqtA3PL55Ob6RU4+A9AlYoH0Xot3m6AfDrnZwi8bHrVrEhWQzeUfeY9o0GXQXy+l8mNdh6B3sdiSimM9s2E5YIDCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784887054; c=relaxed/simple;
	bh=rBTuhL8o+9AJ5Kj2ARbbCll9avO0T0QAYJh/TNUuSFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N9SuyCk0BOTpmy88JVGC7QGHkPp32xt2eKfdYDz4L6KeFylbBxPe2pmiZ8Mm5dfpwxWaSdtf+gPaIQCS2rl6zD/zI5bpQa7z0wOijGN5oeosNYNtmNdVc1bpNtGlLFk4hgMCsYbi7TU5Vee8XylIHB0igF6VJbH1m/TYDzuxCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChU7PGJt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChU7PGJt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69CAEC19425;
	Fri, 24 Jul 2026 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784887054;
	bh=rBTuhL8o+9AJ5Kj2ARbbCll9avO0T0QAYJh/TNUuSFI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ChU7PGJtlAZxS+y4rs1/BHgmfqDUbT08ZIfgHNdRVjZJ4uAZwbDlnddYArf9cRDGi
	 Lsa9tB3nQggWTBERO1JUEvzouIadv0cbHQC3rHcmGhvdsp2+iP1xwGAHTJR1G/QM5R
	 jPPrh7IjduweuLhdcBWB8kYPwaIiGyzS55arTU39p+IREZjyaZhDEEviSyB5+j09WE
	 +ULbHYZfPPicj0RvnwkqbDKPycWZjBctpJwB9ckZ4wjopNrBA/qlJuvx/G4QhAMWg9
	 BgYlKlVyrxk12e3QIcZjdmfEgB/Fye5Pb4HfZgWpyY58Xv6+mzM0/32PCqzvYfXmLX
	 Ny65grWnYJuRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4669EC531C9;
	Fri, 24 Jul 2026 09:57:34 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 24 Jul 2026 17:57:24 +0800
Subject: [PATCH BlueZ bluez] bap: Start BIG sync after receiving BIGInfo
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-big_sync-v1-1-0a35013e30ba@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAAM3Y2oC/x3MWwqAIBBA0a3IfCfoYEVtJSLKJhsIC6XoQXtP+
 jxwuQ9ECkwRavFAoIMjrz5BZwLs3HtHksdkQIWFKtHIgV0XL2+lyS0asqrSqCHlW6CJz3/VwLD
 sdEP7vh8FbU8MYQAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784887051; l=2484;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=f+CYjopzc8Xtsy+P4oslA+AV69P7mhWv1FepgB25D2c=;
 b=rl8pmG4sgzce3rqk1xfn/ZblOUmrKeFhKFYSI27ypc/QPBTx/LwVM6HxS5WNVvFXgs8fFOSNF
 m/mMUatdqMqAjWMt2dXj6ZBQ8L3ufBGL52wPqSyY7FEY4yjq7tC86M/
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

The current implementation starts BIG sync before receiving a BIGInfo
report. According to the Bluetooth Core Specification, BIG sync should
only be initiated after BIGInfo has been received.

Starting BIG sync too early may cause unexpected controller behavior.

Trigger BIG sync from the BIGInfo callback, following the same approach
used by the short PA flow.

Fixes: https://github.com/bluez/bluez/issues/2345

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 profiles/audio/bap.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index dd4b3c8ff..9e2cd3658 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3650,7 +3650,7 @@ static void setup_refresh_qos(void *data, void *user_data)
 	setup->qos = *bt_bap_stream_get_qos(stream);
 }
 
-static void iso_do_big_sync(GIOChannel *io, void *user_data)
+static void iso_do_big_sync(GIOChannel *io, GIOCondition cond, void *user_data)
 {
 	GError *err = NULL;
 	struct bap_setup *setup = user_data;
@@ -3659,7 +3659,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	struct bt_iso_qos qos;
 	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
 
-	DBG("PA Sync done");
+	DBG("BIG info received, do BIG sync");
 
 	g_io_channel_unref(data->listen_io);
 	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
@@ -3695,13 +3695,27 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	}
 }
 
+static void long_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
+{
+	struct bap_setup *setup = user_data;
+	struct bap_data *data = setup->data;
+
+	DBG("Long PA Sync done");
+
+	/* store io and add watch that will call iso_do_big_sync */
+	data->io = io;
+	g_io_channel_ref(data->io);
+	data->io_id = g_io_add_watch(io, G_IO_OUT, iso_do_big_sync,
+							setup);
+}
+
 static void pa_and_big_sync(struct bap_setup *setup)
 {
 	GError *err = NULL;
 	struct bap_data *bap_data = setup->data;
-
 	DBG("Create PA sync with this source");
-	bap_data->listen_io = bt_io_listen(NULL, iso_do_big_sync, setup,
+
+	bap_data->listen_io = bt_io_listen(NULL, long_pa_sync_confirm_cb, setup,
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(bap_data->adapter),

---
base-commit: 89d477bb5494eef0b24e5667be62f854da250a97
change-id: 20260724-big_sync-45c24ec09121

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


