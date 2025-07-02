Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D34AD51;
	Wed,  2 Jul 2025 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425941; cv=none; b=pdJtZeNKgEipa3U4C3AA36o4fhyXppwgESVEg5I3b26H9MU5YFZAT9IPhrzdj9fKyuuVg4s1sIWvycBDFcI0WLauDZ5epWCb8nfBl7ICIGfKMbHSEkNOlKH+8bC9eaFVvlsL6j1hur7c5232Imlxb7401/A4fzIFUrtRSn4qC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425941; c=relaxed/simple;
	bh=qVZrCfXUOLvZ91iYV94x6z3FWKL+0s92wJdsIAMgA6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QatsmyU7DyQmOUGuW6JWqn7ak26b5I7/XhQTrVE0j8cbl6XsWe6HNTeGarfGGGhtz1k9LjI39z4XnjDAQPxcQBYw236lhNgMrV38iYBC/E5lNjtV3Oh2egWK1pORzGwlg1BVC1re923MozA2Fp8XDivY76A8FgZ5weB52q2+rZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRHP+aIP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRHP+aIP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C375C4CEF0;
	Wed,  2 Jul 2025 03:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425941;
	bh=qVZrCfXUOLvZ91iYV94x6z3FWKL+0s92wJdsIAMgA6Y=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CRHP+aIPYoKUK2nn4RswuiuE6F9sPBa0M6D55mw9A6jhiSbE3Jwbq0wEQGd75DKRQ
	 GXNCdL0GmqIO4ySWl7MfYmH7wRW0bLYiKNJXtGlUYwM7m2/7vSvCTe+1pcCWaxAEfQ
	 rT0QVse2W19H+nz4v9jB17PnlY1A2e7U4WwEseC1CHR+IRCchp9ed68xGNCwh40Kk3
	 7klaXSzUjUL2/2cl4Y+zbDytbLKHQUURnpIKqOxcFGEDYipcaKpEEUThFfm+g+RG3V
	 5trrJQm2Ow7PYArfDkll/a2qSBUdHK5mCEaaMFkMf9KzQuY0JXxvhTat+mU2gjbj57
	 M0rv4q/Kie5UA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADDEC83038;
	Wed,  2 Jul 2025 03:12:20 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Wed, 02 Jul 2025 11:12:12 +0800
Subject: [PATCH] Bluetooth: hci_event: Hold PA sync conn when BIG sync
 established
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-hold_pa_sync-v1-1-3cbdd2c29c41@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAIujZGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwMj3Yz8nJT4gsT44sq8ZF1Lw+RE80QLw8SUNAMloJaCotS0zAqwcdG
 xtbUAEHq1GF4AAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751425939; l=881;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=V8m462H5RbM/oJyz7gwSJlctSKUTcMZaUXIOO+asIqY=;
 b=riJZDjp3zgUR2fA0G+8xAl/LyGaVa3g9bI9F8QneD/Ww/NxnKDpw+LBf30rOisdEUp0vP+ZtP
 rdPSLdxZP/1CZR60+ROi7n4bxzniCxzLFsS7vO24Tbt9Z8qR53sXttI
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Hold PA sync connection to prevent cleanup during hci_conn_timeout.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e817c4a77f97..85ae1608e028 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6968,6 +6968,9 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 		if (!ev->status) {
 			conn->state = BT_CONNECTED;
+			/* Prevent cleanup in hci_conn_timeout. */
+			hci_conn_hold(conn);
+
 			set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
 			hci_debugfs_create_conn(conn);
 			hci_conn_add_sysfs(conn);

---
base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
change-id: 20250702-hold_pa_sync-91ca7a81adf0

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


