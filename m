Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792575333;
	b=Alw1bnoyTitTRPx+7bHKArr2IS0xRcgtfMeuWiXD/kf9LD/xajGY7GYqbgP5GjCZFfqe
	 AuEKiq8na9tcmatovdbgsT0uTA26B2sUlM5U/L27PkiqlsVrBMH7H+5/jzish3Q0ysFlq
	 JllXGAOX7tabzcNI+b3Vsr6xx3kJlh3MZ4NAVpUfJIllYfjQ4zOMbqELgrH6P2CEFp3b/
	 oo5/EZwzxZwCrHMBV7WVMlb6puxxnCukGXWt6RZv/8mZFdOTYx0yYr8cVpxH+yLEyEwHv
	 mxYAku5ozpZ6+Y0lKNpD8wo64Tsj6WQPYhILB/9pQOKFI/5INVbhosyAuclymhB+znQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Qpy79RFwgt3GKedmF9Rhg7N96RjtCmNvGJAIiKOFLUA=;
	b=v9O2z2OXLDnJubopNjki0dxJYd63npdDPZWcWWYxcdVBa3yO2hL/RNGslW7KRbMHcgn7
	 Dw180JxAcwgpvjKiLTCkG7+IHrAXvr4ahvKYDVyGXieezptZEaDwp4Zk71tHdwHcJzZQ9
	 8v9zgsRxFeYtqaN3FrTWm5Q5+Vt94L67fgc8Nl4cS0uuiwLXTAPrvN2OfJn8N1phTHf1m
	 dLACaYzXK0fE5oZgBTvgYrZr1TNiWqR9YpnMnXWf/gIVzlCNmLSeYfi7yo5FIigR8u4bg
	 fPaLY5XxqUjpJAQi9gNC+MB+eMZAaLc45xOsjNUvp1NdHqqC1iiIArZNaeanwPJ5C2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sfomHs9I;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC49606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 09:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC49606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sfomHs9I
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6d7e06dbcccso295746eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Oct 2026 02:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792575331; x=1793180131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qpy79RFwgt3GKedmF9Rhg7N96RjtCmNvGJAIiKOFLUA=;
        b=sfomHs9IHpeMX13pWs8/eFvKRI8o3ibEZrUY4T7gJKzxDNYy1AXbaeLheTamgEEd0X
         MMAkDqftcspf0lX0FYP7pd4/nBriColbflOtlB4LCbRLi+h0jMFYDHqLtst1TKdo+DXs
         /Sm96HriYmo4YrmRlaOFEgAyScGIw8+ayrD2WnybPwBuokXSSud+2Sa2edCfrry8VV+O
         wx/tUpjhCW3yCl96d30CSE47ns6J8B/5N5zcfuZyfMsyWrLvscToxvsYuq2xQHm2hSml
         Lj0ecmGmlBbLIGHsvQ6DD+/C5FtoVk47Hmd4ahHe3v/7tEWlhqY5IRxCgJ3G0Z6OOd8Q
         G0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575331; x=1793180131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qpy79RFwgt3GKedmF9Rhg7N96RjtCmNvGJAIiKOFLUA=;
        b=rbhIahVTSPBdN6fYTpxsrrUcf9RbKuBiJF16d9JZlerBP7G5h75Imybj/v1OHiQsmV
         mOv9pVoUT2YIGCNCPE7QUNdexumAFtg2+aKg7BHffyzvY3xblomOOVVzNGQTUqsbu8U3
         mG1e94t0/IiyKo/VxwgVB8sFS1UC1nT8J5vzXg4QBmU3sjxacLz52N2FTFN3RqBjCx5A
         BM2VMPrgFpmAxZ5K2nFsS67D+uMEanvTUAjXvOebEDPqFUH3zONzXDAYRdVs7OpnBiyN
         m2xgxQpGs/oaWfADoX1Uj7up/TAEKEm9Tn7GWvMHF4ZHDlp16NsMwlP88Kyet7GUxtRm
         x38w==
X-Forwarded-Encrypted: i=1; AKwUvBwuUMVbyX/oO4yVa1uJZPlbtHtnMWR/GqD0QhAg8iqOZ33mDY2EozeyeCkJ69wlQZ1xNf5EOWDHMTFWCu3vIJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIUSrF7SiVwRzJRBrlN7hnqxSdYno6iFuQ/ft8lYWMaNGlhpWe
	RqRza0wF0oQ7wKW05BOrqkdp7bMD36XwfVlOgJlVwez+PKytyNWJ9ywC
