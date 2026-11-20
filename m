Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795189700;
	b=nDJEqDcvkbNE2pKL1XF0nCFgImMJagV0zls2OqX7OxF8t9O4J3THZGrAA4m5alRFRlOe
	 hNkXoQvFEU+ToqcKt3TQWlkZq5nogL2wBvAnjoLiFeLJU/9owArDSnrfHK6gIAXp+TEX0
	 ADTyNvIpIeyZWfySQB7dSJzuNWkQvEmm2h7zb3d/4FD6NihhE5D4R+KyjlAyW06K1D7lA
	 WuIxwsREYo+lMbqyOkc+LXiQMDQhQS3oxh8dG7Tc36+5HESh1pDlBK6vCqDMwRNtRTt+8
	 3oZK+xaej5YZ4eFRVROU9UjGqpByc32xVqt1eEYpSINlGL7ksfMNYgg67YsMniKSqmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CJPMHJ5+QNS7BgDsInVXMWjPDj6K/VF97wMl0lZ+96U=;
	b=fLfwcjltKMZg1+oYjTeePcBjMu6YGjeDzDwXt1QgEwSC4kdQId4dzGg9jdIjMEYCZzCy
	 yB6lbEfMwU0EGN2wzDe/3OvJLJf+6uMxyWtfDYPp84UH6UM+3pGjhtcY2bFsjLSE5QgOg
	 /sie+gy+kC0Z38Mtvxs9uoPVuQehO5kpi5+vM+emUoB5FFQpzARHfz1oWF57vgpZX4oZ4
	 AFopLRYi7PbL/98bXAe1HSr58n2y55Szd6+M/MNFw88NvhA+hkF2oOhvSZZgEMUYcXnJ6
	 E8X3b9sSi4/mBpvZBcadOYDVNUCO+qsaLcb+06jVdY4W6LVJo4ZJvnLX2UgJGtRowTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMtXc0u3;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33260A260D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 15:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF33260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMtXc0u3
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eae12762c9so390160e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795189699; x=1795794499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJPMHJ5+QNS7BgDsInVXMWjPDj6K/VF97wMl0lZ+96U=;
        b=XMtXc0u3kT7o6uUAw++iTm5d83N/6GJfUeEyuxdvOHLG5qtclvqgl1bZ9DycvOGRcs
         0/HIhpGIhy3px/wUA9ormTZm6spnQHVuDlaQJH4knEkxcQmnskqVAJv2YLVfjC5Js2oq
         VLxfbWGw7WdQvZp2ikf+WKUxJMOOmBDfUYDx6PehdQwSextkoatAKVsLGOV8r+RbM2ly
         2JIrMWe/3vLQ8qwiWczIIHISL3yq8huUOGFsBrILtsz/3uTGhKvFnBV4KCkhOZDDbPuv
         jY7686fGEozdbU1JExgVHW3xbejLo4KXCfXva+o3xWH85PhqB1H1rCVIUUWMzWth3ZHJ
         lMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795189699; x=1795794499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CJPMHJ5+QNS7BgDsInVXMWjPDj6K/VF97wMl0lZ+96U=;
        b=hHYJmGD1Iy86kohribO5amjtQyNHs8hd4t7zWBPqq+BRxyzaLYlpVyORCYxl4CTOIh
         sVG4jiENcFjZqenz0Uzf6l852a82TOyQ4Mqotue7CJi3bD69TyDtRF6Vd9k1Skhhkdnk
         tOXyqPFa6aUP1KsHnt0Pm4acMtZUC54aphJnaMJVnj4M3dg1g9KckJvp9VPT3ac4W2uk
         ehBaQIRGXfil8Sc+R6BSIINR2bnJ2AVn0wAPPJi1zQR7IWWQo3kg+EoSec27tIuWyx9t
         2UVcFM/ZoKNLeorlpVJlURyq923wohcxer06eyEpSJawP41E7xa0ECbxqO56dvpgJpOo
         JUKQ==
X-Gm-Message-State: APuU4Z+h8yyxb6oxJPCHsz/PBYo9ywQuKEBToSAeVZs7blPB94UuWQG+
	FXademT9onfYCvLELojT5H4OFseEOPpDSVFjc4SdDfr+iB109IEFup1PnqMMRyUP
X-Gm-Gg: AZFdTZc1pYANILfVvUt1yyHUNVWRyIobm4EjkKT/QVUnbh2l8vospuvJ74xr5JpzMTt
	yIycQCbFSpC8GCiOHBAfL9DHyv8MRlWORQBCHkmhtjh29dIuuKrRb06hgsMF2i2IC1CRDB6DDcr
	jdd3rMdONU7Ab2a9k95EAe17Ef3BlW93oDyrHkLXm6bw6/Gk4DsF7nUUnrRNxCgKci4BQ9nSU3W
	m9cMCpo/F5k5yvJ0nyl/UICkUaTpyCJeJMteP6wdmeDzSkel9EH7tsNrs83CY1U995e+B1J/lAz
	Jy1R/KP02X9jUPylL9PG1ZXhVjw0wzpe8w7a8gFBqZrXHXjcLFA4RpzzV2V2JGD+5v36MmD91Me
	gxji49NydXlwDg/rBJF7hO8Bb0ktLsAOqQxAVz+s1fh6+Q/TUdaqm1lTP0VZiE35uVjbNlwqWSx
	5jXt3vt+nsem9mXP+LurcHHGUMfM+Rv79KMXaazBV3NXxcFWCnNyjYy95KGXE1j5RGfb2yo7894
	Ti+3Lkpw0ZLF5xEAj6HfCMizRt2ucLpJPBMecV9x0kyoLV79PxiOYNicSodVIkBB3EBdph1Sux+
	H41EML/YtpBulPvo+SOhVdyyeUmb/ElQXlSq3PZC1Bcv5itnIK5wqh1AtBobpbSEOQfswRX8ik0
	hC1SlA8tl041TkXy/cbXqrXCy2R9N2KAPjk7tT3pjwZn0d5VrTbizArOOk0x3JcYqRKE+5x7E1r
	m28JI=
