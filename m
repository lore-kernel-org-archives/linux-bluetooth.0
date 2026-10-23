Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795034;
	b=EW+Js+ZV75PD6ZwmXnnCRcAMxKksRRkNN61/5xhjeZS2X3qAkPCP0tKW40XcYhkvq5rA
	 LyU7awOXD6W7afzJg5oerU4DaAa/V5vYihvxvB5cVMuA1bnbZFa+ejnIRVJWKibbSVm+7
	 2FCXZao/gchJ7nZDSshsh/GBXyoLSf3++QVUTupNHk3TD25yXszaH8CF77QB2vVjyXvY1
	 mWkec5Xlxn/M1liUMgCmvJe7ZL9Y5bqwCPeFTERTSWI2rCqUhJCBssSicvRofOPszrRH0
	 KlOdDoXGpJCW3tYvCHUOlxOFe3bnOk2qXYMUv273zkGvR/vd2vV020FKCRHoaL7ZVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=taclXfmopI2WkupkQ75I/mBLfFE40AWq2QC3hOa36Gg=;
	b=EU7E1FxHApD1cqasnYzCmOns8M7VP00L8S2vpBNZCDwIQKsyu+KU/yxw5iGrDqdlSUoW
	 QUeM7w3PXPTckaSXo1/bK1VYUSPv7CuHffS19WZZLdjmVnqmU3WOujAe/d0LGZko4WFx3
	 2spVrcjLzNwq0NU8Pe60YWbQcihH7pm2FL2XJtJQprCRD4sTM/dNI08z/pKjN+IS3VKXe
	 RbW0/2t7kpVj2PHzqx4YUrgvnkiWDsKRj9hm6G0MoIhkzW6hpuOPoNxN67m00rOwzS66j
	 OcKzs8gm9CFmJWjQGYVbejUk3CpAAqMnhxA2k8yys0JvzgLUR4m4TVCFKvg1wzNJU+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=0ACGSdRO;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644AF606A32E
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 644AF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=0ACGSdRO
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35ef6b49813so2015506eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1792795033; x=1793399833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=taclXfmopI2WkupkQ75I/mBLfFE40AWq2QC3hOa36Gg=;
        b=0ACGSdROXDmuP9eJ7lZB1jQPIfH3uhjBRp+Ibn1mZa1AH6iQXiR0QUY4gD0OXVp+ti
         woQAMBQx7wdw1PLhmWtd0GNnA+UF0xJ8YbH/OYIJjjoPT6e+4Xc9HTYDHL08M9uk9Ra0
         RjBkcmZ1vQqWoMJnQuBIo6hSi2ea+obeLa9JO0fJ7CL8b+0Wq3DGO/O7J29sjY3HDlsY
         Y92es+8B/qD30owZOnvn6UJa7w4mTF5CDcYd1dtOCOW6dBO2t6amHLzs86pL7FKMRwBB
         2W4oDMz9WKAvEq1cgfLwtiGlwMiXSjxhotPI61VeGCuJymRbgChxjlx9gcRxFRwa1+2G
         o/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792795033; x=1793399833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=taclXfmopI2WkupkQ75I/mBLfFE40AWq2QC3hOa36Gg=;
        b=UGfGF7S8q65sr51RED5rYKwBBoDU5IxBZBQQOf8n/hYH804JRsPK7azT1t3HaQkPwY
         bAkzF3+4xVaOhJBlSOPcTHH+D2u/2Qy5gfflW9o/LWVp9ajtYWv7gu1TGGdHpTKvJrwc
         w04GcTBz+4awmK3fcZDy9Q4hLxt2oYFOQ3YsoiGvxFAgUtrtc6WTYUszdyk62I8Nboay
         BatIIQuRFa9vHyD8P1+OPFLPzMAj3pj7dC+T1/acSsJ5Ghwic2AF6bBhHbIuxIDpbleG
         l1LXSPXk9H6PcvXntfde+PNMfPKcgftxD4miCzWFu5Y2Uwv9h4fG8FwhXOTt1wI5R8bV
         jIig==
