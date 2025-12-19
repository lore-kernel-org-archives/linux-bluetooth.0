Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237922AE45;
	Fri, 19 Dec 2025 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112197; cv=none; b=YeDCZvFcbB2kRWvPHrL10VMcXxlsUTmgbbGxjy9/zcFurRNVXuNaC02AqdmwArP+GAHA5VEQAO/u+yOkEKawsJQ/jRsiXmc9oTEleCghdWoyEFnhbJtUqVErB399EKDVsPRQ3hLqET+ytxtuzYj5hno9Ffq/BQsvhVBCgckq9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112197; c=relaxed/simple;
	bh=pSyHnDARnN/1VlftZQtTdU3xw+NYMbMs8ovfmOrQz6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tCRyDtmPnWDG87nkcorBBAACM9dCarAfNuqUUTUWvZPlCucMRV9dpBWZ1QDX9FzrfNuXXKYBGIHjK5A8YDYnr511iD+9INmtLyvYbCYcis4oijRRWFfI+GusVICl5n9Lw0OtYQ7JF9aK3WpZ1SKy8bVPGWo9jGyt7kEQeyHwg6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ib5axCiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ib5axCiO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 451ADC4CEFB;
	Fri, 19 Dec 2025 02:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766112197;
	bh=pSyHnDARnN/1VlftZQtTdU3xw+NYMbMs8ovfmOrQz6Y=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ib5axCiOz7vAo2snyEjdujaoN1KI1GX4hi/r+7ZNPY0TVuS+beqThhObBKjGYyRdj
	 2Ai09tHjEJTSE1o8a/crqcowZwf+WqdXA+AxPRdC4rMqCNClF6akJ0LS9G5grRoS7f
	 Hbd3qUbuiRHFt9knxVLGwBatRxsiO9CjwHMZMvW+2PSvM/vD1XAPEFV1x1+fXV5A6/
	 dZg0KTD5XxjVuCOQmijxEzht9fqRtUVf4Sm/aTVe2891vPaa8V5IxXxoMVkg5MC2d2
	 QQTmOblUGeFaVEElkBATlgpBqhbBG4kj9r3Hqfrv4KC/1EPPhKBnHfZZo/D/mz0Obv
	 NA1iJjS52WjBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32392D711D4;
	Fri, 19 Dec 2025 02:43:16 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 19 Dec 2025 10:43:09 +0800
Subject: [PATCH] Bluetooth: hci_sync: enable PA Sync Lost event
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-enable_pa_sync_lost_mask-v1-1-2769917f44e2@amlogic.com>
X-B4-Tracking: v=1; b=H4sIALy7RGkC/x3M0QpAQBBA0V/RPNuyK4lfkbbBLBOWdiSSf7d5P
 A/3PiAUmATq5IFAJwtvPkKnCfQT+pEUD9FgMlNooytFHruF7I5Wbt/bZZPDriizQspcV2pnKpd
 DzPdAjq9/3bTv+wG7aJ25agAAAA==
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766112194; l=1054;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=mCqnwsr5XyKCQ0CWzmE6bWicYgYAfb+tL3ko7n9wlUE=;
 b=iYSjVjzKtKXOsG1Ob0xTT9T561e6gq+W4bQ6pqyS8LJoh84P282BunWYMPj+Zu5NbGHh0Fl8o
 ZHkrfVHF3zfBYSdr+lBZa43PYmMrFuoIhanx4fnjN1c/lvlZCTwP5Q6
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Enable the PA Sync Lost event mask to ensure
PA sync loss is properly reported and handled.

Fixes 59e5396a2579 ("Bluetooth: hci_event: Fix not handling PA Sync Lost event")

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 net/bluetooth/hci_sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5de98be752bc..3f04510b806b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4420,6 +4420,7 @@ static int hci_le_set_event_mask_sync(struct hci_dev *hdev)
 	if (bis_capable(hdev)) {
 		events[1] |= 0x20;	/* LE PA Report */
 		events[1] |= 0x40;	/* LE PA Sync Established */
+		events[1] |= 0x80;	/* LE PA Sync Lost */
 		events[3] |= 0x04;	/* LE Create BIG Complete */
 		events[3] |= 0x08;	/* LE Terminate BIG Complete */
 		events[3] |= 0x10;	/* LE BIG Sync Established */

---
base-commit: 98246938a0e66e4100e95b6b7881843a9a4e4882
change-id: 20251219-enable_pa_sync_lost_mask-ae0fb71f29f3

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


