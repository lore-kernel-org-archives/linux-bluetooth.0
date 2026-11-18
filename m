Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031934;
	b=T8KRw34fdiB9S1/vCIDf/k9kAZ3Ww/j5zt+XlBx6vAoqLq8loveIC5G9IvkS9csNWBmR
	 TfClv8634Z7N9ziMaFHJW6HSD/JzvCuTKaB+Mq8kijgpQOwKp0vegZGFFdZRSbyHPfm+f
	 vdK2wJvt4NU/JtrMgvyEupQrhjDUFTtd+Tx/RscLTCviAOC9G0mVlXN9wadvg8VHGstTl
	 YBDclbB64KSugUy4rbs0RumjBNBGKE4Ryj3jERhjFvbcGfGT6NvRUSp3vKnoyR+UC2vKv
	 BrEoRe6U0Wd0IZM78lPmcVU4W11nQ2O8I3ziFbAp4D/YIuyelTov5EzEOyrUGxNhvgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
	b=ffZJ4GJVjHk19gprazZFQVTtp1lAYtd4Nk6yiMkoSG8AKHDs9f8YlwoX/h3WbKjdOBmH
	 KioOZATiRQR2sGBKXE4leQPO/BkcNkeG+/f1dJ+dMkCMxODCLWmPrm1IXZUcR6VRZKWrX
	 u0ZSCgzbSRN4G96rSSxfNZIUYFb8VcXoDq1/dvIKVEe6bHp7/8r28xXESMV5j578m/z3J
	 gv8o3NxML/gRRvOBKP6nq+EaLeB7+7GVywK7gOhHlODxBF0hNCXyX7QUs12hSOfqm/pw8
	 XGfZ7cmuUApILqkv7u7N26XNH0euvRQCjZByOzuChJJ+KGWF4Yzl0D5j+Om5ZfStt2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ml0ehPvw;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A9606A337
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91A9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ml0ehPvw
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so175056241.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031933; x=1795636733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=Ml0ehPvwqQc85/Wp6cb8z73uPHmC1tJOKwCWblv69pE6aphPWQwDQ3vpAcEi8Ro05S
         e6M7etlgVS3sXZHNtH6AKIakCNlRHLJzJTqzZc1QB26AbvWLAGICixOC55IZFx/l5x/K
         r6wDLTDgbz0aFBhw2XYto7IiHH3JzEfY6yuLNR2jrJ5Slw4T3DvE/qP3ecTajzRfslW8
         XaUbH56ObycWiurUzt4Q87SqgwsoP978xVw9G5Y8kemCoDnb8vUtFHsrBqZ8PPYbEM1N
         wuPKLHhwMUDiWD4HOidMNCa8vvdTjZhL6pKo4HVwJsW1MdT4ysk86FcjqHSLpvEU4pkA
         TqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031933; x=1795636733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=20Ik3tyQngouAz8Ks5HXN9FP2mjcS13sqeg1JDs43SmGH4aaqqfMur+qSZXVvicd7J
         EtlKWngJPGbV6QFrIkqqzZvOfZDNiz+V3QWCBwydX3DCUgdz2BZ3cWrbPEdhE/U12AFL
         SxbKKBNr5U6/gyTF5idSlW0BLa/zq9KDxoxuo5BVIEv5N2Sf+rTM7B5N7/+j4K0/4I8y
         XnOIP3QC3FfaRKmRSTY9ATtw8hVXVUCRzARQHShzPtn9/UEgNAMpF29+RbU/0b69yn8q
         4gQQhJLYmwawfltwokxf1VP+NQEMC578NWbJ5qxCwW2e6lU0ugBnIBIGJSBK4eTn0nr/
         rFsw==
X-Gm-Message-State: APuU4Z82MITl56WT86DwQovrDGBYWGcaTOwoFhrL5e1NMDuIYGvctZp1
	9UbHWLprEoXa2vu86GBhF+sZZMmjZyYyXbsFckKK7WK9JQGN/F5K4XtuFRGkMku+
