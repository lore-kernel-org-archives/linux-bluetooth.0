Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108593;
	b=MXO7vTnZpiLX/NT/HsO/1Gzh3QqdgX8605/aODIaFkilDPNdNDlnH/j3Mo7VqDa1i2TZ
	 LPBWXWOrTfLRL6SnbfZOXPrNk+KaH5pHCH9E+CNQAjBrsEeQeZgul7jJMryjuQb1Q1uKX
	 +TuSMb5TbV4Il/+tUixNL5kYF8l04HQ1YpqsExZTh2IwQCi1MSr9VWxwOFVn7/HTW063E
	 4TvbNApxI/2wFLybKmvVJQftFUs0jo3XX9Ld9vVXlufnjstxm9uq76kNBVjeDqV63zBY3
	 mGROgCpIAEUpY8I39vMa6yWSErlZ+X20Oc/zSozsOnWa6vhwWsamrwHcKqqNZFAavEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108593;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
	b=N1OmoAhRxq3lHMgBODyPI1S7Ni/y+OEy94gUQ8kC9B5ObG8sLo9Sn4LODerUPip6vJ3A
	 2XJYNrdZyAiQKBnaYnvgOrjGHBUuXc40W1cU7alqP+HTJF+U+fETkQ3Pwsfi/CQRPjeTx
	 wgmCZPdNaNX9/+vK1+v+wXFkaVTUxBDBvhBnsAy2q++G39k05xywS8/jAGI9fMFkeump8
	 jY911tp4vmToD9/oPeMbnlQ90cX2LwdUBMA7dheycua23qiRIJr1aGZkzzyiGzQj7dg1C
	 ddMkRA3dpSLj0nkP1C3Lxe8F5i3lCyZG8+FLrQVPIGXn2R4rbmZYuZopSgy/vukyFPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hUFBtwPJ;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6E606A334
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC6E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hUFBtwPJ
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso910820e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 09:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108592; x=1795713392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=hUFBtwPJw21eLuvEA+1uIonEj/IBxvEVcrx3B6KoZVywHap26Fn9j5NLrpDBwKBogR
         uOAAkZliDXM9+Xn5xXDLKwXtgzl9oYL/MX2Bvy4XjS+SqJiPtQE33pU5NDT8cS5+G40x
         ftejZN//klodWrPZxPzGb04aqlD3N8OGIdT6wvzq/O0/FQqWcRdnlPLfD41/I+otpdKf
         ZiZZFqhUH3JZdcjB2X4GU0SST4fCG2nF+JZrRNbTRnxdSJdQfD+Z2cTE5tJSXKov3kjv
         gq1h3cCtsv+GFnXpRddzvvpq5f0O35M2SW5dFtLHul2cuiO33mrYUGrPwBD838j443QF
         fbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108592; x=1795713392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=zuvbkuh2aEwkPyG/flDp8IsmkXErL3RKsmcf1gMFR/GM140AS2H2tsaZ4rzAoukV8B
         qN1bLZgctzwbONQ+7+MfkVlXEoE06CeVps6zTwvRb2fqZCm27PeTsD4cuDt/5GxknEbk
         3++iMZ038Yw5w8QmCnpmTBYtPhcIKprMZnmiy7qNHKtmmtUQV3vO6WKHZaB0qO91rNRD
         Unb3SPZPam8l/EshG5wmK4Wh51IulimUBOMC/MCODzyL2GaPZLBF3obXhGuR0Exgc+FU
         Lkt5iFl3bgHCC8wzB6O6N7CW0MsszidDaqJC2y358V85/RYw1fyAPC44QoUy98PEdbZe
         ViWQ==
X-Gm-Message-State: APuU4Z+XI9/GSGyqSAca6iKm4YB63A/itS5WxiNHQVNzLPMHWnRVWCCA
	4Owzup+ZLR2dgyH2/8bjW5HqokWOvtakz8PgTO4snGtH1HMFcaxme4tW8H3Xm2h3j0A=
X-Gm-Gg: AYBFou2Ey8hnmK1RZu2p2tOjECtOAC6op8+1Tl9+lXHn7IBJzVa9Z9tPXgOxxwtIDMv
	L20dqWY/lFI+aokDfKgYk0lsaqZHm+RG7db1O7mv6Mo2vTzUV9LSJpHl0/gWT32ceD1l/raRq2I
	PfTbSl2stRAgpbT10VK1pS0vPiu+pSprilp4658gMoEv0yczIniI1c2x7+XGXUoltodRxc57jZr
	ERnciheX6n8EuGQW3HlFtjH9U5CvB9LkudKU+8uXhOBJOcdWBrkUnl/x4awB8uJIFQ1ok0bHlGK
	Upw6akxdvmXGS9yVzB3Qdj2nnCmC8HZGBjZq2RdoT/P78ei7mE3mw6/9tTkJpYjwlpPmEU2gafh
	tK4oS8okSRYG7hSWzChwGluNjDk1i/2bkFJhLA7lLG0/DxdoqAp4RP0MeyKda7O46D76q6ZqKju
	q90AnB8dtlp0xc4W1+iJqufhevT59/COCV+agkah0zxkZXRMSLnAcLV1A4nUSksKH1blUKGaZ5A
	o0bVyvtFiS7NR3GM/vhCO+9Ehnc+CSnBubLs4aqEQLAGBXrlwzwCIi6nV758aGk88UBczKY0UG/
	225NNuiuj1IQQPVhjZojXdjRCXp980ROBVkY7SlsFq8T6fCLVSELGMDdHrzsSyoKvx1n5qtxBQx
	nPamm9rQvlW7JQgbGq3/0ERPt5vxWDfMnvitLkX9U0kqnnJXNPXt8Ex+Y5I9GFG6NFBFbvGAmwM
	9Bkdg=
X-Received: by 2002:a05:6122:2194:b0:5c9:c60e:3a43 with SMTP id 71dfb90a1353d-5ee8af73b85mr235871e0c.21.1795108592233;
        Thu, 19 Nov 2026 09:16:32 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5a8fd3sm131881e0c.8.2026.11.19.09.16.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 09:16:31 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 05/16] client/cs: Fix use-after-free in stop_measurement_reply
Date: Thu, 19 Nov 2026 12:16:13 -0500
Message-ID: <20261119171625.1014004-6-luiz.dentz@gmail.com>
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

