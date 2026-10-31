Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793448997;
	b=aPSLe90Oyib9/f3GnVkb6cP6KKdnYCaMKQ7nMM3uqf3am9lzMOSJSn/7gg8ibfwfNlAq
	 ri8+NXMHCopRHjXLRtSLjOvIZxa6b7NugLjKY4m3Egvey8Jp4L0a/m0NQ4VkZAGN+8YG7
	 84KTN1bdvBgtkT1x4pOhrKkByemKy3ft6Kso/lCE6P/GDpe5Tmj4St3OuGjrPw55y7j6e
	 8VVbH5b3ynBaAICu7ORkBRLpRC6aR/ArIHnb60EWGUi/+NuCoOzbvgIfsLz63dKWWKekL
	 s1DadlKFfg1aUE9L6ebUrzvzCoP9r5nETJ5rKih0Ws7kTvo2B5Gc5AvSwnRI5ATGKDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448997;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=he2Rfu8KETjYQmLhYbCWYK09Xpzsszq5xHpoav7qOTE=;
	b=EXPeRE4Tqcl2J9BB4ScBaOf+hC37wzU+LiI9GIUmhUJlh2MCbwhz/f6MxSGuXBG7OrPT
	 FoPftViIqB/gSWuyOOMODlOQigaop7SXF5YzFLRsQu1B3Z+GsX8F1bkO9V+eXRnpw7l/u
	 f5xE0xlRoM28KUfX+uHmSIPJdjVA7UQJg7qMZkBr94Hb/wg/6e/L+80pgBeeLut0cLdr0
	 0Gi80GqBP9JaZ1TqkCSzeco75fnYqjMUMV53YVSFLjtUl3VZ9vw+8dOhm7BNUpbUoBKxM
	 5ACzy0E2HWMSGXOQKYAVfFTSGXVcsU2FEESsexremvemSkcCd8He207Gz5PPbfYBkVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hApxP2Pe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D240606A31A;
	Sat, 31 Oct 2026 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hApxP2Pe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793448997;
	b=OQClpE6GLk20TKFy8l55dAkphJD/hhSIWxBvVugGObPQlwMaPB+W83XcLKxmgtED/Syk
	 F2PuutDKFpSK6X66qQQlsXyxvKtKb5l7d+lPfzQ90Mh3PeRHTglQe86ONtLaHcKpvp7Gb
	 LtF83narSSDyu7Ms2HrhKAZpQ24qcrNkXe5lgD0SeKxx/RcJgY8ZzvCAya/8/LbENsmAN
	 +Eurbe/SRlFLae6MHuOBWT+bd8pjS3cnsXD2AQxIoUFOhJo5zW8M/zq4RDk+Wo9WPB8MY
	 kjLN08PUtBG+Wzm+eUkqpJTSnArw9sZ9nzBslhS266dRbgXDjs4tPoUTdyj5ZKVBp0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793448997;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=he2Rfu8KETjYQmLhYbCWYK09Xpzsszq5xHpoav7qOTE=;
	b=dAbDmh6ugNYXh5MZPrWl4ZEeltgxICKIDXx1fuYKpGJ8rgupJnwyQhyAZ/FOjJ4D2BsS
	 Q1Sv+ttyTUwPseBinZEydd4Hd+l58BKZ+qD9YZthp8HBkdUKpiZNRTW9dvbERoV7UscYl
	 lMbr2jrLSExvj6cmaGHtepffPZAXTdXYxvjb4XFlJ2BnCffVSvQUSPP+vii6xetKmGZWo
	 R30k/9ukBwESDNi/FGCEL8wr8a6Z/g3pva8RV22h8eSax//sRSPeIUYNWCQaArLBG3cPI
	 vKx+6VL7GLZoB5xDSg6RrVL2E/6xtJjolQCMf801k9kPi67cG+ZYSDMWNC5K9eeQWCQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C35E01F0093A;
	Sat, 31 Oct 2026 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793448997;
	bh=he2Rfu8KETjYQmLhYbCWYK09Xpzsszq5xHpoav7qOTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hApxP2PedjALElTRO5iFpDttxphp384/LvgjDMFvP63/6JK/4span6d+i/z27jJKm
	 rPHEF4LwlIHBuvUyRTT34ZIPQrJZVZ78aKwvSdh7IX2WD3ATHyeDhTlnSkNA3dkjK4
	 1GWkMkMlVhLlHNp0NqcCKtIH4zSXESl9VXxPwkEp/PMj+uYnMbcKadoKAsraZZ0y/Q
	 6Da1a9cV2IDk1QEu/Cms2f/mR47LmXl71VHMieRFt8Qm31I7k9G0cUdieziTw5A6ZP
	 lGhXoZ/gfG/1DVd+58veqPACXecCeUzmYs5PBPMXC1bcFkyJE3FwhUA/eY+I4/b3ZY
	 uRcy5o+ThgQuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 360F845E62;
	Sat, 31 Oct 2026 12:16:35 +0000 (UTC)
