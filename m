Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456292;
	b=2YTgeBp5LWJF8zK0xPcA16EtwFWa42Hn0z7HkMnUCl6lAARRC0WvctiqWHn0j48hU5eQ
	 kmBBiQAzyRmFz55ixyOaQ8/gBUkrIyym3vuSu6/EWRHOa3QewUTPUYoZ3bnqtywcsoYSW
	 7ZaOJX/E8u02OCNBb4oqAeZjWF40R/L2XN5J10M/lkhSxgb4icjQPGcFZusJEULtlu4IW
	 lSSA6ID6ZmfWG4REaPbrG3oZuhUcGbgWuPZC+2U961FFdRXLldRu/M00YJjQAydVZa2Jp
	 8LCoXeUA/j1Ud8n4js6sDN1cBC1nL5BbzGeoFoFjH0aZTY+mdYWNiYJYlclsYLy8ETA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
	b=gCqIp5mBYEUnnpGrwPTK8vZU21tlGVQ9fUKYw81vtjhVwOC0w+xBhpblFehYZVfcY6W7
	 qAtKnuCBrjBiL9dio4pQtX+nEAqZWXJ9HjnosZeIAy6JGIEL6frYXErPNS2NQ80zoWrfj
	 91bep8emfnKa5x20QFRr2/dzTp35wHcrF2fZG0PYz2JQC6orSFiADdQec6m/BDntvtW10
	 3pUECi9+x6x3+tdnpFJ3/Y759KS8h3RYgFVdqvhh/YHENZytGHybInC16lD3gvnoK9yF6
	 CdNYwR6d131rR6MHos02buwGrldH42PP9PKGv6g06X3DKDnXMKKCccwBduDwyDqnMgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lGaoD8+v;
	arc=none smtp.remote-ip=209.85.222.46
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E3606A680
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 085E3606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lGaoD8+v
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-99b49d6a5caso953029241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456291; x=1796061091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=lGaoD8+vuu4afC+5HrEMN0dDugm0eOks1U71VU+z0sFeIPd1N4suU9k5zaUhWX6QOW
         iKC8okBle/PMioqJWrnn0qgMem0cfJYBGu3Sadz6+KresTLq7Knc44W+zM7o3LsenjQ5
         P06ejgRZvr0B9oI7S2W92ZKS6utjqImP7iHlAvVdpd3cIVPoiYrCiEJ0szlTEtsYV1cx
         X6qDml44Sw6chTl+6tp05YdrMt+tjFAm5w5vQaDCxfz9HM8u/+YoOb6PJRghcGwb4gq/
         KKJEKgdfRDpTdIsU99axjORMMuvQXgAw+usvVAu8dEH0agl+OdonHCmGRetKKRobu80Y
         lvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456291; x=1796061091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=L5QuZq+JSkFg/Y7eUT9KEn6S335pARxlFqECXTaEC8CJUV85GsWKQgSxk8Pdgdfh/t
         XfAmD+m8zsIC2jbS0QHySduwlYvo4rpgof9xt3KXiLrAiSFl2Grm0ZG1A7HzXABzjl3M
         5DbjkZZTMz/huj9otw6hXI1hqi4GPkAOTqc6GAdaPOgMaHsspc5TLqVB45ZXBVsgLH9H
         cYG3iyPnOZpqYoV4m7UZQG+79rILkgfgwqmFvXmzWarQktXc5rO/coaH6kWzMy/Qc9oW
         UNvHYMnaUELZX+j9Kpy+owKDVaLaFz+LB1MW+F5rvp5syX4FTRyMVumEr0/+4XwamUQ6
         YlcA==
X-Gm-Message-State: APuU4Z+wvq+lqj0/3lTX7872ZTMiAIhZenNUE1Qef1ZK7Lr34CtvLFjV
	fp2C51LH5C9E7XQT9LAVtMe5FQ5rIPo4YgokjShbBZxE2pbGBc3CfqVeYFCIlg==
X-Gm-Gg: AZFdTZdA1ycIuNGpAXKotJsaZ7s2T0zJusrCITU1g5qFBY5koMPw1yQyF/I17pF9kEj
	iPB3TnyYN1/eD9Oev8RNMfZivNIJgF3hgjQ2pioA8cKjyCcMoecv2X/nt0ffG87sqF1A6v9E1In
	/fX0WDe5snfIgp52XcxEyi2hNG7AFkC/n5ieyeSSWEn/eGKAyz0IsGk/NiwK9JVkXLy2/wMlreU
	ZXYB6kmir4x12vm8lGR6WxaF0okZfhGHVFypPecUfiGmLu/AkC5w3O1ZxV4tereFj8rYqHF4YlN
	lG8MtyTNO/xfuD1PoRzKQ33b7M4CPLRka0J/yU/VJFb0QXDA1DDpxAbopzJsTKFdOidJ7iYvsXC
	ZU4nmEDZW2cWEVvRslrL/ZSXPG+tixB/aXwI1hvbEno8vxVqgVd5h215aQtE2RQznrVDrDpPr18
	SvZ7dlnuEC8Uom6ummCOB1czpnQ3pwkwo7Ptv3MZFse85lv/p4GXIc0CEF3zebSPvvilHgKDMTB
	psnSvJyMMepTXyIhhXhl4n2sHDoEYG8oEMkIoLOIqWvU6pzt8fIQmVT+I72vZigCrArL1roERlZ
	F27RMmpXtJyFw1QEuK5lnsesP802gHHNnU2Ejq5isTXEWYxhCzyLKL4ZP5oh90laTAcDdooIXNN
	JAmNuwDv5AcNcFqHVpkdJfq2zefIBDYT//SpAXlzPHhBMOtBSHS+sUS27pL6ny5TJTLavDk+RiE
	1k8HW+4sx6ZRvzTCqJFOXdkl01
X-Received: by 2002:a05:6102:6c4:b0:7b3:8f0a:f76c with SMTP id ada2fe7eead31-7d7393caab1mr4935809137.13.1795456290749;
        Mon, 23 Nov 2026 09:51:30 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm12795393137.5.2026.11.23.09.51.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:51:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 05/18] client/cs: Fix use-after-free in stop_measurement_reply
Date: Mon, 23 Nov 2026 12:51:08 -0500
Message-ID: <20261123175125.3642617-6-luiz.dentz@gmail.com>
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

