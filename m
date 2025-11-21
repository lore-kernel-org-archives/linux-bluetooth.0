Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851912727ED
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716587; cv=none; b=EhgUsBwIpm5u9e+mVATYs3v73oy6NukHOhjHNA5dYmuPVLrlWPCYScxwCaY0uUzmRdLc5SA5TCnR9OoiBP3ntHlxbDuKnYd6NUPGFFSzCSDGPtf+3/Bt6eV3/eNh5YKwY9PUDhiyHSGLntdWPN299+b2UOpYdLJtmppeHTTNJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716587; c=relaxed/simple;
	bh=Es0w/ZRgGkmB/qYVp3Eg3fG5AGUiNHqaji5pzenqlx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MuDbbL45zGzBCO3lgQWis8iqlpaGV0lQ7Psv4elMwUYHp+AD2mVHtVIdY48GjuZ+3hUo0tZDi2q9Z7rDodbXhEa1EAU+rVxbdXJI6yNdNHEjXld+cXdZA0QiZTxbJoNnDGORdp0k9SKyg24yOl1hpDs1VeyVPm3auVgZV5XZkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItWcodJF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItWcodJF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 061D7C4CEF1;
	Fri, 21 Nov 2025 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763716587;
	bh=Es0w/ZRgGkmB/qYVp3Eg3fG5AGUiNHqaji5pzenqlx8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ItWcodJFahh2TmmaX+wnraUIqPumpsYmBju3ym7ZVp1apcpKrGZDYc6f8KnwbEq68
	 ditY1UMfe35/LzXgP/14vdi5omIXpROsyITlH+23qWmR5Ne7RSpFQf66q9uOVpnaZW
	 hdF+yAKEwAo6U9CHzo5r5odEjlnbg8TvBRP+fCHNO19/gShzFPI1eunyinqn7xwMIi
	 X/MqoE1/pCBgIoZjDw4609Mw7FAaBsN97+VwNZzwzrh5YFCnC2jeWt7OwCQvvhK6xE
	 3k4IRWnHoZIsLRAOC+GdKctQ+2cxIRZvzeqLOHL13gANqZAwJvbOQ/h9qYpIDga392
	 wMP7WhksJ7MNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9284CFA756;
	Fri, 21 Nov 2025 09:16:26 +0000 (UTC)
From: Ye He via B4 Relay <devnull+ye.he.amlogic.com@kernel.org>
Date: Fri, 21 Nov 2025 17:16:25 +0800
Subject: [PATCH bluez] client: Fix issue of bearer info not printing
 correctly
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-bearer-info-v1-1-f38dc0cbbbd0@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAOgtIGkC/x3MMQqAMAxA0atIZgtNQEGvIg5VUw1IKymKWLy7x
 fEN/2dIrMIJ+iqD8iVJYijAuoJ5c2FlI0sxkKUGkdBM7JTVSPDRdLZD74hma1soxaHs5f5vA0z
 7yQ+M7/sBIxx282QAAAA=
X-Change-ID: 20251121-bearer-info-9091fa22c006
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Ye He <ye.he@amlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763716585; l=1718;
 i=ye.he@amlogic.com; s=20250225; h=from:subject:message-id;
 bh=9ong/20pvfFl6Qwp1TJerRk2TanoS/FERDslnNWs9xM=;
 b=gZQByx5XNCEufcS5iKTZRA289I9hfwG9//zUwNbohuEZofXtyXsQ5TF+wb7zGdapo9knRgyRj
 YOlMcxJRhvHDA6JuW23mEAR41X4bPczpzSJ3o5DdCKMaBCgr+G6fNeQ
X-Developer-Key: i=ye.he@amlogic.com; a=ed25519;
 pk=hiK/p0mkXYSkX8Ooa496DfgjnbtdcyXSPFwK2LN49CE=
X-Endpoint-Received: by B4 Relay for ye.he@amlogic.com/20250225 with
 auth_id=348
X-Original-From: Ye He <ye.he@amlogic.com>
Reply-To: ye.he@amlogic.com

From: Ye He <ye.he@amlogic.com>

The device proxy was incorrectly used when printing
bearer properties.

Signed-off-by: Ye He <ye.he@amlogic.com>
---
 client/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/client/main.c b/client/main.c
index 0a928efaa9bb0d2a806895ff8f8c0c7c0d2493bd..a3a46ca267b09fe54c2f3cfb723f3e72d03f699e 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1894,9 +1894,9 @@ static void cmd_info(int argc, char *argv[])
 				      g_dbus_proxy_get_path(proxy),
 				      "org.bluez.Bearer.BREDR1");
 	if (bearer) {
-		print_property_with_label(proxy, "Paired", "BREDR.Paired");
-		print_property_with_label(proxy, "Bonded", "BREDR.Bonded");
-		print_property_with_label(proxy, "Connected",
+		print_property_with_label(bearer, "Paired", "BREDR.Paired");
+		print_property_with_label(bearer, "Bonded", "BREDR.Bonded");
+		print_property_with_label(bearer, "Connected",
 							"BREDR.Connected");
 	}
 
@@ -1904,9 +1904,9 @@ static void cmd_info(int argc, char *argv[])
 				      g_dbus_proxy_get_path(proxy),
 				      "org.bluez.Bearer.LE1");
 	if (bearer) {
-		print_property_with_label(proxy, "Paired", "LE.Paired");
-		print_property_with_label(proxy, "Bonded", "LE.Bonded");
-		print_property_with_label(proxy, "Connected", "LE.Connected");
+		print_property_with_label(bearer, "Paired", "LE.Paired");
+		print_property_with_label(bearer, "Bonded", "LE.Bonded");
+		print_property_with_label(bearer, "Connected", "LE.Connected");
 	}
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);

---
base-commit: 8a41ac3fde997137d374791a93a49d9a3abac0e0
change-id: 20251121-bearer-info-9091fa22c006

Best regards,
-- 
Ye He <ye.he@amlogic.com>


