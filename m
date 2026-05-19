Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39971367B85
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214698; cv=none; b=Dy/nuLHsLNPyzCEj2odc2CFVT1FYGnWnWwqRboV8V0QLxeLjxxLEa1w+0v0duw3pIw2K7t//3mzAZK9vfisTQnwSAsnrjRMvSKFxzW8NeVFUodjwqlsn8e65IXnf7ilKRL8GXpYqgmsjf7QoVSS7AhGrlIFr71IsJXPVmqNCP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214698; c=relaxed/simple;
	bh=eXHp82baqxaLH1q4iRY469trvVd0cOQSdBovZjXWxvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAcBa92irGMNKnqc/3F+twl6FTk6Pq4ViK9K2m0BoitxLnpecTGWzRkxZhlECJq2GMfA4HUh0kUIsW0UgiCnJOz/3A/CkEC/Y9LGzX2BPUsaE1Waua9LkRBVOFqPyZQuzXzDLi93T9edpWLW9qw9z9TLstX1nrDTRbz2b3fCbm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtGfUqBY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtGfUqBY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4585a116a4aso3212726f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214695; x=1779819495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqmfQ0wqvW/5YkQLpj5T9YPDYLhpHMgWUpuXe2X6Ab4=;
        b=qtGfUqBYduP1Yqkr80hR5CRBMSAVJ/GH5tic7dtOMSJy0cHxqs0oYFbEFMJXPIyDMa
         vt5BYb2doWXGl5USANsICHwuIr8zrTlwZMbvyV59toTY14aIkI/DTpmKJ2VUQKu0iJx2
         jG4TI6zNHoT9cAeRSG85IGvVr0weQpp02Mx8kUTlXQyJkmaGFdDk01FuOzomnKzuuTpz
         kEeprK3vNKmY1yuDjLIEvI/7eiLxCenY7YL+zyOIIfrnP2cA7mDd1lmp4fGBgGilPLuc
         XplfuMCpepzt/LvswZdv7UKJx2Wg58FgbM83dCvUrZk1UoVVFsRu41F9G0bbSHaIEg8t
         rkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214695; x=1779819495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqmfQ0wqvW/5YkQLpj5T9YPDYLhpHMgWUpuXe2X6Ab4=;
        b=YUBoovteiLhP0QrjkfhJDwRVhSbZD2OtfujegbMrAhkHwFmwGBe0lCSHxE8G96uANE
         rmKlrVGTx2LkyycggfoTZ/En8IAjOdHpJK5dodWcvgrDWYQk5av7Rvcv5B/oCmmkQbWO
         5rmHuhvfrdJzEI5uNwHxvWS+q1cuVdSf3rUn6N13CroM+5Q+FZ6YScF+gIZIMNiuzJeH
         1n+ayw/oI5Av/jjhCsZTOSSj7ICkDiP4+UdzkdeGV9XztsN7F6mMjKMRwgm47iivQN4r
         CqC9tV+NyFvFpYlN1/X41TSEOyn/+/Rad/JC7xK66egywQcPlu8+E1bAIxs+lnxaxnR/
         /a9w==
X-Gm-Message-State: AOJu0Yw/bPFQdjgLBcRDXkVILw13bHMBD2N/Q+wcpxtkGWFmJ+UCDyYh
	l7QIdKIltWFzxQIYTxs0YAFcz1SgOt6Qcb9c4YXbstIQJaYWRlGVyCzLL9W8GeLMmnTuEg==
X-Gm-Gg: Acq92OFzIyTGTuApAKKL8puVwoyyCOMbGtOqfE9rzh8QBhx756RNn8W/bRpGnFh2Xdo
	USSIGDPYcBg1uKn0uRgONhFjTrm8OhZWKYxVi5Iv5yjmTdt/PNR5W0QwB49yRuz44VJOfQYF6pB
	v8nLWKaNXFWHjYA2zIpMpTEtQiVE61HUd6Ct0zWw28tQuDnlkNlY5Jk7AISvg9Q1Quii5Ldx0sD
	6UQCdicVVyDh6vdrG/dOS7Wc8z7vRqnU/RjbMN7pPNM8/ftzPXT+8SDuFk5PV37NbszssquuaNY
	MQUuQN2gtltDrUr0BeLCNXqdbUiqmx5I2+WAqjAanMdd9fZLEj1GljSvlhTG3VnAttUo4syzFXB
	SVdi+z8Bk6HTxr7M22pIJM+ROut6oBi6ZfvBxjlm2bWKy7JMMWKmABDMOK8IC7n7F5rMyQdYgDJ
	/mWbeEtDmdbgj262FIW3ZAHQv+eQcNKvYBiMjgwB7lxReuzMaHZk62fS8wsaTEwzizNj1RKXVmO
	BEhtROFQLBo
X-Received: by 2002:a05:6000:1845:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-45e5c57d2fdmr33277547f8f.6.1779214695304;
        Tue, 19 May 2026 11:18:15 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a1aeafsm49915487f8f.23.2026.05.19.11.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:18:14 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v3] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 14:17:49 -0400
Message-ID: <20260519181749.15746-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519042017.29564-1-meatuni001@gmail.com>
References: <20260519042017.29564-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
immediately dereferences hdr->addr and hdr->ctrl without first
validating that skb->len is large enough to hold the header. A
remote device can send a crafted short RFCOMM frame over L2CAP to
trigger an out-of-bounds read before any session state is checked.

The FCS trimming code that follows compounds the problem:

        skb->len--; skb->tail--;

If skb->len is already zero the decrement wraps to UINT_MAX, causing
skb_tail_pointer() to return a pointer far outside the skb and
producing a second out-of-bounds read when the FCS byte is consumed.

Replace the open-coded cast with skb_pull_data() which validates
skb->len against sizeof(*hdr) and advances skb->data atomically.
Save the original skb->data as frame_start before the pull so that
__check_fcs() receives the header bytes as required by the RFCOMM
FCS specification. Guard against a missing FCS byte with an explicit
skb->len < 1 check. Replace the unsafe skb->tail decrement and
skb_tail_pointer() call with a direct end-of-data index and skb_trim().

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

---
v3:
 - Replace open-coded cast with skb_pull_data() per Luiz's review
 - Save frame_start before skb_pull_data(); pass it to __check_fcs()
   to preserve correct FCS validation over the header bytes
 - Replace skb->tail decrement with skb_trim() per Luiz's review
v2:
 - Fix GitLint B3: replace tab with spaces in commit body
 - Add Cc: stable@vger.kernel.org
---
 net/bluetooth/rfcomm/core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..66eee8a86 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,23 +1741,29 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
+	u8 *frame_start;
 	u8 type, dlci, fcs;
 
 	if (!s) {
-		/* no session, so free socket data */
 		kfree_skb(skb);
 		return s;
 	}
 
+	frame_start = skb->data;
+	hdr = skb_pull_data(skb, sizeof(*hdr));
+	if (!hdr || skb->len < 1) {
+		kfree_skb(skb);
+		return s;
+	}
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
 	/* Trim FCS */
-	skb->len--; skb->tail--;
-	fcs = *(u8 *)skb_tail_pointer(skb);
+	fcs = skb->data[skb->len - 1];
+	skb_trim(skb, skb->len - 1);
 
-	if (__check_fcs(skb->data, type, fcs)) {
+	if (__check_fcs(frame_start, type, fcs)) {
 		BT_ERR("bad checksum in packet");
 		kfree_skb(skb);
 		return s;
-- 
2.54.0

