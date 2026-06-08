Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B828CF4A
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916408; cv=none; b=TBGGXAp1w7wDbCze3dtcaZ/9JFw+LOlqFCXa3C6D45GXhAHtA0xbQTuS9VRVJwZx/jGf4C5LKNlKrk4esy0w9G1aH5y5UuztD4FJ7ITyRg6YEb9sp3Qryx54gQ3GL3jD2rqZEhxjfwUjxfvWgYJ805SUJyt6RiceuuIY/7iggmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916408; c=relaxed/simple;
	bh=Oqv8DEvJL7DnrQq8XHEq74AE1BHmdPajAIpq1GnREUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVcBZX+F96e/Z9wAg2BUq560LQOmfaI7O/6TQTm24JCNg09wvjua38uQcRv1/8yt2TCwFRWdaS3JDp9rI9wYX31EB+QNv4P8ixCkXNRSL2oId65YpVYZc1K5fIvJc4awbVJEdffwSiZC/mbjZ4Phep14nNfce08d7QiNqaZjQRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=Eb+fKVDh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="Eb+fKVDh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46019b190b6so3146682f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jun 2026 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780916405; x=1781521205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/jc4Wc0ys638cAy+jn5n8OIV/QtOYmloxXVNM/v+kU=;
        b=Eb+fKVDhYV6ZZ5XzfinYFg8T9T/8xtYmlP5iDso0DPugHgPiJkUoUomdMQOIUnLy4P
         cfhUJayOQq3T6eyYW68UseSjCsE1OedMkBZj24u0T9qDybp7tCwiQ206NRfbVdE49OC7
         fm2qPuegw/NGlByP0ik9eMW4r3OGsraJ7NE+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916405; x=1781521205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/jc4Wc0ys638cAy+jn5n8OIV/QtOYmloxXVNM/v+kU=;
        b=nU4fLkLPgy4e2Y+zHSdSm00mdXaCLd8YvckA6EJqGvml1Kqjx2tPVFfwCLkJoRPEG8
         kqHE4b+agrGwmjFFvbI5hucx3wGsk30lZrtS2Ou4cEytfDo2NGUvkvF22BTmNyPnq9ms
         ZBoQC+OBPMFT/CCg2cOWM06LGQIsVHA8ahvIYra+w/FW30zd7ULP1+qd+9PnT1Sw0v1i
         l4gBAmkfc397pe7B/edtlNo3o383jxmKMdvC1TTLa0fDxkvKuMLSF1p7MbP8FecTY01M
         pslkBPuYMKH4G2U4tR+5zXC1PQnfo34Q18p3odz8jETxFs9bZ2rZPl8MBRqKkC7LSyDZ
         eeYw==
X-Gm-Message-State: AOJu0YylmrPKpLSleD5naJFlzOypcFB8+DU7Eyq8VwYdktCLUI6S7X10
	ZEUvJO7/UJuvrVPo+SaYPxyX2BRYD7HybU5d4j5z4JqIvpp7SG3zvvfLFeZ6UCUjgsRvLrw17P4
	4aTC8
X-Gm-Gg: Acq92OHt2XxY/CMZofkyS6EmA7VrrUF33MrBQDfjGElodNd/Mo3xc37yEesjUt0h5Mt
	cIQlfdpKdiGkaVF8G+QDKkrVIeJwotVI2nWO9fVO+53wYHdXDqgf7O+njZRq6h14IJ+CrX7mc6m
	rvtdOP3OMhI+8ajHAmRByLeJMxSXEyI9wVQrr82jKiC5ZApa5awuLP+Yu2Z4ZCTH85TM8T5GbqG
	RAJkYAxxoPKFo5zktJboYjNdtp+cU9nD1sxCh5+wYSL5FFrJD1nAKPyUEnIgTGf97uJrSC8BzKe
	DR3s8GO8GDB3jbFf/xENWoN9TkFOzYEflq2DuCdYj9n7I/VQNd4weBDW+Sqfaj0cruVCKHYIKZW
	Pr4+yJIlpWqMvb1o7tip+BMwH1ZnsS8BWAX3liqlP1JaY/WCnXp/gnAm5h4XCnoWXgYC1dBglPb
	ghZScr9p9u0QhGF/b/23w3MEUjx/KJrXKh9ET93Z2VKSMYBbR2B4p9iQ==
X-Received: by 2002:a5d:4252:0:b0:45e:f684:7347 with SMTP id ffacd0b85a97d-460302e711fmr18203347f8f.12.1780916405242;
        Mon, 08 Jun 2026 04:00:05 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:2869:769f:34b:70a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm93113112f8f.29.2026.06.08.04.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 04:00:04 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 3/3] device: Fix returning discovery error for Device.Pair
Date: Mon,  8 Jun 2026 12:59:52 +0200
Message-ID: <20260608105952.3683040-3-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608105952.3683040-1-simon.mikuda@streamunlimited.com>
References: <20260608103905.3614057-1-simon.mikuda@streamunlimited.com>
 <20260608105952.3683040-1-simon.mikuda@streamunlimited.com>
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

