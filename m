Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BF032E6A2
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 19:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406166; cv=none; b=ZFGJhWs/gOsyMxn05M4oWVMaFJMxL1I0Fib3VaSX7noUhJyJlZskEUZwL1xOeIVdZqUOsMkaSsfKOtKVAXYiLZoupBlqPlOxCKXOiIv7sFD5bfQd1OeEkeWb7v8xGFZwTgxSZDUUaTJofgsFCBhGdyRjX0HaQLGmoGQ56NV77Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406166; c=relaxed/simple;
	bh=N8z2xSFO5/oDc8m5Kc1ZhM+/6NZkmWx4TcWpS4boSpM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RlI3KGMmcn1J/qXDk5mUTZ+ebQNwiQuwNEFKcK6IO1U0FmMHJI3I/486TTQ2T7Vd+tNuBRVYxQBX1ere/j1vUDd4TcmFqVAte2a8JihR+BL01bkHUi5T8qfvBRBAGWCo119SvamcST3DVgpdemAmfB/6mUR1vZEsbllkjFup+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QST68VXZ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QST68VXZ"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9372149216bso2702502241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 11:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763406163; x=1764010963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4rVzz58fEc9CWyyVOntQbGkF4qcopgs9ZfrlCK+AsUc=;
        b=QST68VXZGdXr1bMhMON02GjfSunpz0qavaujSogEeLW6Cb9RWELqcbe+yrNEvQ2CY1
         cJhREdaHKnRLuzASlF/9paU+3CwHYn06/WJjCnJAK0Ohywgyq8YVqu14TXUVBG9g/Ui+
         +k+BlOjDQwaomwEdlNFuoRABASaCSOxQyCVw+ytt6OuA3HipO4N/fpsq0WaihxSHnBWm
         f5F5TrtK7bGwrcEK4MFP7Ol/uN4t0V5XeAcVLOP1s2MhwuGuICLcFnDq8GeoOkcAeH0r
         kcue9LAXxvTkSxRhS9LJhhE8wU9S7d58u1meBoy6gNOx4Y0HY1r1XBLu9IJXktbGyGFf
         bxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406163; x=1764010963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rVzz58fEc9CWyyVOntQbGkF4qcopgs9ZfrlCK+AsUc=;
        b=pF9UHw7KFo13yDtMZJYkuuV2X5RhhrbaFcC5k1eP35RBF52KW4O9XWEFFFUqtYSosX
         yzOc+IjLF96p2w5/JJP+DRiF1EFwFx4eiibjcM8B/Q9PSkGElW/7jCCGD/Gt9s91O6q/
         G3j93sDFgIy7XYYEeVlHIKU8XQw5G9wk37oIn2Vj04lK2mtQIB3WkqNAqMgeHxjVeMg4
         glHgbGMZ/ro6oGqu4Zh/rXvXzAv7ANpayprWmbt2h3DXznJ/3uOX2RvZSRA6f9Z5CWbP
         fleszhGjJCIbjGrohvdWoamn2eCAmQOEMww5MsDcWRQrdfV2m865M+uDS8gCMIYTlhkF
         xRsg==
X-Gm-Message-State: AOJu0YzI+WhYHqiNd+9kVyO+kioUw1rkEdiKZUcVzrkUE/u57vKzzHiz
	Paioz6xm5k2Abz2vZmXZ6xqLL3gaQ+alNrnTqyKGuC2UliBPffUrh+2MZN2MIr7z
X-Gm-Gg: ASbGncuo9nJmfn/IcvUwQZ704/0yTztCWE6PWXb0nqy3hmJpfiy7iUcVeVi+xB0OJiP
	gHuhtfNguI2fhwcSfuVZO/9Z4vPDp9QISESQghv8RcwEXL4Q8DefjeM3AFtgI1V6yI5P0buxa+o
	TB24amylQEKYDBNClQdNwYbd3U0NQROIr6J8op2K3E3z4tNLzGyeKNxU3b/UAEeJSs7iS0RI7i8
	NUYJvmAl/luKWTE8BWULrxKbuHFryz/qStDe6v/4ThXZgDwYEFR4riJVRKqKOjnw4vPAsE44e3d
	/w9+mRBhvnBPjLL9+6/Km41fwqW2/msbKfxne+/e83BwDgY+p8ePrUgXYQ2o7hcEh0VskLoDaH4
	oHgwuFay7tkcygOYsbVZJrAiKHcuRiFWkB3ng6UGlBXPKOUplzJN25+zxV62swCuwvXspHWrazQ
	NTkRGcGmzucOwDpg==
X-Google-Smtp-Source: AGHT+IGr+SLQ9vIyIc4otFYyKfLIkfu8VApWVgnVKNmP/vqszEyJuogsgXSUo5loI56aCCxd82L5nA==
X-Received: by 2002:a05:6102:5a96:b0:5db:eeb6:812e with SMTP id ada2fe7eead31-5dfc54feeb0mr4982987137.18.1763406162603;
        Mon, 17 Nov 2025 11:02:42 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937610ce60bsm4178125241.3.2025.11.17.11.02.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 11:02:41 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: SMP: Fix not generating mackey and ltk when repairing
Date: Mon, 17 Nov 2025 14:02:32 -0500
Message-ID: <20251117190232.3918619-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The change eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
introduced a goto that bypasses the creation of temporary mackey and ltk
which are later used by the likes of DHKey Check step.

Later ffee202a78c2 ("Bluetooth: Always request for user confirmation for
Just Works (LE SC)") which means confirm_hint is always set in case
JUST_WORKS so the branch checking for an existing LTK becomes pointless
as confirm_hint will always be set, so this just merge both cases of
malicius or legimate devices to be confirmed before continuing with the
pairing procedure.

Link: github.com/bluez/bluez/issues/1622
Fixes: eed467b517e8 ("Bluetooth: fix passkey uninitialized when used")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 45512b2ba951..08461ca06cde 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2136,7 +2136,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = chan->data;
 	struct hci_conn *hcon = conn->hcon;
 	u8 *pkax, *pkbx, *na, *nb, confirm_hint;
-	u32 passkey;
+	u32 passkey = 0;
 	int err;
 
 	bt_dev_dbg(hcon->hdev, "conn %p", conn);
@@ -2188,24 +2188,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
 			     smp->prnd);
 		SMP_ALLOW_CMD(smp, SMP_CMD_DHKEY_CHECK);
-
-		/* Only Just-Works pairing requires extra checks */
-		if (smp->method != JUST_WORKS)
-			goto mackey_and_ltk;
-
-		/* If there already exists long term key in local host, leave
-		 * the decision to user space since the remote device could
-		 * be legitimate or malicious.
-		 */
-		if (hci_find_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
-				 hcon->role)) {
-			/* Set passkey to 0. The value can be any number since
-			 * it'll be ignored anyway.
-			 */
-			passkey = 0;
-			confirm_hint = 1;
-			goto confirm;
-		}
 	}
 
 mackey_and_ltk:
@@ -2226,11 +2208,15 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (err)
 		return SMP_UNSPECIFIED;
 
-	confirm_hint = 0;
-
-confirm:
+	/* Always require user confirmation for Just-Works pairing to prevent
+	 * impersonation attacks, or in case of a legitimate device that is
+	 * repairing use the confimation to as and indication to proceed with
+	 * the creation of new keys.
+	 */
 	if (smp->method == JUST_WORKS)
 		confirm_hint = 1;
+	else
+		confirm_hint = 0;
 
 	err = mgmt_user_confirm_request(hcon->hdev, &hcon->dst, hcon->type,
 					hcon->dst_type, passkey, confirm_hint);
-- 
2.51.1

