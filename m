Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F142279918
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725514; cv=none; b=RhU6UtmtH22pSaDaNJ0Kn5uzW5dNPsTvuv9uGLKjJrI1JkFr6yuHaKsMXAr0L2R7mXQggwjXnJUq+qyTNYH5S1Q8hO0cX/MTQX86AFYQZ7Q5fBTJc52c6vhhSp9+8WpZInCtLoeDTLyBaMYgseRFFuBcY9gM5n38NOGnujCyOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725514; c=relaxed/simple;
	bh=Oqou2WzDRfdfjEeGo8nPmezYJyIJVWvwR4YmWPmq4WI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dbh1TkbjSK++aeauwiovfx7G5AI3QCz4O0h7px92Z/tnAqA2HzSVn/1CPGw5bNGKK3s+jrR7N8e2c0Tn2fHPHSnPlWrNBejR+kX2LUhHcEyjAWXFmDE0+wVKfm7suH2M72bLlwT0+7JPyslui25phdycRTfEMnpnVOE7zVGoMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhIBsmnW; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhIBsmnW"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-884f22f9c90so1359904241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 10:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753725511; x=1754330311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FFb97GSV/X3/LHfN4XYeNCb3U7KTCo6t5xV8IWQixw=;
        b=OhIBsmnWLWVPo2ko7CiMi4P4syxnRAtZ9kVN/JvDA3UacBHvBaYzIdFbfLzI2Ei2+2
         78Kpd0aL+zFg+ztO71MmSJ3B/gkMm/v3VeVcLASb+VZa4qzIc85018jJ0Grc6pOhNO+2
         cN6PMZNpgXDsj9DdbteFCXZBuIrb2ss1L9DxgnMg8yUe2ZMXSM9aiwPd1s/LXyuwKxV8
         dTTQVM1hk6aswkIKiBntj/ROM+/SOBdnz6pXVWvyKWIFVh9g3PPjb4+Ni/sMh0WQEeZu
         l3q+iQkYio33JiUELmqWgbD9KcmQSRT4jqjYUQUL2xYxnIdaI3hwSrK/RC+GK+2qIK8L
         Hd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725511; x=1754330311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FFb97GSV/X3/LHfN4XYeNCb3U7KTCo6t5xV8IWQixw=;
        b=apzqqmTnrnLc0ed/MrbbjxqkBrZOr0iumi2y7fGeKR/Pw1lm9KxD/w3/t/Xj8bmVrD
         L0eJ2/T9ovmRxX6Q/WqGp2Vy5oaVVEvBjjQggp4OXKK3B/xquAWA+acEXx/1DHQAqiqg
         WC8MQiU5G2csjPHheUEQKt/dHQYZNWgV+r1V7cAAdOgG93STg9wb0lkssZWsoOrdQpGe
         aKOW1YsiEtPU/36h/hUIc7RnEPWukxapTDN2xNpYvsUaNBR4P4SwPqBzYgQR3WJA+XnF
         85ty2V4hoffMd1cr4wENFPyBFDAdektHSG4jfIRrjXoWqW1XMNsRewt/8O07KegOwXb2
         TgWA==
X-Gm-Message-State: AOJu0YxWGg9XZcrhcAxo3j4qHLbPT6O+/ETTLIwptmTjppfGu51vlOgP
	3CVwQ0w0JPd0vFXFJ4o7/0jLZ0dw9YqENFaKBh7UdTIRzYqEFfeIpD+jJAceIMwi
X-Gm-Gg: ASbGnctcb3hvT0+rueFwG0jvbcShCJ4t/lHebjPFlLV2bIyZF9NmpbLLKThgH0W+ZSq
	bvgW/aJTQVmnE1l7S2cj6GJIrWsjF5DpjVl4gRFzMNGqFqlgiaW1/f7sLWrNgtZhXNPq4zky2bw
	rg70QGvfPTc71dPg+ugXSexP4O7i2lJRgvedi0oXwPlwrPIJIb36lq8N2WSoXUKjU8pb3NN4hUT
	n4Ozz+RmvU7PJlUjsSChi1br24B+L7kKNrWKGNrAD/a3El1wdWOwbpuJtNu8z9LrYe87faPYEKO
	muDCSyRuaDPUM1oQCkJA0hDVPv8drVPZ6BnRN3qMOHE/wRXVMpXDXN2LhSI2wGVNJthw3xywreR
	Jwc81IAm8URQDbUhZma3Wa1Z33yrOMWOCOZSZCxFtljvfYKoBq+rt47aknn/FFoEe
X-Google-Smtp-Source: AGHT+IFoV5TotUkXfJOA3vDRisxQmNJlrG6WOmulwF9ZPcDiYl/y82bVZHsUsT3IDmAvTB8nAGo1uA==
X-Received: by 2002:a05:6102:3713:b0:4f9:6a92:8232 with SMTP id ada2fe7eead31-4fa3ff0246amr4061374137.27.1753725510765;
        Mon, 28 Jul 2025 10:58:30 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b8de03ac7sm1393940241.21.2025.07.28.10.58.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:58:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 3/3] Bluetooth: hci_conn: Fix running bis_cleanup for hci_conn->type PA_LINK
Date: Mon, 28 Jul 2025 13:58:16 -0400
Message-ID: <20250728175816.850399-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728175816.850399-1-luiz.dentz@gmail.com>
References: <20250728175816.850399-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Connections with type of PA_LINK shall be considered temporary just to
track the lifetime of PA Sync setup, once the BIG Sync is established
and connection are created with BIS_LINK the existing PA_LINK
connection shall not longer use bis_cleanup otherwise it terminates the
PA Sync when that shall be left to BIS_LINK connection to do it.

Fixes: a7bcffc673de ("Bluetooth: Add PA_LINK to distinguish BIG sync and PA sync connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_conn.c  | 12 +++++++++++-
 net/bluetooth/hci_event.c |  7 ++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7d1e79f69cd1..f8b20b609a03 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -830,7 +830,17 @@ static void bis_cleanup(struct hci_conn *conn)
 		/* Check if ISO connection is a BIS and terminate advertising
 		 * set and BIG if there are no other connections using it.
 		 */
-		bis = hci_conn_hash_lookup_big(hdev, conn->iso_qos.bcast.big);
+		bis = hci_conn_hash_lookup_big_state(hdev,
+						     conn->iso_qos.bcast.big,
+						     BT_CONNECTED,
+						     HCI_ROLE_MASTER);
+		if (bis)
+			return;
+
+		bis = hci_conn_hash_lookup_big_state(hdev,
+						     conn->iso_qos.bcast.big,
+						     BT_CONNECT,
+						     HCI_ROLE_MASTER);
 		if (bis)
 			return;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8aa5039b975a..4f0a6116291e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6957,9 +6957,14 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 				continue;
 		}
 
-		if (ev->status != 0x42)
+		if (ev->status != 0x42) {
 			/* Mark PA sync as established */
 			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
+			/* Reset cleanup callback of PA Sync so it doesn't
+			 * terminate the sync when deleting the connection.
+			 */
+			conn->cleanup = NULL;
+		}
 
 		bis->sync_handle = conn->sync_handle;
 		bis->iso_qos.bcast.big = ev->handle;
-- 
2.50.1

