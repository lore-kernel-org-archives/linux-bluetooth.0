Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6331327D
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 10:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915165; cv=none; b=EykiqR+ZtIzX4DpMJXTPfjkztZhWgHlYMDmGAoFUcrhqEN9bW+L7OEA+24ijoBAWdhduqiMca7I2Ymd87tanuKW5J+KWRMSD6z/MsLLi9SIEWv4wFu15UjA+ijusk9ybaT+d9pq+j9mar+INb/97t553mHMr4lrnHh8Py3Bm3bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915165; c=relaxed/simple;
	bh=Oqv8DEvJL7DnrQq8XHEq74AE1BHmdPajAIpq1GnREUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wqa5cwdvY9RbLy+C6WlIv1uqzAxYV1l0+l4L+KtNPDIyo29CDTuqV2FxmEFdX/5i8tAcCGAAdUpe/vW3yjN3nRqsBBoGg7wRPGWuEt7a6JP11n8YOjKKgeVLAUoobyw4ePy4O1HT40J1ZmY3F4ourIvPow4MmN2ULyTxS1X3UXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=PE8ux46N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="PE8ux46N"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b7866869so48228895e9.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780915162; x=1781519962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/jc4Wc0ys638cAy+jn5n8OIV/QtOYmloxXVNM/v+kU=;
        b=PE8ux46NB4Rlq/5qOzpjZauknxDTtsV0rfcM0/PONgbP2w9idTp9zplau2U5XZ1KRl
         iZcgNDVgkvMVjCfBuuegGVAKU2rDN9r5tdy2sxaq+bdtWavUJlkjcnEAK3LyI8JJA9a4
         zv0OSdit89azrFd1VoKtChrNqEVIIsAF0BCLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915162; x=1781519962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/jc4Wc0ys638cAy+jn5n8OIV/QtOYmloxXVNM/v+kU=;
        b=jO/a6mmQYn5V5fdWnSThNyfQw8Tp5psSae3hHU5aihzRAAGMBxBDdKe95a3V35OQ/V
         rIR9piuKOaP2Z8BkfItlNaI7/MJK5k5nd86wb781g+s014EyDwONx9Sqdd+sapiMpL0j
         sfR9opvtrY8rp8WWPJ5g1KaC/W894ShgbgwGaH8f5m7HbEykUzBfz3vnphXxRNShSPFx
         NDh1Kr8OAcXb0omQaKu+WcbNLXQ/KXBkNJen8za/+6RBFL5ofTxP3BRZ7LgvSgI4kg5C
         pw1n8abGIUqFaqKW8DgF0frwUmuHuUzW540PmRfrS3y4LTZoPirKJkPfrGe/KUmycr0Q
         QfOA==
X-Gm-Message-State: AOJu0YyPP1KJU9OxogPCIeElkHmqFeDbHasfCnlmM6Tr0Y7ELtqA/t2/
	uVcuOBOiEIdMUaJjO36cEC4jnCm6v0hV9MAVhPhLZaDCSiyCInhsRpHiwN19KNgBoJOgoZaaWbT
	wRj6c
X-Gm-Gg: Acq92OGUQA0QpbrpDKzELYkvunkSvtru1ZVTrSfxmdQdwI+w943s6zVPOXOiAUxGzUA
	Bs6GbybUPy+2YlufuqgKz2g4Px1/4bCSBinQEFBV01elfqBUJ1Enj2xOC4m916wjuhy9rJ4G7IK
	HIEUEa/DYPP5WhViBNNLj5GZsGvGmGgW6XvYAF0fuKaO7l7yu/q06MnTeOddpLmMkBWwURlKY+o
	jzk1aIwFp3Qyxs9vrfl0Fd7s88+dhlM+bUVF6+4mGi0HKMzSHvOe768bCF3Ah9KhVp2btZSKjv4
	f+zJzMlT7e+MfrUdaJsa5nQaN4rZ9rMW9CGCyQtMF6Mb+18CzAV54xHR6KZq17dCTgL98YAotlW
	no69nCMlQ4qVzT/klPN4mKOa00lYbRiOijvBtLWkPdoVOQpNE8iZA/k3FiFLyP4Bfwvg9kpZKMw
	NZZ8YioSddDGhoycfVIZJW5OuVRIziWDT/9t5w5ytRf2PYInLzfgqzkg==
X-Received: by 2002:a05:600c:8518:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490c4993bdbmr260325825e9.24.1780915162057;
        Mon, 08 Jun 2026 03:39:22 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm92776130f8f.29.2026.06.08.03.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:39:21 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 3/3] device: Fix returning discovery error for Device.Pair
Date: Mon,  8 Jun 2026 12:39:05 +0200
Message-ID: <20260608103905.3614057-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
References: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If discovery was requesed from pair request we will report successfull
pairing even if there was an error during discovery.
---
 src/device.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index da70f9cc0..429fc5e6d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7294,6 +7294,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 	struct bonding_req *bonding = device->bonding;
 	struct authentication_req *auth = device->authr;
 	struct bearer_state *state = get_state(device, bdaddr_type);
+	int err;
 
 	DBG("bonding %p status 0x%02x", bonding, status);
 
@@ -7352,8 +7353,16 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		DBG("Proceeding with service discovery");
 		/* If we are initiators remove any discovery timer and just
 		 * start discovering services directly */
-		device_discover_services(device, bdaddr_type, bonding->msg);
-
+		err = device_discover_services(device, bdaddr_type, bonding->msg);
+		if (err) {
+			if (device->pending_paired) {
+				g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "Paired");
+				device->pending_paired = false;
+			}
+			/* Disregard browse errors in case of Pair */
+			g_dbus_send_reply(dbus_conn, bonding->msg, DBUS_TYPE_INVALID);
+		}
 		bonding_request_free(bonding);
 	} else if (!state->svc_resolved) {
 		if (!device->browse && !device->discov_timer &&
-- 
2.43.0

