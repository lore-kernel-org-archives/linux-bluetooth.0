Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C20346D2AA
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296115; cv=none; b=KstrbQZpXcGKjnLEJ78p0M39x/GPEdKqC1UHmpYHqZuq6JpGJ9xGh2jTOeCgcWXnk1PbaWNST0LHJhRtd2lTFA4AkJOC9yZoCys5+z8Ub9uCQWtfei9uWyW8M99a83NsyNNate4bPRWnMStbf9pVP4h7br6Z4qEnLoErka4Xnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296115; c=relaxed/simple;
	bh=VZ9AhH8GNxPD3BtJGBAYbVUfZQKYdMQ1AmQEDJqmp/g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFhgAH9brJqPOaJmNgBGtJqLZE1Zv2i6CqjwgUe00ISlQBmuSsuhGH1KxA13rhNMBVZOOW1+la/L0+uEIOmLpxUybrICU5CGAWLmiRt0u+mWT4yBrHBhZIvSaeiLCbdH+FK9YrXtWfrr/UxbP3enCbJvixTcJjbSB+dFSbxeRuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP9023zo; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP9023zo"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9851592ada1so195465241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Oct 2026 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791296112; x=1791900912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7bhefNdw88FtFQ9EFc6hGDUTzndekuRxJ0kKKppfGoA=;
        b=CP9023zojdQNnO9U+RZvoFA0pQ+/HnX3nz/FsKPk6agGBVyFKHWEMHEsfWK9ZwI1gD
         LUB5e+Pz/kIC1hzxQScAlPxC3/AsHKqokYp/NjhNOn1ju5hsxphcg9Q6izph5moAx4uK
         oHGHbWdgxUrfflALIBPdbjcfxSa5uWhacfsHPyJQg6KikX+RWR+R77La/CzwjlRqp4Au
         /LLI1uzQZLJZGTFL+ixSWqcvtDAHREbhubueYHXgrzIIBoT6iPGy0i92zvGLU9wpqZEP
         6antbbzusZSERZfaszi6PeiNhQjeym+lZwKrLLpxw5tOiOQvYNcOWTJALECGmrdOrHls
         ctsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296112; x=1791900912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7bhefNdw88FtFQ9EFc6hGDUTzndekuRxJ0kKKppfGoA=;
        b=PJrNRFc/HQKnBLuFeR7TR2nc/WVDbXd5V/Mq6zoX015oXXt8EVaMXZXVi8+WOQUMaW
         gZmSIb56YOZQ33UWvYEL0Ws93D6PGIpkn0AlyM7QTqx6ZSq+LbVyFfLmSYrgeCjJhJpr
         kDqylGzk5ROvbVSLcRvaeA2Dds+SfYx6929tgFhOX0KzIKOsDPGOY+6qMYkAuLMXvgvu
         jt89jVWHY8nm4T+O0cRmYK7BvFAXWLkGeYGYCdKB4OtSytTV/eWDqWAadMBuwHfnH9gN
         m/oDAxirRcZqP1upFkgby6OuoSDqKmSvbO2L/N8QqZsNFeXKN/e0lqt/4U1tf9I7lHS7
         yf7g==
X-Gm-Message-State: AFq9FYIizotVfI8lu4My4QCm13cd/LpP1shPrUfOMmaLtji7wvuRwDNr
	55gUwEjodmikmiqmJJio48sJLDC3wKLxqxSYe+U1fPF7sqsYnsU67WXCSa/IMXdH
X-Gm-Gg: AYBFou3K51AyUFXZkRF2Cx5th4EFrZjQ7bFxL0y5TnnNb2ZzQVXS+mCT8Eu204gxmbe
	5uEAeSPgrtMSPWzA2zUBXHrE77wJA8JDGQRLxJ6OjdinTq5qre0kPB9X47RqwPv5bhpYRnns1C5
	Ex4JoXHJ0sJByYH11hdFJG4hY9fAJOnzJgSMICbJkyj6V1uKzgsNTPg9Wu9X8mx6WlAGihqInPV
	l+a2NDHCXCHs/OX2AMZDR70PpmIA4nBT/bbUDR0FFTrJysC1b2Yalorgif9KSD9y6JhKAQpKK0h
	1pAvqqfQk6pPP2ln2OGJoXePdiMxdAFRiJ8LLAmuIiZkI5+p2nLY1l04K92LFOrT9gZ+IUT5v3l
	D3Y8UK9Ya4sCSQWaHHb+Z/Po8xVOM13Q7YgH3zLx1Li0MMHPCZDL1HIy+f9usWkqe3sEiMWGfvY
	cXVM6rXaS72FVYPsgHvOQrNp/SYSH3hMjLDtH2NmhDFCay7DzV5tEv2gH3SkboUfRj8js3CG5YD
	uUA/60vgp4o30DNGDCRyaWpy1/2qhNCKi/FFHoO3UiW+F1i12lPRoadTgjPp89N
X-Received: by 2002:a05:6102:54a3:b0:7c3:342d:6c86 with SMTP id ada2fe7eead31-7c879efbc10mr305898137.9.1791296111972;
        Tue, 06 Oct 2026 07:15:11 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7c0ff5c49a9sm13235132137.4.2026.10.06.07.15.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:15:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/4] Bluetooth: MGMT: Fix pending state of instances added without HCI traffic
Date: Tue,  6 Oct 2026 10:15:01 -0400
Message-ID: <20261006141502.3789138-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006141502.3789138-1-luiz.dentz@gmail.com>
References: <20261006141502.3789138-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When Add Advertising completes without HCI communication, e.g. when the
device is not powered or the instance is overridden by Global
Advertising, the instance is left marked as pending, so a subsequent
failure in add_adv_complete would remove it despite it having been
successfully added.

Fix this by clearing the pending state before completing the command.

Fixes: fffd38bca51c ("Bluetooth: mgmt/hci_core: multi-adv for add_advertising*()")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 106b35c88c98..93872a5fc39c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9173,6 +9173,12 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 	if (!hdev_is_powered(hdev) ||
 	    adv_overridden_by_global(hdev, adv) ||
 	    !schedule_instance) {
+		/* Instance has been accepted so it shall no longer be
+		 * considered pending, otherwise a later failure in
+		 * add_adv_complete would remove it.
+		 */
+		adv->pending = false;
+
 		rp.instance = cp->instance;
 		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
-- 
2.55.0

