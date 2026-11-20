Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193726;
	b=AySf82mNofp4nKoCCj68X47XhBlwAeAGYd18HyW3bwPdY/5fPRzWLd6jO+jZJzkQCBdv
	 g+vHyFYTtqWmX7cUetP8KDgX8WyYBeJpfx8sENAyf+lVNUas7OlvgPtjDO2kgxJ9Ba/cz
	 0vODyaQ35nWqYdJXldLKo1cgR0Qg7thL876dyol1ASg0ZvR+bH6n9NRDNQSOL0bo/tX73
	 8s1HuXJPwkwpbF3vyepbLKk7SoaXBWaWRQ4rnSO0bSnEQ0st4TpNIbCAN+RP0tPyPkSkC
	 OPICPjo5c48MB4EP0Q0kSbQbSlFk4vZx9grkV5pWyBwDkjetEtzuNuBJeT9VqBQGoGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193726;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
	b=DsRXUvshgl4hVftMG8Dzay26/YdemVF7gUEiFHuye4XRQKAXdZgn7QIYWPbJeKJL1dVl
	 svdjnmwKOn3IYIxCZ/ZkyJFtdvxJQzK8S9rxIyiX/E3BBqLoQt18OfZ77hzTsMpmdxnWw
	 lkMKcKA3Nv3j9eVkw2I4nxy60iD5jPG0MkR1SAPkzW/QF2ht+s14ahr7dpiDOUZATd5Zm
	 OFl4dXOrBE/vbnNP/NbYkecTavR+M8EiLTTZ6IyK6ITDN8E1CfZxPRrJHyXtw7Tyg/cZP
	 jxZUafKbMr9e9TrgdNU2LMQdNEarWCTnBOyKYa2gp9Q6Fw2BE7HQAuhttFN74HFh2PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpBaSNzp;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21F606A33D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B21F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kpBaSNzp
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-99e0d9b3438so308627241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193725; x=1795798525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=kpBaSNzpiBNRAP9gQ7l/yzj4ZHpHH/ktGcS9Idngg1jO4VtSnuJFZ818iOOY2Wq0DA
         KU/IlMRsOfyMbrO/kboeiFa4JRnVUfzxeS1zh2BFG3VNchCyuAj8pAPTwb8zqYjYsN95
         427vRd2v55sPJmJRNnKQg/n8UoQiH/JtiKNK1vaOcwYPNg72K+9LUJQ+b0NBYEL+qGVL
         nqeXgl8VY8nSACtRbJfsofapncLtJoRG+SBojLsuGO6ZlXfHV1w/IbE0+X5Qkm4xz6TX
         eiOX3OQdtkYt8nNUM02ytF51KmojroyxIyhcB4HVw1CxdLjoH8bOLVrXY/tBj80jJCGS
         GBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193725; x=1795798525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uNJDcDonwJPcKiS2SaoS4TSeCKFi2WbbvpazhM15EQc=;
        b=M/OMq9CL5PAoz5zQ20zfdHR1laEuirynUaN3DO7L0nblE3ew6A1OvVzFdFjCl0nieg
         vo1BLXLsfrwCz7hScVxyo4esnLuLGpaSLQGiZpDywYzCvrhiNfsM3LjihtogV/r1Q0uL
         WvckIsIXSqnm3kq1XIPqwla51Whne3r9R2XaVzKxACozXVWBJhsQJRQ52RWdHXLWEn24
         fVv55xK3Moi2hXVnhVDVQ4P9zYLCNRZpz5jgkghtjHQtVqkhkBJqnnEQDmAAAJ9H3NdP
         1qyswZTYCqN5/0/DA6DIpEWFnbJbKhVJEgWbB9w4YNw+j5EAeaLgNZLXJ7o79UOF4mfY
         dfRw==
X-Gm-Message-State: APuU4Z8rpm3B66iZa5FtUz3G5YaxTTjzygcvtlLE1z5ULnw+KAGQjL4q
	sVLM7OVoTpZQsV8LLwt5if9ZSu1SfJ/K0QcHJTQwo7RPEojACOFY+Pp6gDYnWjJs
X-Gm-Gg: AZFdTZcLtYvY8BV6nyjLguG23cgUKxcl/E2deHc25sbjMoI/t5PgNHero7zf3HbGI/1
	fsGaf94EEr1dmWpOTtIbqlQlo5etIXJFSbnyL69F8487x6VlKQ7u3SD8SiECT6YITDdTkIfwdx2
	3CfeNAUSMCFELoumAeAGYm6xfJ/MgmicCB0+TasEI56fCOESTsKHDU5Xa8GE1C0WR0BAyWEPAUw
	0OJa0A2YWCY9iEU8pBpnhiF8MUy4jktaTXbzeKzVT1ys1xNhCKlWUyYaWLkv5YSB2M1i3R000gW
	5HnGPuRK23V+ryKdrl3vDQVcO/GqbIV81filhmlbK0J//HAAz9Jn7rpI6ZJzlRTQGWg3y6F76JT
	bNht8xvN97MeyhoTyJOBvAmPwuW684AZKRM8lc53ydirHgRqwp1oyHVIDZsU1sZDT7XeIak2cwQ
	OiGykImkvsIbdKAFHfMp5JrfXbp/LR7lGwDYoCxULAGleFIpF4IMNwTziCgeB7P28IWx9ZPhj0u
	ft3hkP2CFG0KwUcqRV5Q2VnKX1A0sPvaR9lEM9Ea6STQfi0A7P/uuiPb97PvtLqg77BGec3KW9P
	RoKuboLTopeh/lvno2s1sTCDd0xcREqiBdosrCSxdRaDq4/Jh4usGauqmFqQ3FhNddwocB1Lo9g
	Qlq+/p71tQW0FncWMrIcgr/T5upZhevKZDWv9zq7nxIaoGk2nR+uAk9rTt4YIWyARZWfPihtRzx
	yRz+4=
X-Received: by 2002:a05:6102:440f:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7d7396aef0dmr1654067137.36.1795193725153;
        Fri, 20 Nov 2026 08:55:25 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 16/18] shared/rap: Start the Real-time timeout when the procedure starts
Date: Fri, 20 Nov 2026 11:55:06 -0500
Message-ID: <20261120165510.1858959-17-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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

