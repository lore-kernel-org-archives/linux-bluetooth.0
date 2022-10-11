Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C7CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 19:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJKT0D (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 15:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJKT0A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 15:26:00 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9407F75486
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 12:25:59 -0700 (PDT)
Received: from monolith.lan (91-152-121-49.elisa-laajakaista.fi [91.152.121.49])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 0E0B42024C;
        Tue, 11 Oct 2022 22:25:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1665516353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyMi5E4dTvBBBn+MCoiLCuT/rwJZSoFTa3yyi9YQ6d4=;
        b=wq6iExBE0mqMV84L/DRFlNssitX6R7Ns/LoS9oX/QWyEU4XBbDWU4xfU1S2ORaN6O/6w4m
        al48KxmDkxPd8tZFcWcHH74FVoHvtrydVTjEJAoZofCKtc/OyqMoQOI09DYckUrNg5UHSV
        DibJ9BEIkbRWxNZ2L+ildqAFrcu1Pwg=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 1/2] Bluetooth: hci_conn: Fix CIS connection dst_type handling
Date:   Tue, 11 Oct 2022 22:25:33 +0300
Message-Id: <20221011192534.16281-1-pav@iki.fi>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221009174216.17533-1-pav@iki.fi>
References: <20221009174216.17533-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1665516353; a=rsa-sha256; cv=none;
        b=YYulz5YWGg8aX1iyLlDUbSI+YYrAghHQ1E/oQUw5PHTAeRi8ubE6X8qPUO7wpidOBRFHYT
        ulX+dVXpTSXZsd6QvyCQXts9ja1SQGXofuumlZWIpCgZLD9QrsCUoF2u1YJWxBrmSgsZO8
        VR22gS9e5LwXTg2ZIXvZzP+aXjz7mPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1665516353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LyMi5E4dTvBBBn+MCoiLCuT/rwJZSoFTa3yyi9YQ6d4=;
        b=V8lnM5ZMkjGTYXiuwBOAcQt4W221g+yjhSo2ywaU/DxzYZteIIxVp4e1YDbmlkY3sbTdJr
        359T5ZBtZnlp5OjI5YvTMkzqoLUGjKzdsQ+7LbNOIkFcViSzTK1SyklfiO0Pnrv0031bOZ
        7uWXkFNu5wkhEGtN+gHYdlLo2mBO4UE=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_connect_cis and iso_connect_cis call hci_bind_cis inconsistently
with dst_type being either ISO socket address type or the HCI type, but
these values cannot be mixed like this. Fix this by using only the HCI
type.

CIS connection dst_type was also not initialized in hci_bind_cis, even
though it is used in hci_conn_hash_lookup_cis to find existing
connections.  Set the value in hci_bind_cis, so that existing CIS
connections are found e.g. when doing deferred socket connections, also
when dst_type is not 0 (ADDR_LE_DEV_PUBLIC).

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    * do address type conversions in iso.c
    * do the same for BIS for consistency (separate patch)

 net/bluetooth/hci_conn.c |  7 +------
 net/bluetooth/iso.c      | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9777e7b109ee..f1263cdd71dd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1697,6 +1697,7 @@ struct hci_conn *hci_bind_cis(struct hci_dev *hdev, bdaddr_t *dst,
 		if (!cis)
 			return ERR_PTR(-ENOMEM);
 		cis->cleanup = cis_cleanup;
+		cis->dst_type = dst_type;
 	}
 
 	if (cis->state == BT_CONNECTED)
@@ -2076,12 +2077,6 @@ struct hci_conn *hci_connect_cis(struct hci_dev *hdev, bdaddr_t *dst,
 	struct hci_conn *le;
 	struct hci_conn *cis;
 
-	/* Convert from ISO socket address type to HCI address type  */
-	if (dst_type == BDADDR_LE_PUBLIC)
-		dst_type = ADDR_LE_DEV_PUBLIC;
-	else
-		dst_type = ADDR_LE_DEV_RANDOM;
-
 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		le = hci_connect_le(hdev, dst, dst_type, false,
 				    BT_SECURITY_LOW,
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 613039ba5dbf..f825857db6d0 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -235,6 +235,14 @@ static int iso_chan_add(struct iso_conn *conn, struct sock *sk,
 	return err;
 }
 
+static inline u8 le_addr_type(u8 bdaddr_type)
+{
+	if (bdaddr_type == BDADDR_LE_PUBLIC)
+		return ADDR_LE_DEV_PUBLIC;
+	else
+		return ADDR_LE_DEV_RANDOM;
+}
+
 static int iso_connect_bis(struct sock *sk)
 {
 	struct iso_conn *conn;
@@ -328,14 +336,16 @@ static int iso_connect_cis(struct sock *sk)
 	/* Just bind if DEFER_SETUP has been set */
 	if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
 		hcon = hci_bind_cis(hdev, &iso_pi(sk)->dst,
-				    iso_pi(sk)->dst_type, &iso_pi(sk)->qos);
+				    le_addr_type(iso_pi(sk)->dst_type),
+				    &iso_pi(sk)->qos);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto done;
 		}
 	} else {
 		hcon = hci_connect_cis(hdev, &iso_pi(sk)->dst,
-				       iso_pi(sk)->dst_type, &iso_pi(sk)->qos);
+				       le_addr_type(iso_pi(sk)->dst_type),
+				       &iso_pi(sk)->qos);
 		if (IS_ERR(hcon)) {
 			err = PTR_ERR(hcon);
 			goto done;
-- 
2.37.3

