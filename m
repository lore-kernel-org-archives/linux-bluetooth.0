Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6F301026
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801995; cv=none; b=qL84wZiTKdG3i7ypjfFtc425XpePZGALp3YwfymuWsjdN9qLrZ7YkPn7AtrrSmnE89dZ4s17Ay8eRqGvK6Lpi3UkAwQtdojxWalT3wkNRfzTTAttuEf0HJFLXjf4HXD3h39WW360ayICmOPeioXDP1Fa86C4Jy97wS20E9UFkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801995; c=relaxed/simple;
	bh=nT5O83jSkLYpi3/i5ldsVA7OsVnO0xr6IEU/qSyDSOU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7CtGu61cqrzxy8n/Kf/DyH0nR4rLlJx5a1E970eH2WVkIZvs1xu+2A1hGklPOBo/BZMIXe/FvGKNX0AsODr37oqyRruFMTUn6KH0MNxB1gXIbCmekpal2+ye5Akg7QxWQg2teK4gjN2VDjwyYnIQy9v9WjFSHXpxzi08M1O8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIDayECx; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIDayECx"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-560227999d2so892771e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801993; x=1770406793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1srS9EwaTckUnyuXn+3W2QGl6a8lsbIgxUJXyY0hoBY=;
        b=eIDayECx6nU1xTOulWCN4kIAcKnFLUq/yn6zbU5noQA5wFj7q3C2AQzVg8LzuKMtMB
         +RM3CuCHwlMyqvtm/bINouC3kQWLtxBVTFhkJQvIXW3q/low9d0aS1a+h1TXg+J1PAec
         wKJrWNzA73B1LaB1bWPRtE/fI/k9+Fd3r4eVSvbUXBhwsBVJ7XvdF2+/8T0Rg9VZ8bPr
         MMEvKizbL20GUri1uwRugoMqFxVohdyUPFtKpMuQuCi65j0pgc/J0wAxVaCr1pVRVwXR
         QmTS5gDg8wysseZnAc6XQrLXPzXon2PnYcwXDbNJqL+X4+VWKApZkA0dQwt+9PTjjzfU
         +U/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801993; x=1770406793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1srS9EwaTckUnyuXn+3W2QGl6a8lsbIgxUJXyY0hoBY=;
        b=Ie6Cg8JKtCXkSKzTUkIlf8TM0XLrCzaL6JyCxqEgdwYvDzdUwUf4JHCEQN10RL4pLQ
         fTaCazfJyhvQnEDJhGk+ZVT4M0mzvdI6oncgmd39hEqBVufHypfnYDhpCVDCciUB5ngo
         kF2j3lhrO9OKP8Ah+yxHJiLo8iw2cD+lpOhaU5u6q2A6L/HEaNIy0uwoQu2zNBxGXlxE
         vb3BuzBXoWOM6J7XN5gjrDr40sJpqNLgoUDHuc2NHYeGrXH/YvZOG999IBafa2AE4n9N
         R7ANwTAOf9FVrboQZso6dGKzIK8BCQOy8LgthBO7gXu2OfnLApyBBGWuE0zcr64LEloz
         Ws+A==
X-Gm-Message-State: AOJu0Ywci+R7ex8neh2q/yqxNW51Ngox7i6jsF8kXfyNnzZnusp5ZazV
	8hWob0+54dHqBUADa9Bqtp0vodBXeVqlS4bGKesd28zHmyu4kFOkoBQvhclTcQ==
X-Gm-Gg: AZuq6aLrgoDayg+PPQCNj1hTYpVF5XyuTGeYnbtOdjsxjGBN+hp4DUd/GunuLF34Vjq
	fvUfilAiQftL3b8Uj8lDqpcTXW4EMZ11e559K9GxaHeSLU6CJVfc3/XzUJbwtTnnz0LMA+I/28y
	XN97FiwyrH5Wo27iosP2NwfXV+iI7Hb1vXWjMxKPJVyuQ/Af6//B+kvQAfLcSU9cMScekfaLE0s
	TcNSmDuiOnBSCznWOw7NsnkyEnFoxKmQAVAzSiGC1NZZQ3/1CjS8/Tzx9iBXkkENCE0UO//HbVX
	Gm1j4yjylO1i4tGPNHrrZaD/UhUMJQBtf/eGfEW8+d++1BMSdLmhWhJEqRO2VwmPqWOfRgbqc5B
	1X1YXJLbW1pvJJLOr9wxbOkxAv1SczjBjDvYG5pb1PkGxYvW2NwnuE+wlJIFIujn90CQxqOKKbJ
	COBtZBotmAT3JK3dKE+yN4v6cz4MYHqZH4IVFE3rz0aOGSuCdQIDwasZWwJLzQGikFI2wCCxHDA
	D0bmw==
X-Received: by 2002:a05:6122:490e:b0:55b:10d7:51a5 with SMTP id 71dfb90a1353d-566a00c08b4mr1145256e0c.10.1769801992895;
        Fri, 30 Jan 2026 11:39:52 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 23/35] doc/org.bluez.Device: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:05 -0500
Message-ID: <20260130193921.1273263-24-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl and Examples sections
showing corresponding bluetoothctl commands for device methods.
---
 doc/org.bluez.Device.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 593ff06643f3..85247cbfbfac 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Device1
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}
+:Used by:	**bluetoothctl(1)**
 
 Methods
 -------
@@ -51,6 +52,10 @@ Possible errors:
 :org.bluez.Error.AlreadyConnected:
 :org.bluez.Error.BREDR.ProfileUnavailable:
 
+Examples:
+
+:bluetoothctl: > connect <dev> [uuid]
+
 void Disconnect()
 `````````````````
 
@@ -69,6 +74,10 @@ Possible errors:
 
 :org.bluez.Error.NotConnected:
 
+Examples:
+
+:bluetoothctl: > disconnect [dev] [uuid]
+
 void ConnectProfile(string uuid)
 ````````````````````````````````
 
@@ -125,6 +134,10 @@ Possible errors:
 :org.bluez.Error.AuthenticationTimeout:
 :org.bluez.Error.ConnectionAttemptFailed:
 
+Examples:
+
+:bluetoothctl: > pair [dev]
+
 void CancelPairing()
 ````````````````````
 
-- 
2.52.0

