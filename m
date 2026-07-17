Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB5330B15;
	Fri, 17 Jul 2026 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324468; cv=none; b=jt/NN9R0wcrjAJf+ygm6ujTgawIZeiuDet5+k9KnClf+9YjhCynUq8F0Df0lCW5X50y0HtUnIEZd37573Jg7FUT3q8Qbj8qhwXkQWEE+giIUr/utpg8bMAjaP3AJFLwfO7rnl1hv0SPJ9mfqlxweW2A/E9WO/MoQJA3knjRcdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324468; c=relaxed/simple;
	bh=TfcFfDZDrk0DqAZBBL4h6OR44UPkg7B0FARbEJfC+KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fv5QOCSMUBAAuGqkFCzTQtgJxJOXfT2Hm/7zUkPv7mKQDjkh2FG16Sr+LGeGyvtcfJh87k2uB+vgJm/OP0Fua3Z55KWLJu8Oxb4xcaNG0o3FxLHUSgurYOKoKo7dZGD5RoKvux/Kyc94SCtfb7MrcBcwlRQoV695SniI3YUAIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYwCB98a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYwCB98a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDE0AC2BCB8;
	Fri, 17 Jul 2026 21:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784324467;
	bh=TfcFfDZDrk0DqAZBBL4h6OR44UPkg7B0FARbEJfC+KQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=EYwCB98aVTiVZMtY3yzs4gbUgmdaUvF/xrjngTjdM2VaaThrIT1JYUyrk1zCf9P1a
	 W4OhBTafs06BelN4tPZGparu2qipnJpSZvrdvDfzZyeaGqah6ilinc0Ll5/RKKAEpn
	 ahhDBvASuDAm9mFRdC5FbU3gOFQVzBg5htlI/P3ydNlQ+jV6q45MsKorahiYM+mM6g
	 PfeEO7Qmsmnx/AFeV3/mx4IUI0CCXr2WrZJu2cqXfQovM3/NC4L5N6n3Bz6k8eanbx
	 X236a5CoanJJPEuJIC4KnwnvXJqIma/qLghjeQ5CUwJ0fyA03Tq/+TyhtWrBx2wufd
	 0R8pNFx+3JnpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE81C44516;
	Fri, 17 Jul 2026 21:41:07 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 17 Jul 2026 16:40:52 -0500
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM4356A3 UART bluetooth
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Nz3aTkXBNjU7NEY92kEt3kFHOL5GSDNBOjVAsloJaCotS0zAqwcdG
 xtbUAdlmMQ14AAAA=
X-Change-ID: 20260717-bcm4356a3-bt-cd78cc0f42e8
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784324467; l=1010;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=bQ6WFjUIqP2rPELTYAWoRuAn5MAUJ18Jq8ZRipAGP0w=;
 b=EaKI+21I/MInPDJoJM2xSBNHH120R+oL6EOtq3kiw4DSt5n2L23U6dINaPR/HLzooQOSUMauH
 pPKh+txgygWBGOyK/KeNrHsLKC3Oq9UIRL/zjbDeCuIslWXR/Z32DUK
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This patch adds the device ID for the bluetooth chip used in the
Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 463d59890befe..14acea7325478 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -506,6 +506,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x6606, "BCM4345C5"	},	/* 003.006.006 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
 	{ 0x2310, "BCM4343A2"	},	/* 001.003.016 */
+	{ 0x2409, "BCM4356A3"	},	/* 001.004.009 */
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ 0x420d, "BCM4349B1"	},	/* 002.002.013 */
 	{ 0x420e, "BCM4349B1"	},	/* 002.002.014 */

---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