X-Gm-Message-State: AFq9FYKw/bsJsHT9Xjox1/q+xJuUg0H5P9XcCllYjJZp3aASCVlBcOK9
	dR+AbuYSFWtvARKHqZDfY1CV8ym9ziDpbj3fCKGehP19LXgV36xfKWrcy3+VgvtMdxVi01OBLD+
	vh1I5K8c=
X-Gm-Gg: AYBFou0KzB8IfSEjjBU5xCaR43lFjZ5jpF69H2wxYysVeck5ueXmb4Wk1WACY6Ylwd7
	mjalRvh7G6/GcvWxowvFI9QKlBW7TLPg+WOFiY6n+eIh8qmwZJiiSOPr7vBfJIuG1sYKGZ7p5SJ
	nco1/2Fk9BxDcRxwLnjoEO+KZViANVw0D+Rqyef1EPLYOwNgepLCZIkc68yV1odMUq2ccBlnTGt
	gpGog+OCYTEB+3zb2kGJmgtuKiPyDte8eu2nWzDF8xMEzBWZ7PwSF03C5PYbcwgBwIZPXd7FQa9
	P3y2mmDE2ukw89NZ1IsmG6vMO2k0b+fACn/nrWs0hg9rvDkFItzVPDTut6I7mUEkZ2NSMknrAcD
	2d2rJqNrd4LTyd4ccybfEzAhxGBWT7Ne6Mo+GWoX+0Q5eR/+saEVqvs/wd/idI4+FvxLO/4St0G
	3L4D9YrZlMKXJHbGo+csDie8GXagDHEi7TkfXCh+AHehbNG8xxMI0EiCaDkfzAnmpPARKPAZYIu
	g5CJZ60M6ciJoK5nDd1NZL3d8SNJ44kkZDORSP0rELJFMjKNopG8s0UQ44cvXr6bu2yL9Bk8tks
	hKpAQwj/ATFNNu3jfdfYzWE2X81UJ0M+t1S5eA+cA0UagWIQt8nhZaLGjHlA9kVGREN4yxADnxJ
	KfZ8AqBAM+3RfBlJuV5y6TA==
X-Received: by 2002:a05:7300:f292:b0:368:a825:bf7f with SMTP id 5a478bee46e88-369e84fa201mr759189eec.13.1792795033348;
        Fri, 23 Oct 2026 15:37:13 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d9307bsm1327484eec.14.2026.10.23.15.37.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 15:37:13 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 2/3] bearer: Promote to stable
Date: Fri, 23 Oct 2026 15:37:07 -0700
Message-ID: <20261023223708.76232-3-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023223708.76232-1-kevin@simpleble.org>
References: <20261023223708.76232-1-kevin@simpleble.org>
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

Drop the experimental flags of the Connect and Disconnect methods and of
the properties of the bearer interfaces, so they are available without
enabling experimental.

Assisted-by: Claude:claude-opus-5.5
---
 src/bearer.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/src/bearer.c b/src/bearer.c
index ea3bf697a..51dd789f1 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -199,9 +199,8 @@ static DBusMessage *bearer_disconnect(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable bearer_methods[] = {
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Connect", NULL, NULL,
-						bearer_connect) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Disconnect", NULL, NULL,
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, bearer_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL,
 						bearer_disconnect) },
 	{}
 };
@@ -312,19 +311,13 @@ static const GDBusSignalTable bearer_signals[] = {
 };
 
 static const GDBusPropertyTable bearer_properties[] = {
-	{ "Adapter", "o", bearer_get_adapter, NULL, NULL,
-			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Paired", "b", bearer_get_paired, NULL, NULL,
-			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Bonded", "b", bearer_get_bonded, NULL, NULL,
-			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Connected", "b", bearer_get_connected, NULL, NULL,
-			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Adapter", "o", bearer_get_adapter },
+	{ "Paired", "b", bearer_get_paired },
+	{ "Bonded", "b", bearer_get_bonded },
+	{ "Connected", "b", bearer_get_connected },
 	{ "Connectable", "b", bearer_get_connectable, NULL,
-			bearer_connectable_exists,
-			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Role", "s", bearer_get_role, NULL, bearer_role_exists,
-			G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+					bearer_connectable_exists },
+	{ "Role", "s", bearer_get_role, NULL, bearer_role_exists },
 	{}
 };
 
-- 
2.54.0 (Apple Git-157)

