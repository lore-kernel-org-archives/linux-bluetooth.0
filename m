Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F415A2673AA
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258177; cv=none; b=uMSnWYS3tN7wW7mlGiX6zZCHIPcjlZ/czMcezKzPHE2rRMhA7y9lI98rmZnsB+NenSnCIQwrAPGSisC7pYv1nBv/R5FyTSP6yPmg0/yD0fKguzIo/NJ3QMW7Zl6+kVfHvOxoaRevfbO4niMpE12vMpvOQUUiTNZVSk+4B8sb0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258177; c=relaxed/simple;
	bh=7BOZKfZ+GnZAQxZiXzYwEQT7sy53zo5/6siQw6a47b4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLjv3dX9q4IIwjpxf2xtzlIYx5EGnyp34diOSAWeh+5+gttutMFGFHJ69XNOzvgBfQ9o3dlEvQ+79vU4/qWQ8muYp7ylNa+vFbTLgaTTQLFK4+4mNbug/D2OwzOjDwJDEKAnPcejt4UELobnFj2QDO+WstpBHmvjbod7bbXZj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ouhJkTA2; arc=none smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouhJkTA2"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7a4fb331cc0so806007137.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258175; x=1790862975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZwLAizyG/WdQAb9JvN+54XnZGBSA+5/OIgjagYnKtPM=;
        b=ouhJkTA2e6krCANKZEt5Jd4KUFWrFiqWktVVePO3FfgDPwKb0JAKyM0+UiE5xpPzJi
         xzywi5oDXn4rxP83drzV18jNaVZGx6xnFB/H3K55zqrA/e5ws0hPa9eKCfQjGPg5wErr
         huKoWzUvIUVxMQ3Caq4r0s/aq3xgsZmEOebMcId3qKLfeDRVfGi7q4yipZH62biK2GGy
         D7IV96qIBPjy6ObZEi5BzBxi/yRME6yiAU4lW0vtSr13P4YVz77j1Uvp9wvFl4JA9N2Y
         oVULbLAloIOg0QFr3fq6sBwBZZVi8olf0OHHV+jb1ZH+axIJkPV5/fqUA6aZNM79edsD
         tMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258175; x=1790862975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZwLAizyG/WdQAb9JvN+54XnZGBSA+5/OIgjagYnKtPM=;
        b=cVvWZEvFjyVUUghzVj+kX/aU5jQZvC9hfXDYhKIElWI+H2UOJYBF3tIRwYoAF9O6FP
         TdrAGM0ksrJR1mZ1vebEhNGrdex3BeAAIhub5pZOKRb3X+sSfoUHWxBnp8YOH9I14/xW
         oE3gELZotEZPf+ptqHJg0R5vbRCRY7Gbag++Zi8Zy4covBZIOs5r8mnIzqWlGLHu8VUD
         EltKPIeua32t5s33rLx3Dk1uLRQf79MNLcrEUiea1FvdjfKWoJS+bghh4ciNfZlbazzX
         YHbt0kGno2Eeh+YNTNRm31ujjSyAjoO5D/RHviLx5gtn7yc2/usnWMLILRe3+5RMPofv
         IabA==
X-Gm-Message-State: AFuF++lN4BWgciqrMWM5KjEy4VLVhtyfusMwLaR7hzwPMqpU74wGxDaF
	bDvSNT1TNVrdglwpnwYRJ+FUJpUAjOz906GOEkpsjshnMJw8tvTupteKYUVitO+E84/MlA==
X-Gm-Gg: AYBFou0T9OA0ZaASHLxsj54hwjg4MwzP4pa6d6EvhZv35XJxtF5sXCdits2v1Y9mK/h
	MylmxB0HPoH/uR6mm+Xbe2mvJRwaxNajxogUAVcNvp+DVIGGzcHPyzZykD6199MeJSYg8qurQQj
	WsjQyOMMbRrEhRC8kkAXItk3KHwfMy7pn7xZogBgLqOAHnfQP7x5DsISic6GZvbGgNdnq7T6wUh
	B+4mBCV8liqygkymXWPNM7fPFFOsNpSe8SNa8s7ocBNFBEO7pW9CJkUH25yV7YQC5tSH8IvBRFw
	KvUv0it10FfyJCnZsAI65OPIObmf3uCahx2oEmOZPVEwkb/TYncmXl4x4vCZQ/Zb+IitzDYRiHM
	bzUChVr0M3yA3L6OCKNBWr0gVY7hYjbQlDsHA0zSoekWdJAQAT4qRejUQbgGGucvazFp0No0fYS
	haB5vqI5oDoLcUbnFK0Jmr7CbWwUnF9zwTuWkEOTIc92g0zf718ea06LBuAdXxkluBpxKZB0UN3
	2zzATCSlBlWlz+zQ0XPxCmlOodH3ZL/2oTgvDwW8ZrxHE+0qJUlwG8kcPysk4vR
X-Received: by 2002:a05:6102:e10:b0:7a7:195a:1b27 with SMTP id ada2fe7eead31-7af1f611721mr1080357137.33.1790258174776;
        Thu, 24 Sep 2026 06:56:14 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af8bdcde81sm1493194137.10.2026.09.24.06.56.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:56:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/8] client/mgmt: Print Connection Subrate event
Date: Thu, 24 Sep 2026 09:55:56 -0400
Message-ID: <20260924135601.330277-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924135601.330277-1-luiz.dentz@gmail.com>
References: <20260924135601.330277-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Print the MGMT Connection Subrate event, generated as a result of a
LE Connection Rate Request, e.g. after mgmt.conn-subrate, or a change
initiated by the remote device, so the new connection rate can be
confirmed.
---
 client/mgmt.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/client/mgmt.c b/client/mgmt.c
index cd2ef80221ad..a7069e5bbb37 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -499,6 +499,35 @@ static void disconnected(uint16_t index, uint16_t len, const void *param,
 			index, addr, typestr(ev->addr.type), reason);
 }
 
+static void conn_subrate(uint16_t index, uint16_t len, const void *param,
+							void *user_data)
+{
+	const struct mgmt_ev_conn_subrate *ev = param;
+	char addr[18];
+
+	if (len < sizeof(*ev)) {
+		error("Invalid connection subrate event length (%u bytes)",
+									len);
+		return;
+	}
+
+	ba2str(&ev->addr.bdaddr, addr);
+
+	if (ev->status) {
+		print("hci%u %s type %s connection subrate failed status "
+			"0x%02x (%s)", index, addr, typestr(ev->addr.type),
+			ev->status, mgmt_errstr(ev->status));
+		return;
+	}
+
+	print("hci%u %s type %s connection subrate interval 0x%04x "
+		"subrate 0x%04x latency 0x%04x cont_num 0x%04x timeout 0x%04x",
+		index, addr, typestr(ev->addr.type),
+		le16_to_cpu(ev->interval), le16_to_cpu(ev->subrate),
+		le16_to_cpu(ev->latency), le16_to_cpu(ev->cont_num),
+		le16_to_cpu(ev->supv_timeout));
+}
+
 static void conn_failed(uint16_t index, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -6006,6 +6035,8 @@ static void register_mgmt_callbacks(struct mgmt *mgmt, uint16_t index)
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CONNECT_FAILED, index, conn_failed,
 								NULL, NULL);
+	mgmt_register(mgmt, MGMT_EV_CONN_SUBRATE, index, conn_subrate,
+								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_AUTH_FAILED, index, auth_failed,
 								NULL, NULL);
 	mgmt_register(mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED, index,
-- 
2.55.0

