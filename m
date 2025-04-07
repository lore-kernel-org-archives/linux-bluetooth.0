Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6F22D786
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744022075; cv=none; b=CRhqJvmj7q5x95wMevYkiQrDubtDFHy19Ij6Z/vm/Zm2U4y7cLs1hy+5x5Q/DhK9T1ab9JDOl+t4hv6pLL7V5mZ5iei4zXjfZa4k9YVx/C398oOJMDh/1SvQoyjNE4Exw6rRANUKLgLE0zEL3T5cWulJ3wCdwJMlsGjW563Bp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744022075; c=relaxed/simple;
	bh=fNSZQHLW84t988BraoVib2HAlFwW5oOxspQdkJ0T4Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=knFbTtSABRe6lnmAoUIFvnCo6lxKEEWHzMEMfytE6qCcmaG/p8A9LSdw7RLaMBulDXhqEi/2ub8YF2w7WCxpUIVssSG4VTVLJAvb562oJeHhQZk/y9zkCvV0Y08pNqiuSydYsQHe/xBQjwVMo3hJGQhzddQeNkpR47PHHCryxWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHY7eY/E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHY7eY/E"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C79A9C4CEDD;
	Mon,  7 Apr 2025 10:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744022073;
	bh=fNSZQHLW84t988BraoVib2HAlFwW5oOxspQdkJ0T4Hk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=kHY7eY/E1CCmMv0n6R8vWzor9RpnbumTcySySh4pM0Ar+VKGcj/azP91vZHwvJ/1a
	 0pbtB+U+WkjVNyKVYKRFpqLu7xXVPpaI5LUzGQC4Eo5RdXQ3wraDlf232s1mz0Rf+2
	 /JpDVxCt6g8cC7lis2WZVGqp4wMVQB7NTPCA++g6vCiHicmjUjuwJVlGpBM8Ax2PSj
	 ya/jnTDpDqFlvTvdMbwSRF+7rMxtcuzUqb/xcuDBYEUQETSl5Nnje6fEF5SLxZp992
	 Tbo2LfrvJFcDg58anXe00U1JEVvDcgF1VW/Kz0FH/zqHvQORaE2zVxGeOza4c86dG+
	 cFCCZoD/akETw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2150C36010;
	Mon,  7 Apr 2025 10:34:33 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 07 Apr 2025 18:34:28 +0800
Subject: [PATCH BlueZ bluez] bap: Add idle notification for ASE State
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-bap_aes_state-v1-1-dfc090c49cea@amlogic.com>
X-B4-Tracking: v=1; b=H4sIADOq82cC/x3M3QpAQBBA4VfRXNta/9arSBrMMiW0g0Te3ebyu
 zjnASHHJFAFDzg6WXhdPKIwgH7CZSTFgzfEOs50qgvV4dYiSSs77qRMovPClNaaDME3myPL1/+
 roZsPuqF53w9zOtGrZgAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744022071; l=2070;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=WHQVuOtn73gpfFGTGwu0z9z2k9/H8BgH1XFPzS+H9zY=;
 b=r7ZAjl7Of9cxrKOyM0irDmumBtEbBwj5TmeBFNQLiXyySfv4W3E52DtqbFpd1CUca0TZ2krYc
 XfCYArvA75cCm1a4mxCyZRf39YMg/1Sj5/io6o4YzOheKnQ5eIMGV8b
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When the ASE state changes from releasing(6) -> idle(0),
the idle state needs to be notified to the Client.

---
Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 src/shared/bap.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 650bea2f4..c40d6e051 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1123,17 +1123,12 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
 	free(status);
 }
 
-static void stream_notify_release(struct bt_bap_stream *stream)
+static void stream_notify_ase_state(struct bt_bap_stream *stream)
 {
 	struct bt_bap_endpoint *ep = stream->ep;
 	struct bt_ascs_ase_status status;
 
-	DBG(stream->bap, "stream %p", stream);
-
-
-	memset(&status, 0, sizeof(status));
 	status.id = ep->id;
-	ep->state = BT_BAP_STREAM_STATE_RELEASING;
 	status.state = ep->state;
 
 	gatt_db_attribute_notify(ep->attr, (void *)&status, sizeof(status),
@@ -1713,6 +1708,7 @@ static void stream_notify(struct bt_bap_stream *stream, uint8_t state)
 
 	switch (state) {
 	case BT_ASCS_ASE_STATE_IDLE:
+		stream_notify_ase_state(stream);
 		break;
 	case BT_ASCS_ASE_STATE_CONFIG:
 		stream_notify_config(stream);
@@ -1726,7 +1722,7 @@ static void stream_notify(struct bt_bap_stream *stream, uint8_t state)
 		stream_notify_metadata(stream);
 		break;
 	case BT_ASCS_ASE_STATE_RELEASING:
-		stream_notify_release(stream);
+		stream_notify_ase_state(stream);
 		break;
 	}
 }
@@ -6397,9 +6393,8 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
 	DBG(stream->bap, "stream %p io disconnected", stream);
 
 	if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 
-	bt_bap_stream_set_io(stream, -1);
 	return false;
 }
 

---
base-commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
change-id: 20250407-bap_aes_state-9306798ff95a

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


