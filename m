Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031941;
	b=eKKkhnQn8UWLwE3YanndIuq7WZSJgXAE7vBdgBEXiSbwksInQQt0+aqg5B41fzXoLagb
	 +5n4HTXNZxQkkn7SBOqiW0Y+imXzxeQGSndCZxZ7RsA1DTSLYb1sp72Aac4+E1hOj9j7f
	 4Uu2KWtDs90HTdXRCZRrIsiYU5G4NNge3DF3xFzdfTeaDQm8qTen5juvzkzk8ROpKXqLZ
	 zo3oc5SnfCb5CYdpipvQ4F5gOxL89jhf3Tk0l0d1GUVCerz4Zb1DAGYx9MBuJzQWLSKUa
	 PqMmgS2FOy3hRuahJoS3NO8QvHmdNz6DlD4cM0DZPNf8pxnf1oIBT4Xay7k5VBB+zQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
	b=Cl8hfc6U/ALsPADfY9sPz495dNKNmMuU2jwq6xRT2X0GkB5Qjop2khr0xRSxgg1OMGxq
	 AtT6UqUY7Gx82C0Cirhv61P7iDIFTLRWyi6VVeBsQYYrY+pNvyCVcMp1OBe6ogJAP9VRK
	 yeP2js8V6AnfajsvQ/0ryPB4d49W940YfiFDgbn7QhhoDz5+mX5dCPWMIubeK83OZZ8wr
	 sjPsrXcdRx31Uexe5/pA5CkuzWEoDv++fkLis+BU3m+ncQSWKnp/SLMNVLVHLgEZ8dR/r
	 I8riMGx7DDVNUm+lv+NU8tbmiqzQG60BEkzwIb4mm+3+Ni5jNYbxIkDNfA2TvMvhiXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zcKl4eV4;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17860A2616
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E17860A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zcKl4eV4
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so537590137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031940; x=1795636740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=zcKl4eV4xGjLTSX+5poa5mucoIjxNyzOhkCSZlfIOsajPHNeNvDdt0FM8Ve7fKXYSS
         q0mtpIniOyXGcKf1LXLEQ8o3egvSX9g5XWbAPCRe0g/bB3pYuoMEOBHuY3p2AeTL/Wr2
         p+gbmCflLvZe8FQGWkCg6YwWIueiljb7mqspeGTaICsFnX+KCsa0YwB/PLVVzYoNMVhY
         240zrvAVbq0d/fXTai/TaLWsFEgO5N088QAuPzgCe1ZqiWcSCTAwQJnZ8eGb7u6f5MM9
         EN9pOg0qfGYOme6lw8QazAmw73wEzyxv8tg++JKKA/5eDNniK5D9rLKKf3jfE5herCwJ
         I50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031940; x=1795636740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=kF+8FaqagqlthGEZmQbeOUzPmG/pcl67QSF0I/VQ3r8SauHtF+7JMVCM7M8UwsvpUW
         9trl+z97TZBrnC/iaRskMtApN5N05WSHaxWfTnPm84X39W/C1dzzv3Kcq5+2EF7pmJO1
         Mz05LAFsjT9bjrUaeTxfDp/l78EX9t67xMQn5QTbwpKk9O36055/8Ye4eyPGK5JXaDTi
         Bzk+Wx1KXlM3Z9Aeoud10J3crpxbI5Wp93eG1cFNK9fH8QFUO5O8J4CkXZP1cQhSjpDa
         1PvOJU+PXAss+soCii7calcLw+5ff1wGGJjNNJujIGl55kzsFldZJhxnuUUutHN1xu1g
         lAZw==
X-Gm-Message-State: APuU4Z8CKG6Yigvk5ImFOAGgDAcqi60nxcJo5ZRjwPevHXtLOGRQ9I55
	zQp78AmNFZCfzH22c/q8xN4kxOMfNLC7abKyF8rB2j7LrG9ifvheCaMRChdyEfhz
