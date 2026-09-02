Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C047F786
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369399; cv=none; b=P37Iw260HjALsWmcvGHH8n1/PP2+ADJcPA30ljYpWFz8pYMxWCt19fSvTSJL5kTnugqQbXEfr708xdmUszOYspRWiIlZofQomhU+3uqA4CH6YPPjjkp/XJ/fhGLrus+FasvNRR4PC/1me0jy7h1Lp3rqpkZEdang1aVqbEfQwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369399; c=relaxed/simple;
	bh=XoQw8ZsaL+d4yTUkHlfEB+Z3aVMrRCiqVCbXXpNfX3Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ub++p/TVsvdsfKxaP5hFxr9H3Om2iIGWbfXsrZ7709HTjY8VS01TpIasJFL2aflawqQL0MlJ3rXqk4cWXBQ73pPs8kcgKSC5CnL8yPoMYo1cLz8EipNSEdDIqKUHTLwAyGtjS6L8FyknX0NahWF5bl1iDgCMZdmvwXiK8prsa4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYYSrCRB; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYYSrCRB"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5c663437fe5so676901e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788369396; x=1788974196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=biyyUcaCkShav7WDsA30wL0jUdEIw/+kwUjPOM6Wqns=;
        b=LYYSrCRB5yNxaKxyGr3Sgpyc6U3bumuIwb+jqIVyMnHNws/xV3U8hIXF6EfwC0rPm/
         o544EZa9kZ9Nm7O7obwreKTe1DV/kLDEDg9ZlECRFyX45Hzy4/mYRD39vT9HEJCh3tXc
         eP9l7NgQE/Cso7Jv+fQSLf2gXBzuaaTO+O3WH46jchaSSoIUszXgIM3qXmVtmi+vR1DL
         pXBokcPFUvHexe9obwUBBxHHWk5qcan1K6g5ohB+67afyQQE2in8yRkcOUtEApKUuUVP
         NB++34q5N6B3jfu/1rzlHnPdWMEDbUP1kxyryXHADYAclrlDEUK5s8bURb0p2BH8Nxyo
         AbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369396; x=1788974196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=biyyUcaCkShav7WDsA30wL0jUdEIw/+kwUjPOM6Wqns=;
        b=Qf9LQ0GrM3TECAzi8vGYIMmlX5HWzxbawi8c4Ir8N3MBgQBhN/4QXcpiCZpeUR7F25
         8levIDk/sc9aGZXxYjbZ3xuaKBRfr1vf2fEGRuDtD8Z/HgJxJSOtyUsqzVGORzFjVMfk
         GG733ts9BOQ7rEh7rjQDROxGF8OR4p927phmINShwrd7ZCozi4oCrHGKZ9gWGY70Pmzg
         nRsa0H5ddBWSJnPvEu48J47a0rhJXQpbo2JeCGmli6XgVNnA1asFyBNetErxFlRw1KkG
         UVbCoud0MmXfR+PnuGY7TqZOqCQpHIJ9PyNamHpTysHLduZnujG/2scc1lGkELNeQv3Q
         deNA==
X-Gm-Message-State: AFuF++llYRORrUb+gEV6kJTnACYxMvbUnOnQi0xRiLZxlVOaClGYowpg
	a/DdqhTicYprWUDQ+Rd8Oo1eLn2Eky+mp+h3MrptPWaEQV+E4UIv8iqita+lDzXbpi82yA==
X-Gm-Gg: AYBFou3v8GnAv8xatC1pi+kP3d9JzM2vO+lyaWohQX21dmlbz4kZN3VWKu/FkJLPgab
	SdE84dtxSC3gNqhO5PNxBxgM5yseLYOfy3lSYmbcjTLbklw8qcUfUb7Gs14UUI81pBUim35oGBQ
	SbUedrfyT1RtH8pIk1TjvtZQSk65dwuSKkq4dsf/WrtS3cEKco7+zDeSWudnvXjQJwy2D19oCNe
	uxbairT9XGo5UeshUMfw0jS+WQvSbqafLGwXifidURznTfqZk3RMhwbzBGTKGmWxbMplCf5h9rk
	QnCh8zHZKMj0NjQxjl09/Ogy3FrpkDoFQwdlHTzalwFJ8VS/eX3Z+dS4Q5fyU48g8CPg8bABHAq
	bdwIJ6FP1sUSaX0Ez6DP+nx3wgZA3u2039i9suJPZ/og42mhfoWkHMOkZpxGRv+3aAFEDjpc31s
	0l0SW34l+O2BfFOK/JnY9upA2OcMIfHH2StBX+j+yO2zE2JcrIeuZYeHJr/rp+37UMwfXM6/jHv
	BKfq6m5UD9Ac3dVj6umOz3fibXQbDwS5AHocQ6YSx1eOw0EE6FiiSI=
