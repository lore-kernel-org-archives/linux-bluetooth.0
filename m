Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC739891F
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434037; cv=none; b=sK9SBdF2585r7Y2hvFzPLp7KSRFQhh2yp56OehZ3L1Y03vSKfbpBndeiYVuYfRVOWz94bnkrWmKV9cxa+D+ileDylRD77zLv6dk3OYd586K6mgK5JSj0Eksy4xA9Zry7VB8cJb8JC2a6mkpr7MG7KddmFq0FMwBOMch2HtWxJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434037; c=relaxed/simple;
	bh=1VICLYTtT8TpkDFPVJf85WdgCa9waJ5stKoKHelrvLQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6QWoHUVC1kMADLbEocMYWxZqPzH2zCJc8aEMb1CPI4xIG8F7nI/1Zr18yKKc1qd0i8eAcoWhhTUZWgd9AX+PQp+3tPmYJ1EAQ1cKLiM8XNtggFneRJOvq4AUBMCKkIjsWwh7LkhKsykcKqLgT8bfbh6loBEc1E5N/1Cn8eS7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpSup+Tr; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpSup+Tr"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9639b1ef167so1634522241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780434035; x=1781038835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7N9eqTcdvHE0GcR2OZ5t0K+PXwREL+74RQ/0cgTyDM=;
        b=qpSup+TrHuZU1tcLw/K+pVx//bxDbOwVTsaf0Oib13psZhlcgE7WGlGmUwlhTRStZ8
         hqRK727Qglo8w30Co8Gp2Blh/vCy18EYDLpJ4Z7e68tDM85cfAjJaOg81cSb0KLLLUrh
         L4yW+r77Kz5t6m9ZFPEf7BIaNdYvuhqrl7q7Gj0qAIWNS+1hNVUfQIvX1SR6CFuDMx66
         +2IG58vSCPxCUPtKh892y7W0XznVVy2vUYEMxyTu1OsDLSQWtTGGVg9FR2yDeRVD15GJ
         /XzpZYTIT/AAyX9sRPclMnzUzgwLMKuRMhbF6aP33uD9So/2gdzQdu7/n88pmctPiNS4
         SYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780434035; x=1781038835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m7N9eqTcdvHE0GcR2OZ5t0K+PXwREL+74RQ/0cgTyDM=;
        b=KnweW0LHyGqib3MNM7g0LUW8gBflafL79JpBcDvQHKS4gaRjaPOBs3hMZl5KW4cHPG
         tbf4kxLBZGNK/IELwscgcpvT4Nhpxkede9roKQRnm+g0WiyMBGwcLVHoFAaVEfCtt43g
         clqtZ92n85JMuUnuGocgPUKQfKP8RnjvYhBMiRv2Ta8ig+25aCs5i48sp4ZMvIdar8jZ
         Jj6/EkmD08gmH/5D6JXgTG0v45yx9VSd+OXhVDQ0JedIz1cQ4zjHVu7AHhaKm95vsHit
         P8v/HIq1NzkopWBguZkJOvHEJOMUiwxY1devQhYXOKdDMusFTtRZFfTQ/cqDPdPQf84q
         gJVQ==
X-Gm-Message-State: AOJu0Yz1vV0vIcyqvZfdqrr4Pm4r9S17dvyOKJ1PeqdIM9B4MrM3lorS
	XwP6HiZxL5pTbYSERXNcufQvTPuoEmBPPwJFyetOj1QBRNLmPLT12p96g8DuO+haqNs=
X-Gm-Gg: Acq92OEiDOzffFwp//9oj0Cai1a09+kITn/CKvgz1HsBkXa8gY5LLYro3jM+fcwvhaX
	vX8C9SLylRAfTXVlZlicDpLVy2ucoV7/dRDVbXdqDdLoCT8Nrp1bPREZdqw/8Y+uyDAFwBc9uG8
	RY/wvZ2gOerwByVv56n/YSe0pCsAvrciw64e2tOePItKCFRjbTj8nchYIl36fzr8kzHNefiz70G
	gmSBdLOKtWmYirhTqAd4rUfxn0uS/iKxpaiuyJWC2GlENDQ1A4CtIn587OyWEP/5IP9eZCcKC3S
	o4cvYyB8pDxqbtsObSb8C8DXpvbhUEBR6jOMbsKOUrs2NfWgViHwCb+RbHVc2RfK6dpnOY/dYp/
	UV6o6dkQ142d6Z4sNIoZrDcA5+pThXsqKCYOChY+jNsf2CTKumWLrkwDL4jvry01oGpI8qUn59Q
	yfPV5K/6I/Do8ZMbsSqdztzfwiuTbbKjU8Fjk1bPA41lkquDKexlBpwOF9C1CXjQAAlXfTOhepA
	lwjT8NaE9hdkYFXUdRALdG7wxjv
