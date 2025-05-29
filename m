Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE68347B4
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536981; cv=none; b=jSnLZ0oAO44xfx4ZrqG0h9C3FhYuPWUCI9d6OsXbsoJul2IiH7hjvNEE3dj8ADWf0BuyWHkShZtEDbcglHpm2CBN12AEa3T1iMril4bu7eKb8K9Jk5dg7HD2ErCB3W76ASNaD2542IETsRhk5ASvMsp3sytGXAW429SfLO9blA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536981; c=relaxed/simple;
	bh=DNkWxCdEjfVGq7c+LiDk9aB22bzxILOPtVUffsk4RPk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u6xLtM03NVyb+5QOepDzMhHzCws+m1xs0HixrrdmYDlrVrRhCTvZCdPBY60CSDqDOYu+vJjSFYri5NGvk+GON+HJRx+ndJZoArCuHET98Bh3azOu+buKMqMRYb2vAAHs4zxMTEX+Od9PwV5CU2SPH3rVbLBnEKPeLR84MzCh04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHf0VtvA; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHf0VtvA"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-87def66dbceso332704241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 09:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748536978; x=1749141778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CcAVI4IfUXwwYctPq/9iofIw6UFjeTR3M7c+Xw/ivnY=;
        b=jHf0VtvATho+uohrqC29j526Jhe2B2vwu3zCXJiFQX88WoPPmxq6eESANS3bj1LXlO
         yoZq6iaDyRjRnWH0LZwDiHa+ZdnM7tjN698K92vPg7Ik1eHXzGR4RRhzC8wFMnpbvmmD
         EZtCqp41hS44CJ9iXWOnqQmjD1++PbHsecU+NsrO/pKLAX4vRvC8uWuFX8fRLf5mr/JV
         XwgpauprNl6i3TZdAqSCPIZi5bLJlouR821a1DyKi1bLf/VvpcXlBlqM9FsMc+U6BbNU
         CM8XF6dCrwzEHdvtMwM9UQUoHotwy+43vSR0sLRDD7RpDmgLVCcGhmKPMD8aQXTVP4FH
         doKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536978; x=1749141778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcAVI4IfUXwwYctPq/9iofIw6UFjeTR3M7c+Xw/ivnY=;
        b=OxNXsXMPd1HzdbfCyG7w63hfNbEw8MKGObKAJSdjxSsA+l88SqVvZisRtc/tdCi/OC
         9zI4jl7EWFXbMlaIStOaVxD0f+L6A+8/chIIE48sL8bQry1QOBkTX/Z6a8W/Hz5bhJAm
         tL994c4mTKpnsW4ZIPKvBNHku4bh/1RttaC/kiJAFNSE4wnr7mC4S5sEbrgxDyDQGILu
         oXKTXJySWujts3jIP2DGtm46tyBJdKDpDoDqHUoBUoCUO2a6EbNskOUf9WfsUv1oO5Pu
         CoE33FT0UAZzbu/Ca6Sjgm9+y8StVMf/niJE0jDJl63/Kx6WC5rND8DR+9nLriUw7vx3
         TqUw==
X-Gm-Message-State: AOJu0YxkQmkuwO9ZKu+exELj3uOzCA1a6zUpuzj8fpFgU8iy6g3dZHRn
	FVc4eliN0HKh/DYIGWJ0zWOTb1eR5okrRzsw7R5qGFRutCSmJabepJkHtFBiTs0E
X-Gm-Gg: ASbGncsvL9LxTaCketLfoFLHuJ0N2lr/8jXn6sGDwjaVNYKaJUU71ha/W56JKIFRxqC
	PiYqPoOqnvv65zxlj/XSIdMDktQ1gIDiWAPbzVL8efR21I8ANVTRpuXX7wiUmSK/BB0+MTzelK1
	8LPqqKvCkSxSWbe1dui8Rtd91PkF6JYU3Z9VmgJ5iaXDQ1plSBw2LRg/V8qw5UbE3RYcRfxhbx6
	xSpqIPJ6TctbTayEiXV3A9Qagz/lBK71+S0f88gNLG1nEQiA9NkHK82fLo83cyrX1d2JkTtzh02
	Anb+tXqd85iSLSsopahdmwva35BXOZISLYJ7kkMtvYOB0GWHnNJk+3TQF4qvW8EEzkAs53PTUtO
	lWZWnOdGf/VzDvYHH9Kpr
X-Google-Smtp-Source: AGHT+IFfNpaxBIZ592dk9e/4/8lC0515daVOhPfYu7ibx1D9qTdINqY3zQ3s8RscjMwDn7haC6AAHA==
X-Received: by 2002:a05:6102:3c83:b0:4b6:5e0f:6ddc with SMTP id ada2fe7eead31-4e6e410cb2dmr342415137.14.1748536978524;
        Thu, 29 May 2025 09:42:58 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e644429652sm1351495137.4.2025.05.29.09.42.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 09:42:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bass: Fix not using SID from BT_BASS_ADD_SRC
Date: Thu, 29 May 2025 12:42:56 -0400
Message-ID: <20250529164256.188167-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_BASS_ADD_SRC command does actually have the SID of the broadcast
source which must be set otherwise the kernel would assume it to be
0x00 which may not always be the case.

Fixes: https://github.com/bluez/bluez/issues/1282
---
 profiles/audio/bass.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 017a5aa75c85..417b7b72ff9b 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -106,6 +106,7 @@ struct bass_delegator {
 	struct bt_bap *bap;
 	unsigned int state_id;
 	unsigned int bcode_id;
+	uint8_t sid;
 	uint8_t *bcode;
 	unsigned int timeout;
 	struct queue *bcode_reqs;
@@ -646,6 +647,7 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 		btd_device_get_bdaddr_type(device),
 		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_ISO_BC_SID, dg->sid,
 		BT_IO_OPT_INVALID);
 	if (!dg->io) {
 		error("%s", err->message);
@@ -1320,6 +1322,7 @@ probe:
 
 	dg->device = device;
 	dg->src = bcast_src;
+	dg->sid = params->sid;
 	dg->bcode_reqs = queue_new();
 	dg->setups = queue_new();
 
@@ -1460,6 +1463,7 @@ static int handle_mod_src_req(struct bt_bcast_src *bcast_src,
 				btd_device_get_bdaddr_type(dg->device),
 				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 				BT_IO_OPT_QOS, &bap_sink_pa_qos,
+				BT_IO_OPT_ISO_BC_SID, dg->sid,
 				BT_IO_OPT_INVALID);
 			if (!dg->io) {
 				error("%s", err->message);
-- 
2.49.0

