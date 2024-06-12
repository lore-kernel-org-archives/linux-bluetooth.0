Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86C381AF
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718219511; cv=none; b=S1vD3MzDj4DZ2+to4C0XJyap+FkHruJmcI/vUOUyXIL704SUsboaMo33qXj6iqk93domg5V0j7kSL2KzBRmeX0JGxPpKTVL7ZcdfHiaNOnvxEW3uDgTHhH1AeX5xpsNk9Bq9PPz0cZOw29NL52xM5+NP84T4RVn0X59oA6HdfMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718219511; c=relaxed/simple;
	bh=F4J4efZTwxHQDJk2qK69YTUmbWtvlR1LVQvQgFnGbyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IEhOwcpENMIiiP+04eJXzHLTxMuGrqPNE9pwMjmmRqIRFzKEJLtj+nl3PvOtfAiFevTfISqxSZPAQV/NzPDhDnEgf8H02OxmYFH86gVtPika+WoYUt9jirRqo5xfxUFVrvbPfOJq+vaLHymXx5XhsAYZlJBS+pJgaU+oL2B6RhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Apgv/N8y; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apgv/N8y"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-48c4c15e57fso75461137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 12:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718219508; x=1718824308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LxelnDaGXHSBue2jtsAwnUYUt2Mhf3DQsmqRxsR3gMw=;
        b=Apgv/N8yAXXEjgkObUuIt0SS8Exk5EvJaR+QaCTcWbSuEbLdXUabl01d4F11Ts9LWp
         TKssuVVVVAl2MMXjypLak+igRcog5q3tQ+lOCpQhvezEizRKaKUlBsSZOUdMsvnyd2WQ
         dEQ+FRIBlMuSgOEPHA/3crkA1VUwrTfWiIz9/PnMnC3+iskQSC6iXlUZv/Fs/Xz07YDp
         avbv3yflORVknuAhdkM/JDOjxpj2sLOUBofGejBCwidwRhmAMRse8CAB8xQMaFd9vZq/
         7yQCauU7vNCsRYdV9WmEAIkH9GYZocgSFwNRYVgcopuVCb0VIOLeyjQPJ7sWUAH/Z8nF
         XfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718219508; x=1718824308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxelnDaGXHSBue2jtsAwnUYUt2Mhf3DQsmqRxsR3gMw=;
        b=mzPIqcKr/tR33dAVzF4yPmH1+ib4ZWd6eOAlAqgp+aPA+a6X+dP22fKXUYbqj6MmjN
         z9zukrSTUcKSmaE9+cAjsn4fm/OTXLf9q6uYilzYn/512hgRz7TCBlKmHws6UEHj/0B1
         8qzNysnPFBuVT1IDHGLWDT9tCKNK51IMtpQP3B+GM6kOYfWkR2+8zYeoYQB+vYNVhtJH
         H32iHYSjhXrcBuUcpJ3ht3Tl1xWU9kwW+sCEb5MFsX3owW+RY1bQ2K6QTyRDyltCDulo
         yxAK7BNQMDbvDJIK/l96TcTLJXZFSAzyi/2YbgxhmF4Fc6q7vDS74ZBq1D/JdkosPLJ2
         +PHw==
X-Gm-Message-State: AOJu0YzhLtSWbPlCPf27fXpLymyw0AFl0HOKnPz7H7ixz3a+w7N2KbGV
	gKrbGq3voITWC/kRMZnlMWJZvplSqr4D4dg7nqPlMKhi/0Ndl8cPmNmY3g==
X-Google-Smtp-Source: AGHT+IGKBy7KE9yE93CAz4+o8LmpMZISBoh17bNrVzM2SJcQe+BpyWSAD8/MBajfNc2mIDCabJV/NA==
X-Received: by 2002:a05:6102:515:b0:47a:231a:3856 with SMTP id ada2fe7eead31-48d91de1a04mr3240969137.16.1718219508384;
        Wed, 12 Jun 2024 12:11:48 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-48d92a165d3sm478706137.31.2024.06.12.12.11.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 12:11:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] device: Fix storing conn parameters without first attempting to use them
Date: Wed, 12 Jun 2024 15:11:44 -0400
Message-ID: <20240612191145.1379415-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some controller seems to have problems to use connections parameters
that comes from PPCP as seem bellow, so instead of storing the
parameters immediately this wait the MGMT_EV_NEW_CONN_PARAM to confirm
the connection parameters are save to be stored:

< HCI Command: LE Extended Create Connection (0x08|0x0043) plen 42
        Filter policy: Accept list is not used (0x00)
        Own address type: Public (0x00)
        Peer address type: Random (0x01)
        Peer address: FE:D5:D9:EC:AB:99 (Static)
        Initiating PHYs: 0x03
        Entry 0: LE 1M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 7.50 msec (0x0006)
          Max connection interval: 4000.00 msec (0x0c80)
          Connection latency: 0 (0x0000)
          Supervision timeout: 5000 msec (0x01f4)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
        Entry 1: LE 2M
          Scan interval: 60.000 msec (0x0060)
          Scan window: 60.000 msec (0x0060)
          Min connection interval: 7.50 msec (0x0006)
          Max connection interval: 4000.00 msec (0x0c80)
          Connection latency: 0 (0x0000)
          Supervision timeout: 5000 msec (0x01f4)
          Min connection length: 0.000 msec (0x0000)
          Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4
      LE Extended Create Connection (0x08|0x0043) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)
---
 src/device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index ce794f315995..85857577ae11 100644
--- a/src/device.c
+++ b/src/device.c
@@ -7435,10 +7435,10 @@ void btd_device_set_conn_param(struct btd_device *device, uint16_t min_interval,
 					uint16_t max_interval, uint16_t latency,
 					uint16_t timeout)
 {
-	btd_adapter_store_conn_param(device->adapter, &device->bdaddr,
-					device->bdaddr_type, min_interval,
-					max_interval, latency,
-					timeout);
+	/* Attempt to load the new connection parameters, in case it is
+	 * successful the MGMT_EV_NEW_CONN_PARAM will be generated which will
+	 * then trigger btd_adapter_store_conn_param.
+	 */
 	btd_adapter_load_conn_param(device->adapter, &device->bdaddr,
 					device->bdaddr_type, min_interval,
 					max_interval, latency,
-- 
2.45.2

