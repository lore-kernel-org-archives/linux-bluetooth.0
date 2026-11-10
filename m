Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794281164;
	b=UJFaFhxajuMfJBMVMaLV5nBroifqi+CBzIfXEBqEoYKYTFi+lGJRtsDIlYdoQg6/mZMR
	 YvS+qf9pFWRku50w4kx7J+DESYc7h2OhkZheFX7iycYt4OkxNXgSPYJycbkzXMUOSkpTq
	 43iZDuIwGU67Nslt4Kpg/XQtyoPCocGYGmTN5i+lmCG5NfllmhVCPcmsujVgH0Qu5jd/i
	 2nNLD/FOJk57HioJtOZFftwesqrfs5GVb1PpMWysNuKHnPZe1vNy494xicyq8dWKsCZ0G
	 bhxtv31f0WMpfGxJ9sK8OKG+m/jYnWxd1VsM0lOy+9ktRanTZa9lUp+UyvSuePBN9BQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281164;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4HI+KyCMEDjW9zsyCeezglOrOMW4ap3W/K4vONE6ztA=;
	b=MGWNoKTpDkMMgAecw02v4KOkexpAOr6bTWQRVylJ0A5yrqXXqygPxaIyKRRcZ9dYb7IC
	 KMc6OVuXBW63ycS8g8ZO+aj8LS1afpZ5WvzVW787dWla3nc5aYt9p3ltxmFLBPK/Ud0Fm
	 IQkhcnWY6pb7uYsR+N0irOzxGf84AsSRiJ2oss9otlOWgpUEfq1LN0n9zAGCyw2Y31m3o
	 BWvG4YbsNvp9cOyemF7iN8gQHDsyXbX+r9D4CDikaXVAmWeuKI4V9YzixbO5kCP/aVtts
	 ZzueXDVMyb6oOKsQzGQZTG/b1DMsqcIVeTYmWoQmCU/v8LcVl04X5d1h3sm+mroQSGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcT+Yz4T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ABD606A330;
	Tue, 10 Nov 2026 03:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EcT+Yz4T
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794281164;
	b=vonfAwBXSXDIRgPdbBIC/monLynYsIsMs77/44x7N93eBstujZlBwlpWgnZmSp2d2PkX
	 ONlLazOtxjiTmQ8kbJCbGJxidGV88dNEKhDAI8kehT8ltddsimlJjiNA6Zj9FWFQd8HrM
	 Y8puVD1PCh/sCib4RFWtAlwbVQ5WpR9P7BEmaqZhtUu0u41LmWYjjACOmnoOh2xFDBFtn
	 Fk574ZUjzUoSeywvaVMfxF9u0Y4sKx5VRnReRlxjaXnlewaRRaAsjg0mrAnc0Z/9xtQG4
	 w3NtjSfML5SuiIwCxW1LlL82YZQMUbi1uLy4/1ID6jR5zN5qCcfQogequAFur41nWew==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794281164;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=4HI+KyCMEDjW9zsyCeezglOrOMW4ap3W/K4vONE6ztA=;
	b=vCRAbr36WfqRN6Mh77RkrMv1FVbHYK3nDDxyTrSoaj1Sj9qVB5KTbJv7xaOydakR9InW
	 SJoYOc0FDfg/RM1dTzC1wHc3wmIjbPa2G0E9vFbV94ToAzUat0TcXDx25XBiUhaOgnq6A
	 MJjS1uNc8hvMfd+7HoWu+FyC6xAFgO42IyU2xgxc4Ir2LVgnNwNUBfbJBEn78Nk991Mj4
	 2xO72ywpNUAlKrX3zXjNPJOR90w/PkRnlrwWyCbSA+xVuaHoXXnOO5ARi8ykSqeDF09sg
	 ZX7vs42g9shpaZUIKzE+QmAkEKg/i+486dlCeZlEL/0ry4o/3hV33nZ9t3TuVOb0q8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 809141F0089F;
	Tue, 10 Nov 2026 03:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281164;
	bh=4HI+KyCMEDjW9zsyCeezglOrOMW4ap3W/K4vONE6ztA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=EcT+Yz4TuO9gk77/dP1DTYZWrsqLa6q3eyCZpGxAD1rxCaM0tGtIyW2pL0R/UxqFu
	 HRDg1O5wKM+q6bl81/MhRXs6rqtAMJKxrH0LLyT2KAdH5alpOTqNw7lAd3/nKNIjQ8
	 Ncy7tjs3t22RQiGKdGL5tKeOi1mr+x7oOlGWwfGyXHIexA67k/Lz0xdT22ExVUZ7Ez
	 dyk3jOTasQj9CEQ5RdJAH3AaSMEDsqowdnxkZuszQzZYdKwtPI9Rh78uxnRiJMer1k
	 sxkn4bmvKi18ucfoGS2omZeUbmGadk9HRyNu7rixCUNU+Zs/K3mNk7r3yqqi9Kyztk
	 OT+/3gNHVVBJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D6AD6487AB;
	Tue, 10 Nov 2026 03:26:02 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 03:26:03 +0000
