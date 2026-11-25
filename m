Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641136;
	b=lbJGfzSfZCTE5EhuarpWBBZMn9MuTuqXh+OdRv56kppfO46k3n5l8ohEjx1d6Q7Afg0q
	 VpSDG/8xysUkZ1EMkvdUSy9eQnBSYqIKZhljkMPNH5/g1odQtS4SC7pjia3rzL+MM0YWY
	 Qwj26MgWQCX64XKRbxmXgroxoaBrX+fRm3GKYu67ehsvX5H/s2dIyWdeIedeovd6Xpd2Q
	 zzxGgrsHNqGx9FgH7sFRrtySoMdYHD4TjGiJONRZYxM+rjKcuwbvRddI7e9aOP+CBRC2s
	 TN5mLMCsn3TxNLHjyFyXLBYQGrcUfXMhEH0R5Mo/QmHZHATu/n+jiqep7SuhaPzlI9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kH1xwIm1joLd9WZcFoQ3l6dxZbedy49iSwUkmFN9eu8=;
	b=WssP9lAHYaDczAlxRG7Ly8zezSxymVqKYzUvTw4JFV9WZy6lKgNuGnu5wSeslapf7AJc
	 cnXdVTm3w84qgYt4BZklvqfhhQtuj3qiTIEfPNtx6IkfYqkoJ1SimhlUOOiq3fKEji41a
	 5dIefbG1CojCe+6FCguKzQQq8cxoG5LbVXobW8vxnVhzMIvHAaiwaOkl01NAki89ssutj
	 f6FkcQtAruk8FFERBK0yMJNw9uAB03OhKA43EdgQUz/YKFrW8Tf5cNHiBdxUKoogexsf9
	 IIEkLaATeaX8NNvUPTTpIaipD10R40wTVV+p/rQiisEcjecPKKldpZbQBCqnpODeYuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VnPR/YIX";
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9D3606A339
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A9D3606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VnPR/YIX
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-980c4f5c921so1767019241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641135; x=1796245935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kH1xwIm1joLd9WZcFoQ3l6dxZbedy49iSwUkmFN9eu8=;
        b=VnPR/YIXR5X/qqdmPseoeWxbKvq6a7zibFjJXvBTGbkQ+vlPSthtcYOkEElIyYdR+z
         9obH45kAJavNsSb0XQvrKfJc7V1YPTHPBpQPkcSYSj0YDsXuvUFyo6AGJT23rYsBIpsh
         gt/UISa0KlI7N6JQ4WVaS5raeDRBHquh3V78r+QPZBvQWqqQHm9hiD88bYoYYJHzLtzm
         iia/heoEm0GFXQIi+KB02bBkTE+s7gNeI9eVkaLDaj/sauQKzLCXlbgyHWIM8uMPATAR
         gNTo1ug0kcPNBGcqhcdd7ejDOk7EhMitjMIC2KJsomNiYA1bmvSnzW3Vw5e6afK5EwX9
         a1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641135; x=1796245935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kH1xwIm1joLd9WZcFoQ3l6dxZbedy49iSwUkmFN9eu8=;
        b=MLYGwRefOSIUDuja8RbQy/y1IDcoGJhyLtaIw7BJkhvwU5MDy3ITcdJY9KXnO/mBvU
         3ACXZFsOshFTK4norXKL1ylk9lFYkc9dA76P1PSe2J+mBMUqgXLioWP6e1UWXxmHGJKB
         YMZOTbLGcrd1ZCHeSUmLrGXSWdL3xHVVJtP6HwO+wG/arOxs+9uTOsCrPO/cKxIzuSXj
         8Easy6KsIj2cviswSx21VagyNYBME6ExUtAkSGzWtixf2O1XcQ9IgiKpGWmcPR0KEUOG
         yjI31mXBDkC0MezZeE9hJGmWjZjz9mdv9qBvfjYvq9kHni/1uvEUuepYqmxROQIv0qN5
         Hc5g==
X-Gm-Message-State: APuU4Z+1SNTUwwqwLI097IR2Moat93UpJ3xvNIJmYuViDXoPGQKBDGBo
	JqVdX3FT5DX2mrQiBnxuKNuEoTYMvhAba3KXZevYyVYYrhso+1xHhdTGbXiiSw==
