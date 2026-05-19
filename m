Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE782D7DF1
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 04:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779164448; cv=none; b=O6FxDpbp7LlScjW2ao/3rWCvo3yFZrhU5nurV6L8PUqfVgotpG04D/wnH5y4jQdEQ1vNIICPUbpb0E2OilUpOWhPVrTVwjOAkIiMgtx+o4D3GbCId6j54Cre3qyXTnDjk2HJ+rwfiyRGebiZAi2WH/JiBGXTPNeWDfKnQssF55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779164448; c=relaxed/simple;
	bh=LiV0xUqYF1sDgcQ4JGiJk2vaMfz4EW5Z764wJBePVXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t7tb6awl3pDSuydToh/aIta0t6U+80Oc1gn1TkcJyHYNis5aiPot7Whl6w4p6df72v8vlPvxWZmrdagQ7kgDdg90KkFoBa3VsUVLTmGkSUy72zmwOqra16gfJINcG0a32rqfpuX3loRYTrOdpSPzCpyCu/kJa5Q6JBRlwprTYx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN+9HMmP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN+9HMmP"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82748257f5fso2535762b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 May 2026 21:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779164447; x=1779769247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUFBQc52UJfk2XrsTn834tkvWEs3F4USHaB2v8AXGtk=;
        b=mN+9HMmPwfWflA/7V+bxot6Y4Hn438kqmFqWq2bw80NYUjYm/3J1Gxto+O/muGvWuo
         OxJUihMzIi5Alo3NMs2cw2VHEIbgU4Mi/dwFz2ycRazpYswheoQUQ1coLAFQ/ojOZNwr
         LCv+SSpzQIxl4ufz6zbZbaM3Jcgvds6sIgICsa/9OymWQUqZ4oZzM9DaVBp/9NjNW0wb
         WcDvOVCRbbsOApabXyUjWNfPAiOioOTj9rJbh2p1uA/XdO88/+LIpluveUIwOFNyHD2z
         ECaet5dPLoOKGWT/tSS17wzKjnTGjxxmNi+7oKIiMyUJnUYXIXzz7YnqshMxPSJTrNmW
         tPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779164447; x=1779769247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUFBQc52UJfk2XrsTn834tkvWEs3F4USHaB2v8AXGtk=;
        b=gN+ZhM4azLysbyG0wlt68LIWVXKqqOkPBLN9q4RZncDrQ8aP2H0d+SHR1w/OvS7KjU
         Czr6Mjx1OpOPw754rwBJcH5U60ce+WnsC1KnRPH8VUMx4MP5cDxFUKzDYTSwoDNOTFrS
         6pcCGPjKaQLE8SyJWGDqeQFEusf5yi+eSD3QG314IRx4rr7LyvbEdquDQioQ8qd3LgmL
         8w5HGC9dFVMNHeWgzCoDSicensC2Wc5mChWAa3FB/XHZ4JEwaOhInDrdJj8eZ0G95FmB
         DewXL6rgNMcypu7m7b33lEC7OrOsCXJoYFKn1hGuJrSkKUPu3dEZI3PHPkBfiA25o2kL
         73+g==
X-Gm-Message-State: AOJu0YxIytNfPFNDmXvEnkeDRHZGGYkFt7aChF8ruCbGmB+f++ixuQVU
	1SgmlFi3FM57bZDH44PUcfUXNkF6AWmRxZt8qOjCOcG59twoG6peSSOroZ0w/uxjzgY=
X-Gm-Gg: Acq92OGBY6kciGw9myB3A1cQQQcPxg8nMUdb+PzpmhQOrkpNU+3D5SijMhDNwrIhBbx
	9nSSwMEvorF50RpxSUsRsf3TEgA2SmFddt2piD7ZunHQqjACMFXJ5ThT2jfa09BbD85MwOPOUl8
	0XuP7FauGFDybBV1m+CTv1u+V9U2pnpnhf4CODs44YKBVNgkdwD//i+1xR3Bp1PuDcqn4EDLPpG
	6LPqPf+CLtzwfH67x0iFOF6PTI5Os5vfL2bkig27kv0sTzW6LJbSpusGLrSAOO2gOTv416wMdf6
	tIeAtl2Qm/uH9rhypOjPaIM5rauYDXwPuzdTOHDxvNHEM2vzakKeyv3zVwjRU2/PAFqbU+KtWkx
	lcX9vE+FuT7vjtJps4HgjlMBmY4nnxy/4aItRvq4lqvWQaCP48dRY4Hk8AA5AdfpIeDHcHXqxPo
	fr6N2DaA/8fY/Xu/Z9L3JWAd+GVRpVAgL8MtLpsG/a8ISbBHzLLWsGjiVwSlowgp1KRaSH2EedL
	g==
X-Received: by 2002:a05:6a00:2394:b0:82c:7420:82bf with SMTP id d2e1a72fcca58-83f33c8a27amr13455006b3a.19.1779164446475;
        Mon, 18 May 2026 21:20:46 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b4bfsm16929148b3a.28.2026.05.18.21.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:20:46 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
Date: Tue, 19 May 2026 00:20:17 -0400
Message-ID: <20260519042017.29564-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Add a minimum length check before the header pointer is assigned. A
well-formed RFCOMM frame requires at least addr(1) + ctrl(1) +
len(1) + fcs(1) = sizeof(struct rfcomm_hdr) + 1 bytes. This single
guard prevents both the header out-of-bounds read and the skb->len
integer underflow.

Note: SeungJu Cheon posted a related patch that adds equivalent
length checks inside the individual MCC sub-handlers
(rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
rfcomm_recv_mcc). That fix and this one are complementary and
independent; neither subsumes the other.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/rfcomm/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index d11bd5337..6b300237c 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1741,7 +1741,7 @@ static int rfcomm_recv_data(struct rfcomm_session *s, u8 dlci, int pf, struct sk
 static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 						struct sk_buff *skb)
 {
-	struct rfcomm_hdr *hdr = (void *) skb->data;
+	struct rfcomm_hdr *hdr;
 	u8 type, dlci, fcs;
 
 	if (!s) {
@@ -1750,10 +1750,17 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	/* Minimum valid frame: addr(1) + ctrl(1) + len(1) + fcs(1) */
+	if (skb->len < sizeof(*hdr) + 1) {
+		kfree_skb(skb);
+		return s;
+	}
+
+	hdr = (void *) skb->data;
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
-	/* Trim FCS */
+	/* Trim FCS - safe: skb->len >= sizeof(*hdr) + 1 >= 1 */
 	skb->len--; skb->tail--;
 	fcs = *(u8 *)skb_tail_pointer(skb);
 
-- 
2.54.0

