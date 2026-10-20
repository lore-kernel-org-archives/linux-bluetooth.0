Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.18.0.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502808;
	b=KTSWWC+wfAWccPx6Cm3LeO3gF908HpCFN3mRuApFefAQuV60gm8O6BsP/zf8s4HOc/w6
	 4vr47f89dzTQYmPqU28rR3/CCmVuWq2HGG/lPYTwmlqXG/bJ3MJtudkMoCkrfX+AQwbww
	 jeZ/bHehPM3/LcEVDmm/pDIGhYE0x9WUhqvKlcbfoQeK3luvHRzPEEmtqBLwzysRavgI2
	 X3JR5MTHii5FnM1+LWjSigmvBwzpHVhNQDXO/TZ9pCMoSmUIAk1kv9x6WM0FhtgN0hWrs
	 FtBrIRfEAdPq3MOs0yBNpyyMvnvJJUlO8103oXaGEW8wF9LLrPayeshW+VRBagpTt5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502808;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Virus-Scanned:Received:X-Auth-Info:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GdTiT1zqUh08frHkDgB93/kDjVVTubZPK4W1lRMqWhc=;
	b=pVzZfJPPQfoXX8NfoNPQ/WUyl+4JwdOu6gMaJVopCejYI1n0GA5N96a5tV7IQ0j7djlP
	 iuHunP+C8sqFoqPtSU9jEZk8Mo8Nsf9YHsfwcESRI2xrsli/pHZmgpqBBYtJg9tbFWe4U
	 tPwGqso47mWJf7jqK0LCoFzHT1nMiW/z4m+1h8pPjaEn9NxDym3cCXO9Q/pwKpUyhf2Tz
	 Xh1EaqddjfywC5nRaBlJuAfJTYAlE13dX1lOVGBku/+aDazTKGUoS+7EGeWqntCBRc3Pu
	 oQTSbcdleJ/ERgvA6ImZ/GE+R8xteEUN6jdaCaToyecKn+aqSyOCC43HQGLGUSVx3vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=muenchen-mail.de;
	spf=pass smtp.mailfrom=muenchen-mail.de;
	dkim=pass header.d=muenchen-mail.de header.i=@muenchen-mail.de header.a=rsa-sha256 header.s=r1 header.b=6SNc7g8Y;
	arc=none smtp.remote-ip=212.18.0.9
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7243E606A31D;
	Tue, 20 Oct 2026 13:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7243E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=muenchen-mail.de header.i=@muenchen-mail.de header.a=rsa-sha256 header.s=r1 header.b=6SNc7g8Y
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j8Cqd5dKnz1rB8C;
	Tue, 20 Oct 2026 15:26:37 +0200 (CEST)
DKIM-Signature: a=rsa-sha256; bh=GdTiT1zqUh08frHkDgB93/kDjVVTubZPK4W1lRMqWhc=;
        c=relaxed/relaxed; d=muenchen-mail.de;
        h=Date:From:To:Message-ID:Subject;
        s=r1; t=1792502797; v=1;
        b=6SNc7g8YKQW8B0TohZR7jo5AebywKGsa/INxfzSIKzPosB340Pv7c47xTbkDYgg7
         bqp8Tw9c/72sOkVAFqbfyYiRtNEcPgxicqFqWWG+hVxXgan2YJn/GAa9Lt1svh4/
         fB1m7cF7TRso67cZ7VRoEXdyUdLtfBeE86HC+6pIWh1zYQbC3UIc6Y1TqeqJnFLt
         BD8ObIwULVwZGLSG5sjuNYswcr7oRn1z0459JAa6xA3000NjBoymys8Eb7ze6W6+
         dfW+VqPYDGA80qU7J1bbTkeVOlwwSu7TO3esGWqf6i4yUpg8WC9vK44MRy0lJLlh
         YiocInrEg1HWT0qBIgCkKw==
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j8Cqb4LQ0z1rB7K;
	Tue, 20 Oct 2026 15:26:35 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4j8Cqb2pJxz1qqlR;
	Tue, 20 Oct 2026 15:26:35 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id 7LzTV1TIc3kf; Tue, 20 Oct 2026 15:26:33 +0200 (CEST)