X-Gm-Gg: AYBFou2Hj0v/tDnkhGy/OKymQnn0u1zcaDj6jgY5lp5naCgeWIc607Oz4rdAGNY2kbq
	7XqEID4ckfCWvL/3ROGB2eWo6mq9PByiqwWfpUOWXpBCzvhaV56AAqXds0VHLYRhBKqWU2EUoQb
	PZsc77r6aSzCgpWvKRitJytRoosf1DeCSm05RT/Yspvi94pjJPzPf6uLmRDfWohXS5MzxdbBhkv
	AuenECdcwVfEqLBQED6qdt4aGFQDvqT0xsTJf84DlOCUl+5L/Kd0QVTvuAl7OOYLAIUX5E9+rVH
	W1qlMRmOlit6ObwO5FWPmaIR4MxIWzWqnCabD/k8pLipR+0v2kg3uvSruMr2krWxRqffpsAgUGN
	vBq5YO1u/OC/8MZ8fQy98gJLorKT9JFbCYWezSv50EmLbqlOuJoC1tKAx4pzYe1B96oefPGTlH1
	owQt00PRdTaq56okF2bU40DheD724FUTKdN5XthycSewt7OJWpe4TO/tm5j8N2S/EZwI4inW7MJ
	RsQ+cOTwcEAV1nfQHqaO1P7Oo75usoavfhRqbVHWsxkZ1k7V0N6AQ==
X-Received: by 2002:a05:6820:16a4:b0:709:1cc3:ddee with SMTP id 006d021491bc7-7093fcba26dmr691591eaf.30.1792575330925;
        Wed, 21 Oct 2026 02:35:30 -0700 (PDT)
Received: from linux-691t.suse.cz ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbc7d9b0fsm1908308a34.7.2026.10.21.02.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 02:35:29 -0700 (PDT)
From: Chun-Yi Lee <joeyli.kernel@gmail.com>
X-Google-Original-From: Chun-Yi Lee <jlee@suse.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Chun-Yi Lee <jlee@suse.com>
Subject: [PATCH] Bluetooth: SMP: Fail if the X coordinate of remote and local public keys are identical
Date: Wed, 21 Oct 2026 17:35:22 +0800
Message-ID: <20261021093522.3536051-1-jlee@suse.com>
X-Mailer: git-send-email 2.51.0
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

The 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys
are identical") patch be introduced since v5.13. Looks this patch can
handle the CVE-2021-37577 issue. However, it only checks if the full
64-byte public key (X and Y coordinates) is identical, which is
insufficient.

In CVE-2021-37577:
Bluetooth LE and BR/EDR Secure Connections pairing and Secure Simple
Pairing using the Passkey entry protocol in Bluetooth Core
Specifications 2.1 through 5.3 may permit an unauthenticated
man-in-the-middle attacker to identify the Passkey used during pairing
by reflection of a crafted public key with the same X coordinate as the
offered public key and by reflection of the authentication evidence of
the initiating device, potentially permitting this attacker to complete
authenticated pairing with the responding device using the correct
Passkey for the pairing session. This is a related issue to
CVE-2020-26558.

And base on spec, the remote and local public key should not have
the same X coordinate:

Bluetooth Core Specification Version: v5.4
(7.1 PHASE 1: PUBLIC KEY EXCHANGE)
"If the two public keys have the same X coordinate and neither is the
debug key (see [Vol 4] Part E, Section 7.6.4), each device should fail
the pairing process."

Bluetooth Core Specification Version: v6.0
(7.1 Phase 1: Public key exchange)
"If the two public keys have the same X coordinate and neither is the
debug key (see [Vol 4] Part E, Section 7.6.4), each device shall fail
the pairing process."

Update the check in smp_cmd_public_key() to only compare the 32-byte X
coordinate of the public keys, making the validation strictly compliant
with the specification and effectively mitigating CVE-2021-37577.

Fixes: 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")
Link: https://nvd.nist.gov/vuln/detail/cve-2021-37577
Signed-off-by: Chun-Yi Lee <jlee@suse.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 2df303f6a38f..80128b31e631 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2734,7 +2734,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * not in use.
 	 */
 	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
-	    !crypto_memneq(key, smp->local_pk, 64)) {
+	    !crypto_memneq(key, smp->local_pk, 32)) {
 		bt_dev_err(hdev, "Remote and local public keys are identical");
 		return SMP_DHKEY_CHECK_FAILED;
 	}
-- 
2.51.0

