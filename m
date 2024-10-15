Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DB1AF0CF
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021382; cv=none; b=lMUUn65/OwheotUstTyZxbDDk0pI+8yTVz3whRq1oMzDxwr67AN0Wl8Vtp7qix1bcLGFPh0jWGDUnYBwPGi11wkgJOf1NpDrKNidJ5ay+8MXBKq+nBURjxf9j6YUOTfgyBTzw6fwleGdndtKH8bq9809LgpOS6H+Jh28+UXs+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021382; c=relaxed/simple;
	bh=5a3SnJYKc5cJdzSPe8XkKNw6+GnclQSThOPPh4MHDGg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Wf21a9G8sVH5kHoLrjoISakHvsuiGAl64lQwmqbTMmKpAwi3Tr1DbIA0Qsdg1yLEZO/LDEzPzWz92Rd73YPxPGS47v7nxgGEmNITKaqEUNMz2JxNUSSZd+EZ2mL8sJR0jGHl9IrBISDhuKDTt5cMOil2QYfO3hUhh1OwtTuiRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSa+paYs; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSa+paYs"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84ff612ca93so962460241.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729021379; x=1729626179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSn5rE+gtJg7o+Qvt7OfHsCCuws/vJ63IjQg3MKA8Qc=;
        b=jSa+paYsydnr2glg59Am3Orgxn+/orYNnn8xpoPlasKfK5CFl8DtwBYb6zhkkh/YmX
         8GWfX1p5w2jZI2K0eFBDaHN9eMTKp5ji6eJ861uqX1DNk4YrKYmOU1foRnqtPunSZoWL
         Kl+N/7jjP/WSBfXiwV6l5gOALEjwhPgnL/0hpC6eEBH2O7M3QpvvhTYzQlcx0bwlWF9j
         wUb7ICikRkZsjNYJrjDECNIhmO+bgp/9VikpFJuPdmsC0t9jtr/YyfKgl3b0O+7oM3rB
         nf+HyT8P/lF096ceTHsArNKzMiTi23HLSRu5rh4PYLLgCT/5Zaenh26/vInEQyWGARxX
         Dtjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729021379; x=1729626179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSn5rE+gtJg7o+Qvt7OfHsCCuws/vJ63IjQg3MKA8Qc=;
        b=lYCN26r1abcxb+GqkDLhHLm+quJ2kslwEVW/gI9ziEJ79KIBgf50dVKJuswaskAG1s
         0y2IPn9HFRRllnoOAVd6YCKsLCi2Sn73FAtx6uVEjoXzAJ8mrO5Qfpgi9EtFkHRX3cgT
         DidoCQHXKgrRNxb4dmivsl3J7ujv2WEfsyhRaKcPfOg4sRn9B5xXInyfIyEVgUKO+5Co
         8oKOjCCnumvKEL0HAdUl+haJO8vWnAmk3Kd7kwVGy5PCcuBz33DLKf8GWPmQR0F4/V2D
         SfZ5d8NXCPSGzGWia59bcCab79ozRmfeaS0SjeayVh901tgPUGgCORD5p/Zs/IR2PojX
         cbyg==
X-Gm-Message-State: AOJu0YwLEcqgm26R5/XFxoI6ud6OM/HxKm2onbf2mSU1On4TmwMW2fXi
	wP57IO+wt3x9ed6DDPzkeYOqteaAY6blSZYQNXK4zJj6tQjFfmdABHaKQQ==
X-Google-Smtp-Source: AGHT+IGqP+YXVg/G81B8rT4CdK80PrmC+BX1lK+1VIUH1TgvJ80D2iDnsBrSLqGrv2XHrDtwhQLU0A==
X-Received: by 2002:a05:6102:418e:b0:4a4:8526:1800 with SMTP id ada2fe7eead31-4a5b5a6ff32mr2029155137.27.1729021378691;
        Tue, 15 Oct 2024 12:42:58 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-850318be656sm277114241.23.2024.10.15.12.42.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:42:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] avdtp: Fix triggering disconnect_timeout while discovering capabilities
Date: Tue, 15 Oct 2024 15:42:54 -0400
Message-ID: <20241015194254.543683-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are many endpoint registered it may delay the discovering of
the capabilities long enough to trigger diconnect_timeout which may
cause unexpected collisions/disconnections.

Fixes: https://github.com/bluez/bluez/issues/981
---
 profiles/audio/avdtp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 289b40827d88..80fbe847e043 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2037,6 +2037,14 @@ failed:
 static gboolean avdtp_parse_cmd(struct avdtp *session, uint8_t transaction,
 				uint8_t signal_id, void *buf, int size)
 {
+	/* Reset disconnect timer if command is received */
+	if (session->dc_timer) {
+		timeout_remove(session->dc_timer);
+		session->dc_timer = timeout_add_seconds(session->dc_timeout,
+						disconnect_timeout,
+						session, NULL);
+	}
+
 	switch (signal_id) {
 	case AVDTP_DISCOVER:
 		DBG("Received DISCOVER_CMD");
-- 
2.47.0