X-Received: by 2002:a05:6102:fa0:b0:789:100e:3d1c with SMTP id ada2fe7eead31-78a1f26c9b1mr2071503137.5.1788369396285;
        Wed, 02 Sep 2026 10:16:36 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1a510ca3sm2686413137.11.2026.09.02.10.16.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:16:35 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_sync: Fix not setting CE length properly
Date: Wed,  2 Sep 2026 13:16:26 -0400
Message-ID: <20260902171626.1711932-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both hci_le_set_def_rate_sync() and hci_le_conn_rate_request_sync() were
leaving Min_CE_Length and Max_CE_Length set to 0x0000, but the connection
event length recommended in requests by a Peripheral has a valid range of
0x0001 to 0x7CFF (Time = N * 125 us, Time Range: 0.125 ms to 3.999875 s),
so 0x0000 cannot be used.

Set both to the minimum valid value, which is safe since the Controller
is not required to use these values:

BLUETOOTH CORE SPECIFICATION Version 6.2 | Vol 4, Part E
7.8.157. LE Connection Rate Request command
7.8.158. LE Set Default Rate Parameters command

The Min_CE_Length and Max_CE_Length parameters provide the Controller
with the expected minimum and maximum length of the connection events.
The Controller is not required to use these values.

Fixes: 2f8784cfe8a9 ("Bluetooth: Add support for Shorter Connection Interval (SCI) feature")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 24eeb76f7207..5376ade2cdc1 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4797,6 +4797,24 @@ static int hci_le_set_def_rate_sync(struct hci_dev *hdev)
 	cp.cont_num = cpu_to_le16(0x0001);
 	cp.supv_timeout = cpu_to_le16(0x000c);	/* 120 ms */
 
+	/* The connection event length recommended in requests by a Peripheral
+	 * uses units of 125 us with a valid range of 0x0001 to 0x7CFF
+	 * (0.125 ms to 3.999875 s), so 0x0000 cannot be used. Also note that
+	 * the Controller is not required to use these values:
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 6.2 | Vol 4, Part E
+	 * 7.8.158. LE Set Default Rate Parameters command
+	 *
+	 * The Min_CE_Length and Max_CE_Length parameters provide the
+	 * Controller with the expected minimum and maximum length of the
+	 * connection events. The Controller is not required to use these
+	 * values.
+	 *
+	 * So it is safe to just use the minimum.
+	 */
+	cp.min_ce_len = cpu_to_le16(0x0001);
+	cp.max_ce_len = cpu_to_le16(0x0001);
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_DEF_RATE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
@@ -7457,8 +7475,24 @@ static int hci_le_conn_rate_request_sync(struct hci_dev *hdev, void *data)
 	cp.max_latency	= cpu_to_le16(params->max_latency);
 	cp.cont_num	= cpu_to_le16(params->cont_num);
 	cp.supv_timeout	= cpu_to_le16(params->rate_supv_timeout);
-	cp.min_ce_len	= cpu_to_le16(0x0000);
-	cp.max_ce_len	= cpu_to_le16(0x0000);
+
+	/* The connection event length recommended in requests by a Peripheral
+	 * uses units of 125 us with a valid range of 0x0001 to 0x7CFF
+	 * (0.125 ms to 3.999875 s), so 0x0000 cannot be used. Also note that
+	 * the Controller is not required to use these values:
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 6.2 | Vol 4, Part E
+	 * 7.8.157. LE Connection Rate Request command
+	 *
+	 * The Min_CE_Length and Max_CE_Length parameters provide the
+	 * Controller with the expected minimum and maximum length of the
+	 * connection events. The Controller is not required to use these
+	 * values.
+	 *
+	 * So it is safe to just use the minimum.
+	 */
+	cp.min_ce_len	= cpu_to_le16(0x0001);
+	cp.max_ce_len	= cpu_to_le16(0x0001);
 
 	hci_dev_unlock(hdev);
 
-- 
2.54.0

