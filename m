Received: from mail-vs2-f35.google.com (mail-vs2-f35.google.com [74.125.227.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DA4D0A0A
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 17:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222756; cv=none; b=XccyN++Fc0/0/6bkkCepknPDrfgmuc+D67p/WfZ+RXpy2uFwDOMLO735x2f5CFvk74jIg1xdO3Owwd3a4Sh+MubvWQD2E9vHEriGww+X/wTMEP5CnY6ximohNAWOhbwb4tYXUAkuzx8nyfuTy0T80ZC3gvg4JUdBTSQK2KQMn7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222756; c=relaxed/simple;
	bh=173lNItfpjMro4Gvtkkqy/SPRw/DA6J+B3UiFChl/Po=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBHK+BzySSlrZzQsyqXpgEhyGG35cHTF7bWSpSw3Vdv3ruRgJRLmmjoejDVbAwNw1PhvjLZ5HOyDt236nnYNCJZRo/L54GRESmK0SwuE7HdGjSkUMJ2AoqGdGqN2PZBRREVhpUcuQQjYI5+W72T/kp7X0fwK0wBk/Bv2QKfQyaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mt8NebUK; arc=none smtp.client-ip=74.125.227.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mt8NebUK"
Received: by mail-vs2-f35.google.com with SMTP id ada2fe7eead31-7bf9002ce96so576301137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791222754; x=1791827554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nbqgG7/uPM5UUmCmj1jybH+69pmIAI/9F5gKi5QPagc=;
        b=Mt8NebUKOh/Nz+UbSwDQGWje85Vdpx/GcNm2ZBbJQCYu5C+YSir/DmvsLVgqi09ii0
         fbzFy5Ka615hotQGHKaX46l5RjFyWmMEwNN6dFflp7u74Xk/tGZBwHK88jSDiQaV3p+Z
         tjVU1xLgnpiXOqH4iX/arDujwKAP+Ev0AF3/8j2BlciZZM8Oc5kiHSc377KqJUYxSYsm
         qx+oAUh/6OGGZjIDNJjsQWCpzbp/z0BWch7PW+yYfrS63LRyBEeJBltt+hmVC53v/RHH
         hnA4956lhFU+/EZASmvqTjtkZhAfm4hcXAvapAKVAei4ppU7QdlpwDtsWZFZsjOwruQW
         1C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791222754; x=1791827554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nbqgG7/uPM5UUmCmj1jybH+69pmIAI/9F5gKi5QPagc=;
        b=w5YBMefFvMe/B7mLx6qNOx8Z0c/aD6iM0Ya8jxoOi+2PmofzXL20g22LUEuXB8m0JX
         lVK4wAwamzWcg/p6IyN7QV2AQiHESHwfBG6ducqkFmQ7YEFemA5iAk2H97EcjhuVARS0
         SXbtj26svqvxYVXumOyA22K+KtWDywhAJ+npwAKFSNgdQRnktS70FSxvHjh53usLEQzC
         uf9eBMd9zsAkCrafOMIyJDB3s3KcNx/y7fNMuHh4Q6nubxeBzyFFpsnE4Y3WdQjFce7W
         x0XbaNSOtMpgGIuiwf68iwbDmjmicP3BsqoAIprUrp8iInMbCfIL5tM1JkYGBV1+KyAr
         pw/g==
X-Gm-Message-State: AFq9FYLHBEIqYft5zdSMik/wfuegSSdwngvjLPdEMKov7rSj+tMaxPeN
	45pEECzRSGWHnTZMjyB3Rh5ckm+6TxAmIjV0WwhHIHmk0tVmOcUpWiHWLSiOSLaS
X-Gm-Gg: AYBFou1B3HCtAsw2It39sd572egssD4tyWWY6YeW2WI0fMoGZ1GyoD+IIned4mGMEDT
	42nywZDkl/hMWcpBGTdXDfoOFsrWmDw0pbuBqcyr89uIRhybQaGsaRMSbKzixx4mcY3Slk1Lnx5
	blcvr0871O1ZIydMnS35E3ZEp+z/4oLydiwje1dIffh5y8RsmhsXWefKQiMbQtr7KNxXVWv6SKW
	e7lm/NECvyWhVVDUQkMGqfWCPIBiSmtiPCqf1RKE15YFY07FR9YS1sSaA90/YLhqj6gLER/eTbM
	hC9XwtucQ1246YROEkqXA/lcdz6aqTJdoNG4Fyjac9AZ88OBvEByZl1iR2jBLWesZT4uB1bYjZ3
	TVze9yr70iFo1hoFmA3BNwoUX1C9FbKO13vIVWImYtNU5mT8pQ+2v7edDrqiADLLcbvaUzIPaFt
	PUBY1YtnYPbW+khjK34ioOXdVYkpqpQ/FJq9DCPWWYMhEVNyzSV+LqKwh5f0x7MDN8HWjTfjU+c
	dsfN7wtqzKPs0IAvBhGT576Oa2UzO2b9O7VgGur+QywZcpT/NtVE5XU5WTzimwp
X-Received: by 2002:a05:6102:a4b:b0:7c3:7286:b7ea with SMTP id ada2fe7eead31-7c37286c9b4mr1140739137.17.1791222754215;
        Mon, 05 Oct 2026 10:52:34 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e54eee558bsm25655e0c.7.2026.10.05.10.52.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:52:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] Bluetooth: MGMT: Fix leaking instance on Add Extended Advertising Parameters
Date: Mon,  5 Oct 2026 13:52:19 -0400
Message-ID: <20261005175219.3547838-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005175219.3547838-1-luiz.dentz@gmail.com>
References: <20261005175219.3547838-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If queueing the command fails the newly added instance is never removed,
so remove it as it is done when allocating the pending command fails,
but only if the instance has just been added rather than updated.

Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 93872a5fc39c..34de73aaf90f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9361,14 +9361,15 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 				       data, data_len);
 		if (!cmd) {
 			err = -ENOMEM;
-			hci_remove_adv_instance(hdev, cp->instance);
-			goto unlock;
+			goto remove;
 		}
 
 		err = hci_cmd_sync_queue(hdev, add_ext_adv_params_sync, cmd,
 					 add_ext_adv_params_complete);
-		if (err < 0)
+		if (err < 0) {
 			mgmt_pending_free(cmd);
+			goto remove;
+		}
 	} else {
 		rp.instance = cp->instance;
 		rp.tx_power = HCI_ADV_TX_POWER_NO_PREFERENCE;
@@ -9379,6 +9380,13 @@ static int add_ext_adv_params(struct sock *sk, struct hci_dev *hdev,
 					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
 	}
 
+	goto unlock;
+
+remove:
+	/* Only remove the instance if it has just been added */
+	if (adv->pending)
+		hci_remove_adv_instance(hdev, cp->instance);
+
 unlock:
 	hci_dev_unlock(hdev);
 
-- 
2.55.0

