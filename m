Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83467311948
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768200134; cv=none; b=WegPCSK89t0XmgCqSDH+JD26SlDIozIPdUOwchQKFqTS/6zCriLAPTw789sB1HmgHGP/HyGj2jrqFQ2yMpD4fmsy/qCBvkeGHDwZYd1Qe2A9kO34PshHufq6qQLt1eLn6JLhsfLDkGHJlTirUJy0dv9mIN+yelSmzUns2FDYePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768200134; c=relaxed/simple;
	bh=OVo5ZDTIrwmpDUG+gI+8VFFk+2hq9OkbA2Kb4SuE/3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TrGmFY4WKfFALNS17Trmf5MiJUGU2eq6t8LKhes2JUCVI6n7ONZBpPTjGqnuZDIveKtO3PDivirICeDtqvFW3g/J/ZNzwxSupOLc7gCdTMjhxx7Quv8XOR+8gUJIg6L9MWv2sCYtbNW7FtOH1tNBKk3c/dGvz3taa6tcgMOttBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz2nWVKz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz2nWVKz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F47DC116D0;
	Mon, 12 Jan 2026 06:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768200134;
	bh=OVo5ZDTIrwmpDUG+gI+8VFFk+2hq9OkbA2Kb4SuE/3Q=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Dz2nWVKzA81qrE2yOdV2UjUehG3rt/8kjJVj3GSdcR5ePB0tjhSSwWzNAFpYvoH7M
	 IFGL8J/aRN3EnCqJpUkVO4pcu4ByFdTkkenV8Bi/3fQQjvPO0nf9p1HRve6VdaR9WA
	 cx1TUZkspIP09wuVQh+6fIg+AEULbHFsQ2ALrqEVX03XehRbrj7qXJBepWDO5GcDz2
	 n+DzBdLoQaT/Q8yHx/3iBhq2yuN2BZ3x/kKvcn7lheY/JtkDVcMV4txO1QHBDqdB4w
	 adVUbXu1PE/4JkdSFKj4Vgd9l/zd7pF3WmWyKWTfdPCS6m52vHE9OETBj70/dJYrYV
	 Tfa4Q0Yy0bKrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E238D25039;
	Mon, 12 Jan 2026 06:42:14 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Mon, 12 Jan 2026 14:42:11 +0800
Subject: [PATCH BlueZ bluez] bap: reduce ISO sync timeout to 2s
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-iso_sync_timeout-v1-1-9a3e99259a3f@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAMKXZGkC/x3MQQqDMBBG4avIrBtIooh4lVJE468dqEnJqKjBu
 zd0+S3eSySIDKG2SBSxs3DwGeZRkHv3fobiMZustrU2xiqW0MnpXbfygrCtqkEJN1Xl2FhQzr4
 REx//5ZOGz4aLXvf9A0jW/fxpAAAA
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768200132; l=976;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=y2BRDsP3/C+MiSJUsfUZeWSpftDfagbVB+7mlzikP/A=;
 b=r8OAJ2HTOV3R/+MHRLvk8Kwys7+swGAzL9Um4Pufeiw0zAd3SYb1bcLw2k97+C3zBWrvYO7oj
 nUCsLPZiZMYAhsBXx69n6bifRwv12NKpW3Ni9t8Sb/gzb0Ip+BPAuQI
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

The ISO sync timeout was previously set to 20 seconds,
which is too long for PA sync. This could leave the userspace
flow pending for an extended period of time.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 lib/bluetooth/bluetooth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7..572009e75 100644
--- a/lib/bluetooth/bluetooth.h
+++ b/lib/bluetooth/bluetooth.h
@@ -152,7 +152,7 @@ struct bt_voice {
 #define BT_ISO_QOS_BIG_UNSET	0xff
 #define BT_ISO_QOS_BIS_UNSET	0xff
 
-#define BT_ISO_SYNC_TIMEOUT	0x07d0 /* 20 secs */
+#define BT_ISO_SYNC_TIMEOUT	0x00c8 /* 2 secs */
 
 /* For an ISO Broadcaster, this value is used to compute
  * the desired Periodic Advertising Interval as a function

---
base-commit: a94f994201a69a36753abda65cc51937de9cd3e3
change-id: 20260112-iso_sync_timeout-8e3ecf43d82e

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