X-Gm-Gg: AZFdTZehjNUYXYBer+rEHRBnBFpAimyd/gAM1dOM9qJRPYaQtLx3wIt2FvuRqAJqkac
	68XsMgSEXibo46KbfkbPA9Qd5ZTxDtA5s1j/5+PDkX+LwQT15eohLT80yaW45vBxg6WgUkHZRQC
	X5iI7u2DD7DNhF8c0vFjOKtdprT1+JoAQzNSz9GUjTjMPZ8iyVB0IpHYPPnKrvaZKva2MJiHzCS
	GlSP3DIorP2Fha0M8bc36tkOP77a/euCjqU+tApuNOdbB/cNFJe1nh5D/wAq5klkbwshQbUsqKw
	wPHOa8rgcWTxv8TvYqnRfsYV9ZkQxeSYYjHrq0pESH5i9FztjFPF8iYgT1foFNpS5+fZL5afLIc
	7Z7OxCSdu/IlhpCNsKYuHhX6Ya6WHKsJDwnswHr7doXrPFZY/ec91Z53SFksxDv24dKTOCqusBu
	cK4aLA78ziIigd/tMFVTwOt6DspAYeD7KKdoqmZFM+p9gHlUjxxTAFWnDkFFKAZi/qt/OPqxmGu
	i4mAFXiq9MtOl1GFTGAIwYlbpXEPAiQJ99lzPAcAQwbZ51vMNEimqETi8TksNsbYtdF3ZLVbj97
	oxxKuYcE3wo/KJFDlJ2rCItRZm3pqkoSe4ClUUl98FP/epaICAXJH5D0rQCx+Mak32CPcAYkbqh
	eH/7JtQ4hsgxrXlg236Q0CSyyAp/cTWpl63drZcWMieGEvx473wCzC13IqgezlqjRRuGEcH3Fgv
	17be0=
X-Received: by 2002:a05:6122:d03:b0:5e4:f6c8:b0a5 with SMTP id 71dfb90a1353d-5ee8ad0eb56mr10931673e0c.0.1795641135038;
        Wed, 25 Nov 2026 13:12:15 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b556db7sm18316369e0c.4.2026.11.25.13.12.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 3/4] Bluetooth: L2CAP: Fix accepting channels with insufficient security
Date: Wed, 25 Nov 2026 16:12:09 -0500
Message-ID: <20261125211210.1955598-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211210.1955598-1-luiz.dentz@gmail.com>
References: <20261125211210.1955598-1-luiz.dentz@gmail.com>
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

From: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>

When the link security changes, l2cap_security_cfm() doesn't check
that the result meets the security level required by the channels:

 - If encryption completes it sets chan->sec_level to hcon->sec_level,
   so a channel requiring a higher security level than the one the
   link ended up with has its requirement lowered instead of being
   refused.

 - A channel in BT_CONNECT2 is accepted, or offered to the listener if
   it uses BT_DEFER_SETUP, as long as the status is success and the
   encryption key size is valid, e.g. if the peer disables encryption
   while the channel waits for userspace to authorize it, the channel
   is offered again and, once authorized, it is established over an
   unencrypted link.

 - A channel in BT_CONNECT is started as long as the status is
   success, no matter if the link meets its security level.

 - The security level of the link is updated when authentication
   completes, before encryption is enabled, so it can't be used alone
   to tell if the link is secure enough.

Fix this by treating encryption completing with a security level
below the one required by a channel as a downgrade: the security level
of the channel is no longer lowered and the channel is disconnected,
or refused with L2CAP_CR_SEC_BLOCK if it was pending. There is no way
to disconnect a fixed channel at L2CAP, so for those the link is
disconnected instead, which also applies when encryption is disabled
since l2cap_check_encryption() doesn't handle them. Channels in
BT_CONNECT2 and BT_CONNECT are only accepted, or started, if the link
is encrypted and meets their security level, and established channels
are not resumed if it doesn't. Authentication completing before
encryption is enabled is not considered encryption being disabled, the
channels in BT_CONNECT and BT_CONNECT2 just wait for it.

Since chan->sec_level follows the security level of the link once
encryption is enabled it can't tell what a channel requires, so keep
that in the new min_sec_level, which is set wherever the security level
is requested for the channel, otherwise channels that never asked for
more than BT_SECURITY_LOW, like SMP, would be considered downgraded
when the link is paired again with a lower security level.

Deferred LE Credit Based and Enhanced Credit Based channels wait in
BT_CONNECT2 for userspace to authorize them, which doesn't check the
security level, so refuse them there if the link no longer meets it,
with the channel kept locked until it is closed so it can't be
authorized meanwhile. Only that channel is refused, the others of the
same request are responded individually. Enhanced Credit Based
channels are only refused there since the response of the request is
only sent once all of its channels have been authorized or refused.

