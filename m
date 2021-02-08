Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85541C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 22:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CF764E66
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Feb 2021 22:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBHWGX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBHWGS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Feb 2021 17:06:18 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C61C061788
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Feb 2021 14:05:37 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s18so19484765ljg.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Feb 2021 14:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VsOIvekpMVd/ZPNEFb17yiukitnUdsKwH8117qbIQf0=;
        b=rszRkkcUZca/Oay6YtGyNCd9cvkmCElyPMHnuSvzSRNjumlQX4TSc+Kh3/IhOMRcn/
         QMNIoqU44xJRJ2ZDOK/RwuhClynQFdAsEKyNztkWadEyOB712jrVTH3Y5w4s+Md3jdim
         5/SoPVChrnWLcMD0kjfBJwUi3szgK11U4tpO9VXEH+Tj8jndYsiLZmIRKo47ZGaZTxy6
         atOMQIrAzxsxrYsPTJLpht+h0HlrXftc9KcpSuSSLAEY/LEnm4WUoWnEXYyYd1i+0wBN
         G5LBfz9RFgQj4fyKvlP+gFCNGou7Cz2xrh4VBV3JYov8+4evZ9FrxyP3Ld5f4ALbZxod
         7l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VsOIvekpMVd/ZPNEFb17yiukitnUdsKwH8117qbIQf0=;
        b=q3lK2m9/bTcnss0BG72eZQXfqdL99XLVLawTp+buUkLXC9FrR5/PhWgCA1h/7yq+LI
         pQqj7jxJVdvny3h4Rg61y3cyhWzplZfGEtRorwChRv+yoTpUAU/vmSwAy+pE+HGljQi/
         4YdJTuPDSDEaGDgJDZbQIPo/ZmdDsj9OZPWeWvPBOF6Zyev11lnjOszg9E9FI0ftNfl/
         iiYPgtbaV3YxqwpzFiBgUAfqusjIIb86acY//q1LsZv+P2Zr0yyonH6xiSQeM8zF3832
         tM/XDXEmsp2xPJrz4sXhCsZkqGAQm558TEFFsbLglNKQOmPVRpVe/U6k2zkdV4podFIG
         qr9A==
X-Gm-Message-State: AOAM532x/uxReFSFK20kXVYiqHPPUIt4ITSkjwrRN9UIx/pFBy+0XORz
        kWpV7lOn4+t0FUqy0THpthQuV9X+nW931IokKH0=
X-Google-Smtp-Source: ABdhPJwXtoToUv3AIPMmFIcBVQml5p0bmf6L6UWu0VASq3TOyFxpL3lQk2uv5lzuSE0anNarBuRSxg==
X-Received: by 2002:a2e:85ca:: with SMTP id h10mr12850182ljj.474.1612821935936;
        Mon, 08 Feb 2021 14:05:35 -0800 (PST)
Received: from localhost.localdomain (dzqmct6w75s9d-569np-4.rev.dnainternet.fi. [2001:14bb:a3:5428:6a5b:cbfa:3fe7:5d5b])
        by smtp.gmail.com with ESMTPSA id p15sm975615ljc.123.2021.02.08.14.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:05:35 -0800 (PST)
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ari Timonen <ari.timonen@synopsys.com>
Subject: [PATCH v2 1/1] Bluetooth: Fix Just-Works re-pairing
Date:   Tue,  9 Feb 2021 00:05:31 +0200
Message-Id: <20210208220531.3471-2-matias.karhumaa@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208220531.3471-1-matias.karhumaa@gmail.com>
References: <20210208220531.3471-1-matias.karhumaa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix Just-Works pairing responder role in case where LTK already exists.

Currently when another device that was previously paired with Linux
device and lost the LTK for some reason, tries to pair again using
NoInputNoOutout IO capability, pairing fails due to DHKey check failure.

Btmon snippet from failing pairing attempt, Linux side already has the
LTK:

< ACL Data TX: Handle 3585 flags 0x00 dlen 6               #12 [hci0] 38.872591
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, MITM, SC, No Keypresses, CT2 (0x2d)
= bluetoothd: No cache for DE:C7:3E:59:CE:8B                          38.873677
> HCI Event: Number of Completed Packets (0x13) plen 5     #13 [hci0] 38.972258
        Num handles: 1
        Handle: 3585
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5     #14 [hci0] 39.072201
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 11              #16 [hci0] 39.171956
      SMP: Pairing Request (0x01) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
        Max encryption key size: 16
        Initiator key distribution: IdKey Sign LinkKey (0x0e)
        Responder key distribution: IdKey Sign LinkKey (0x0e)
< ACL Data TX: Handle 3585 flags 0x00 dlen 11              #17 [hci0] 39.172070
      SMP: Pairing Response (0x02) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
        Max encryption key size: 16
        Initiator key distribution: IdKey Sign LinkKey (0x0e)
        Responder key distribution: Sign LinkKey (0x0c)
> ACL Data RX: Handle 3585 flags 0x02 dlen 27              #18 [hci0] 39.371260
> ACL Data RX: Handle 3585 flags 0x01 dlen 27              #19 [hci0] 39.371550
> HCI Event: Number of Completed Packets (0x13) plen 5     #20 [hci0] 39.371891
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x01 dlen 15              #21 [hci0] 39.372120
      SMP: Pairing Public Key (0x0c) len 64
        X: ca5cb38db1955168537666917f6769235c16684dd5015b29d1f02040178a5e36
        Y: 59e440e4fe49cffb4a1d5abfd0392c088412b19a21c8799ed940e88bb1b7a844