X-Received: by 2002:a05:6122:62b1:b0:5e9:6d96:a910 with SMTP id 71dfb90a1353d-5ee8adf0e32mr1755778e0c.3.1795189698534;
        Fri, 20 Nov 2026 07:48:18 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b555137sm2830847e0c.3.2026.11.20.07.48.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:48:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: L2CAP: Fix accepting channels with insufficient security
Date: Fri, 20 Nov 2026 10:48:15 -0500
Message-ID: <20261120154816.1745952-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Fix this by treating encryption completing with a security level
below the one required by a channel as a downgrade: the security level
of the channel is no longer lowered and the channel is disconnected,
or refused with L2CAP_CR_SEC_BLOCK if it was pending, and by only
accepting a channel in BT_CONNECT2 if the link meets its security
level.

This means a channel requiring a security level that pairing can't
provide, e.g. BT_SECURITY_HIGH when the IO capability is
NoInputNoOutput, is now refused instead of being connected with the
security level the link ended up with.

AI assistance was used in finding and preparing this patch.

Fixes: f66dc81f44d9 ("Bluetooth: Add support for deferring L2CAP connection setup")
Signed-off-by: Mohammed Alquraini <mohammed.saad.alquraini@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v3: Don't use l2cap_chan_check_security(), which may start
    authentication or encryption, instead compare the security level
    of the link with the one of the channel. Treat encryption
    completing below the security level of the channel as a downgrade
    and disconnect the channel instead of lowering its security level.
v2: Drop BT_SK_ACCEPTED and the changes to l2cap_sock_defer(), only check
    l2cap_chan_check_security() in the BT_CONNECT2 branch of
    l2cap_security_cfm(). The early accept is handled by patch 2/2.
---
 net/bluetooth/l2cap_core.c | 42 ++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 943effc86740..3fc0fecdbb5c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -8095,11 +8095,19 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 	}
 }
 
+/* Check if the link meets the security level required by the channel */
+static bool l2cap_chan_sec_level_met(struct hci_conn *hcon,
+				     struct l2cap_chan *chan)
+{
+	return chan->sec_level <= BT_SECURITY_LOW ||
+	       hcon->sec_level >= chan->sec_level;
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
@@ -8108,7 +8116,9 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	mutex_lock(&conn->lock);
 
-	list_for_each_entry(chan, &conn->chan_l, list) {
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
+		bool downgrade = false;
+
 		l2cap_chan_lock(chan);
 
 		lockdep_assert_held(&chan->conn->lock);
@@ -8116,14 +8126,32 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
 		       state_to_string(chan->state));
 
-		if (!status && encrypt)
-			chan->sec_level = hcon->sec_level;
+		if (!status && encrypt) {
+			/* Encryption completing with a security level below
+			 * the one the channel requires is a downgrade, don't
+			 * lower the requirement of the channel to match it.
+			 */
+			if (!l2cap_chan_sec_level_met(hcon, chan))
+				downgrade = true;
+			else
+				chan->sec_level = hcon->sec_level;
+		}
 
 		if (!__l2cap_no_conn_pending(chan)) {
 			l2cap_chan_unlock(chan);
 			continue;
 		}
 
+		if (downgrade && (chan->state == BT_CONNECTED ||
+				  chan->state == BT_CONFIG)) {
+			/* Fixed channels are removed from the list */
+			l2cap_chan_hold(chan);
+			__l2cap_chan_close(chan, ECONNREFUSED);
+			l2cap_chan_unlock(chan);
+			l2cap_chan_put(chan);
+			continue;
+		}
+
 		if (!status && (chan->state == BT_CONNECTED ||
 				chan->state == BT_CONFIG)) {
 			chan->ops->resume(chan);
@@ -8133,7 +8161,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		}
 
 		if (chan->state == BT_CONNECT) {
-			if (!status && l2cap_check_enc_key_size(hcon, chan))
+			if (!status && !downgrade &&
+			    l2cap_check_enc_key_size(hcon, chan))
 				l2cap_start_connection(chan);
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -8143,7 +8172,8 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			if (!status && l2cap_check_enc_key_size(hcon, chan)) {
+			if (!status && l2cap_check_enc_key_size(hcon, chan) &&
+			    l2cap_chan_sec_level_met(hcon, chan)) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-- 
2.56.0