This means a channel requiring a security level that pairing can't
provide, e.g. BT_SECURITY_HIGH when the IO capability is
NoInputNoOutput, is now refused instead of being connected with the
security level the link ended up with.

AI assistance was used in finding and preparing this patch.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |   7 ++
 net/bluetooth/l2cap_core.c    | 129 ++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c    |  44 +++++++++---
 net/bluetooth/rfcomm/core.c   |   1 +
 4 files changed, 166 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 72d9d56c6f2a..a68aa4228206 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -544,7 +544,12 @@ struct l2cap_chan {
 	__u8		chan_type;
 	__u8		chan_policy;
 
+	/* The security level of the link, which sec_level follows once
+	 * encryption is enabled, so it can't tell what the channel requires,
+	 * that is what min_sec_level is for.
+	 */
 	__u8		sec_level;
+	__u8		min_sec_level;
 	__u8		mic_len;
 
 	__u8		ident;
@@ -987,6 +992,8 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm);
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 
 struct l2cap_chan *l2cap_chan_create(void);
+bool l2cap_chan_sec_level_ok(struct l2cap_chan *chan);
+void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_close_unlocked(struct l2cap_chan *chan, int reason)
 	__must_not_hold(&chan->lock);
 int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d39d8b8c47be..c81eff21468c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -551,6 +551,7 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan)
 	chan->remote_tx_win = chan->tx_win;
 	chan->ack_win = L2CAP_DEFAULT_TX_WINDOW;
 	chan->sec_level = BT_SECURITY_LOW;
+	chan->min_sec_level = BT_SECURITY_LOW;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 	chan->retrans_timeout = L2CAP_DEFAULT_RETRANS_TO;
 	chan->monitor_timeout = L2CAP_DEFAULT_MONITOR_TO;
@@ -567,6 +568,7 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan *pchan)
 		chan->tx_win = pchan->tx_win;
 		chan->tx_win_max = pchan->tx_win_max;
 		chan->sec_level = pchan->sec_level;
+		chan->min_sec_level = pchan->min_sec_level;
 		chan->mic_len = pchan->mic_len;
 		chan->conf_state = pchan->conf_state;
 		chan->flags = pchan->flags;
@@ -5230,6 +5232,8 @@ static int l2cap_le_connect_rsp(struct l2cap_conn *conn,
 		sec_level = hcon->sec_level + 1;
 		if (chan->sec_level < sec_level)
 			chan->sec_level = sec_level;
+		if (chan->min_sec_level < sec_level)
+			chan->min_sec_level = sec_level;
 
 		/* We'll need to send a new Connect Request */
 		clear_bit(FLAG_LE_CONN_REQ_SENT, &chan->flags);
@@ -5846,6 +5850,8 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			sec_level = hcon->sec_level + 1;
 			if (chan->sec_level < sec_level)
 				chan->sec_level = sec_level;
+			if (chan->min_sec_level < sec_level)
+				chan->min_sec_level = sec_level;
 
 			/* We'll need to send a new Connect Request */
 			clear_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags);
@@ -8152,11 +8158,37 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	}
 }
 
+/* Check if the link meets the security level required by the channel, which
+ * for anything above BT_SECURITY_LOW needs the link to be encrypted since the
+ * security level of the link is updated when authentication completes, before
+ * encryption is enabled.
+ */
+static bool l2cap_chan_sec_level_met(struct hci_conn *hcon,
+				     struct l2cap_chan *chan)
+{
+	if (chan->min_sec_level <= BT_SECURITY_LOW)
+		return true;
+
+	return test_bit(HCI_CONN_ENCRYPT, hcon->flags) &&
+	       hcon->sec_level >= chan->min_sec_level;
+}
+
+void l2cap_chan_close(struct l2cap_chan *chan, int reason)
+{
+	/* Context analysis: caller holds chan->lock and chan->conn->lock */
+	context_unsafe(__l2cap_chan_close(chan, reason));
+}
+
+bool l2cap_chan_sec_level_ok(struct l2cap_chan *chan)
+{
+	return l2cap_chan_sec_level_met(chan->conn->hcon, chan);
+}
+
 static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	__must_hold(&hcon->hdev->lock)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *tmp;
 
 	if (!conn)
 		return;
@@ -8165,7 +8197,9 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	mutex_lock(&conn->lock);
 
-	list_for_each_entry(chan, &conn->chan_l, list) {
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
+		bool unmet, encrypting, downgrade = false;
+
 		l2cap_chan_lock(chan);
 
 		lockdep_assert_held(&chan->conn->lock);
@@ -8173,8 +8207,83 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 		       state_to_string(chan->state));
 
