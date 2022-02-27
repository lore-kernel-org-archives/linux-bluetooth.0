Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Feb 2022 16:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiB0QoC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Feb 2022 11:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiB0Qno (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Feb 2022 11:43:44 -0500
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Feb 2022 08:43:04 PST
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5DF427D6
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Feb 2022 08:43:02 -0800 (PST)
Received: from monolith.lan (91-152-122-247.elisa-laajakaista.fi [91.152.122.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 95EEE20218;
        Sun, 27 Feb 2022 18:36:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1645979761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0vGowf6T/kFLhM+kr13K3Wuw4J4fjzu6/Y6qc8kKBc=;
        b=ypGBM419vPb3YfcQscDZw4pYxBR3Er3VAfVE29Kh0osQH49CuSkegnDr4tMQFLufr4/HQk
        eV53x33MftbWv7sS1MX1YdDPBjIZGTHKrDdfgMN7V6PDl+roqyAiY5+ZO2R9tucg8g2VWt
        m72IAOIDlv+NmPyORrMTktE+frXsXDs=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kiran K <kiran.k@intel.com>
Subject: [RFC] Bluetooth: don't use ESCO setup for BT_VOICE
Date:   Sun, 27 Feb 2022 18:34:29 +0200
Message-Id: <20220227163430.24694-1-pav@iki.fi>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222212227.24515-1-luiz.dentz@gmail.com>
References: <20220222212227.24515-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1645979761; a=rsa-sha256; cv=none;
        b=mJm/QSTGLCQHUreLon0212q/0b6NHc6cSNvozYlgpa4UeUaLlG93jH8t4qcNTzmsJ6AfLA
        B4y4JO5lDwHVNjrj31jDlhYJFTP7xFKUj03ogPEZeT4zhE4A7InqV/4G/rxIr8qVfAUpl1
        ouRX0dpdHH6Hw+b3MJvFNR+0p7KkD6U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1645979761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0vGowf6T/kFLhM+kr13K3Wuw4J4fjzu6/Y6qc8kKBc=;
        b=GhkziLtyhirgJfekT36isRQwiedxnXiqfCY5l3D/WTom3rE60N58bujTPz4fz2nlTOmwBH
        QrbG0cNlICCVuTBdVAJPZOxhNLdR1+ffNCB+FX1l2Vo8MaTRFchFHonbOGqWLvY5PqQhKh
        99MH0gKR6YBw93aaQCdjz8NQvWczr3U=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to user reports, how HCI_Enhanced_Setup_Synchronous_Connection
is currently used to establish MSBC connections results to broken audio
on some adapters (QCA6174, mt7921e).

Revert to previous behavior of using HCI_Setup_Synchronous_Connection,
unless the user has explicitly set BT_CODEC sockopt. Since bt_codec
contents come from Core specification, use a separate flag for the
setting.

Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215576
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    Maybe we want to use the ESCO connect setup only when userspace has
    requested the codec offload support.  I don't have any of the broken
    hardware myself, so this is not tested on them.
    
    Alternatively, there should be some driver quirk to indicate the
    enhanced sco connection setup is not broken.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 10 ++++++++--
 net/bluetooth/sco.c              | 22 +++++++---------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dd8840e70e25..3a6a3b80368c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -717,6 +717,7 @@ struct hci_conn {
 
 	struct hci_conn	*link;
 	struct bt_codec codec;
+	bool		esco_setup;
 
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index bd669c95b9a7..0aa7f822de32 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -481,7 +481,7 @@ static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
-	if (enhanced_sco_capable(conn->hdev))
+	if (enhanced_sco_capable(conn->hdev) && conn->esco_setup)
 		return hci_enhanced_setup_sync_conn(conn, handle);
 
 	return hci_setup_sync_conn(conn, handle);
@@ -1477,7 +1477,13 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	hci_conn_hold(sco);
 
 	sco->setting = setting;
-	sco->codec = *codec;
+	if (codec) {
+		sco->codec = *codec;
+		sco->esco_setup = true;
+	} else {
+		memset(&sco->codec, 0, sizeof(sco->codec));
+		sco->esco_setup = false;
+	}
 
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8eabf41b2993..e78063d65c1a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -70,6 +70,7 @@ struct sco_pinfo {
 	__u16		setting;
 	__u8		cmsg_mask;
 	struct bt_codec codec;
+	bool		esco_setup;
 	struct sco_conn	*conn;
 };
 
@@ -239,6 +240,7 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 {
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
+	struct bt_codec *codec;
 	int err, type;
 
 	BT_DBG("%pMR -> %pMR", &sco_pi(sk)->src, &sco_pi(sk)->dst);
@@ -252,8 +254,9 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev)))
 		return -EOPNOTSUPP;
 
+	codec = sco_pi(sk)->esco_setup ? &sco_pi(sk)->codec : NULL;
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
-			       sco_pi(sk)->setting, &sco_pi(sk)->codec);
+			       sco_pi(sk)->setting, codec);
 	if (IS_ERR(hcon))
 		return PTR_ERR(hcon);
 
@@ -496,10 +499,7 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 	sk->sk_state    = BT_OPEN;
 
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
-	sco_pi(sk)->codec.id = BT_CODEC_CVSD;
-	sco_pi(sk)->codec.cid = 0xffff;
-	sco_pi(sk)->codec.vid = 0xffff;
-	sco_pi(sk)->codec.data_path = 0x00;
+	sco_pi(sk)->esco_setup = false;
 
 	bt_sock_link(&sco_sk_list, sk);
 	return sk;
@@ -879,16 +879,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		sco_pi(sk)->setting = voice.setting;
-		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
-				     BDADDR_BREDR);
-		if (!hdev) {
-			err = -EBADFD;
-			break;
-		}
-		if (enhanced_sco_capable(hdev) &&
-		    voice.setting == BT_VOICE_TRANSPARENT)
-			sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
-		hci_dev_put(hdev);
+		sco_pi(sk)->esco_setup = false;
 		break;
 
 	case BT_PKT_STATUS:
@@ -951,6 +942,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		sco_pi(sk)->codec = codecs->codecs[0];
+		sco_pi(sk)->esco_setup = true;
 		hci_dev_put(hdev);
 		break;
 
-- 
2.35.1

