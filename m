Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4820DD7A
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559932; cv=none; b=NrBarCYw7vLZd3Z6PFdk46y4TKy0zQ6/tCMaDtZfzn1DGCH5/3CTJdFAS6FLP958TxtPq06J/OWfOvLzZ+Sk6rafQGsITZu/fdUeLIv9O5d8P7wuJds1jB3wln4jq+wCOLviqFNg+DF3zH90DINHUOCakTMIt95KbRyoXvfAR2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559932; c=relaxed/simple;
	bh=bUZCiqZ0CyAGsoOTWzX462nTv/Oe0ormMhuDjAGpoUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iPTF7z27i5NhzPae8zeqCZLm0QcqnbVU1Ns1xy130JnVwwtQAg1cNCnChL1pg/g0yEU32PiSjdvM7RUJrkSFREry9+4rTB58oCKbJElDC5jMOmV42f2WpY8MQOxOvFFy9Ri68Yppj7C8JhwVRWlslm6UTrgVLDfgsGlBsthS7EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9BhG62v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9BhG62v"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBC92C4CEE2;
	Wed, 26 Feb 2025 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559931;
	bh=bUZCiqZ0CyAGsoOTWzX462nTv/Oe0ormMhuDjAGpoUc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=e9BhG62vC7Ir74Ie8joD4rYxpQ8gS3kW7jb/AmoWbIO53WC4H5kDuvFIPsvdkJq+w
	 HBFFa64clErfnIQ55XXQk9bjIf887Nk9Ae3Cdn1c9YnS+FSzDztOqXcTMQQgj8Rg8n
	 JjV/oq9UPpJlHcb2ZPO+vF4Tv7A9oMCvVCCxwwN0tgSeWECsD/oHh/B+rBqG5oZQrN
	 /ZMjkeKJAOuOYa5SNKH+nyvucRrIGjSZ4/dFPA0Qet5+vEtvQhT1J0AYpyhaZaQthg
	 z4vQ97tsl9vezXhztq36fBvrPnlwRe4FE2r9mm+P2/myrxblgRfxFmEJzVrLtw0LNv
	 DlzNo9TQ4/zMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CDEC021BC;
	Wed, 26 Feb 2025 08:52:11 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Wed, 26 Feb 2025 16:52:04 +0800
Subject: [PATCH bluez v3] adapter: Prepend the new added device to the
 adapter devices list
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-leaudio-no-media-v3-1-8f4f93d8a41c@amlogic.com>
X-B4-Tracking: v=1; b=H4sIADPWvmcC/3XNTQ6CMBAF4KuQrq0p/RNdeQ/jojIjTALUtNKoh
 LvbdKWJLt+8zPcWFjEQRnaoFhYwUSQ/5aA2FWt7N3XICXJmUkgjpDR8QDcDeT55PiKQ41ZpLZV
 oLDrN8tst4JUehTyxyzDji53zuad49+FZhlJdyv9mqnnNLbi9NlrYHaijGwffUbtt/Vi4JD8J+
 4OQmWhAA+yNqRXCN7Gu6xtUWbFG/AAAAA==
X-Change-ID: 20250225-leaudio-no-media-634423086ea4
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740559930; l=1599;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=Nuf1CvQabIs9yKgJqweRrUF/2ubCUXHMsHfltvvLKIs=;
 b=A8967SN4t2yyJZcSFzrzprbre7zqk/4Dwrml74o9natOTETtZo18RrM2xJJ1pTclyyYKz0oIG
 6L//dE6m5ubDakLXJ59eH/+LX7iC4/58q0p1C+dseRCswI1db58qzoY
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: Ye He <ye.he@amlogic.com>

When the DUT is paired with a mobile phone using RPA multiple times,
multiple device contexts with the same bdaddr will be cached.
When we query the device context through bdaddr, we always get the
context at the head of adapter->devices, but its status is inactive.

https://github.com/bluez/bluez/issues/1095

Signed-off-by: Ye He <ye.he@amlogic.com>
---
Changes in v3:
- EDITME: Correct the formatting errors of author and SOB.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://patch.msgid.link/20250226-leaudio-no-media-v2-1-8d4dd95513ed@amlogic.com

Changes in v2:
- EDITME: Correct the formatting errors of author and SOB.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20250225-leaudio-no-media-v1-1-6da9454067d3@amlogic.com
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index cbe5b197963a7e07a50f74a697ad3d35f9bc3786..c0d647efdde0d9eab2e27c360c0bfb9fbadeb7ef 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5252,7 +5252,7 @@ void device_resolved_drivers(struct btd_adapter *adapter,
 static void adapter_add_device(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
-	adapter->devices = g_slist_append(adapter->devices, device);
+	adapter->devices = g_slist_prepend(adapter->devices, device);
 	device_added_drivers(adapter, device);
 }
 

---
base-commit: 4465c577778d812702d752dfd2812e25a2f69b31
change-id: 20250225-leaudio-no-media-634423086ea4

Best regards,
-- 
Ye He <ye.he@amlogic.com>


