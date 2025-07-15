Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A31E5018
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571706; cv=none; b=PhNUluuLWyLgE5dWInBQYjUpc0XgwDSTIqhd4tKhfxSgL2pNv2c582u8f2VPIIt/V7nn6/lomHOOZArVAk/bkShQkR90U1oH2MAwJY4Mjxt7uthh7YTXviyrd3D0t41MgjE5aKEArp5EWcUl9POQe8KHvHz/Av6ldrl5jW6UZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571706; c=relaxed/simple;
	bh=G0UPft5dIQLFYQN+FRXxj2ezVzZXTGT0e8XAqZRn7f4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cCjga5E3+E5wrgA2CKRFjGPhkbTq66Nq9g4iBvyXcWzseiM+dcoKPD0GjUdxDgfm54h1/FCs7tHQuJnPpUTS5vZOEcuxGZ2p0U88CKYjg4nLfmpuKOSf2uP+5uS2yj2Gb8ujxd1hdUPtLk8c05oG0q6q6/Jfl5J9f/CJZCDIgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD8PcZJr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD8PcZJr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1772C4CEE3;
	Tue, 15 Jul 2025 09:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752571706;
	bh=G0UPft5dIQLFYQN+FRXxj2ezVzZXTGT0e8XAqZRn7f4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=fD8PcZJrij86wcfSo/GBKojo2N/TLGzmMFf4OhBAJgOZkpnl0fBI5C+fhn4mpBaq/
	 rolPrcB+LJwQ+PWnctHtlbtizlCGfUTyMCHAVYzwCCAha1efDaDYBYZt6Mg5ZZtIRc
	 bzQmp3YweUMdJr4W0/9JM+mtjS5IeXEKQhUo2QVwKGq8TJR4mnBSW1CZGRc+fhJ47R
	 QR8fFQfnV0+C8qgAydchm43fko8RkkqT+1EPg3GHreL57mNoJQRuoWRxUUzluth4mS
	 rqh+SKrP5X/r5z15Gt5Ak2A7xSmXnQTQt/EDYzYajaegnb+BNt+IAXc+pCnNHdwSDx
	 E6NjOOK4yAh3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1623C83F1D;
	Tue, 15 Jul 2025 09:28:25 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Tue, 15 Jul 2025 17:28:20 +0800
Subject: [PATCH bluez v2] adapter: Fix RemoveDevice timeout when device
 already disconnected
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-adapter-rm-device-v2-1-f0ab3cc19391@amlogic.com>
X-B4-Tracking: v=1; b=H4sIADMfdmgC/32NTQ6CMBCFr0JmbU1nmiK68h6GRS0DTAKUtEhUw
 t1tOIDL9/e9DRJH4QS3YoPIqyQJUxZ0KsD3bupYSZM1kCarL0jKNW5eOKo4qib3PSsk59iWFsk
 i5N0cuZX3wXzAc3jxF+ps95KWED/H04pH+Ae6okJV6arUxhhsr3R34xA68WcfRqj3ff8Be2HnA
 rsAAAA=
X-Change-ID: 20250712-adapter-rm-device-12aae5651251
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752571703; l=1753;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=aRYY/vO2OoTvt8VDTw7QQrqM9HHCwW+KWQTERufvvx4=;
 b=3wcmnaUbnZSFcOVFDcuNyv8eJRU2h5ka+AAeuSVCj50G6diYzyf/RcoB9tXcUf1AI0/iylKbo
 Lf5KXX9lHg5A2HotbN0DLsxXj8sJcD6TePFF9+r7WytPQ1Y3Lc3mgPV
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: Ye He <ye.he@amlogic.com>

When attempting to use RemoveDevice to delete a BIS source device that
was synchronized by the BIS sink scan delegator, the kernel marks the
device as disconnected due to PA(period adv) sync termination. However, BlueZ is not
notified of this disconnection and still proceeds to send MGMT Disconnect
command. The kernel responds with MGMT_STATUS_DISCONNECTED, which BlueZ
does not currently handle as a successful case. As a result, the RemoveDevice
call never completes and no D-Bus reply is returned.

Fixes: https://github.com/bluez/bluez/issues/1421

Signed-off-by: Ye He <ye.he@amlogic.com>
---
This patch fix org.bluez.Adapter1.RemoveDevice method call timeout
when device already disconnected.
---
Changes in v2:
- EDITME: modify the title of commit message.
- Link to v1: https://patch.msgid.link/20250712-adapter-rm-device-v1-1-808603331f92@amlogic.com
---
 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 79802300bedf4b25cb7c6bc3ea659c122a01efcb..5d68fa4c7dea251af4ff3b05a1ad66204c847c37 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8619,7 +8619,8 @@ static void disconnect_complete(uint8_t status, uint16_t length,
 	const struct mgmt_rp_disconnect *rp = param;
 	struct btd_adapter *adapter = user_data;
 
-	if (status == MGMT_STATUS_NOT_CONNECTED) {
+	if (status == MGMT_STATUS_NOT_CONNECTED ||
+		status == MGMT_STATUS_DISCONNECTED) {
 		btd_warn(adapter->dev_id,
 				"Disconnecting failed: already disconnected");
 	} else if (status != MGMT_STATUS_SUCCESS) {

---
base-commit: 806dd732fcda584fa6c44322a74373d2b739c781
change-id: 20250712-adapter-rm-device-12aae5651251

Best regards,
-- 
Ye He <ye.he@amlogic.com>


