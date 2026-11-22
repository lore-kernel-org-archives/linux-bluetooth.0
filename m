Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795343938;
	b=5DuIjgM5NkUrrq6kJRxIcPsF9v7m9tCJkmNm4EJP5Tz73+uvmPQs8R4sNQISUjKx63qs
	 86+jgH09aynQdPAahVkrPbNbmZyQOLWX4mK1AEnc3ZaHH3yvY6zmSmLbf4rOlU9kJAk4a
	 dJKkE2XO4gD6LeT+c5MaFfa+gVhBIE3Ke4AaOcms8JwObgfi5X6LTp2JA3SyK6kuPCtmx
	 lQ5yi2dmo62nsWN+lojirp5QQHO8WMBrYfnFzhkE3GTVbVLjPgwfmDbwcsw+xBcw+R1C6
	 UvF9QOxreUpg5JRz9FTA9OZ4Z5uaQSFJdU+oFDUvUS8b1KuZZdDXy3MIiIOLY1hpsVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795343938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NYjdfR9wZ53sXOd4I20EvmJV4CLETMlTJuW8yXUZzrc=;
	b=p544zAO4davyXyavYwa/lWB55c8VgeHM1kxuKDx5BP+C/UgLK5ASAnCL/CRDS7hxmWxj
	 Kqs8y3KSGzMTPjTIbFU7AlbRcu+IYyY/IRTb9MZ3A63LtlsqiKRoWx6vkp2RQjNkq8fRf
	 I6026/lLEwHW+0/8emMe56/lMx8Ng6pxrMMcL9/AJqEwOHjZzwS8fmBVXHtTDcunbREwW
	 IYGYsA7GlaFsZ9RR+V9qZPcMAYKtg5rqpASUW5voJqCdFKI3JASlwIzrUPJJpjh4+xdhs
	 GUUdHk7V+fTvEMypEBnzJHZ/xEdrPnfHIzh/I5iQr+DTdYpjnmYSLbu6pYuppud3syw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=qGQFfuIQ;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA0606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 10:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EA0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=qGQFfuIQ
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so16772865e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 02:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795343936; x=1795948736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NYjdfR9wZ53sXOd4I20EvmJV4CLETMlTJuW8yXUZzrc=;
        b=qGQFfuIQzPGxS733glAy2iEvxGELz1+PyBIksXurDLB9iiJB4vp6cxp4/Ji/dhzQ3O
         Mrypwl8GLVbSnG+xyP5rY0aaHRpT5DphDbuds9Tx33AtYTMV2rk6BwhnUC92rgjirKnP
         79PCiPvCGiU1ntPUHKyFzm2OZzd/YxA+gs7JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795343936; x=1795948736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYjdfR9wZ53sXOd4I20EvmJV4CLETMlTJuW8yXUZzrc=;
        b=la2HzwJLqXPwWdpcDPIROAIeDgykIdrbFv7YCtSeFVnIx5UrbbS8cXd/QKIAHccZW1
         r9LJEn/QkJKZhnvnDFBXyNjd/fFJrGmhUEv5MdAHTjzdHS2A/sr8sA3SlzmumuY7smqv
         KFD8u6CW1wnte0kBGbjHM+BlUxLZq0TVbV60+YTo0sKf2FMHhfStKoqJjP5zenm99BNN
         CmwYMICNnTyUCn+vU1elmYtKhh5+zGw53K17uXdykZZKwshD819fYgl/q2a3Apq3K37l
         Y2esgEGf7YwTvXnUyQnB3II2PmpyeVRfab9RvxTOJZ0oPNd7rDOTcegMDfHmK/Dnb9pR
         ikPA==
X-Gm-Message-State: APuU4Z8v0BkYfa3ihp5ti4i2Q8VOs0npv29cnhTWPDMWbVbIRdx0BT6z
	IBWO2GAZQt2iGrWf9FAR21HVyUgJYHGI0AMe6yhoTnbc+ADCsEkF0pWdmKyC11NZtEk9h8tZfnB
	VUts2
X-Gm-Gg: AZFdTZfM/l2MQFhTdEJWNxDGGXXIYBie07EB/t0Vcer9TJTULkDO77qMCeyuuql/Ggz
	OHv/N+FQ6eISD8+CvCCnPp1NFdLlk3Ik42DbHyJUX0uZLvEvLMD/rvxxm9qBiJyvcOdKl9dhR8Z
	JKuV8BdV4KIRXfAEP/GrL3ikBaBvG7MYHVEo2r/qLGGx3Sh5154w5/Y1EoDrKw/etXOd//piclu
	Pi7vWPsK0dB7hgIO/mz3UK/q3nKkkWDm5THSKTz87UdEwM0gPCCMJajr1pC5wPkQg7HBBJe7noQ
	8ZnfbJ+WwH2MsT32W7gw4HUhWoyXsexv5Hf+0dBXUexnbA7PooEyTx7nErAumcsKVTarAPfXBTu
	AWQtWItxHximcc9lXSAeI+SPjJdKVoTQALqhs8YYP3VXs0ZJ67F5JhsZ2eHSErHHqu1VbrcXbF7
	QlkT5XteXUq+Lc03m9sl3LHG+upVFCuHeGyUgCPcaALFKX7TRyoLQ2Mykho9C7rDC/tAKRCtCDo
	Cf4fVjsGJTQvGk2hDan95U5wLnFDfW/flOZulaHw0F/FsnfCoge9BT3azqjVaRDrfH8BHajoN1w
	tPWpxb11m8A+PXwLHTuD/umcBq667saswzm+834O4G2Zo5YqLkg=
X-Received: by 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb8880f29bmr199544875e9.10.1795343936125;
        Sun, 22 Nov 2026 02:38:56 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8533579csm234606675e9.2.2026.11.22.02.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 02:38:55 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] avdtp: Fix error parsing from failed delay report request
Date: Sun, 22 Nov 2026 11:38:51 +0100
Message-ID: <20261122103851.681782-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

A Delay Report Reject carries only the Error Code, as the one
avdtp_delayreport_cmd() sends does, but avdtp_parse_rej() parsed it
with stream_rej_to_err(), which wants an ACP SEID before the Error
Code. The 1 byte reject failed its size check, avdtp_parse_rej()
returned FALSE, and session_cb() treated that as a broken signalling
channel: connection_lost() released every stream of the session and
A2DP disconnected, only because the remote refused a delay report.

A remote rejects one, for example, when it crosses a Close of the
stream (BAD_ACP_SEID or BAD_STATE), and bluetoothd sends one as a
sink as soon as a stream is configured.

Parse it with seid_rej_to_err(), which reads the Error Code alone.

Fixes: 5f8a274881a8 ("Add support for AVDTP 1.3 Delay Reporting")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 5ebc0c5cc..c49ac9c0e 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3212,7 +3212,7 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 					sep->user_data);
 		return FALSE;
 	case AVDTP_DELAY_REPORT:
-		if (!stream_rej_to_err(buf, size, &err, &acp_seid))
+		if (!seid_rej_to_err(buf, size, &err))
 			return FALSE;
 		error("DELAY_REPORT request rejected: %s (%d)",
 				avdtp_strerror(&err), err.err.error_code);

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0

