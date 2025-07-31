Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC129DB9B;
	Thu, 31 Jul 2025 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948802; cv=none; b=ZZS6vcthUxyXpHOfc6hIOfPcgnVR7GgCkLJmiII2Rj1Dtwtt0XsEdMaDaaPZvRhEzG+XAvTb3G/WuN9TBR6UwXPiS56euJXcitesruhXEBtReG8o9PtAbI4jzeB6Zm/uk4a9f32i4cu8T/G6VP7nPaeJO5XKYKIhfYwMC9dv8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948802; c=relaxed/simple;
	bh=G3VPbg8FPJGVzdEGzREC8clwgNRzGtUEk5FGgYrZMeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TNGtGML6sjwPfbEvXUe5HmjbZKBZvyXOMhKPH/ZQybBfasrI2nmvBi1RCZcG9lCTScuHpIbVRxcyYpvuhf9sOoaWjWRZxYnWyU7CCHc8U8ZpcuFhsHCkxcg6bRbNt5X03LwfmNxTBYVKGCmJqOK+0nVNIzv6HFi6ELLDdssagAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAUtDke7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAUtDke7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29728C4CEEF;
	Thu, 31 Jul 2025 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753948802;
	bh=G3VPbg8FPJGVzdEGzREC8clwgNRzGtUEk5FGgYrZMeQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oAUtDke7Qor+Zn8v5/ySJO6Hpi//p2dlVkeqkx5Y52L9JNB6TseqOKSbLPuxdqLtY
	 nPToMQa53G0xMCGUSXdntVsYKDlJEBEqTzn4fnjXjpvRCTJTApGfRZ3DuXeqXsZebd
	 mrJ1K1sM/eN4rqHq7F4jUjcQ4kZrsS2/N4/1H3KtRwt/0zeCyFfR4gl5vxRzG68nsj
	 0mlcvGGClCj9X2/NrnOMZYeobpipdAGwTgZ3kEq2KlWpir406k+gtvQpFaU+PKzMJd
	 wXhVq74pbwBNmPld5saK0K5ZC/zFonRh7OdcZf2BEsHPVTJwgW11DPzo2hev9GGBQS
	 Bd+BXJWWp924Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D4C87FCC;
	Thu, 31 Jul 2025 08:00:02 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 31 Jul 2025 15:59:48 +0800
Subject: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAHMii2gC/0XMywrCMBCF4Vcps3YkV2Jd+R4ikibTdsA2kpRSK
 H13oxsXZ/Etzr9DocxU4NrskGnlwmmu0KcGwujngZBjNSihrHBaYsflGb5LtHFZ0EnnjVHRBqO
 gvt6Zet5+xfujus9pwmXM5P8dK1rkknBVKDF6q7soL0G2+uanVxo4nEOa4Dg+siMdaZ4AAAA=
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753948799; l=2024;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=+Emn1CseXuQvh2qlK9A1nweKtqNCFRhwr83xHhi4y1I=;
 b=YjKHMd0TaKuzpNAD7T0TbF4kgTx5P7oXIlhOZ6UqkTzFLqUilmcEyvVlUHgc9kBxisD+wBqGe
 881mMK2N52RDLiB3litZzn+2cUo3+SEEakmVlJtyBFvHdMlWWWbkDwp
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

When both BIS and CIS links exist, their sockets are in
the BT_LISTEN state.
dump sock:
  sk 000000001977ef51 state 6
  src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
  sk 0000000031d28700 state 7
  src 10:a5:62:31:05:cf dst00:00:00:00:00:00
  sk 00000000613af00e state 4   # listen sock of bis
  src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
  sk 000000001710468c state 9
  src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
  sk 000000005d97dfde state 4   #listen sock of cis
  src 10:a5:62:31:05:cf dst 00:00:00:00:00:00

To locate the CIS socket correctly, check both the BT_LISTEN
state and whether dst addr is BDADDR_ANY.

Link: https://github.com/bluez/bluez/issues/1224

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 net/bluetooth/iso.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index eaffd25570e3..9a4dea03af8c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
 	return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
 }
 
+static bool iso_match_dst(struct sock *sk, void *data)
+{
+	return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
+}
+
 static void iso_conn_ready(struct iso_conn *conn)
 {
 	struct sock *parent = NULL;
@@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		if (!parent)
 			parent = iso_get_sock(&hcon->src, BDADDR_ANY,
-					      BT_LISTEN, NULL, NULL);
+					      BT_LISTEN, iso_match_dst, BDADDR_ANY);
 
 		if (!parent)
 			return;
@@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		}
 	} else {
 		sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
-				  BT_LISTEN, NULL, NULL);
+				  BT_LISTEN, iso_match_dst, BDADDR_ANY);
 	}
 
 done:

---
base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
change-id: 20250731-bis_cis_coexist-717a442d5c42

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


