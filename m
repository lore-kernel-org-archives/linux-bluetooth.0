Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8891EEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 17:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjFWRTU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjFWRTA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 13:19:00 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221A41997
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 10:18:59 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QnkVK0RyXz49QK5;
        Fri, 23 Jun 2023 20:18:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1687540729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaCe5l9sNZdr/d/DwckHXoXDhHv0aArdv7bPevQmsZQ=;
        b=PP8hMMJatUJu323qjIPOT3/Zc/qr6LDLVBDTFpF0ksAv55cLAAJ/5ICZImKD3cGGvft9M8
        XLeNmVAiBerU0mntFIcSYQttp5MvGnaTuPcwf6FLLBF2bqIqIuqgIf3y77VBfuV4k+4OGz
        EmSbSJEt5eLQltyBxf1eVY4Gal3D2OMkK42dv1S6yEL3GCAJFwq+NvLLfYvXjIgvLyliOi
        qej7jiz/cTRmTJBCXcLPAJOHQDH/IIoPiVJjC9ttw0DanTlkqHIUkh/bSJ+zI3QY/5zgoY
        maMEhXSqSfwSDw53Kk4HfshuNQ9P4FhFYgsgOQTKmQrBc1pdtCcfhTRnWOMGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1687540729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zaCe5l9sNZdr/d/DwckHXoXDhHv0aArdv7bPevQmsZQ=;
        b=d5TgFgcULHDmAE+I6GnlgXyGTodsNpb8fG2V3f+Yahg2ZQjzwOHu1+I5DRXpy7uDVqxott
        DyV9V7h0Q5qay20HR1AD5qbqTjToGD2y09o2osXcXBHACkfG1YjwvE0lyGOf5CqxRy6XYP
        bsWG1Ah/Oj4jW0sPA4UVuCDAUzgRfEfb908/97cDL8Go8w+QuBu5Ygfkmox3soNCh+h1ld
        f8W8HaZOIsAEs3q6sV0299ZCr2mMkFRgXsXjUAE3Dbe5zuJuJnnWQxpQ58li30gh2c1Tpo
        rcP5RJ4mJTEJbo3olwvYMkHL5t5cfyfDNwcL5QaYruRzRCliOGynLQjbzbgXLA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1687540729; a=rsa-sha256;
        cv=none;
        b=VYZCLYn54KUx8tWUqH+PK3x1eJkj/rstqeWVeGe4a/lSZNAqnUesKccv6zH2sSyEyUf/gv
        HYaKUDpZ1ONtOziHf/lZ065i4bMxj8x9gmSE/CK1u2QLSN5P9W/hTJyM52hhyd92vUfttJ
        eATTsKrcWN6L2l8CES4NIDrST4mTJlo4ImAlvAi+94LgD9kIfmFtRK6D2o35Mff8JJSICP
        Do0LPPr3hL+YgV7K30/3mcNt95bkIeZhUjHjH6SaM40CgCAJKiO2CvtqBaNizyoURiHVjF
        t9VSJT+9UH1CQsXaDwKnNvaKOaIjfpRiNuJhjJlxdogiT+i0uL7opq9BnBMNyg==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 5/5] Bluetooth: ISO: fix locking in iso_conn_ready
Date:   Fri, 23 Jun 2023 20:18:42 +0300
Message-ID: <b0eab0121b79c3cb5c1abae958cafd102440897b.1687525956.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687525956.git.pav@iki.fi>
References: <cover.1687525956.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Getting conn->sk must sock_hold, otherwise the socket may be freed
concurrently.  Access to conn->hcon is safe when holding hdev->lock.

Fix the locking in iso_conn_ready to obey this.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/iso.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index ea0209fb9872..c2045adbd7b6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -179,6 +179,7 @@ static void iso_chan_del(struct sock *sk, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 }
 
+/* Must hold hdev->lock */
 static void iso_conn_del(struct hci_conn *hcon, int err)
 {
 	struct iso_conn *conn = hcon->iso_data;
@@ -1547,19 +1548,23 @@ static bool iso_match_big(struct sock *sk, void *data)
 static void iso_conn_ready(struct iso_conn *conn)
 {
 	struct sock *parent;
-	struct sock *sk = conn->sk;
+	struct sock *sk;
 	struct hci_ev_le_big_sync_estabilished *ev;
 	struct hci_conn *hcon;
 
 	BT_DBG("conn %p", conn);
 
-	if (sk) {
-		iso_sock_ready(conn->sk);
-	} else {
-		hcon = conn->hcon;
-		if (!hcon)
-			return;
+	iso_conn_lock(conn);
+	hcon = conn->hcon;
+	sk = conn->sk;
+	if (sk)
+		sock_hold(sk);
+	iso_conn_unlock(conn);
 
+	if (sk) {
+		iso_sock_ready(sk);
+		sock_put(sk);
+	} else if (hcon) {
 		ev = hci_recv_event_data(hcon->hdev,
 					 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
 		if (ev)
-- 
2.41.0

