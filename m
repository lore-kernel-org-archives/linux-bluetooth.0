Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C13126DA
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759412462; cv=none; b=BjlRcC9+T+u+thwVAW4a/BjnZruvZY+YuG5f/fR+dpYJ5ikmHng0Xt/ORzIIQnx7vUTFdYHjeDFwqOzrqK4r1UN6LgAn8QWCsYrmAOetkhe3gtZTFbPj0CynEn0B8T3Od9dCpQEBzCtjlsmmF296SnnC4PHgEvEjfIt6eIQZrtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759412462; c=relaxed/simple;
	bh=Vp8+nDxvW86pQu8RGuVwHY6xJ8y4xgUYXaw5TvhL5dk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNW0aqHe1NtR8qFiS4Dt6WJQE8G20H46jhprF/3M8Ov2S0uzeYKVH/TjRTRCUzgvmLKwSgtNjQIxj0B9difIRqTW5kqxS5D1dwxRmSwJfL4wgHdDo/WBr8L2fmasG/bD4pNVmVkR2eJvCp1ybtqKz/51G/I7YQyjH8NSm02Fqao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US2yabiN; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US2yabiN"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5522bd69e14so577148e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Oct 2025 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759412459; x=1760017259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4KmjXlprKlKWtD6bAGA48qdfhbb68+3/VncPBUfg2M=;
        b=US2yabiNxR+hKs8Jy4owjjGqewx06zWdhyL6bvktgYoRIiPn1ZL2tbb2fEtjafbzZ6
         QzI9czY+Wo2JqV7EwfwJPoLk+fm1XycVURMPqHxpp9xFMUKOHiozJ7MWIEOXtVcVmzkx
         2P7V7OwNl7V77YgbOEnh08hTFGPUEVQcg5HWFJPvAR9VrA/KpswgUu2SYJ8hfi6RjagV
         lWqQaA3ysoHqHp/ykZRoY3wEvIo8uRA72dGWnZr1d/vuqDRLJkSPmjz9uFlURdZ1B7t2
         18EgAqMiBJow+G9YUeJPWihfT9PLngUGpA6eP+h6x0fhizDvPcAgyZEaDRz144LDV5V1
         YTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759412459; x=1760017259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4KmjXlprKlKWtD6bAGA48qdfhbb68+3/VncPBUfg2M=;
        b=dr8mYM7WW8Gk7v8Yt2/nSmeY9Gbovo5X5rGpiZNIosinskWP/Nh8vW8XtR1whF1aTa
         TChPZbmOP3MWZfS1JtiD788t+qFLInSEZvPcAY46X3ogj5RB7C1vGSzGf6Vlru++qPrk
         rkZcBuiLfEU+uSd58PgiFjSsdoCYdE+V7Gop/YxXulT/gxt70laNkL8BjLaHDmFmCBil
         2CTEx0dfux5dOp6nzcqjTfxOrXkc9wIK3123BVV9BCY/Jt64jrYObjxxgNPvlUM0twaN
         plYfHlMIdOzEFH2j6e9LNhPm4gWCIxWURBWuUdyXgry1zgYFbpu+QGM7xnXHaxPO2WX2
         GenA==
X-Gm-Message-State: AOJu0YxJ7ILEk4T2sSCwS4Mdei7IbLILfB4MfcCVqm75mtkB2TLsuEVl
	xqqrE/KiUCxaAbr3mQTQPKmHS4qZhfVZB6ELUOH9AEbpOnvUaE/SpUEhdb2m6PEG
X-Gm-Gg: ASbGnctkQLLl3JnZTqRUVo9mKrfDMqU5qY4BDKOpYNBF5AQsJ94LV5ESuBmoHbwqVhA
	Ways8aPVqwUok0EN7EbIJD3tHVyRvQnb61rN6IQgfveW0CdENsbvNZsBW9w/4cOt4+yEZW0Gfh8
	9Ul9/pBkUEID8XSUoTu2Wt11Ss3r6v6c1oFJJv3XY0sla9QpFwIDBsOKKI0Lmbbu5R+JdZ38b24
	AT3G3s459t3RFUVdOVPrkYf2/6NEfwTGjEki6WP+3+26HMAEfMkAe0Mu6jBm2SO+N/vcIcv3i3R
	BOMgeXX6/1gMguvsCjOvsz+xO/z6w1lqICxDZ9PEFhlNTXEgqmCTsgnqrasMgf4ZLDgs5kHlKMH
	eRTk4ZRh4t6qxDPSgHRWP7U/ZF8pywB579NLIiPyKraL860UwL7kBeCWG6f8NKSdqz2dyFEJ9Cm
	RxkAW77Fv8JH9KWg==
X-Google-Smtp-Source: AGHT+IFCAYlEjTCzj5jSnLgpd4v+9zgzZG/bX+BXnL9U42nVawXB80uhsyY1KEARAoTiRrDZgXw4cg==
X-Received: by 2002:a05:6122:458e:b0:53c:6d68:1d2f with SMTP id 71dfb90a1353d-5522d3a2a16mr3554751e0c.13.1759412458837;
        Thu, 02 Oct 2025 06:40:58 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523cf6558esm490157e0c.22.2025.10.02.06.40.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:40:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] shared/bass: Fix permissions not requiring encryption
Date: Thu,  2 Oct 2025 09:40:42 -0400
Message-ID: <20251002134043.196760-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002134043.196760-1-luiz.dentz@gmail.com>
References: <20251002134043.196760-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both Broadcast Audio Scan Control Point and Broadcast Receive State do
require encryption:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/24670-BASS-html5/out/en/index-en.html#UUID-dd95da9a-6ac0-3f45-7e34-13fa9e04d41c
---
 src/shared/bass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 4b4fe8adf762..19cc9531d617 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1223,7 +1223,7 @@ static void bcast_recv_new(struct bt_bass_db *bdb, int i)
 	bt_uuid16_create(&uuid, BCAST_RECV_STATE_UUID);
 	bcast_recv_state->attr =
 		gatt_db_service_add_characteristic(bdb->service, &uuid,
-				BT_ATT_PERM_READ,
+				BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT,
 				BT_GATT_CHRC_PROP_READ |
 				BT_GATT_CHRC_PROP_NOTIFY,
 				bass_bcast_recv_state_read, NULL,
@@ -1252,7 +1252,7 @@ static void bass_new(struct bt_bass_db *bdb)
 	bdb->bcast_audio_scan_cp =
 		gatt_db_service_add_characteristic(bdb->service,
 				&uuid,
-				BT_ATT_PERM_WRITE,
+				BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_ENCRYPT,
 				BT_GATT_CHRC_PROP_WRITE |
 				BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP,
 				NULL, bass_bcast_audio_scan_cp_write,
-- 
2.51.0