X-Gm-Gg: AYBFou0Iw67LswcoK0g1L7KAfwQiEWiple/wvfowqTmvevRoufxbJSgcCSn1tbM65mt
	1P4xoIrNX0Ecr4FNhQiTTfFphoa+YEZHto+SvuYOr5O8Ayrj4sYJtps1GADtPdcwHfcv4hD0cnB
	D5ZdeyaqViQ2UK3IqQW14wTjJAMBKqXRIL3iVfA2EI0DokMcCKLPA6bch4ZKtqliB5yw6ep6Pqt
	K3x+V5N3CEC4nNYHQ7QgStXkDy/jyFVpHG/L/IjMBzykM7jb82DYHkaldxDH4NHAT8akgalZDdI
	hCTpclJsy2k3C6AUBciEpBNDct9uIHwzW3CFE/Sc4KRoXy4fWkyReCX598FGBMuUSvSzF8aTN0d
	ZCWExJ4+7/FYwJV55xn7N9gmYAg+12m32pS6GJdf/SucBRbQp/vILc0MD9ymYukdMan/7fmXFET
	CpaTpMulWwQ7v9i842aIj4TsgGhgF+K1luD0moZgNighJORsclK+xvOfZRawBGsLtj4fSD2iVhq
	dJsvplKYUO91G6iXBD1yfIzm0eq+ANYv+U5UvuRWKfT48RJM/bPAySn/Bb8gPAMGnCbZll8C0L9
	cWKzp0uiqZcKkdTaC+B09B+2gYP0ZRmETDrMyTdbjOdARDcl0c8p7yLTgH31WBp/dNmUa6rvcn4
	29yhUSG7UhRxvYMzPQKGurheuu9WbGKHE1WNZh55JZlVkIpbzkSLmz1JBbsSIg8c44joAbCIEFE
	W+Z6Y=
X-Received: by 2002:a05:6102:548e:b0:7ba:b5ea:c4b8 with SMTP id ada2fe7eead31-7d6cb42f39emr188237137.1.1795031932749;
        Wed, 18 Nov 2026 11:58:52 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/16] client/cs: Fix use-after-free in stop_measurement_reply
Date: Wed, 18 Nov 2026 14:58:33 -0500
Message-ID: <20261118195846.393710-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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

The daemon emits the Active=false property change before the
StopMeasurement reply, so cs_measurement_stopped() frees the session
first and the reply callback then read and freed it again.

Pass the proxy as user_data and look the session up again in the reply
callback, returning if it is already gone.

Assisted-by: Claude:claude-sonnet-5-5
---
 client/cs.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/client/cs.c b/client/cs.c
index 4c181e74300e..e029da881898 100644
--- a/client/cs.c
+++ b/client/cs.c
@@ -1369,7 +1369,8 @@ static void cmd_cs_start(int argc, char *argv[])
 
 static void stop_measurement_reply(DBusMessage *message, void *user_data)
 {
-	struct cs_session *s = user_data;
+	GDBusProxy *proxy = user_data;
+	struct cs_session *s;
 	DBusError error;
 
 	dbus_error_init(&error);
@@ -1380,7 +1381,15 @@ static void stop_measurement_reply(DBusMessage *message, void *user_data)
 	}
 
 	bt_shell_printf("Measurement stopped on %s\n",
-			g_dbus_proxy_get_path(s->proxy));
+			g_dbus_proxy_get_path(proxy));
+
+	/* The Active=false property change may already have dropped the
+	 * session, since the daemon emits it before this reply.
+	 */
+	s = cs_find_session(proxy);
+	if (!s)
+		return;
+
 	cs_sessions = g_list_remove(cs_sessions, s);
 	g_free(s);
 }
@@ -1425,7 +1434,7 @@ static void cmd_cs_stop(int argc, char *argv[])
 
 	if (!g_dbus_proxy_method_call(s->proxy, "StopMeasurement",
 				      NULL,
-				      stop_measurement_reply, s, NULL))
+				      stop_measurement_reply, s->proxy, NULL))
 		bt_shell_printf("Failed to send StopMeasurement\n");
 }
 
-- 
2.56.0