-		if (!status && encrypt)
-			chan->sec_level = hcon->sec_level;
+		/* Authentication completing before encryption is enabled
+		 * updates the security level of the link, so it already meets
+		 * the one required, but it is not encrypted yet: encryption is
+		 * expected to follow instead of it having been disabled.
+		 */
+		encrypting = !status && !encrypt &&
+			     chan->min_sec_level > BT_SECURITY_LOW &&
+			     !test_bit(HCI_CONN_ENCRYPT, hcon->flags) &&
+			     hcon->sec_level >= chan->min_sec_level;
+
+		/* The requirement of the channel may change under chan->lock */
+		unmet = !status && !encrypting &&
+			!l2cap_chan_sec_level_met(hcon, chan);
+
+		if (!status && encrypt) {
+			/* Encryption completing with a security level below
+			 * the one the channel requires is a downgrade, don't
+			 * lower the requirement of the channel to match it.
+			 */
+			if (unmet)
+				downgrade = true;
+			else
+				chan->sec_level = hcon->sec_level;
+		} else if (unmet && chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			/* Unlike the other channels, l2cap_check_encryption()
+			 * doesn't handle fixed ones, so encryption being
+			 * disabled is a downgrade for them as well.
+			 */
+			downgrade = true;
+		}
+
+		/* A channel that is not established yet is refused as soon as
+		 * the link doesn't meet its security level, while an
+		 * established one is only closed on a downgrade since
+		 * l2cap_check_encryption() handles encryption being disabled.
+		 *
+		 * Enhanced Credit Based channels waiting in BT_CONNECT2 are
+		 * refused when userspace authorizes them instead, since the
+		 * response of the request is only sent once all of its
+		 * channels have been authorized or refused.
+		 */
+		if ((downgrade && (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED ||
+				   chan->state == BT_CONNECTED ||
+				   chan->state == BT_CONFIG ||
+				   chan->state == BT_CONNECT)) ||
+		    (unmet && chan->state == BT_CONNECT2 &&
+		     chan->mode == L2CAP_MODE_LE_FLOWCTL)) {
+			/* There is no way to disconnect a fixed channel at
+			 * L2CAP, so drop the link, which takes down the rest
+			 * of the channels as well.
+			 */
+			if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+				hci_disconnect(hcon, HCI_ERROR_AUTH_FAILURE);
+				l2cap_chan_unlock(chan);
+				break;
+			}
+
+			/* The channel may be removed from the list */
+			l2cap_chan_hold(chan);
+			__l2cap_chan_close(chan, ECONNREFUSED);
+
+			if (test_bit(FLAG_DEL, &chan->flags))
+				chan->ops->close(chan);
+
+			l2cap_chan_unlock(chan);
+			l2cap_chan_put(chan);
+			continue;
+		}
+
+		/* A channel waiting for the encryption to be enabled has to
+		 * wait for it before being accepted or started.
+		 */
+		if (encrypting && (chan->state == BT_CONNECT ||
+				   chan->state == BT_CONNECT2)) {
+			l2cap_chan_unlock(chan);
+			continue;
+		}
 
 		if (!__l2cap_no_conn_pending(chan)) {
 			l2cap_chan_unlock(chan);
@@ -8183,14 +8292,19 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (!status && (chan->state == BT_CONNECTED ||
 				chan->state == BT_CONFIG)) {
-			chan->ops->resume(chan);
+			/* Don't resume a channel the link is not secure enough
+			 * for, l2cap_check_encryption() deals with it.
+			 */
+			if (!unmet)
+				chan->ops->resume(chan);
 			l2cap_check_encryption(chan, encrypt);
 			l2cap_chan_unlock(chan);
 			continue;
 		}
 
 		if (chan->state == BT_CONNECT) {
-			if (!status && l2cap_check_enc_key_size(hcon, chan))
+			if (!status && l2cap_chan_sec_level_met(hcon, chan) &&
+			    l2cap_check_enc_key_size(hcon, chan))
 				l2cap_start_connection(chan);
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -8200,7 +8314,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			if (!status && l2cap_check_enc_key_size(hcon, chan)) {
+			if (!status && l2cap_check_enc_key_size(hcon, chan) &&
+			    l2cap_chan_sec_level_met(hcon, chan)) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index d5663a4642a9..a6916e01d1b6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -47,6 +47,15 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 				     struct l2cap_chan *chan);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
 
+/* Set the security level required by the channel, as opposed to the one of the
+ * link that chan->sec_level follows.
+ */
+static void l2cap_sock_set_sec_level(struct l2cap_chan *chan, __u8 level)
+{
+	chan->sec_level = level;
+	chan->min_sec_level = level;
+}
+
 bool l2cap_is_socket(struct socket *sock)
 {
 	return sock && sock->ops == &l2cap_sock_ops;
@@ -143,15 +152,15 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr_unsized *addr, i
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_LESS:
 		if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_3DSP)
-			chan->sec_level = BT_SECURITY_SDP;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_SDP);
 		break;
 	case L2CAP_CHAN_CONN_ORIENTED:
 		if (__le16_to_cpu(la.l2_psm) == L2CAP_PSM_SDP ||
 		    __le16_to_cpu(la.l2_psm) == L2CAP_PSM_RFCOMM)
-			chan->sec_level = BT_SECURITY_SDP;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_SDP);
 		break;
 	case L2CAP_CHAN_RAW:
