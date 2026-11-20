Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193719;
	b=amDF9bPpFCw9uAtchgqlt9mCsC+12iUfKIi35jKih35VGtME6Jcn5UKFx5fJCur0qxwz
	 wuWn96emDP10DyBZE+jtt11FPJ9vyJ3oZBpEooBwp3BN8HXyHAqONjc53yR7vRNOpIvds
	 //Vb18u0V4ZlkNxl4UK5lC2RMbEiph2Mmwzg9rpxZ1TUXv+C2xuz50p+7X0cQKvpWn0p7
	 H6gLzov77eK2hPqxeNe8AfEtDIISvCrUZTLCmJtvIlrXHU63quXmfNTIJvcbQZ6WEYIXJ
	 DDar9Uf+IEsgLZvxT4au+fK+o5XG+Mu5CgbAKWqkP9QHTlr6lpg+n8n0Sw3ZlSjIlIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
	b=dr5gpfTcJK3XiFgpJKFTOGH4IDU4gZxzFCRhNji6CJBPHEvN2h1C4UDveYmZ97sm6pU5
	 IM2fxJOmmXXnytsK3NQKBla0SoaSECNb4EdsxfbJt5CdQcnoAPMcNZ1YjQ/ETmxeSomci
	 UX9uv1niieM3GjYus41EZnVY202lQw7B43E0ldK1tXLoyX1sU56b2tHM0edIH/pat/Nd7
	 60bvpXGgkAGIp6Iszu8YPXv1YUsvNAaPnNQ13tXlUkSFHMiOnrCro2Y/7aPuNAw/PqIjs
	 i2a2iPZtpqPLWoQYfkiDloDIV3+SRPo9B70MbY+nenLJPm+gwRxhr1O/sIcslOnl1wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTfzFu0e;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711CA606A331
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 711CA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTfzFu0e
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc91ddf447so375886137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193716; x=1795798516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=yTfzFu0e7KCBiFPvu5gIW4SfMr7EOst6zbNZqP5KxiZBhFlq+0OxgxXCAFJTFlAzCr
         0BoMUmEdyVwZLc72WEctB3IzfL4xpE9ogaXOgszAGY/n9/iGRkekEjhU9gcqVftJskL0
         C5QLsn/sArq8eWWtwXpfSIuNpAtBHJdWY//pvmRvga9Q51phS4r2uc9569YFw0cApp2X
         Bsti6bad0X/jHYkuJJechTIHIleM5Fscw32Gi/z1hIZDEfMu+Bwv/K4t9RXy9bHswrvY
         OfGBVmwC0TFgrqQuDlv4tbPNjaRNOoXuTiDR+u+oe2M7jUpgFsjZLqd0LxOephcvbjyg
         2wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193716; x=1795798516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vAl/b7hMYAIDcmGXFZYO+BcVuKc9G5RZS9zq595xucY=;
        b=Qruyr9YZXv3rU1tAzuaBYPQQ+Tw0pP5+pdbU2rC/93vvttdXfxjVzd+i0baJQG+0k5
         UG/ZvDVFrrc7gWFL418bHsrb1upyb1HXd2BULBL4FXs59/7ImID4RnLNQFlHj3qDx8/1
         hDOTk2ugtW597Qht4FtAmtR0N+Eze3hgkfhDtixUyIYYQW4nQqImp4oCHwHU4fUzouUF
         78dUtW8KpE7Vsg/4vypbnKz+6AAMn6B9EQXknBN3Nj53IhgiMTO1YVjdsewd2UopOAoi
         uvyDqx8cSgOvOPi11uH3xQhlFzGbZfJhfPGXw+6IjeKODvdZjJzhEwRd1+6QgGjxAA92
         g9Lw==
X-Gm-Message-State: APuU4Z8vkVXSdbb5mhmiTS1IJOFNqEgI1YMmbc6kGy/YOGp/g/qqVhny
	PXCNQMm3yYn9Ub3TDh9Lanbc/puctkRQidmdj41XE3fy+pshD1qbQDlrubQVIg6x
X-Gm-Gg: AZFdTZdVsk93EGSO7GKd+21Sleqk0jZItPrwZXXZUcJqdV40z+E5OaWAfpe7/6ipWaR
	RboNioIRtQMgVPI7R3zZXOb6R9DCQfAnri2ktilX02FZ0mGMxd6DI5UHmSsDFqZDGH0Phfij+z2
	jm8JPlkGnMw52CkPk/zFALNqXtN3k4hOTDyDjoNDLz4QlutiIPfVfpYL1VnwAWV46C/CXnbVy+V
	NSjnjk0SIg7VMbj8oUGxA2HDnvjOIv0IQ2lmRqjDUIY7rqbALAfPETP4uubwG8CglywYF6CB+Bo
	Ybfx7f/i/rpcQmZoVGrc8KGEyX1hZpGDZjgPH6fHxfHOWmrzsu60Ao8UxgPl+x9X0kdmM6kzHsC
	0ivtO97NacckeOypYSKGTyltbcXSAjR5Oiak5+S2FuZjoxfX2hW12pCav4zG5/x8usTjia52DsW
	wPcSNFR60P6ol9jGioll49SM6eP/1pybEw4kEs7ES+9cghd8wbOm3zDtT8oUKd/rcLVr12EseYv
	Ix99FUINpqSw7IMHOY91Xs7Tq2NXmMvouDhSlPxp0UWhxpo3V1YpDGe70qxzHZxAJDk31+rSLKQ
	zeZLyAF20cG+ApYNhmRsEgwPibaCF+T2nlw8AnyEPv9kfASzxjldlU8KoqWaE+UkwbQsZE2hT7M
	OP3J5s5aHbz4FiyolVSDbhiUmNrFpVcWPw9GxAe+BaRPNi5yNs8vI9l5Y6swOwsXLcQrVBXX/ES
	EM4LndkCjrFf0NXpKr6zgtYo8Q
X-Received: by 2002:a67:e115:0:b0:7cc:2712:cafb with SMTP id ada2fe7eead31-7d7394524cdmr1159420137.15.1795193716257;
        Fri, 20 Nov 2026 08:55:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 04/18] shared/rap: Subscribe to Ranging Data when a measurement starts
Date: Fri, 20 Nov 2026 11:54:54 -0500
Message-ID: <20261120165510.1858959-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120165510.1858959-1-luiz.dentz@gmail.com>
References: <20261120165510.1858959-1-luiz.dentz@gmail.com>
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