From: Ernesto Salvetti via B4 Relay <devnull+ernesto.salvetti.tambosi.tn.it@kernel.org>
Date: Sat, 31 Oct 2026 13:16:15 +0100
Subject: [PATCH 1/3] Bluetooth: hci_core: Don't use extended advertising
 with broken ext scan
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261031-barrot-le-fixes-v1-v1-1-30e2089882bf@tambosi.tn.it>
References: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
In-Reply-To: <20261031-barrot-le-fixes-v1-v1-0-30e2089882bf@tambosi.tn.it>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793448994; l=3587;
 i=ernesto.salvetti@tambosi.tn.it; s=20261031; h=from:subject:message-id;
 bh=S7EzWsPZZdSgugiaMBXQ3KzQZLGqMEw7XwNS27NrlD4=;
 b=al2oVKRlVrqvqfhDXOnL7HuOnmehyNkRhbKOm5rwBPFElOx9z5fp0hrlwCaXL1gva2cjAvvyR
 AbR64GHNe3VB8JnEV8/lDJzhBn3orJfcrImxRcaFc+r778m5dLpg1TJ
X-Developer-Key: i=ernesto.salvetti@tambosi.tn.it; a=ed25519;
 pk=OLNiuyRbYD4dcNYoAvM99nt/1KZTKeM316r91BCQDUs=
X-Endpoint-Received: by B4 Relay for
 ernesto.salvetti@tambosi.tn.it/20261031 with auth_id=1370
X-Original-From: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
Reply-To: ernesto.salvetti@tambosi.tn.it
Content-Transfer-Encoding: 7bit

From: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>

When HCI_QUIRK_BROKEN_EXT_SCAN is set the stack falls back to the legacy
LE Set Scan Parameters/Enable commands, but it keeps using extended
advertising if the controller reports the LE Extended Advertising
feature. Already during init it then sends LE Read Number of Supported
Advertising Sets, which is an extended advertising command.

Core Spec 5.3, Vol 4, Part E, 3.1.1 does not allow mixing the two
command sets: once the Host has issued an extended advertising command,
the Controller shall reject the legacy advertising, scanning and
initiating commands with Command Disallowed until the next reset.

A controller that enforces this, such as the Barrot one in the UGREEN
Bluetooth 5.4 dongle (33fa:0010), then can't scan at all once the quirk
is set:

  < HCI Command: LE Read Number of Su.. (0x08|0x003b) plen 0
  > HCI Event: Command Complete (0x0e) plen 5
        LE Read Number of Supported Advertising Sets (0x08|0x003b) ncmd 1
          Status: Success (0x00)
          Num supported adv sets: 4
  ...
  < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
  > HCI Event: Command Complete (0x0e) plen 4
        LE Set Scan Parameters (0x08|0x000b) ncmd 1
          Status: Command Disallowed (0x0c)

  Bluetooth: hci0: Opcode 0x200b failed: -16

Treat the controller as not capable of extended advertising whenever
extended scanning is marked broken, so that only legacy commands are
used.

Fixes: 392fca352c7a ("Bluetooth: Add quirk to disable extended scanning")
Assisted-by: LLM
Signed-off-by: Ernesto Salvetti <ernesto.salvetti@tambosi.tn.it>
---
 include/net/bluetooth/hci.h      |  4 +++-
 include/net/bluetooth/hci_core.h | 11 +++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1c992e87534d..74b96941ad11 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -274,7 +274,9 @@ enum {
 	/*
 	 * When this quirk is set, the HCI_OP_LE_SET_EXT_SCAN_ENABLE command is
 	 * disabled. This is required for some Broadcom controllers which
-	 * erroneously claim to support extended scanning.
+	 * erroneously claim to support extended scanning. Extended
+	 * advertising is disabled as well, since legacy and extended
+	 * commands can't be mixed.
 	 *
 	 * This quirk can be set before hci_register_dev is called or
 	 * during the hdev->setup vendor callback.
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9d5d3ab4a075..d622cab32ca9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2095,8 +2095,15 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Use ext create connection if command is supported */
 #define use_ext_conn(dev) (((dev)->commands[37] & 0x80) && \
 	!hci_test_quirk((dev), HCI_QUIRK_BROKEN_EXT_CREATE_CONN))
-/* Extended advertising support */
-#define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV))
+/* Extended advertising support
+ *
+ * Controllers shall reject legacy advertising, scanning and initiating
+ * commands with Command Disallowed once an extended advertising command
+ * has been issued (Core Spec 5.3, Vol 4, Part E, 3.1.1), so extended
+ * advertising can't be used when extended scanning is broken.
+ */
+#define ext_adv_capable(dev) (((dev)->le_features[1] & HCI_LE_EXT_ADV) && \
+			      !hci_test_quirk((dev), HCI_QUIRK_BROKEN_EXT_SCAN))
 
 /* Maximum advertising length */
 #define max_adv_len(dev) \

-- 
2.53.0.697.g625c4fb2daa


