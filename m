Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193719;
	b=MZGHXjD2iprWxsXWTtcmGJyHUMH/YMJE041IQFn4lNZkjU758GU6J7D4sZdymQImUpyE
	 YKWpVW5FZ3ScKm7y7xKEdro7KFQ0LtOpSJEVGKp6sCj8ZP36sM+vSjUSOCt2C5CYvWfXM
	 gubLtadmiWMh6qzlBAP0TIwczVVeXBmCDWAyFxXP4FedKLjyoxicPGsQXHaDq6De/uQYn
	 y673UIK17SHDoiTHN6aW0iPnGuGcprc8o8uYVDEfpbygXIk3+0SwbuknQvhcmGKRhycDO
	 c4Ie+SjuzlbjAzKM5BQYkMA0E0RbZWZoejYbhjdH+Ku67XH7r9JQMQgMAxf7RX/JJRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
	b=GxILw+hd8k9/2IQiIEo+euAg+QTmBiSQ9ypRvHrFoO8CBLXIP4C9KYhwEK3f02wmDdT4
	 /9y4/3ZK4pxn0qv0GgQ+MgpIM5FRnuCCecB8dIdViIhlfiwohRWvKJ2UjFrhpfrv0+i6J
	 JYWC7YtrKxCRbLQhu5TiYM0YpIGX/fyuiR6yxG5UyNz5x/8KAm+dtLuOihhkA8wea001P
	 FYcMbsAubwLbXJDVq0qu7Mp/cVr+03kQ06P2XpT9U5HZe+zcMIpOZyYTUKm/os5qncCrr
	 4HllQ7U817XbvPCmi+erqNVIzEY9/+soUmL6ZjfCz1qIILKXAWzypw79TxnRMN41m8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=px0tOqr5;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DED606A320
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 16:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25DED606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=px0tOqr5
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-98301b325c4so348621241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 08:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795193717; x=1795798517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=px0tOqr5yc+uyLjUv9LcwCvpm3pLgWL4Lqq4I4bhfZ8B+sInKFZ7JeJhTDV5pI+1yK
         daBiXaQ6LLQ6Rl4Wxbyx2Q5EgUeJwl9+wWTm+GCL7t8wg2+5aQ/5OpAmCNOlTiO6XBO+
         S7xGgqHQAPUVAIQpHFHt9OUgG4h2fXYOAIhQWl1fQta3sJR2uOZhr62qZmtcX1lfmMTU
         hSK8Zx/WPNMWQlJ41JZNx+8kJxCfwruYvunBls6R/PvtAa0rwLW6s6K1/23OBxz1bT+I
         M1OHyNa0/A/PREk9UInpU2FKsK/8px4LnkEX9yRR7Isv/cZlh3VJI3xrLgsJZF6nCxy4
         lj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795193717; x=1795798517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S+A+tHoWTxzv1Ecb5EM0HYITMJOtYSb2KXWl/kr6btc=;
        b=TSKH8SdeJP++0jeojODC6SbbE7oSdSSEk4vwJWB3b/Q7a0HBkTSAYtD+qiOcSKGJyn
         j0qsW8JZw6puw9bZy2q9NNDsQscJWJn5bLxgbLA3saSlzdwW5kZd9M8G5Q+h72oeeHcJ
         hqU2KJQgAgT/fAXPjmsfAv7gn7007qUsksO39W0TAOftoSK8iGw3evILEI9Gn57AbRiO
         Khoed/BYO4v5XGFTUh0On2inPNBE1uBoqr046MOKGkX4S40mz6jBAg0vpBmrnQOEKoIe
         k4EcFgE6P1onz3gi/ZH+KAl9OIIYKaCX2D/KrmJFjs9F24fbSPb2Kx868soREzh6WAwJ
         hHdg==
X-Gm-Message-State: APuU4Z82ADDHsTAFA67JKsmYfOU76BkFiL1JuW77GEKBy+N5AfsFlZMO
	nfsOLkQnpYVwyna7MeF5JUDMveHWHYNkjuzEUi8LywJdTxnKpMb6hub5MB27EfPF
X-Gm-Gg: AZFdTZdLd2QJ+AX9fUU6fJoTMYBn2289aO2RRw33kxj9T9hsDNeAU7ofW7h971js9+4
	KfLljmAmXw0tYe1E+qQjff2nLfctpXm/Fa7VKz83iQB2lvzAP8rBo2gUXX/7A4Eby7s4J/hYmhi
	UHisAuiBCpuegxAyiRaSCetvNuZ+IK9ebqMviYDApizASbzuSxCt6QkvBHUT0amFgYV4wmDDylT
	/1E92q7oGnaz2p1YpYxiORzLrFnzAt/wRhN2hmG8VCWCRXDHeQJ1ycmIuvGSoFaAjHNdkYqR2s4
	hSrAqewdLzrOVxXODMcsCi9S9wOQ7kn5dUmuBkpALEEZNzeqCzbcMk7iSMrqAsMmQQ+3B7be70Y
	6TfWJiEpgimnZbmPEGmUltsbXNR5peBySHqQGopYInp+kYOZPTgqF1h9jBtPwCl+stTg3+ZqKO1
	xoRyWA/FF5LfwD+EyJZBaxa/Mdhkm0+a23GMiAVZFpB1O0E3Oi83+SKRcOUbHP1nMTBjgOdQVUL
	ezd6N3Mm3pNIj0eIQWfEDiuu4Eu2iP8CzSu6lBSXbomYn47it9LeOZ2lPWG5GJ85nr1/5rI9T8O
	EN1oCQ5ts0Nnb1apSBxZ0NTxYvbQX8Qd3Mj5VrisM8e/EIYsE854hNrcm6l5yOfn7pBijSEz0kM
	Z/YqFyh2b5W5xmFhx98n9o6Wbw+/hbRuS/aRZ0ysK3xYitvVU+J5Z426nNhUrRYx/mXh2xh3Cu5
	iImtzJ/jwb8VhmmXONXj2zkqcY
X-Received: by 2002:a05:6102:1627:b0:7cc:9d82:ae17 with SMTP id ada2fe7eead31-7d7393c88d7mr1467993137.11.1795193716995;
        Fri, 20 Nov 2026 08:55:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6df8a28dsm3486193241.4.2026.11.20.08.55.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 08:55:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 05/18] client/cs: Fix use-after-free in stop_measurement_reply
Date: Fri, 20 Nov 2026 11:54:55 -0500
Message-ID: <20261120165510.1858959-6-luiz.dentz@gmail.com>
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

