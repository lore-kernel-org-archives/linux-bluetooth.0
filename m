Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4723325487C
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 08:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774687631; cv=none; b=mvMZGjvRrEpSFyqdI6YE7hRcQZjSRzdndlr2UDfs4U+vPGHpm6jQw3DsoYwab1lGeM02RuohJEy46xlU71vBgyJlmSbTniwLrNps/y8f25ulnyBNaVsUzL0d3MpvLDSQ6bcHSHpmIeqm6518svEAlKNf4k/PFRKCCzw3HioFW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774687631; c=relaxed/simple;
	bh=vu6GwH8lg+WlvtYQjpdlmKqSSH1CL/aqOwm2YVUYZ0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxkfDq6glsjLT9RJDinVTkfwMRxLqhf49SedVS0s+YuhAlhsGdlazVQ7J+S6QGjRdFYm8kogqbJIAhzlNc26+sACUV8W/Qugb+7lozMlVeB4WovEBcRggHScx8buWXvLyslMc6QxqPHSn1lPtH84mEySb2cVvLoe1iT6LukRAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGrO0oqT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGrO0oqT"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso103858a91.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 01:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774687629; x=1775292429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ew9NpfGRmawZ3hZMjmWZSIlHYOBunetFwERImQyBBJE=;
        b=NGrO0oqTQZbgWyOF+OQLB5c1N4VrKhfqd2rsfImwoKZ0uDkcE4Qn/r2zadTHoxfZui
         v9m3rk1R0F+NO2aA+EumtXLCPevLoHpDyBNydgaHfEqs2G2x342xQ4739cwT7AjCU+Py
         CsvM2EX3nw6R4pTSdKMefS5ztVgxLrX+iwdSo5SCF+ovJGsVbjorXn0XVQTspoX0mR1/
         OrD2WSr0i/JydD+MRx+aQprE+nQfpZJ26wFOwEwgoSrrDg4U0znPTG9+4eMrZPKHiHO2
         Tr/Ks2bGD5lUiSI56BlBr0/WfzIjZLBGNXeGCYhpVeU2dBrQK1WBzsg/U4iO0C+D31HL
         n7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774687629; x=1775292429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ew9NpfGRmawZ3hZMjmWZSIlHYOBunetFwERImQyBBJE=;
        b=YcZK9ZVIXyBUY2ncVLqIdXpVOOztxSEetE6ioqi5VmFgEiHE92Z0sWpmx2p6aKlhZ4
         ZCPh3W8SlVd1Jh5BNsXY8CFaTxfiiE3TwT9PV6BTxbr2t3aB4LZoOnBfvYyG9gTcVetV
         FpkSAq4xh8HeHwiwf2uzHpz8I7i1XSgbSmgoS9gJWiFCToSQBCI6CyoQ57Bbtm1tjHj1
         TVZoRGjj6E2UyS2usa+yUxB9kyikSWCDELXVFdHwXIlWFgK0OeKZNgG5jXZaa4UXehOK
         hv55GpE1ABi40BDQ34nXSICRFE1k+ofGcAlhf3tp7TNHyNfS4ZYicH5KTHOSskmzGNSe
         flhQ==
X-Gm-Message-State: AOJu0YyWTJNLGwcqatmA/OoIRdY/GQovJ57lFv67NuHFyJ2F8r9ARulw
	hL49kX8Bk3mOuDnRWixaVeUlp8CeI/dMcrxPkqPqpMueXoOuRU46fwZGrCOu+RPh
X-Gm-Gg: ATEYQzyHZHqu2pb2hvAf6zHd50Q3ZIpLko0oAtyZ1dANzZunAqcLVDkkP28SEQ6zYvl
	75u7huxm+Gq/nY66zxO4w2JupGnAJtus2dNhcrGCLDjjQs4UiskLUP2Z91Bxb+VJswlMqsHRbKk
	CpuZeU/Kmif5f0gtnMHswIshAjQIKWz3YG1DsUTbHVAbsbXmjCcSu38+jOIAejwXJySORE9DIgJ
	peXWvsRNamHuiZAF7MV0HEKKYBugm334RatPy0yEUCBXCsR1gUbw1inDRjaZK3EdTZ15VZt+QLx
	AclnGOVIWIIuXOy57k+VdwE4b35Eu1mkek9ICPUPUGvMgEc+92n95aYWycyROM840MzvjDMNG6P
	wma0vo7AlPkmjBMuj9En+q0IuTzp+OF3BqnSEWvcQIqQ9cle4Z7zP5s/JbTiD0Tib2NhtcQ2CWF
	tEhr9AMZ4qi6OHAlYOTYtd3uWvb0KTQHYxkhkCyZ099Fv1S8YPKxutTYJXTQfnpLm4
X-Received: by 2002:a17:90b:3f4f:b0:35b:9719:b7ac with SMTP id 98e67ed59e1d1-35c30117749mr5103241a91.27.1774687629151;
        Sat, 28 Mar 2026 01:47:09 -0700 (PDT)
Received: from LAPTOP-KU1E7KI5.fudan.edu.cn ([202.120.235.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950d9b12sm1689510a91.17.2026.03.28.01.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 01:47:08 -0700 (PDT)
From: Keenan Dong <keenanat2000@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Keenan Dong <keenanat2000@gmail.com>
Subject: [PATCH] Bluetooth: MGMT: require exact mesh send payload length
Date: Sat, 28 Mar 2026 16:46:48 +0800
Message-ID: <20260328084648.51158-2-keenanat2000@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328084648.51158-1-keenanat2000@gmail.com>
References: <20260328084648.51158-1-keenanat2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mesh_send() only checks that the total command length falls within a
broad range. A malformed MGMT_OP_MESH_SEND request can therefore claim
a larger adv_data_len than the bytes actually present, and the async
mesh send path later copies past the end of the stored command buffer.

Require the command length to exactly match the variable advertising
payload size before queueing the request.

Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
Reported-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
---
 net/bluetooth/mgmt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e5f9287fb..aad0da033 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2478,6 +2478,7 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	struct mgmt_mesh_tx *mesh_tx;
 	struct mgmt_cp_mesh_send *send = data;
 	struct mgmt_rp_mesh_read_features rp;
+	u16 expected_len;
 	bool sending;
 	int err = 0;
 
@@ -2491,6 +2492,11 @@ static int mesh_send(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
 				       MGMT_STATUS_REJECTED);
 
+	expected_len = struct_size(send, adv_data, send->adv_data_len);
+	if (expected_len != len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	memset(&rp, 0, sizeof(rp));
-- 
2.43.0

