Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB153EC830
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818892; cv=none; b=HDnhgIEUYLPavfCd3Eta+9IpzLlQKBmxXQmzJIt6M1LwX9R07F0uCIGBcRzC1vHFFIiX2J6kRSvD01dgqZS8zEKvwu0crKKtk+dE1w/cOT14ed0n+sXlo1HG//iqw+TcylWRu9YJDIa9Ycr8/k97B9pa/hlqk6rQ6DHM2snZdUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818892; c=relaxed/simple;
	bh=eLUY5hSRSroELyv1vY6TVNc+E5T3oQJXadPdGozeASo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DoXxQTsScTSU48/al3EqX3DzBo2i1n+VsZeLJht5PDX95KYKfUaGOavUJefqwmAXuM+Ky6cI2Pitt06MvgbhhMDg5yWedJjdDtcoNhz7h2Famus5HXNvoK5FrmnpW7texib3snLpRc/TBR+JIdSGD0GJF5726xWWPke+8QGnuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUwGc446; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUwGc446"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7bf5f3736d2so1344878137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818890; x=1792423690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WrVqsyzotvIl1u3VFyJALoyYbdhw0ZgDRSGsrp53+LY=;
        b=SUwGc446AUtQ6CGkwvJJHoapXqaqRvG21Ffpwr/Rb57et5rKay2f32xEkxMeMcKnTr
         iwUdHDAORNK4P9yisP1bKBTvI78VBrPq2KlfuFCNlV49MyCh3O/6EHegyJydS0t8NQE6
         Dw7frgCXv0aJzXVWgsegPafLHDXQEXYKbqOpZVOWLgy8eTcn/PgjDdsMYL2pOSIcqDLu
         YekekLRvpqbmgJGXIflQ7zPKObaGuVm2ujln1djmRrC/gsOQjcsqpt/q4ctmHmKMNq0s
         /ZLDA/48XKv+yc2MLSfvM/bvtk9RpjypRfXzIcxvHWiTYQWvZRVdfCjV9b2HKX4RLl2G
         7CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818890; x=1792423690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WrVqsyzotvIl1u3VFyJALoyYbdhw0ZgDRSGsrp53+LY=;
        b=SXzf2qlT6rDguRn6RfFW8ANi8yulMCosqCV0GkozMGNPvzmlLV1vl4CMoVK7NUAo5b
         PO99LXw0jCvasMxqXOOtyHQ4PLtKjDzxblFRVeW8I7saoEjhzfe3v47D7qx9ppQZFEC+
         /N/WILkdvSt+oZ+b0seDS003SECh7lccIW/DsH5S2+d1cxOZjkN9+pYaQeQr65CfH2BQ
         O1+V4K1r73dHxX6mBv81qcKuPJLN06dLroXXtHA1uTvaWFjbDwIWQII42T3P30KDd3Ha
         BkZt5OyJeeFYhWX8i7cTHvSZXOF6TqHRb8V6mPsNNUFffioSOK3RJKmIDxlM8HcPVQZf
         wd9w==
X-Gm-Message-State: AFq9FYL51Ij8MjPEf8gvR899vLlwzroO7H3oIfQCEnh//ENwkWis4eBp
	aXLmZbDhOmu6000qE6hb3sl+bMZMYfe4kZkyvX4wU+PvN+aI0FubHjSBwvne0C0l
X-Gm-Gg: AYBFou1uz89cr8abrs11GaEAjuzYLT6uJcClkIkSiFnEdNwl6wn2vXOt/5Kbioy2J7Z
	u2VQqoREuErBma4pukUAf8HXRFxkU+kRc/QDcDfwfteAV+Veq6elfPVpoxYr6YnUF9xVse35UWQ
	nx5h/Xv5r0GmIWs/vZHNDPlKLFaQRzLP5fiYDHO1Vb+j8yEjqDlSHIfqek3B/rx6pKBvOpDMUdo
	KADn0ieA40pOqqPtzvaYmj16zq/JhBDQccPGyk/5DMotgJZd5pb9q/vpAwAUayiISqWnr3dTMEx
	tMMWaiIg4QzflEuolGXPYAGv8ujOMhvQxkJILkcdiz6EKrj/JN++Jwamv0vihPMyrKMIT94Ee5b
	My0OreQ58qGftzO76e1tE0GgkOi5hMllLWUx2j4LJVR8ksM/PZSqye5lfb0hL+AZC6Jo5ZNHwOC
	+tzVaZxekaWOemg4V1DaLPav02g3dH0bPTMV6UzKHPAWOPM+RSff1UlJl+NDIwNzOryEAE3BxWo
	e7rZDJVJJPPBgJ4ZW9/hua1wUlM47cyEHYOBCL+6NATln2bkJ+TGzdr8VsGyOlX/GxGuepeKTw=
X-Received: by 2002:a05:6102:6b09:b0:7c3:1395:a090 with SMTP id ada2fe7eead31-7cb3722f209mr3340517137.6.1791818889860;
        Mon, 12 Oct 2026 08:28:09 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb354016d6sm6905694137.8.2026.10.12.08.28.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 08:28:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: MGMT: Allow connection rate request as peripheral
Date: Mon, 12 Oct 2026 11:28:03 -0400
Message-ID: <20261012152803.66542-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Load Connection Subrate only issues the LE Connection Rate Request when
connected as central, but either role can initiate the Connection Rate
Update procedure, e.g. a HID device, which is the peripheral, does it
once the HID host requests a HID SCI mode with the HID Control Point.

Issue it regardless of the role.

Fixes: 19129d7037be ("Bluetooth: Add MGMT Load Connection Subrate command")
Assisted-by: OpenCode:claude-opus-5.5
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/mgmt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9f65863e7457..3b9c82bd2f02 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8347,8 +8347,10 @@ static int load_conn_subrate(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_param->cont_num = cont_num;
 		hci_param->rate_supv_timeout = supv_timeout;
 
-		/* If the device is connected as central check if the
-		 * connection rate parameters need to be updated.
+		/* If the device is connected check if the connection rate
+		 * parameters need to be updated, either role can initiate the
+		 * Connection Rate Update procedure, e.g. a HID device acting
+		 * as peripheral once the HID host requests a HID SCI mode.
 		 */
 		if (!i && param_count == 1) {
 			struct hci_conn *conn;
@@ -8357,7 +8359,6 @@ static int load_conn_subrate(struct sock *sk, struct hci_dev *hdev, void *data,
 						       &hci_param->addr,
 						       addr_type);
 			if (conn && conn->state == BT_CONNECTED &&
-			    conn->role == HCI_ROLE_MASTER &&
 			    (conn->le_rate_interval < min ||
 			     conn->le_rate_interval > max ||
 			     conn->le_subrate < subrate_min ||
-- 
2.56.0