X-Received: by 2002:a05:6102:32c4:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-6ec4881b223mr195146137.25.1780434034711;
        Tue, 02 Jun 2026 14:00:34 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb6668702fsm496943137.10.2026.06.02.14.00.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 14:00:33 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] profiles/audio/bass: Fix delegator reprobing after disconnect
Date: Tue,  2 Jun 2026 17:00:21 -0400
Message-ID: <20260602210022.213562-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602210022.213562-1-luiz.dentz@gmail.com>
References: <20260602210022.213562-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

delegator_disconnect left the old delegator in the delegators queue
after calling device_remove_profile. When a new delegator was created
for the same device (e.g. on a subsequent Add Source after Modify
Source removal), delegator_attach would find the stale entry and
return early, leaving the new delegator without a service. This
caused the "Unable to probe service" error and prevented the BASS
bcode exchange from working on reconnection.

Fix by removing the delegator from the queue, clearing service user
data, and calling delegator_free before disconnecting the service
and removing the profile. This also fixes a potential use-after-free
where delegator_disconnect accessed dg fields after device_remove_profile
could trigger delegator_detach -> delegator_free through the
bap_detached callback chain.

Also add validation in bass_req_bcode to detect and discard invalid
(all-zeros) broadcast codes that may have been stored from a previous
connection.
---
 profiles/audio/bass.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 5eb7bff076bb..a5ef80fbc835 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -257,9 +257,17 @@ static void bass_req_bcode(struct bt_bap_stream *stream,
 	}
 
 	if (dg->bcode) {
-		/* Broadcast Code has already been received before. */
-		setup_set_bcode(dg->bcode, setup, reply, reply_data);
-		return;
+		uint8_t empty_bcode[BT_BASS_BCAST_CODE_SIZE] = {0};
+
+		if (memcmp(dg->bcode, empty_bcode, BT_BASS_BCAST_CODE_SIZE)) {
+			/* Broadcast Code has already been received before. */
+			setup_set_bcode(dg->bcode, setup, reply, reply_data);
+			return;
+		}
+
+		error("dg %p has invalid bcode", dg);
+		free(dg->bcode);
+		dg->bcode = NULL;
 	}
 
 	/* Create a request for the Broadcast Code. The request
@@ -376,20 +384,37 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static void delegator_free(struct bass_delegator *dg);
+
 static void delegator_disconnect(struct bass_delegator *dg)
 {
 	struct btd_device *device = dg->device;
 	struct btd_service *service = dg->service;
+	struct btd_profile *profile = btd_service_get_profile(service);
 
 	DBG("%p", dg);
 
+	/* Remove delegator from the queue and free it before removing the
+	 * service profile. This prevents delegator_attach from finding a
+	 * stale entry when a new delegator is created for the same device,
+	 * and also avoids use-after-free since device_remove_profile may
+	 * trigger bap_detached -> delegator_detach which would otherwise
+	 * try to free the delegator again.
+	 */
+	queue_remove(delegators, dg);
+	btd_service_set_user_data(service, NULL);
+	delegator_free(dg);
+
 	/* Disconnect service so BAP driver is cleanup properly and bt_bap is
 	 * detached from the device.
 	 */
 	btd_service_disconnect(service);
 
-	/* Remove service since delegator shold have been freed at this point */
-	device_remove_profile(device, btd_service_get_profile(service));
+	/* Remove service since delegator has been freed at this point.
+	 * delegator_detach (triggered by bap_detached) will be a no-op
+	 * since the delegator has already been removed from the queue.
+	 */
+	device_remove_profile(device, profile);
 
 	/* If the device is no longer consider connected  it means no other
 	 * service was connected so it has no longer any use and can be safely
-- 
2.54.0

