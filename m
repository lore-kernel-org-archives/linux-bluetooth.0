Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF231C2335
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473021; cv=none; b=VKpcqGhvQ8y8wPF7CViCfZIOZSpSWrp1ucA9MzrkG14n3+aqV/Yg6KzCPvnLzMZ/+x2+1gdfb9dmxXKh4CFVM6/nniDU/dXDDjQYahQpTQzWODIAJv//sqs0D/7iic/aiJpkEdVGhqcvrARzFKENTWApzq1TdFL/h8rrUOtB4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473021; c=relaxed/simple;
	bh=1rGqLJRjNZG6INWO7uElp0dTykTSRAxQzTqofhW2Z8w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EXdjWJvkp7at5SfommsTxsxEOfEzMeLvGs8x3/KVNbF952wPq8UHaOtVjo3DeLKRhjvIEpIK2JtlEBNkFFNfI2MkV2A6HQlEx5in9PNaU7zl937G9+S39Sft33CviV6QTaBP6/AgRfTbF11MG1JFm+JhhD2FK/vSYP8Lq+1wDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THsNQJO1; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THsNQJO1"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-873a2ba6f7cso1130133241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 May 2025 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746473018; x=1747077818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rZizFKGFbvcZUcNIAzHWwZxlhfi+CS6C6RQx0DlnvZ4=;
        b=THsNQJO16gymX/QPzKw8FJBVi6hTB/Km9yiN2WG32riTfdRCnv2ahGBTJA5PSTO2I3
         Z0Vz5LXRjwx+NoI0ubuEsgXgOpaRZQ++qQ4E6va7j/ufo7X3fuP+H4MYqMc4iW2jrBAF
         PFVitkUnkLiw6WS/UU1Tw4sYiOF1Fj9RtunFCU3nx3BYHGP/MuJiESSK42HDjxMrlqBA
         +mWjjP5fchCLSAzzpRxNSYzjk00kq+f+Hk0gvBIJjhruLs9k6+GKlzHHgJJvkOM7/VyW
         IRplmHRN9BfAa7HEvvT462575bvDS5bEsoq6kFuDYryPR/t5Z6yqd5yYB7ZS1a4bTjg2
         jJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746473018; x=1747077818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZizFKGFbvcZUcNIAzHWwZxlhfi+CS6C6RQx0DlnvZ4=;
        b=dLvwtJSwelm3bgoOZtk6Ol3WT8l0+lrqKncK70cC+s9UMRB6ll8RVlJrspVTrhIRxK
         EOzmEX+QrP5wtfakHWrHTbYE5qKJ5MjX4d6gjn+4bvosvALNPfZClijMJKTOtrJbI5LH
         +z7YgsP+KrFY4T+PxNDPcdQIJkXB8uT6Txi4PoB/NOKadC4OiQlqLJId7dC5cL4oqyGK
         ZO67S1TpSmWZbOBv25kHDIx7IejVMxcAtBjHfSWe4JI0W289rAqR8oymZEXez9MVecOT
         MPVKpj1dEmoku8Cb81Jx112+ygqZzCbEY5OLbof2qXswUB41QbS/lj1v4ojHsreKmaZI
         rMXg==
X-Gm-Message-State: AOJu0YylY9ay0HJfAN6/iuGPm2rOHH0ZWcuhcGVkkkbiUdJcyoRpW2Ph
	QeYFRpd4hTzDp9a067cYqWS/tjIDTWdg4NZqa8xwlxJ1Pd5Yesw2xO0m9EbTE4U=
X-Gm-Gg: ASbGncsX7uLYOSCSiGZVNYTUjzYLWEINxoDicFkrrECanU1/7EdlDwGzH//AIxulLEd
	75oOiUhMGRLz87ED6Ofb20spCX+vfwk7aTL544UosjptRBQ3Z0FG2qLCtaj1ulgEYaXRpOh6RZN
	TfqfLoGFKYhW9p4Tqy0VEpe8NNwla10nWQb5Pou1QwwakpvhlMDsEq/oeIGnmlwtZd5IkqMySSi
	BeiPZ24FqZhionUAQCkfqwKoS94S/ylGATTwbGUKaN8resmYqKmbDGw5xd8TKKAjnVrXIigG8+L
	bwzxGFncLKDFVRH2nWV2CmotvSZPLIKG9fTx/IyXqz52JAkiRq2Svwbj+0vvwMIzTnzY8Bu86Xj
	+yIDNFh8gO3/cBTkvtC6/
X-Google-Smtp-Source: AGHT+IHzk/8cKQ59WOO5eRH1ld208+v2R7oVAvFSj4uPjfkXGiRo1K32otZbt7633ZhMDl19zsuceQ==
X-Received: by 2002:a05:6102:2c02:b0:4b2:c391:7d16 with SMTP id ada2fe7eead31-4db147c830amr4708614137.7.1746473018481;
        Mon, 05 May 2025 12:23:38 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8780b293929sm1355569241.29.2025.05.05.12.23.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:23:37 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix handling of ASCS_Codec_Config
Date: Mon,  5 May 2025 15:23:36 -0400
Message-ID: <20250505192336.3191098-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The codec under bt_ascs_config is in little endian which may differ
from the native endianness when it comes to vendor specific field that
are multibyte causing the following error:

BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS] - setup complete
BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS] - run
...
 bt_gatt_server:src/shared/gatt-server.c:write_cb() Write Cmd - handle: 0x0022
 bt_bap:src/shared/bap.c:ascs_ase_cp_write() Codec Config
 bt_bap:src/shared/bap.c:ascs_config() codec 0xff phy 0x02 latency 2
 bt_bap:src/shared/bap.c:ep_config() ep 0x21d6600 id 0x01 dir 0x01
 handle 0x0022 len 5
 test-bap: > 1b 22 00 01 01 01 09 01             ."......
 test-bap: ! 1b 22 00 01 01 01 00 00             ."......
---
 src/shared/bap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 2a08f3eea7b8..ca3a9e5c3a36 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2975,6 +2975,7 @@ static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 {
 	struct iovec cc;
 	const struct queue_entry *e;
+	struct bt_bap_codec codec;
 
 	DBG(bap, "ep %p id 0x%02x dir 0x%02x", ep, ep->id, ep->dir);
 
@@ -3019,10 +3020,16 @@ static uint8_t ep_config(struct bt_bap_endpoint *ep, struct bt_bap *bap,
 		e = NULL;
 	}
 
+	/* Convert to native endianness before comparing */
+	memset(&codec, 0, sizeof(codec));
+	codec.id = req->codec.id;
+	codec.cid = le16_to_cpu(req->codec.cid);
+	codec.vid = le16_to_cpu(req->codec.vid);
+
 	for (; e; e = e->next) {
 		struct bt_bap_pac *pac = e->data;
 
-		if (!bap_codec_equal(&req->codec, &pac->codec))
+		if (!bap_codec_equal(&codec, &pac->codec))
 			continue;
 
 		if (!ep->stream)
-- 
2.49.0