< ACL Data TX: Handle 3585 flags 0x00 dlen 27              #22 [hci0] 39.382192
< ACL Data TX: Handle 3585 flags 0x01 dlen 27              #23 [hci0] 39.382197
< ACL Data TX: Handle 3585 flags 0x01 dlen 15              #24 [hci0] 39.382199
      SMP: Pairing Public Key (0x0c) len 64
        X: c19a87e4b8a77a38b5737aad34022cfb339ac421596e66405d0f7e4439598520
        Y: b1293924e8476082639900ea5241c9138842550b2757427b03d43be67a448409
< ACL Data TX: Handle 3585 flags 0x00 dlen 21              #25 [hci0] 39.382200
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 34cb38b22d23b3a9e80f4bbc90f8efe0
> HCI Event: Number of Completed Packets (0x13) plen 5     #30 [hci0] 39.471989
        Num handles: 1
        Handle: 3585
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5     #31 [hci0] 39.472933
        Num handles: 1
        Handle: 3585
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5     #32 [hci0] 39.473930
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 21              #33 [hci0] 39.571354
      SMP: Pairing Random (0x04) len 16
        Random value: cccccccccccccccccccccccccccccccc
@ MGMT Event: User Confirmation R.. (0x000f) plen 12  {0x0002} [hci0] 39.571462
        LE Address: DE:C7:3E:59:CE:8B (Static)
        Confirm hint: 0x01
        Value: 0x00000000
@ MGMT Event: User Confirmation R.. (0x000f) plen 12  {0x0001} [hci0] 39.571462
        LE Address: DE:C7:3E:59:CE:8B (Static)
        Confirm hint: 0x01
        Value: 0x00000000
< ACL Data TX: Handle 3585 flags 0x00 dlen 21              #34 [hci0] 39.571482
      SMP: Pairing Random (0x04) len 16
        Random value: c57bf6866a97bfa184657f89c3c644e5
> HCI Event: Number of Completed Packets (0x13) plen 5     #35 [hci0] 39.571752
        Num handles: 1
        Handle: 3585
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 21              #37 [hci0] 39.721325
      SMP: Pairing DHKey Check (0x0d) len 16
        E: 7a264e8fa19c835ff0db5db07bec23f6
@ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0002} [hci0] 39.721440
        LE Address: DE:C7:3E:59:CE:8B (Static)
        Status: Authentication Failed (0x05)
@ MGMT Event: Authentication Failed (0x0011) plen 8   {0x0001} [hci0] 39.721440
        LE Address: DE:C7:3E:59:CE:8B (Static)
        Status: Authentication Failed (0x05)
< ACL Data TX: Handle 3585 flags 0x00 dlen 6               #38 [hci0] 39.721463
      SMP: Pairing Failed (0x05) len 1
        Reason: DHKey check failed (0x0b)

DHKey check fails because one of the inputs of DHKey calculation
function smp_f6() is mackey and it is not calculated at all in this
scenario.

Commit introducing this bug was meant just for fixing uninitialized
use of passkey variable and the bug looks like accidental side effect.
The commit adds "goto confirm" statement that skips mackey calculation
in smp_cmd_pairing_random() function.

With this fix mackey is calculated in a similar way also in the case
that Linux responder already has the LTK. Mackey is calculated right
before requesting confirmation for Just-Works pairing from userspace
which in turn fixes the DHKey calculation.

Fixes: eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
Reported-by: Ari Timonen <ari.timonen@synopsys.com>
Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
---
 net/bluetooth/smp.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b0c1ee110eff..b68fc1975e31 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2122,7 +2122,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	u8 *pkax, *pkbx, *na, *nb, confirm_hint;
-	u32 passkey;
+	u32 passkey = 0;
 	int err;
 
 	BT_DBG("conn %p", conn);
@@ -2174,24 +2174,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
-
-		/* Only Just-Works pairing requires extra checks */
-		if (smp->method != JUST_WORKS)
-			goto mackey_and_ltk;
-
-		/* If there already exists long term key in local host, leave
-		 * the decision to user space since the remote device could
-		 * be legitimate or malicious.
-		 */
-		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-				 hcon->role)) {
-			/* Set passkey to 0. The value can be any number since
-			 * it'll be ignored anyway.
-			 */
-			passkey = 0;
-			confirm_hint = 1;
-			goto confirm;
-		}
 	}
 
 mackey_and_ltk:
@@ -2206,17 +2188,19 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 			SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
 		}
 		return 0;
-	}
-
-	err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
-	if (err)
-		return SMP_UNSPECIFIED;
-
-	confirm_hint = 0;
-
-confirm:
-	if (smp->method == JUST_WORKS)
+	} else if (smp->method == JUST_WORKS) {
+		/* Leave the decision to user space since the remote device could
+		 * be legitimate or malicious.
+		 */
 		confirm_hint = 1;
+	} else {
+		/* Generate passkey for numeric comparison. */
+		err = smp_g2(smp->tfm_cmac, pkax, pkbx, na, nb, &passkey);
+		if (err)
+			return SMP_UNSPECIFIED;
+
+		confirm_hint = 0;
+	}
 
 	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
 					hcon->dst_type, passkey, confirm_hint);
-- 
2.25.1

