Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1728E584
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644740; cv=none; b=Et+rL0AAUcMLn+xEkae8f8mmT9NPP3RUuqbjo6LsFcYFf9AyvwztSxkMGz3PbKxGZvoh2VrhD7dY5E6IJ7Xd2Rh0DPZN4zDT3SRTGThUQ385uAPRO4cAXgXjMk1eflnIhFGjPnk792KLnDuRHMMolrRKmHvav6BiIjJvqstGSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644740; c=relaxed/simple;
	bh=na1OudGJcIPsgL8mYejAoIrRotEBzgjZ5swXmdaTi1g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nwbBDpHOHoyIBplZ2rJpiqicjqYSAmcJIk7gGMqwwq0F+xk8NVpri86nGcKYiqT4zmgjvHaTqd8ZHUENAGXsSrbc9JrxtxoPIhm/ZQgZTFOVkV/EFOemZLgEYUg2XkUDEe2vVX15FCalHp04SdicAyCjYdm8uTGM6tNgfD/b1M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=df89yoqZ; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="df89yoqZ"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4c3201d59ccso97436137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 May 2025 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746644737; x=1747249537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t3TrB6AJPU1rrOBGybPyqWkkTurQtn8DxL5TtXgQLt0=;
        b=df89yoqZRqzIRMSw6a66mhbHTjLyDoUtrYKiFJpi9gu9TRa4YV+YNIgo4LLMptR0Wx
         U/YSMWnRPsetwimYlIeNOqNsKtnHbTfx1zCeHTg7wcQukvCPQaRuwOFu6/+MIOb1JxqV
         SZuvm9/fPbF5odfQD70XS8ubK/xsotplbsjo5hvTgwX333TmiCWQ0j3qH8jbXsNkD5XQ
         09vNYwnvHgOCnJhJJlwmQ/cCiOENZwNVZWq6zJwEq4oAX6PfhFYstJN+AmpILNJSMWVx
         jl/82hWl8rN3D4LJaI/UOMJsx5k+8mNM9UGjWk47yANqhevGy0q6nRdcuLuAFlFcCone
         tdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746644737; x=1747249537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3TrB6AJPU1rrOBGybPyqWkkTurQtn8DxL5TtXgQLt0=;
        b=CdCdxJnSMYU9QR9QcVgdTERkuiK1cIddVIkgVQUEyuxec6j3NYug2ugRIQa3+rThsb
         NC3+QAzfzBCQI6IfYbIgjXXADCtcd8HgL93vsjDg00Y8Hczvv4gM5SWerRYqsIQWbhY7
         gy+DlcMeo6ZtJp94jEcUIzaGwnHtEEmlkX2Eqt++FNK7dg8lDUg+Etjxev+1Hwqgvf+h
         f0+BFQnh2WhvhEpiHwftxQOr5OO2lB0ZWP7VI1oKZ00QZMe0qWq0W489mX+Dx8e9B29i
         8/b4709FKJfZWxFUOui1GZq34jGzerB8UwYS3iOt1e12GCBG7onqMffe3ef7QkwuSEgY
         3XHg==
X-Gm-Message-State: AOJu0Yy3dDMC1ry79AHiwwJV2YLT49ff64Pk4YFSpszkHnKBRe8XFhvM
	1opxP0JAopTNxM+LfATJ9+vah7NACUhiyL2k5fk35LVJj9wRsKO84xY4cA4V
X-Gm-Gg: ASbGncuAcy8ftJslYv1xA8p6M8isYX9/Jcdi76opM0q8o221/0YPqVO2VuQBb0j2Dlu
	N0xeSyU1aOJbM7AyT6R1sPaccBvAm/SQe4awEDWv9tRwhdPKe2lkGi0SbBHJKrx9LDCd7pk4qiW
	kL49PnEc/eiscbVz3p6ZlP5RykI/4PZapxjOnb/iZPEaWaOmQpPTJuSUn0cq7Em69jRrKsMekoQ
	hEv+tA5syAxU7RdAOZ4yeuheEWrnyUiVfJMxyrEicgvYtL8keb32YALMTunu7/R4CzSLJAyyqXy
	5YTXh9ylZcB1MKV/fS2I8+FpRUuDXgisZ5g/yfszYr105iGNARdD+A450CkRZRSpUOBQlcdURD7
	eYaxIqJYr0w==
X-Google-Smtp-Source: AGHT+IGRI9ieYdqzfDHdpoVq1enndDELPacG38AdBghnPWfiN65HPXp2j3g9YDWHPIlvOQhS8m/o5Q==
X-Received: by 2002:a05:6102:2d06:b0:4db:1517:46b7 with SMTP id ada2fe7eead31-4ddacd3554emr880081137.0.1746644737364;
        Wed, 07 May 2025 12:05:37 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4daf2678a48sm2189438137.29.2025.05.07.12.05.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:05:36 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: L2CAP: Fix not checking l2cap_chan security level
Date: Wed,  7 May 2025 15:05:33 -0400
Message-ID: <20250507190533.289009-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_check_enc_key_size shall check the security level of the
l2cap_chan rather than the hci_conn since for incoming connection
request that may be different as hci_conn may already been
encrypted using a different security level.

Fixes: 50c1241e6a8a ("Bluetooth: l2cap: Check encryption key size on incoming connection")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 73472756618a..042d3ac3b4a3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1411,7 +1411,8 @@ static void l2cap_request_info(struct l2cap_conn *conn)
 		       sizeof(req), &req);
 }
 
-static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
+static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
+				     struct l2cap_chan *chan)
 {
 	/* The minimum encryption key size needs to be enforced by the
 	 * host stack before establishing any L2CAP connections. The
@@ -1425,7 +1426,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
 	int min_key_size = hcon->hdev->min_enc_key_size;
 
 	/* On FIPS security level, key size must be 16 bytes */
-	if (hcon->sec_level == BT_SECURITY_FIPS)
+	if (chan->sec_level == BT_SECURITY_FIPS)
 		min_key_size = 16;
 
 	return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
@@ -1453,7 +1454,7 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 	    !__l2cap_no_conn_pending(chan))
 		return;
 
-	if (l2cap_check_enc_key_size(conn->hcon))
+	if (l2cap_check_enc_key_size(conn->hcon, chan))
 		l2cap_start_connection(chan);
 	else
 		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -1528,7 +1529,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			if (l2cap_check_enc_key_size(conn->hcon))
+			if (l2cap_check_enc_key_size(conn->hcon, chan))
 				l2cap_start_connection(chan);
 			else
 				l2cap_chan_close(chan, ECONNREFUSED);
@@ -3992,7 +3993,7 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(L2CAP_PSM_SDP) &&
 	    (!hci_conn_check_link_mode(conn->hcon) ||
-	    !l2cap_check_enc_key_size(conn->hcon))) {
+	    !l2cap_check_enc_key_size(conn->hcon, pchan))) {
 		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
@@ -7352,7 +7353,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		}
 
 		if (chan->state == BT_CONNECT) {
-			if (!status && l2cap_check_enc_key_size(hcon))
+			if (!status && l2cap_check_enc_key_size(hcon, chan))
 				l2cap_start_connection(chan);
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -7362,7 +7363,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			if (!status && l2cap_check_enc_key_size(hcon)) {
+			if (!status && l2cap_check_enc_key_size(hcon, chan)) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
-- 
2.49.0

