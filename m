Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA08433B3
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118317; cv=none; b=QCBYe1ZGqKgtUAMZtBKxUySI8ZgyvBnksE/48CtdffMAtd+Vsxf2m3XgUXH7Ot3nw0XmB9zu7Lkhe8YFSejmti9Bns13ZibDgisI0oQ4dFEUQoG5hyD4LTR1tBYbr0p3ktcpWONTb3fz+7PFv7MNdUabMGGqp80lA5qzRPKSiKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118317; c=relaxed/simple;
	bh=EtAQoYnEWW3ytYqq76Kk4TDMRkQ6yMj4Ivt8b7UAA4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZXMlZBe3HZ4+tVFFsreK4Bbb+M2f8qnsExeevNiMgG1vNUD77/KWzl/TZc5x6EtbrWQwBXLF/R/Osol1LESZo/txq2TySK3+HiH0bElAfFoGoAB63uJTVkhezC17EsTz+V4V1L/2hqyyrVrln9oYCkGhfBq0US1vWK69ItSClAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=my2z7k52; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="my2z7k52"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341808b6217so1241010f8f.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118313; x=1711723113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AoaCaRPWAWJZIl4xmEn5wYUiWJwcpd5LRlPbtBNNi6k=;
        b=my2z7k52gGBdvAzzJyfvfD+U/oL9w3Mw2Kmwy+sK0FB4k/C1V0POaW8a0a5a+ViQd/
         Ks/BXE+SbPBlILQRNLjEFCGcYUQ0niyiKDJ5Dd592nzrnQne3/DobUNN26UyH7IZ/Zpn
         KjPooSaq2zHLDdUZicJU71HPog3eR4d1dap3nH0qKjxTWSzj3R//P0up4WPiZjVcelgX
         /BGTl+EbEWle6pe9pH+vmpxpLCPDpA4+kk+BnQmus0wmSklMVlLaqdW6gq4Mq5LAKNbV
         baGYLBzNrIOrd4tvuFxEFmjvRtcMLIrRqGNSIU0j3+y7TbyPZaPC76HguJODY6H972QY
         BKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118313; x=1711723113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoaCaRPWAWJZIl4xmEn5wYUiWJwcpd5LRlPbtBNNi6k=;
        b=XO8QC3+HeyvxSjkkGsc0kNvdjz8tEP+AqMdb6a0F27UycgPE4ZaRBiEYUL9/5Q7DYN
         Udjefm55L0PxyQkIlHwmGS6fTooITi3qeVauynVcHhv9lFs4oboZwRwjDlBGh0yu9CRl
         2irvP2bTCUax+Dv2RhJdufjAYrWntOcO0FczBbVhIfFL+w4eMtp7ivkogf6WhaV6Ps6G
         usdd+ou4Ymlgpfpi4b8SisjoyEEuTh2i0M23HT6omKbvZtrZR2xDjpjNLc+nCmJziU07
         f6OeaKrg/ofS4USmDCsxU0lS8o8FZxlssyOCHTiIUlr5luAtZ/djd7FDfSX+62/yAR1F
         kwhw==
X-Gm-Message-State: AOJu0Yw5NUbfUX/a5kvqTJFpGxDxcirVdcM0XBpNK15kzOlH5UZ9y98b
	Y5HczriZK01JlDkLn6E0Agf6a4sqFPbNG9t8Bj8SAKAQBJ+JrAMIAme54rqd0gALl6jq
X-Google-Smtp-Source: AGHT+IFkSKdxfx/p9ibM/NQDdVy2MdEUIoM9PM9EXnVWM2WszlrCNw5+vWdLPkRBXsHoQkHIFz+kWw==
X-Received: by 2002:a05:6000:36e:b0:33e:c8a9:e0e2 with SMTP id f14-20020a056000036e00b0033ec8a9e0e2mr1416325wrf.58.1711118313013;
        Fri, 22 Mar 2024 07:38:33 -0700 (PDT)
Received: from lvondent-mobl3.. (ftip004290803.acc4.faraday.21cn-nte.bt.net. [109.144.76.63])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d51ce000000b0033e9fca1e49sm2195261wrv.60.2024.03.22.07.38.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:38:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] bap: Fix not setting adapter address type
Date: Fri, 22 Mar 2024 14:38:31 +0000
Message-ID: <20240322143831.198777-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not setting adapter address type when listening/connecting
ISO sockets which prevents them working when adapter comes unconfigured
which then gets assigned a random address.
---
 profiles/audio/bap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 964ba9c21..315eff729 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1856,6 +1856,8 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 	io = bt_io_connect(bap_connect_io_cb, setup, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(adapter),
+				BT_IO_OPT_SOURCE_TYPE,
+				btd_adapter_get_address_type(data->adapter),
 				BT_IO_OPT_DEST_BDADDR,
 				device_get_address(data->device),
 				BT_IO_OPT_DEST_TYPE,
@@ -1912,6 +1914,8 @@ static void setup_connect_io_broadcast(struct bap_data *data,
 	io = bt_io_connect(bap_connect_bcast_io_cb, setup, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(adapter),
+			BT_IO_OPT_SOURCE_TYPE,
+			btd_adapter_get_address_type(adapter),
 			BT_IO_OPT_DEST_BDADDR,
 			&dst_addr,
 			BT_IO_OPT_DEST_TYPE,
@@ -1952,6 +1956,8 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 	io = bt_io_listen(NULL, iso_confirm_cb, data, NULL, &err,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(adapter),
+				BT_IO_OPT_SOURCE_TYPE,
+				btd_adapter_get_address_type(adapter),
 				BT_IO_OPT_DEST_BDADDR,
 				BDADDR_ANY,
 				BT_IO_OPT_DEST_TYPE,
@@ -2734,6 +2740,8 @@ static int short_lived_pa_sync(struct bap_bcast_pa_req *req)
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_SOURCE_TYPE,
+			btd_adapter_get_address_type(data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
 			device_get_address(data->device),
 			BT_IO_OPT_DEST_TYPE,
-- 
2.44.0