-		chan->sec_level = BT_SECURITY_SDP;
+		l2cap_sock_set_sec_level(chan, BT_SECURITY_SDP);
 		break;
 	case L2CAP_CHAN_FIXED:
 		/* Fixed channels default to the L2CAP core not holding a
@@ -867,11 +876,11 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname,
 		}
 
 		if (opt & L2CAP_LM_AUTH)
-			chan->sec_level = BT_SECURITY_LOW;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_LOW);
 		if (opt & L2CAP_LM_ENCRYPT)
-			chan->sec_level = BT_SECURITY_MEDIUM;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_MEDIUM);
 		if (opt & L2CAP_LM_SECURE)
-			chan->sec_level = BT_SECURITY_HIGH;
+			l2cap_sock_set_sec_level(chan, BT_SECURITY_HIGH);
 
 		assign_bit(FLAG_ROLE_SWITCH, &chan->flags,
 			   opt & L2CAP_LM_MASTER);
@@ -940,7 +949,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 	int err = 0;
 	u32 opt, phys;
 	u16 mtu;
-	u8 mode;
+	u8 mode, sec_level, min_sec_level;
 
 	BT_DBG("sk %p", sk);
 
@@ -991,7 +1000,10 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		chan->sec_level = sec.level;
+		sec_level = chan->sec_level;
+		min_sec_level = chan->min_sec_level;
+
+		l2cap_sock_set_sec_level(chan, sec.level);
 		chan->mic_len = sec.mic_len;
 
 		conn = l2cap_chan_conn(chan);
@@ -1002,6 +1014,9 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 		if (chan->scid == L2CAP_CID_ATT) {
 			l2cap_chan_req_mic_len(chan, conn->hcon);
 			if (smp_conn_security(conn->hcon, sec.level)) {
+				/* Don't keep a requirement that failed */
+				chan->sec_level = sec_level;
+				chan->min_sec_level = min_sec_level;
 				err = -EINVAL;
 				break;
 			}
@@ -1019,6 +1034,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			else
 				sk->sk_state_change(sk);
 		} else {
+			chan->sec_level = sec_level;
+			chan->min_sec_level = min_sec_level;
 			err = -EINVAL;
 		}
 		break;
@@ -1284,6 +1301,17 @@ static int l2cap_sock_defer(struct sock *sk)
 		if (!have_conn) {
 			release_sock(sk);
 			err = -ENOTCONN;
+		} else if ((chan->mode == L2CAP_MODE_EXT_FLOWCTL ||
+			    bdaddr_type_is_le(chan->src_type)) &&
+			   !l2cap_chan_sec_level_ok(chan)) {
+			/* The link doesn't meet the security level required
+			 * anymore, refuse the connection like closing it would,
+			 * without releasing the channel so it can't be
+			 * authorized meanwhile.
+			 */
+			release_sock(sk);
+			l2cap_chan_close(chan, ECONNREFUSED);
+			err = -ECONNREFUSED;
 		} else if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
 			sk->sk_state = BT_CONNECTED;
 			chan->state = BT_CONNECTED;
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index e6af6f5f5914..66c88390ca88 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -852,6 +852,7 @@ static struct socket *rfcomm_session_connect(bdaddr_t *src, bdaddr_t *dst,
 	/* Set MTU to 0 so L2CAP can auto select the MTU */
 	l2cap_pi(sk)->chan->imtu = 0;
 	l2cap_pi(sk)->chan->sec_level = sec_level;
+	l2cap_pi(sk)->chan->min_sec_level = sec_level;
 	if (l2cap_ertm)
 		l2cap_pi(sk)->chan->mode = L2CAP_MODE_ERTM;
 	release_sock(sk);
-- 
2.56.0

