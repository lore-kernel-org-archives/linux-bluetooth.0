Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07D14A0B7
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261430; cv=none; b=pTY+5N77IVv3C72Nbqxos8hfrZMm5C5vp5D1n5J1PKBMaXOknyAKDPDl0NIz2IFam/g10oRRNq7VDoR9ugx/Cl/kRwKnBL6ZxEZXRcTRfdT76Cwsp3DPZzDgYBvV/ETPc4ddlxKUlHzpZdhRP6lYTHeZnFgaTO9fmyu+pPeEPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261430; c=relaxed/simple;
	bh=DMB8MlNqBbccl0wiHPYaV3P9ig6cJAqgBB7BdhWwnOI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=E4t3cg+cek4p98uo9Oz9tePlzClu632DrHdpYO/PnLYfvaT39HRQJvnq0QiGPrXaSMXcz07t3Hje62DLmcsKhkzsRs74M8kQVFvJbFI8cQgoZGcAz0z+NaSKFI4TnRIDiYw6KSJeg+EnOsPNFxDe+jzdrrLCCwAL7EO8RClfsC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nocJ/VDE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nocJ/VDE"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso473711966b.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2024 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722261426; x=1722866226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKPhT4vuLRiWEgUh5srrWxG2+l39dvR0wo2/JJ1Fk4E=;
        b=nocJ/VDE+zXL0Ktt3jNhyXz8ttYzqtxZss1M7s6c//JlavGZKckCarReCmFiRmWNDl
         9bxA0Qr/krhc3aqvkxtPo6LzYg+BvwEV58At/V0usQu4tcXc3Ha1p2+r1gmCharxUunp
         +UvEJaNUT8E/s3AHHxL07+0DusPirx82b79lFlAIinw9KAZ5RK9St/+ceOs0OyzbIMRu
         o7jJtszUNU7Y0xcRLwOoFZ2Kg+HLUhTSzSo7qJXT5AMl0D+m5V5WZ+2VPbf5JKqqUaWK
         nYzCvT+MUlAX8ePrXm/YawsCJ3w7BvvzwBN67ZpFQgSQ7TkoGYq2J9RG1jR+XT5972EY
         5Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261426; x=1722866226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eKPhT4vuLRiWEgUh5srrWxG2+l39dvR0wo2/JJ1Fk4E=;
        b=HsFDDhL/UtqESA7hv2qE8X/BJkYd80C9uWbD/W/tyMnRDhedlRrA9d6pOaPPQtZVjy
         iJWn0PWYojh4sjXTU4W4CKA3IGzTZAXz9PDH1OS8l7TPWu1SxBvJNwSybTxj4k0Ch+fo
         dkrLtVcvN+dKiVP1jHQfQKUwyV5dhhJXcFdclTDUEL29AJMTb66hJOEabUkxfGcVYJhM
         XcVvEvkFStEonN/6Cwa4T0A8KH6gYWgHRvx/UuyD3hQSSQ3Rojj6lyo8bS7tTo2Y9RO4
         2zGCe+O8eFKGLhrR3R2XuwXREHI53xkOrf8VCURwZ9BOexQP0ONqsYLUophSPIzgubqu
         nK4g==
X-Gm-Message-State: AOJu0YxsInu3CFQckvuzLkfyASkEmthn1Ns684vFr/srkpGu9Azu9iVd
	BzTHjszxSs7s/6jUnSLTLWle8zNf/Mx1oFuEg1IUzW5pzDjR/C8At5FcA3ycnco=
X-Google-Smtp-Source: AGHT+IFrRAFWhiLA/6XorJt4BKMJ2cAKM5KrW25MLTrx+EaNAH1wBdOLsoXxhodCtIOV4OpwKGvgzw==
X-Received: by 2002:a17:907:d8e:b0:a70:c02f:8a7e with SMTP id a640c23a62f3a-a7d400dbfe2mr700200766b.54.1722261426352;
        Mon, 29 Jul 2024 06:57:06 -0700 (PDT)
Received: from lvondent-mobl3.wlan.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4119bsm505519666b.115.2024.07.29.06.57.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:57:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] client/player: Fix not setting config target_latency with edpoint.config
Date: Mon, 29 Jul 2024 14:57:05 +0100
Message-ID: <20240729135705.172810-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not setting target_latency with endpoint.config command.
---
 client/player.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/client/player.c b/client/player.c
index ac595f434..1280f9a03 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1958,9 +1958,9 @@ static void append_ucast_qos(DBusMessageIter *iter, struct endpoint_config *cfg)
 					DBUS_TYPE_UINT32, &qos->delay);
 
 	if (cfg->target_latency) {
-		bt_shell_printf("TargetLatency 0x%02x\n", qos->target_latency);
+		bt_shell_printf("TargetLatency 0x%02x\n", cfg->target_latency);
 		g_dbus_dict_append_entry(iter, "TargetLatency", DBUS_TYPE_BYTE,
-					&qos->target_latency);
+					&cfg->target_latency);
 	}
 
 	append_io_qos(iter, &qos->io_qos);
@@ -4008,6 +4008,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		/* Copy capabilities */
 		util_iov_append(cfg->caps, preset->data.iov_base,
 				preset->data.iov_len);
+		cfg->target_latency = preset->target_latency;
 
 		/* Set QoS parameters */
 		cfg->qos = preset->qos;
@@ -4203,7 +4204,7 @@ static void custom_target_latency(const char *input, void *user_data)
 	else if (!strcasecmp(input, "Balance"))
 		p->target_latency = 0x02;
 	else if (!strcasecmp(input, "High"))
-		p->target_latency = 0x02;
+		p->target_latency = 0x03;
 	else {
 		char *endptr = NULL;
 
-- 
2.45.0

