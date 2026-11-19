Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108593;
	b=HPjP6hKBTO/s+WIclAVkdDmK83sIPVHTrhZ7rqUdjExcSb+4te28r0Rr2iZp9Jf0FFoZ
	 djxCfHXEydN9vWQ8vGp7OGeQ5etQYZUZzRUN3XlmpquPX24vdxo1eoEJGcHDHy9XZ6GG6
	 FcRSSp2rqxITCj9kfXksC6MjY1c/LbrV4gm+K+BrpJCoXywu/7pU0XY8dvpRnRJ8iHu0g
	 Il8YBol4zy9tfj3hJwa8So9Ezl8Jjh9KZXVARfxsJ6oYdVre9/0AZvQECfBLarn41KZRp
	 SsxP1JCk7j2XgBliWUxObqpHy03B8TXFAOjH7/KPhCgeSVJjiyAzL2qJD5XnMUdgorA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
	b=B7FuQTJUL9Sj+MCKfDgg5AbVevSk0sDoN1MAHF2Ox3T4f658q+mqZbfrM4XQxTDXuo2k
	 1G9XRhnl6aRbiDnJ6J+/MCi3KfBioaCE8Y27ESloB1g8nKyIXB7t+bmz5LFpL3kZG6ZVU
	 kEp+cGqUgBjDrghnAZKQqGo8f5qDACsV6kZYCJgTKjQw1lJb9HFnik4RP3jBYQzeeQtrT
	 HKnGnkRcub9tzOS/ncxPnQxwfyt4EUJKp6g+VZY2zT75wt65lFyRF98IAgo1ALXJvGom5
	 KzxuYxc+MwfMjIfebBF89oWGHjE5V46FD0fjUaLN7oXboLHjbqd1HovuDi1bCPd4xdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MKyn6n37;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C5606A337
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A81C5606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MKyn6n37
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so952638e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108591; x=1795713391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=MKyn6n37IXBmLwPFdxID2H8lVz5HYa7ds1E56efm7u+8CrgZV/uLaxtjvweCj5q8S9
         DbUA6KfrtukxpnDS5j3YBGUNgLqanbtLQQ43kO2TVhKdhogg0Smiy28gg8kVC4dk3qV9
         BFEWCnf9Xs7nkCktS1y4BvEG61CkUYE4aX9N6dFqumsNyRmg59VZ+GQ5yG55OYoF97po
         wyvzgkRW9uKxWu4zQmvpABVvX8905EjjLH3L9nFXhwrUHugD7y8Sth0agNwuWcZQYNkL
         PDCJDQcrk0yw5U/S1Xzm8NobbtD1fRDSCeU+RUnZCeIp2wk2BSDZ2nohe/+XpVpetdy3
         X9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108591; x=1795713391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=V3wvJelra7sVqFroOsuaXvASxR4jo26pINOsxY2EuubF2+UL8Cirx2zjESNqbI+ZkI
         Qd7uVVRqzI6DNd0yTeUECFt6WmW7N2YOy6iDAwHwL7/IBDbV3b8XrX2w+ShgLIlGU26o
         ToZv21S/xEXOBQqyI6ak4rH13RRkjWhrO1jLSjieQ3d0Mr9AMa6UJTmj1LQP4+nUaiZd
         E2jQ/O3wgKlmo71Qc6JU/YzIvtb6VU2RLHuX13T2ibR3BI5HE1QTXChrfw8WOhAgH5Hx
         I/7siBncMWOM5p7UIFwGrV6A5cyRhyiX+KWB7nzQDgnnZhWDa09FDGjqkAKRaahF5Al6
         Xt1g==
X-Gm-Message-State: APuU4Z82gY9cmsCbrEygIN143Wl8ZbLXnPmn8xMcA00tsejq8xLwIhHd
	sHsYoGDCpGT2Z5Lv4xciFp0viRbzfJxucGRz6Sfja3aSVqW0vtJk2CoW14orvGq6Ayo=
X-Gm-Gg: AYBFou0a4xipw2CoMSG/VS/ZxhfUFeEqrEKyjuFl/tZOMoQfiESyH0P9XNIiYPX7w0h
	nYk/yKDM6Vug6DKTa0e7IGcj5GVR7UwlSqNDnLLyuyZsSE3p69mUWY5jcqrquU4+t35s0QMeJJs
	nP5nI/a5EvZ+793bbF0jiLpYy23lsoy7yVT62dEOuglxRuhpn9Wy8KnVusGL+/+cbySEe+ThHWx
	ft2ASOP92TcxAsUeWZj31u02Jnx48iezg9w4pkVW5FSNOWIl9K4R1jgQdhxUCmheEzwjXSszkj2
	ylQU0Iuia68d8cp/Mrv7cZjBnBH484Zxw7jQL7eLFS62x+Pp4qyErZDXVY0+7uBEazKGQ5aG6WP
	MDAQZ53L6+hLabhsar8RucsK+uBg77ktZKKPTro1iGGGIdf7H+nKf97p258QtPGKPkFyP/e0yB1
	+Wdk9487Q51r+dN/XE+LUotEuwCG3GtuIK1/pI9ytSR5ecKoBSoyaayviGRPCiFSZxPef5YVLbJ
	XnEWpKAUTM6X+aoPxSBYxOuBGSpElVUFSieZGCbTYPYz6F6sItwIw9n+N4Nc6ZoGQJV5hR7GGhZ
	2m36Zh3gqYQqzZKx2wZzXrEyF1EYQQkU2x6iMJx2cMPa38nb++9Gp1xZLWjURv4pMOF6gMn2wkm
	JXyhFab4JUiSK4zKxB+KWlYJWPsOkL2ymEkhlSoX/0NMNDBE3Ej5ds6iXbV+Gg1JFcauYYwSDu0
	Zkozl5zezIdwGrdWEVbg0J8+m+