Subject: [PATCH bluetooth-next v2] Bluetooth: L2CAP: validate MPS and MTU
 in ECRED connection response
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
Message-Id: <20261110-bt-ecred-mps-fix-v2-1-48c5ee28fd8a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMqO8moC/3WNTQ6CMBCFr0Jm7RimCoIr72FYQJnCJEBJWwmG9
 O427F2+v+8d4NkJe3hmBzjexItdklCXDPTYLgOj9EmDylVJlFfYBWTtuMd59Whkx7YwVPU6L2+
 qhjRbHSf7RL6hmz4crA0jLrwHaFI+ig/Wfc/Hjc7Wf/hGSMiPO9WdMSVz8RrmVqartjM0McYft
 ExJTMAAAAA=
To: joasantonio108@gmail.com, luiz.dentz@gmail.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794281162; l=2807;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=41c1pMO3EYoT9jgOM2ha+yJ4QeOIoB1nBmapQHpxbjA=;
 b=xcFp+YVZoXkpoInhPt0D+YQxpcGwAPodG0vle5zTsQrrORzV6s5BVdGGGhmGYgWTTTk/n7iKM
 K+yAGwUSaLbBPEG1F6Bin5TDOEr/ynsOMcViu1mRKVLWjl9SaXZxJVF
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

l2cap_ecred_conn_rsp() stores the MTU and MPS from the peer without
checking them against the minimums required for enhanced credit based
channels.  The other LE and ECRED handlers (l2cap_le_connect_req(),
l2cap_le_connect_rsp(), l2cap_ecred_conn_req(), l2cap_ecred_reconf_req())
all reject values below the minimum.

With an MPS below L2CAP_SDULEN_SIZE, the pdu_len computation in
l2cap_segment_le_sdu() wraps:

	pdu_len = chan->remote_mps - L2CAP_SDULEN_SIZE;

pdu_len is then clamped to the SDU length, which l2cap_chan_send() has
already limited to chan->omtu, so nothing is over-allocated and there is
no memory safety issue.  The result is that the whole SDU is sent as a
single PDU, larger than the MPS the peer announced, and a channel is
established with parameters the specification does not allow.

Apply the same L2CAP_ECRED_MIN_MTU / L2CAP_ECRED_MIN_MPS checks that
l2cap_ecred_conn_req() uses and drop the channel when the response
carries smaller values.

Found by LLM-assisted manual code review.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
v1 claimed that a peer-supplied MPS of 0 leads to an oversized skb
allocation and potential memory corruption.  That was wrong, and I
apologize for the noise: in l2cap_segment_le_sdu() the wrapped pdu_len
is clamped to the SDU length, which l2cap_chan_send() has already
limited to chan->omtu, so there is no memory safety impact.  The
remaining problem is conformance only (PDUs larger than the MPS the
peer announced, and inconsistency with the other LE/ECRED handlers).
---
Changes in v2:
- Correct the commit message: no memory safety impact, drop the
  overstated claim from v1
- No code change
- Cc linux-bluetooth, which v1 missed
- Link to v1: https://lore.kernel.org/r/20261108-bt-ecred-mps-fix-v1-1-e7419bff6ee5@gmail.com
---
 net/bluetooth/l2cap_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4dd56e007..c3b8f0f46 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5711,6 +5711,16 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 				break;
 			}
 
+			/*
+			 * Validate MPS and MTU per BT Core Spec
+			 * Vol 3 Part A Sec 10.2
+			 */
+			if (mtu < L2CAP_ECRED_MIN_MTU ||
+			    mps < L2CAP_ECRED_MIN_MPS) {
+				l2cap_chan_del(chan, ECONNREFUSED);
+				break;
+			}
+
 			chan->ident = 0;
 			chan->dcid = dcid;
 			chan->omtu = mtu;

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261108-bt-ecred-mps-fix-a5f18dc06329

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