X-Gm-Gg: AYBFou3tcsfh0sC0vi+ojFw0/L8HaMJVHsCBG6JENIZTmTQvGwh1qZPZZl6VlxushIe
	pl1St1I2+U1r3bZSqIVBSUhiIRmLtq7+a8QRFqypwSW6xvShuDR30E9lm7Jh+BUSViWHE8Gf6hW
	0rXuvRTbmWJ0VouK6yKQuTLvLt3VTtVuQJ5Mba1i9rBtM3u1OqADNN0BkWNRRislinrDzSchtPe
	ADE+wnbuL5tiKZzPnd3yGMTRMhjhuKgZnEVgi00LCP6uj79lFYOIxbCEbJufmeSbKWxGURyiSvH
	KrVMbaAuuQrcUjw4IB1PnYCIu3yUixX9Qmub6N7Vlv7jxBk5WnmXXnDU+LeUySOSqwlp8cq9auz
	EYxZlevA6ork4uG9M/yvmP9xt2BbYAnWZj1G4yvfr8cK579ADlZtjtEwhUAjZWHtH2J6ZTrdLNX
	aIRkrOLK+mW5UzEav/QFLYQw94ovO17MK/Gp6GM907396ARtPx5IszrjQKnAwdqFzk8TTLYzz7h
	AbFj2pDNlGKQfp6NPV3nJfK/a1RAINJOiIrM45aCt3vxZA4Ln8bEqy/t6WmngULB8E3bQRQr62T
	ZO7jYyhSHht0OVwtno/CZxWeIac+GFxppHxzJJLG0q7ROLvTJmu+2IyyGZmwK5F/jV0/iB+X3Zc
	mvcJ5+CuROGz1BkgyW/PqDaLoa9f3T/keVFUfjqfSdgdcAfJ8n9sBOD/8FHW87oZz7sPSpTuCEw
	c8L2E=
X-Received: by 2002:a67:e7c6:0:b0:7b3:6079:1900 with SMTP id ada2fe7eead31-7d6ba4af66fmr1415583137.37.1795031940227;
        Wed, 18 Nov 2026 11:59:00 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 15/16] shared/rap: Start the Real-time timeout when the procedure starts
Date: Wed, 18 Nov 2026 14:58:43 -0500
Message-ID: <20261118195846.393710-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

RAP v1.0 4.4.1.1 requires the Requester to disable Real-time Ranging
Data if none arrives within 5 seconds after starting the CS procedure.
The timer was started when the CCCD was written instead, which can be
seconds before the procedure starts, since the CS configuration and
security setup come first. The CCCD could then be disabled before the
procedure had a chance to produce any data.

Start the timer from CS Procedure Enable Complete when the procedure
is enabled and Real-time Ranging Data is subscribed.

Assisted-by: Claude:claude-opus-5-5
---
 src/shared/rap.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index bc6f133b5da9..d4ce1751f052 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -411,6 +411,7 @@ struct ras_ccc_state {
 static void ras_ondemand_client_reset(struct ras *ras);
 static void ras_realtime_segments_clear(struct bt_rap *rap);
 static void ras_ondemand_cache_clear(struct bt_rap *rap);
+static void ras_realtime_arm_timeout(struct bt_rap *rap, unsigned int timeout);
 static bool ras_cp_write_op(struct bt_rap *rap, struct ras *ras,
 				uint8_t opcode, uint16_t counter);
 
@@ -3352,6 +3353,13 @@ void bt_rap_hci_cs_procedure_enable_complete_callback(uint16_t length,
 
 	/* Store procedure enable config in the session-level template */
 	reqtracker->bcs_proc_data.proc_enable_config = *data;
+
+	/* RAP v1.0 4.4.1.1: the first Real-time Ranging Data is due within
+	 * 5 seconds after the CS procedure starts.
+	 */
+	if (data->state == 0x01 && rap->realtime_notify_id)
+		ras_realtime_arm_timeout(rap,
+					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 }
 
 void bt_rap_hci_cs_sec_enable_complete_callback(uint16_t length,
@@ -4643,9 +4651,6 @@ static bool rap_subscribe_ranging_data(struct bt_rap *rap,
 		rap->realtime_notify_id = bt_rap_register_notify(rap,
 				value_handle, rap->realtime_ccc_value,
 				ras_segment_notify_cb, "real-time");
-		if (rap->realtime_notify_id)
-			ras_realtime_arm_timeout(rap,
-					RAS_REALTIME_FIRST_SEGMENT_TIMEOUT);
 		return rap->realtime_notify_id != 0;
 	}
 
-- 
2.56.0

