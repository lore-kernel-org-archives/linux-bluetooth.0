Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9883229BDBF
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198577; cv=none; b=IKT30Go/9t3T41DQ//BAT9y8YOyoQsRLvjZRXjdrvWMidANtRgDwQcAzEyMWT6+9RheYFoYf5cTXw7UK2fEre6Tg/KsF9OmENCAA9k5UUzJUpLmo2oBj0xiTP37kfij5h/MErCtjKXlVRPm70hPZb/JKHHSCPCLaBjcFWRdJ6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198577; c=relaxed/simple;
	bh=1VICLYTtT8TpkDFPVJf85WdgCa9waJ5stKoKHelrvLQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uen5vuXP+FMLzFrJtlwusIFonWSYw5MurXRI0EISQjxJtvmhPl+ZzI5NpsW9XDz8M1E+UX/4GEX2brW5IePSa6d5ST0bDE2yTTZ6IML04WcrH+NRv69lfOO6OHoQ4KXGfNotv7TsTNLMhkcfErREvt21KPBU9CS14Vn4uVnXrYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUcbNxU2; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUcbNxU2"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6c3a36fa9edso106812137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 10:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781198568; x=1781803368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7N9eqTcdvHE0GcR2OZ5t0K+PXwREL+74RQ/0cgTyDM=;
        b=KUcbNxU2241DjUlLi14Cf15326ysHRpDP+Hz4oOvOkZ5If8Ru+VV9mKD8puH+m7/3M
         jmwMVem1nP0jrAvg3NgGcLL7VL6kH+ncQrb/qqPC4+VgfQxUrrZvrzTqJPLCmikOxMTS
         ZM1kwGg6whW5ByfSeEF3lpYhME+uYbwO50CRTeXt98q7NnL76KlBnM2ZujAOHSL8jIg9
         owLcBphtBL6xsmAV1hM2WZxU4rUJ1kSl0yQ+4icbDQG7bqHLwHmsb2f/XYfVuEO24Qjj
         kjDIk51u5MrHPKnWBNKgKRSBxwE+5E9OHi7x1em11p1hvEMU3GX2h1Yb1d0LMIjC7Zyy
         Is0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781198568; x=1781803368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m7N9eqTcdvHE0GcR2OZ5t0K+PXwREL+74RQ/0cgTyDM=;
        b=iY9TBVusZACcSP4tuREASsAi62rWyBXisbvsSIqLZXRUZ+0Eu8d0mviNrJZhgDQXBO
         ynY2NBTTerwkHmXw2u1Gs9/bAfRnFNOpOEMLrotsEUZgI6N0tubjNLoDPnlb788Gpg0z
         Zq3oeGI/tEhjHMGsuhrC2pUrXBmIiPoX/bLjf+JOGZDxt4vk3B8Fkdvl1/cQbTfEMIYs
         G6DNb/cBJRnBlrP6QrjJpCIby+Tnwixz26l3x+ZrNzyWzC/hqUZJ4ydo3MGNPj7ZgGYe
         rZiiLtr62TwS3Nmw5tQIXMTPCKNEItgOP1K6aQESouJbCsYogsJzZTGkizkPDqOsZ7Ag
         grjA==
X-Gm-Message-State: AOJu0YzyEeGjqpBsPLql08PnEAwfT8WlW9HpblLIcbDS47Z51j0w72GW
	OHwOv0SIzFFubYhavupSN1XqiaLHCmT46b6r+5sl31ixJAcz3r/NhkBy1Pd/ejdW
X-Gm-Gg: Acq92OGfq3rKsBuJsj5wF/9iq2kEManizTzgI3Fby7LGv/A4LUfZuvh0JpH4gc0pgWe
	YkZCCC4sh2iXc/kqmrfSSKMR47Juii13SCe17eyMKsDeG3PmyhEGOSgkfq3vUPlue/yBtZY+GYX
	BBUL8f+DD5kF+MfkRJT8UD0+Tm4kv6C4iJ5D7GqouKgw4n/6a3eTeuqD76Sfj8jz/rhzTfQATMX
	OEl6Z78xjlbGuF56lg72O4q7ZgRKruf6/RMphEYku3ZB8jpSScHpiujln7JHg3M/y0g74midmI6
	9o6FEYOVpql8PNVLD4xY0tOgW6/+En+UZNYYW7CdPmrZIGoqsfsyBX0a/Ad3E6dNnWkk/oMYRnN
	3eRC8iAgvdE0Sqfj+vz3HuuFvWJYH51+vfYoA+nWPbi6x22bn9lB2J8MhQvD1M4kU00SHA9mPqr
	yhmpTOTnSaNyaOAQmyQX+uWHFI/44HY0eGuqLrT2v8WOuRfOKszrNUmsDdjHlqSr30PP8c1nuVN
	NxkkiYSNOzJXTJrWg==
X-Received: by 2002:a05:6102:3e17:b0:633:4d1a:65f5 with SMTP id ada2fe7eead31-71d6a297434mr1847604137.10.1781198567941;
        Thu, 11 Jun 2026 10:22:47 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-71d9267bb61sm1689828137.9.2026.06.11.10.22.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 10:22:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/4] profiles/audio/bass: Fix delegator reprobing after disconnect
Date: Thu, 11 Jun 2026 13:22:34 -0400
Message-ID: <20260611172235.92930-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611172235.92930-1-luiz.dentz@gmail.com>
References: <20260611172235.92930-1-luiz.dentz@gmail.com>
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

