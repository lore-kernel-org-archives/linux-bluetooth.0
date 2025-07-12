Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10791DFD96
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Jul 2025 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312227; cv=none; b=qZbvj7+vrEjtirGmybpt5nKtRvuG7sK0UbfVJT823ZNbmUCPqrPavGVwEqL11LNzWckhmXedC9btjRzywxP0IZPbp1LvcPgGiOJhqGE+VfsecdiEzU09XsZITAdvZ2O/8Xsez8jvxvlM8n60OVdH0bom+eLgTaDTk9j1RJpcIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312227; c=relaxed/simple;
	bh=/5iL7YuIub1w0lJ4x9gVyIkWyrzYJsMfdZb0LpjPDkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ent/sIFtTtf1l1xFcgDDzSY2nVwI0uw5XOgf02UyF2CvqO1ZeeBqmCy8X0l1Tjd0IRdWpFMiJLiAaHbK0NjcfuYgu+sspFuBLq5LQL5dORfBNBl1jdV7y693moXtnxm9P7QdoauVstn3awSThfK3GZfYwzy9ideNFPkiC9/DCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onth3qXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onth3qXj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63BCAC4CEEF;
	Sat, 12 Jul 2025 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752312226;
	bh=/5iL7YuIub1w0lJ4x9gVyIkWyrzYJsMfdZb0LpjPDkE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=onth3qXj4tX0sKcTW6uTVbhqGclUCmr0fNfvBhfJsmGFKVYoMGUwWHt4nyXLa+wfT
	 po2t/WLk5YdeZ9Hk2YC0Fbv18tM0RKwgD9458Kkx4bkXPHZEPLLyKEfliWoMo2HAWb
	 TjZ/l4LGmuf0z1KWCSu6GadzAx16r8PvVUkXkYcYMp7G3PuPBYlEUU/04Vnd/xuaNP
	 SfDY9QUdXlPHXfbX3AB1hXVA+lrgDdqvGeJw/CoSkxjRCOHDK5EDeU22KC2gzW7INd
	 vccdBDuYmKyYGf9+d/cWjcC1ZDykCcvAIWDQfvOluBs9NTwQus0+pGUn/+vGDBevnO
	 pWqiE0g383GfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5313DC83F21;
	Sat, 12 Jul 2025 09:23:46 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Sat, 12 Jul 2025 17:23:42 +0800
Subject: [PATCH bluez] src/adapter: Fix RemoveDevice timeout when device
 already disconnected
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250712-adapter-rm-device-v1-1-808603331f92@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAJ0pcmgC/x2MwQrCQAwFf6XkbKAJrIK/UjzE7qsGbC1ZLWLpv
 3fpcWBmVioIR6Frs1Jg8eLvqYKcGuqfNj3AniuTtpraiyhbtvmD4Bg5V78Hi5ohnZNoEqrdHBj
 8dzw7ur+++NNt23bErRXXagAAAA==
X-Change-ID: 20250712-adapter-rm-device-12aae5651251
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752312224; l=1576;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=DARVIHJtGfNwayJXs1VwNVtAfrL1/3+G/NK64yrR1eo=;
 b=8cOsQ+c0aVHpyDp/4ySaNDXnI3/7X/KIIz5KvpSSAK2v2HywmteDz2wZTy9WDEux9qNs9Kin6
 +MFwjRIITV7BPpZqZGQ43ciEhg5X1wPVgLbZ42xQOvLb6zDJliO5o8A
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: Ye He <ye.he@amlogic.com>

When attempting to use RemoveDevice to delete a BIS source device that
was synchronized by the BIS sink scan delegator, the kernel marks the
device as disconnected due to PA sync termination. However, BlueZ is not
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


