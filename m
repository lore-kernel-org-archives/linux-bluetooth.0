Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534745;
	b=cnqGeqghHQVmGj4XSCuAolbaEAIsoe+LJyK3p1ebRWyNnN1+E1dOHysGwKDMXNmUq9jD
	 ArdjYoPTgGCMrxDjUA8WZdxe6YXX7vBt2HJ5yfboeisd2ZsKHPIlmjHXauWeCFZViNZ4z
	 CadFBCaSpxEySZP1P8w+BdyxMbyCdpBDBu43VEcsZ39P0Omv5K609NG5nu7WzclB34NHC
	 9BeJpDquQ5GtoIEmTYYBiJXoo0pIFwpKAxFw3TwoawDyO0nChp4HYn8iL2sUFp41BxRgg
	 5tGHsFjyFzEJJxbmTQze8A/pWgZBwTffEkMfYKap37YhWL8lvbSPfiaJxICfVmErfaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
	b=cjqE/GaTZ+r+vOEpcScucVzEFkdPenMfBo5/ojXSD9IlgKlG02jDCcBOEJPpTYjQOiRs
	 9jnNaP5B0ZNhFb/g1bIAvJkvtOm5vPmBTpPTPpn4wLqB5OlSwtvmbJ3VDJPikjsgfHdUa
	 Y+ohXNuR10gPBpEfBkPKDBl5O905bkU50dHNl3CZiq1luFNKK3qGUX6mCceBS3U16ld1l
	 8KT1lGfIm7k5LzkIfWJeGgrO+cGLyjF0mwrM8uMkHZO0HcT5UgZeTg4rWt4jTXMZ2pwjV
	 V2a52YWr0aeNWIzHxBEeepEyD2uOefz68XCbPTxdvPaPmnsqAv2IRsYHy3VB09hr1ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=speBWStd;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C234606A323
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C234606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=speBWStd
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ee27c9eec0so1468602e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534744; x=1796139544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=speBWStdPBAiWRwdLXDWE8lbqiLEDeekVfHrouHNZtJ2wdInMHmilAlPUQBIl+z63N
         QnmUZGfr6Ygk+ApreQ4HF9kSzir32XAZoob/7kdMe0fnqI80KRwFBpDxU1dVJVb4sjuE
         6FJRL+zczQ8QtYOTqQ83YehDzJmNS7sQ/CvPCXlrB4c39ZSvvNSCrCOtT65Av+v/98wi
         83FHTVbkYw8UGSb0SU7bLxUe5Jgu7Z80xxdQgZ5DHaee7yIn39drXq25qPH9h1WucYsw
         lVzZAxSDwRWWpP+3HVgByEQfWcAAyiJwx1pSq/ZZUHaCGo0wvpZmYoqFh9rP9Cssg/TD
         wUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534744; x=1796139544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=WvghFeOdqt66GY3NQN52yIViIq7KXyQ3Qm+p3p2YGZ6dI3/PqF9rFiWwGziijZAiKT
         xfIujz/Df+SFLRSAhXMsLzodYsysvjOWvRojTgdzNYYJwbCZosLPXIF/b3RWHeO7mxaH
         kqiBKR15UbrtXCaFU25ruzHBl36ehOB7Ah9DZ/iMjgWhIDrUlLFuJk31HGkVFl0+oHsU
         NZzKxYeoIsTVA3A96aDUqo3lYVsBxo+3T4L7AW/yC3aWONJDQSN+2yzfgCNq73tOh9rk
         2w5FTOiEZutHfe3blf2vnOSQ5iw4pnTKIgM6xW1aLtoUYv3qHseCJMrNkysADi4wV3Gj
         PCvQ==
X-Gm-Message-State: APuU4Z8LKMUlzZnVIMjB0Q1PfQC08E8bRzxnXo83tB0GTorqAI87QTOT
	lZiF1uYznHAS/oEg7tuPL4XiZtRPjdrZUUS+9etqnAx/ruzHnBvWGOWBW28/ow==
X-Gm-Gg: AZFdTZfKl9hs1CVCkau85UZJuJkY10PUtLxDn5WjI6RHQbSppQYOlWJjBbCe03eHI/M
	4iGOaeaimeRUG0jqGx8wB6BFcQQRcm4ZhHRl6WyDc5JfI1YHdEOStoqoM8SDEStZ2fasNIwSujL
	4BmBdg+I14ys5jbHAHDLG0erF7BxGFDeOz1fY8ehvZrCIHfpDwbkkyuaYUL37l8c9VRt3sTGjK9
	SQD6gFgSxiIjA1PreoIr5GF3BnN+JRoH1/CmEMtybc523ghPXdWKN6SxOuH9B1HjxNwhi3P7aPu
	P7Dy3i+zhmdESlEVfIPUytGWLTBGmoQOGk1DFPUQtxdg1hbIfq36leAQ4eRNd9xAgTYrqsCtIKq
	lMxJ7tlxbuNb2tY3YB61gr23EK9A9mwBnSxgLVccnUpXboZlayu0C3MLGtbSpZz4FiFRwvJ37lj
	2F+ygAno2bKg0+iYsHo9Hrh/ZgmRfDgd3GJEu6ffKfOuVRYrRz2N/Hel5g/8sqbsjoCm2DKq0xo
	2bFOKAkfjKupm5wrhuG5nLvBrkez3B8Rg5pCA8xU+VgKIDXHP3XV9aWFItSTtR6uL0t/HoviMXy
	M8cHQeIOv6A0UT2vVC2SUUbDacUvFImKX2pDitSuJRW1JcN1xzGcJ0y894DJE3ZsEYVqh/Yb/nE
	k06eDLYtuhl1Wsr8t/rrOXzz0WXasA8ap3QN4bOXVqcmOANiRDAEsUTB720bbDUSDYjGJSg3l5n
	ILODQ=
X-Received: by 2002:a05:6122:1c88:b0:5ea:e188:a5af with SMTP id 71dfb90a1353d-5ee8aeee7dbmr8912161e0c.11.1795534744061;
        Tue, 24 Nov 2026 07:39:04 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5564a9sm14343463e0c.5.2026.11.24.07.39.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:39:03 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 05/18] client/cs: Fix use-after-free in stop_measurement_reply
Date: Tue, 24 Nov 2026 10:38:42 -0500
Message-ID: <20261124153856.216054-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124153856.216054-1-luiz.dentz@gmail.com>
References: <20261124153856.216054-1-luiz.dentz@gmail.com>
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