X-Received: by 2002:a05:6123:5c3:10b0:5ed:c029:411d with SMTP id 71dfb90a1353d-5ee82853f66mr592541e0c.19.1795108591502;
        Thu, 19 Nov 2026 09:16:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 04/16] shared/rap: Subscribe to Ranging Data when a measurement starts
Date: Thu, 19 Nov 2026 12:16:12 -0500
Message-ID: <20261119171625.1014004-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119171625.1014004-1-luiz.dentz@gmail.com>
References: <20261119171625.1014004-1-luiz.dentz@gmail.com>
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

Reading RAS Features subscribed to Real-time Ranging Data whenever
On-demand ranging was not configured. The subscription also arms the
5 s first segment timer, and at connection time there is normally no
CS procedure running yet, so the timer fires and writes 0x0000 back to
the CCCD. The connection-time subscription therefore only adds an
enable and a disable write that no application asked for, and a test
that expects the IUT to enable Real-time Ranging Data only when told
to (RAP/REQ/RRD/BV-01-C) sees both. It also subscribed to nothing when
the peer does not support Real-time Ranging Data, although the RREQ
has to enable On-demand Ranging Data then (RAP v1.0 4.4.2).

Subscribe at connection time only for the configured On-demand mode.
When StartMeasurement() is called and SetRangingDataMode() has not
subscribed to either mode, subscribe to the configured one, using
On-demand if the peer lacks Real-time Ranging Data.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap.c |  6 ++++++
 src/shared/rap.c       | 28 +++++++++++++++++++++++++---
 src/shared/rap.h       |  5 +++++
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/profiles/ranging/rap.c b/profiles/ranging/rap.c
index f1717d932eab..2d8b1a7a1364 100644
--- a/profiles/ranging/rap.c
+++ b/profiles/ranging/rap.c
@@ -843,6 +843,12 @@ bad_type:
 	if (settings.role == 0x02)
 		return dbus_message_new_method_return(msg);
 
+	/* Nothing is subscribed at connection time unless On-demand is
+	 * configured, so subscribe now if SetRangingDataMode() was not called.
+	 */
+	if (!bt_rap_ensure_ranging_data(data->rap))
+		DBG("Unable to subscribe to Ranging Data");
+
 	if (!bt_rap_start_measurement(data->hci_sm, data->conn_handle,
 							duration_secs))
 		return g_dbus_create_error(msg, DBUS_ERROR_FAILED,
diff --git a/src/shared/rap.c b/src/shared/rap.c
index 1c4b5239e1ba..bc6f133b5da9 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -4712,6 +4712,28 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 	return rap_subscribe_ranging_data(rap, mode);
 }
 
+bool bt_rap_ensure_ranging_data(struct bt_rap *rap)
+{
+	enum bt_rap_ranging_data_mode mode;
+
+	if (!rap || !rap->client)
+		return false;
+
+	if (rap->realtime_notify_id || rap->ondemand_notify_id)
+		return true;
+
+	/* The RREQ has to enable one of the two (RAP v1.0 4.4). Real-time
+	 * Ranging Data is optional for the RRSP, so fall back to On-demand
+	 * when it is not supported (RAP v1.0 4.4.2).
+	 */
+	if (rap->ondemand_mode || !(rap->ras_features & 0x01))
+		mode = BT_RAP_RANGING_DATA_ONDEMAND;
+	else
+		mode = BT_RAP_RANGING_DATA_REALTIME;
+
+	return rap_subscribe_ranging_data(rap, mode);
+}
+
 static void read_ras_features(struct bt_rap *rap, bool success,
 			uint8_t att_ecode,
 			const uint8_t *value, uint16_t length,
@@ -4771,9 +4793,9 @@ static void read_ras_features(struct bt_rap *rap, bool success,
 		return;
 	}
 
-	if (!rap_subscribe_ranging_data(rap, rap->ondemand_mode ?
-				BT_RAP_RANGING_DATA_ONDEMAND :
-				BT_RAP_RANGING_DATA_REALTIME))
+	if (rap->ondemand_mode &&
+			!rap_subscribe_ranging_data(rap,
+					BT_RAP_RANGING_DATA_ONDEMAND))
 		DBG(rap, "Failed to subscribe to requested Ranging Data mode");
 }
 
diff --git a/src/shared/rap.h b/src/shared/rap.h
index af4fab057e97..7ee51143c0ef 100644
--- a/src/shared/rap.h
+++ b/src/shared/rap.h
@@ -322,6 +322,11 @@ bool bt_rap_set_ranging_data_mode(struct bt_rap *rap,
 			enum bt_rap_ranging_data_mode mode,
 			enum bt_rap_ranging_transport transport);
 
+/* Subscribe to the configured Ranging Data mode unless one is already
+ * subscribed, falling back to On-demand if the peer lacks Real-time.
+ */
+bool bt_rap_ensure_ranging_data(struct bt_rap *rap);
+
 /* Initiator role: stop receiving Real-time Ranging Data. The GATT client
  * disables the characteristic CCCD when this is its final subscription.
  */
-- 
2.56.0

