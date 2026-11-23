Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456291;
	b=KQponI24RTtDzFbbi7+NeHkwSRiazQu0hL4f/kobW5WKFnCy6O9iPsKEvdaukOlZaP0s
	 fchOpbrNfPHHYrqRJbiPs66ONb6/qFFoPfrmTZH+3dJdLi2XkskHhYPm8+RiXkqfew+t5
	 ZSAoqP47OJOI/VA7dh57plfsClbB3/EBUkoQCUWfdasZHuhULbZomYo3F3JA0sJn8GQhk
	 ZY3P6owXvxQG87DIETzTG/GbafA/8SVO7aL7Vfs7xZCZhmtrLE4PZ8/2n23QDhY1Ebe/k
	 OP2RKBRMXoYco6YXtM5ebtfOnWHFDBFMt1C7xMqlnBLLMcamMSepX+dlrZFteG3xveQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
	b=OptFYE7gJ9JIRtflTlNF0SR7kAav7p/M+NlfPQdnkwoSGOhs553gNdxjsbXkOSURunOy
	 nvPfvQB8CZms1XNptpjC+i58YBi6zgpChecxJPDn/E/yJL2pTttEzjGd2fxz/lMsoeLlj
	 HHqjy8QQ+ub2K+6JenRcp+41oC6ZioDjr6yt3wZQYAbSdQbdoa/s4MvcBVY0w8/eJO7Qo
	 BVDMsxQXzhnfnsJOxezcotPx8DQtCzxWKalNSKy+2RwEvAJIa+6CdNX/ytDVxbMdw6cum
	 8ZP1XRe9ZiIr+OsYrHVphQxPTaNsp74SKp/8CQQnFy42i7oxQ9Mbttb3BrD2QDXScLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1QSemWx;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E62606A338
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1E62606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1QSemWx
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7d2d18f1bf5so2068500137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456290; x=1796061090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=v1QSemWxR9nshqAV1bweVgbFluWrqi4T6vpMuqH18dm+gaiSoTMUTQeu9ykmcPuZzU
         JKJuRHlREMEq7Ro56I/lBZSfg7m69iLVeaNk/84M8TbWvC0fEaWNf3cl8fiQnwH0WGrY
         DqqiA3IQeOdQ63mtwrUwm0RUig+sGu8m7iYZ+U9qO8iyACQWj8N8eQCAp+1xI7JODrXP
         o9AalTuk9o8cTNYU9jFv36TuTxvB31KHOO5q7POC5NrchjfyfSRTOxKBJoxIcSqHnzkF
         JEwIHmHbEJwJRYnlRfRapNhROzLsXkB8sIGVXlkX+VoXanDPnajB9PpF6AAybjWXR+WC
         prRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456290; x=1796061090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=k2UH4Au4vmx6sOUZbRjPg2ajgZmBCG+ObrJy8feoK9pNdvUo3a8zQgApS7BPgXKR2E
         H+eqMnEB9dFp75aecUEc5sfuNtDA5F1wL+D/Mo0+gYmiS2udP+F47LXweqMK1ll4dWCV
         9noAdg8UqwzxLNXh8h0Doe+MK8xCmeGEQgyEDV8DJEIEgsYqMCZTNF3HXEeAwexxj+wP
         pvVubTTgu4KKIuLweQg3jF5sqZUKpWe2GO9dAjZAinOCKcOsrGRczrKiGk1pYJeS4zvK
         Im3DofK4uvSwXjuHyWbH8kFA7hACepQePep1oiaOQcSrNbeoOBMW37q0qM8pLuPLNJp/
         w+uQ==
X-Gm-Message-State: APuU4Z9zfND5p8HWmgLD2QKNV3JLTIqw/LGs8cWyo8b5Cnxrqcw5Afhd
	U5K4dLYRYRWOrIzE5CnLtlaNHlMK9Aax/JGMqaDrfxLU4mo24guUj58CWV0Ehg==
X-Gm-Gg: AZFdTZfK0zw4ZMix7oZGxpsM+aEcFqyHqVQBSslnWXeZffkzuolqtqcc7EDzfr4pq0g
	nPyTJI4wVhE+27IiXDlCWXL5J0v2sDKckL6EPNvxUfQymvIIrxEXxZ0hpCvfE+ztD9QBLye4eeq
	BkBYITLMg/ArZkJ3EmtxQppRq7X/O5t8RF7siulrtkWL6VyA1ehwFiEaWSRiR90exPdMt/ivCg2
	ddcFiXeqoiLM00JJkjDHUsUKCM2T30PpDuJiRrvGudkWkCetpJ5+ZJTIGsNltY4yr6Vzq1KYmYu
	nYMyWdnr7VSqbWHCkuccsP8hoa3ZvZ19K4dJlkQmYsyDo+Ek2QNzVwfOfbiusn8Sv+ncGYX2QAW
	o/H0swO8jg8s0RJL+R6BuYEHQL9097n1YAj6oG0Cmudc+yy63WOaHWD5vYaLSond9jMs36MU/bE
	CrBcvCMRYmYbtuvn1Nud3OAMFNHLoqGPiFkQXuGa7SfENo49nvquhc4/E2PwBTk6CvFLUDkts88
	VHwk7Ly+0gBhuWvezad8JomkYepo82I/kkj/yM4KpGO23gkydhg+fLKs/cNw4QOghQ0fTl5IWbg
	9FnPdoCEkTPurDo5l1KdFqwhNzjZvQdN0xUcavE+0Xet5hPTbEk/mbj4mT4lzgRsROZn4POFNUu
	OgPkaCj3d9G5xDI0EjUNwCuqHlAM0MM8mom5CiWvDmjcSgIbfW9+hKXvqIatL/hTCXonlT9dFjJ
	ZMIhY=
X-Received: by 2002:a05:6102:374d:b0:7cc:971a:61ee with SMTP id ada2fe7eead31-7d7393ff678mr6541143137.10.1795456289925;
        Mon, 23 Nov 2026 09:51:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 04/18] shared/rap: Subscribe to Ranging Data when a measurement starts
Date: Mon, 23 Nov 2026 12:51:07 -0500
Message-ID: <20261123175125.3642617-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123175125.3642617-1-luiz.dentz@gmail.com>
References: <20261123175125.3642617-1-luiz.dentz@gmail.com>
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