X-Auth-Info: bowsSLLE8E7Ly/rhqS6TupuytPwKIElhWtMg/6gsRNpShmZ+y+aRBvGJ5yv4N1LX
Received: from wiesel.intern (aftr-62-216-206-189.dynamic.mnet-online.de [62.216.206.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 20 Oct 2026 15:26:33 +0200 (CEST)
Received: from murmel.intern (unknown [IPv6:fdea:9b79:8984:1:7b8d:a039:76a5:1596])
	by wiesel.intern (Postfix) with ESMTP id ED4C179A08EE;
	Tue, 20 Oct 2026 15:26:32 +0200 (CEST)
From: Thomas Gerner <thomas.gerner@muenchen-mail.de>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Thomas Gerner <thomas.gerner@muenchen-mail.de>
Subject: [PATCH v2 1/2] Bluetooth: btbcm: disable read tx power for BeagleV-Ahead
Date: Tue, 20 Oct 2026 15:26:03 +0200
Message-ID: <20261020132604.90708-2-thomas.gerner@muenchen-mail.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
References: <20261020132604.90708-1-thomas.gerner@muenchen-mail.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bluetooth module of the Ampak AP6203BM is identified by the btbcm
driver as BCM4362A2.

The firmware of the bluetooth module on the BeagleV-Ahead reports a
capability of reading LE tx power. However reading fails. To get
bluetooth working it is necessary to disable reading of LE tx power on
the BeagleV-Ahead board. The disable is implemented in a similar way as
for several Apple boards but uses the board compatible identification
from the DTB as there is no DMI.

Signed-off-by: Thomas Gerner <thomas.gerner@muenchen-mail.de>
---
No changes in v2

 drivers/bluetooth/btbcm.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 463d59890bef..2d02cc1863d0 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -436,6 +436,11 @@ static const struct dmi_system_id disable_broken_read_transmit_power[] = {
 	{ }
 };
 
+static const char *board_broken_read_transmit_power[] __maybe_unused = {
+	"beagle,beaglev-ahead",
+	NULL
+};
+
 static int btbcm_read_info(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
@@ -537,12 +542,13 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
  * This currently only looks up the device tree board appendix,
  * but can be expanded to other mechanisms.
  */
-static const char *btbcm_get_board_name(struct device *dev)
+static const char *btbcm_get_board_name(struct hci_dev *hdev)
 {
 #ifdef CONFIG_OF
 	struct device_node *root __free(device_node) = of_find_node_by_path("/");
 	char *board_type;
 	const char *tmp;
+	const char **s;
 
 	if (!root)
 		return NULL;
@@ -550,8 +556,15 @@ static const char *btbcm_get_board_name(struct device *dev)
 	if (of_property_read_string_index(root, "compatible", 0, &tmp))
 		return NULL;
 
+	/* disable broken Read LE Min/Max Tx Power on first board found in list */
+	for (s = board_broken_read_transmit_power; *s; s++)
+		if (!strcmp(tmp, *s)) {
+			hci_set_quirk(hdev, HCI_QUIRK_BROKEN_READ_TRANSMIT_POWER);
+			break;
+		}
+
 	/* get rid of any '/' in the compatible string */
-	board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+	board_type = devm_kstrdup(&hdev->dev, tmp, GFP_KERNEL);
 	if (!board_type)
 		return NULL;
 
@@ -577,7 +590,7 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done, bool use_autobaud
 	const struct firmware *fw;
 	int i, err;
 
-	board_name = btbcm_get_board_name(&hdev->dev);
+	board_name = btbcm_get_board_name(hdev);
 
 	/* Reset */
 	err = btbcm_reset(hdev);
-- 
2.53.0

