Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCA23B5DE9;
	Sun, 11 Oct 2026 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726497; cv=none; b=g1WX6lzguPpkCeNOdYdpwFGpMiaW3G5dYNiwXwJyxXufVdowTB7VDCyVadWzwcxutZFgxD4/vNdXiKzAUfGQNmsLv1Vjj8cuXBUCX+eU0OG0gvDWRVtoq5ahKBf3LuvVK2+HL9PErvzyLe+PRMwnVSaj74z2UYSubYCy5vSzbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726497; c=relaxed/simple;
	bh=6+N7J6t2yLEWtzAtDeUfrbKdYFzLj0LDNvuZilpOE+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkfDJvZVZ4D/iMdgC6WnPmQ3q1mq0OQWbVwi8hpiV4tmS3sEBeda85gFtBkruX4iwnGrY4XHCpeYPfK38oFCZdyktfGJIrV9HeU081G0GiL6xfq5z6R42dCq9oHfZWI92hMMYNFOf3w5EeHm4V8uj95xyUJ5WqnomZJt/4K7vzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muenchen-mail.de; spf=pass smtp.mailfrom=muenchen-mail.de; dkim=pass (2048-bit key) header.d=muenchen-mail.de header.i=@muenchen-mail.de header.b=hxJA5Ia/; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muenchen-mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=muenchen-mail.de header.i=@muenchen-mail.de header.b="hxJA5Ia/"
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j2hX94YV1z1sRL5;
	Sun, 11 Oct 2026 15:39:05 +0200 (CEST)
DKIM-Signature: a=rsa-sha256; bh=gctCJrJ7Kds3CcZcJwy4+R3P44nlumx62CuaYhKhBXA=;
        c=relaxed/relaxed; d=muenchen-mail.de;
        h=Date:From:To:Message-ID:Subject;
        s=r1; t=1791725945; v=1;
        b=hxJA5Ia/WCT0qT3mkgZX6yahUx1R0mBqLPfnDK7n0/SqTnX6/p4Cj4rqutOkXURC
         c+7GbvhjmrBTa/I3XXltN42CNR1rV22LBUFn/PJ5nWLzM2n/myM79DumIS86Wtmh
         cE6Z9AYIsiVEl3p7FT/vMg/2+tAPfMs9aMOXL2/9TyHTWj668u2Ab7iuQ3FMBEf2
         kCvxDXHxwxCxyZFzVb8kvf0Fz2C+mLDJ8fj0VxoVrZixcOaSG0Ag31d9stLkH9Y8
         Qu4sVStqg1Wt7sY/qjBed3H0fLmLouFweUVCxswqW7GP+Lkby1GFvsLsTJ+o4ole
         EGguTPG5gV2AYXA3vjBAyg==
Received: from frontend03.mail.m-online.net (unknown [192.168.6.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4j2hX80GpLz1sR8M;
	Sun, 11 Oct 2026 15:39:03 +0200 (CEST)
Received: from localhost (dynscan3.mnet-online.de [192.168.6.87])
	by mail.m-online.net (Postfix) with ESMTP id 4j2hX74SX8z1qqlR;
	Sun, 11 Oct 2026 15:39:03 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.6.182])
 by localhost (dynscan3.mail.m-online.net [192.168.6.87]) (amavis, port 10024)
 with ESMTP id aaz3n9_3Nu0C; Sun, 11 Oct 2026 15:39:01 +0200 (CEST)
X-Auth-Info: RWtFOPa2WPAAcoNvORZRjrjvz3yyE/RdyuxRfNfJkBn6yqWRhEJ0wED3jO+mdFff
Received: from wiesel.intern (aftr-62-216-206-149.dynamic.mnet-online.de [62.216.206.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sun, 11 Oct 2026 15:39:01 +0200 (CEST)
Received: from murmel.intern (unknown [IPv6:fdea:9b79:8984:1:c2df:628d:efc1:8817])
	by wiesel.intern (Postfix) with ESMTP id BE9AB79A081C;
	Sun, 11 Oct 2026 15:39:00 +0200 (CEST)
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
Subject: [PATCH 2/2] Bluetooth: btbcm: disable read tx power for BeagleV-Ahead
Date: Sun, 11 Oct 2026 15:37:58 +0200
Message-ID: <578087018e274b0dcf25a523adc0d5cc590cceee.1791720467.git.thomas.gerner@muenchen-mail.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791720467.git.thomas.gerner@muenchen-mail.de>
References: <cover.1791720467.git.thomas.gerner@muenchen-mail.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
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

