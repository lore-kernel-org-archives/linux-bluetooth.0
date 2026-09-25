Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83B395AD5;
	Fri, 25 Sep 2026 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790319185; cv=none; b=f+6Rdcy3Wxx7A/SbitC9bBUV6Xb7T8htASWftUVAGKZCadAZl2vPWiprOmL/L24peIy0yNR635TBAze/zYhh/GAxTAZe6Zjs4BMAUSMPT9uETO2vcq91RctqvLRzDwfHAeoU/m6qqYTcd4hHUSw6oVn13uLy+iaJR4p8PUXj4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790319185; c=relaxed/simple;
	bh=tP6AL9NAD9Ousxk21NIRHD539PB1usyQzleE9kn8HO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zw6A53U3fJek4Dtf9i6i7YEI5VnYq0UYZ9Docw1XtycUKBfazQ95eSUhVPivN9C3h2MzaetBc0iIyh4RCOtIwSK4ITs/n6+kauvlxxGetAp0vgkgonWZLEQwtWDjOAgKffEhivCequzRmi5nQjPDggpA568UxtwUsry7/i1Yjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYnPRp9s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYnPRp9s"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25AD4C2BCB8;
	Fri, 25 Sep 2026 06:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790319185;
	bh=tP6AL9NAD9Ousxk21NIRHD539PB1usyQzleE9kn8HO8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VYnPRp9svN2XG55lnhro2amywmuMeGRMRxgr6gv7PNLt1Jaj0Ayj4qy7PvfpgAO4v
	 jXGZo9Sye0oqWVGrbDeofkFS6TSHzXxt44T2jPliDiUDYzbXU626iu8IJc/kKl4ukR
	 A2gwJOsJRhkgQBzrCOLTyaaTBT9zF5cc3qIXwt7bYwRDzKg/72dyJ6NxuFRL1wDeDK
	 jPCIldcfh2vr6DGWPW3OnAfML/GxXEgWjLNB0Fk3AqropxI9itabFoD1FZDACFcQjW
	 cjXqIlT4v6JOTJezr29PNeKVSJTuy9zZhHpC5Mrb6kKytIJ2WInqgTcZKrEt85MyMi
	 6b+i/sHPZ8J/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BEFC9830E;
	Fri, 25 Sep 2026 06:53:05 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 25 Sep 2026 01:52:50 -0500
Subject: [PATCH v2] Bluetooth: btbcm: Add entry for BCM4356A3 UART
 bluetooth
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-bcm4356a3-bt-v2-1-42098aca235b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XMSwrDIBSF4a2EO67FR6Kho+6jZGB8JBdqLBqkJ
 bj32sw7/A+c74DsEroMt+6A5ApmjFsLfunArHpbHEHbGjjlkiqmyGxCLwapBZl3YqwajaG+526
 Ednkl5/F9co+p9Yp5j+lz6oX91j9QYYQR7zW3AxdCSHpfgsbn1cQAU631C4lyC7aoAAAA
X-Change-ID: 20260717-bcm4356a3-bt-cd78cc0f42e8
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790319184; l=1578;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=AD/eIUQbbqFcpJLnIHNzJvShs6PAafOnSxMSfdwR5aY=;
 b=hvB9VnfWyCfk/orBFrRCxM7ya3Prs06AZUE6g+o4iJ9UT+/QQ5vydsb3zumvsc7KNQhCG/lEZ
 rlBMHG/mB3GBinuH8/l/nFTEppldRBTlQzdwUNHmNfR4xec4AvesYvt
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This patch adds the device ID for the bluetooth chip used in the
Nvidia specific Broadcom BCM4356 PCI-E WiFi / UART BT chip.

Startup log:

  Bluetooth: hci0: BCM: chip id 122
  Bluetooth: hci0: BCM: features 0x0f
  Bluetooth: hci0: BCM4356A3
  Bluetooth: hci0: BCM4356A3 (001.004.009) build 0000
  Bluetooth: hci0: BCM4356A3 'brcm/BCM4356A3.nvidia,p2894-2551-b00.hcd' Patch
  Bluetooth: hci0: BCM: features 0x0f
  Bluetooth: hci0: BCM4356A3 37.4MHz Class 1.5 Nvidia mDarcy-0108
  Bluetooth: hci0: BCM4356A3 (001.004.009) build 0109

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Add startup log to commit message
- Link to v1: https://lore.kernel.org/r/20260717-bcm4356a3-bt-v1-1-ffa2d5233360@gmail.com
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 63c4c788d9c48..065536d4ec762 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -508,6 +508,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x6606, "BCM4345C5"	},	/* 003.006.006 */
 	{ 0x230f, "BCM4356A2"	},	/* 001.003.015 */
 	{ 0x2310, "BCM4343A2"	},	/* 001.003.016 */
+	{ 0x2409, "BCM4356A3"	},	/* 001.004.009 */
 	{ 0x220e, "BCM20702A1"  },	/* 001.002.014 */
 	{ 0x420d, "BCM4349B1"	},	/* 002.002.013 */
 	{ 0x420e, "BCM4349B1"	},	/* 002.002.014 */

---
base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
change-id: 20260717-bcm4356a3-bt-cd78cc0f42e8

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


