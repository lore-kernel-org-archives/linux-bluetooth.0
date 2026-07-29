Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5A261B8D
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 01:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289638; cv=none; b=j4S8N3EidL8eDHU5KqomxXdRGmbWxsUqIWjiUZEEwMiaSHTUd1njx7JfxhYI2+NOhB4BnXucfaH9Ol8EGNPApqJtHyPRF1Immh8FcbXKNS2+MjMZ4VD/jg+V/fs9T9sxUyBP2s3B6E5C/9mKWyO0VQyGfdcl/RoLf8AZaZbgMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289638; c=relaxed/simple;
	bh=34zOqqmciKL4/EKWKLKlDZn60c8D3z+uxSEwJJUb5Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n4jpuRwBt0P2Yry2BrIsARRnpapIwL7BWQCbz+HntBmcwgtp957WhNjAyLQgEbSNrzwGOIGeJbKhuafo10DFXbPGFtcKOEsX6KO6yFQeDCy9Rvr2hdN07hiN9EVXropdno5SNvVslWJKV/PHBzjqC9E+3KNs3wRnsJvPJOn/C0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3+P40JZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3+P40JZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66CA1C2BCC6;
	Wed, 29 Jul 2026 01:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785289638;
	bh=34zOqqmciKL4/EKWKLKlDZn60c8D3z+uxSEwJJUb5Mw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=a3+P40JZHOm0D9Cl66Y8YaeRjpNaJ4lwTNRax/NU3vaGHRI1ANNrb1L0UtOEtcov3
	 3Fl+SKYbWxz/eSSwfRl6HfjCvGNaKWjhLvV/MixxWoMeLs0NiVi03wWfs0HDc4WJ/Y
	 rE9jOpY41k5WHfkD5oq48bYAqeu4F2hrmxZYy9+32G4xdfuHG7+GTdpn9bH6A0lOPY
	 RXMgH0k3iG7YyzYxkJSW2WrwULYVdwCVtk7MHWnClmZioK7e53+lMwrQ3gZ4df2aHn
	 /5paEj6QoYZOrt3VJHytcfrBVwMH1+khBw1Wq5khB4+6QLZQXYBEg1EoNR1QhvesE7
	 qnZvwXMy/afJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45889C53219;
	Wed, 29 Jul 2026 01:47:18 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 29 Jul 2026 09:47:16 +0800
Subject: [PATCH BlueZ bluez] bap: fixed the return value of GIOFunc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-fix_iofunc-v1-1-653c8e9ac29a@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAKRbaWoC/x2M3QpAQBBGX0VzbYspv68iifFhSku7kci721yeT
 uc85OEUnuroIYdTvW42QBpHJEtvZxgdAxMnnCcFV2bSq9NtOqwY5CwQyXgoQSHYHYL9Zw0N64G
 b2vf9AMd6gZFjAAAA
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785289636; l=1171;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=/hbuF3t2bg82xqd+B+KApp2WG+Bkz75KXCTrlPmc4Zw=;
 b=T5dq7cOQoNvxWnGCFggc7dSUUk52e2TLreLMea6IQjuzw9Bl9+YrerdgJvX7jFdaG66d2yFWD
 sRkjA+3xKHLB8oI0cvRRX8DeJxaapfFYkdJcrL7jxNoXW11KHcp129j
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

The GIOFunc should return FALSE if the event source should be removed.

Fixes: 322c39a64 (bap: Start BIG sync after receiving BIGInfo)

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 profiles/audio/bap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 473e4cfc2..ff8f58a12 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3683,7 +3683,6 @@ static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
 			BT_IO_OPT_INVALID)) {
 		error("bt_io_set: %s", err->message);
 		g_error_free(err);
-		return FALSE;
 	}
 
 	if (!bt_io_bcast_accept(io,
@@ -3694,10 +3693,9 @@ static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
 			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
 		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
-		return FALSE;
 	}
 
-	return TRUE;
+	return FALSE;
 }
 
 static void long_pa_sync_confirm_cb(GIOChannel *io, void *user_data)

---
base-commit: 729f96089cf66831d911385623ca932e0c245913
change-id: 20260729-fix_iofunc-e62cecc52b8e

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


