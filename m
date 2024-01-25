Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC9634E0
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192988; cv=none; b=eiaXex5gaQ2+Xn+NeCEuW4o9u5gmpCfPUZT3OrjbJqX6Ox1fmqxeipJhunSKuC6tca6J9l0FnOE/P+NsOu9XOfXmEe5GZCKSPCA5I46KN2ihAZkzi0F7raEC5PxIIFtHkXPcvv2bB9ngM/4qUJSetRQ7voou10to4yOftr/pClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192988; c=relaxed/simple;
	bh=JUfr0p07h+Ewp/sLbyEq7IYa0JlWiyZ8irZXMLhZqqs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTp6DzeBMSMh5sWOTC/sL/PUbu/a0O5NlPRW7kXxrv5gPX+FiKiLAEVkiOBmnkiZuGbO0nmKglEx0Ny7YTpXuusa7M/T6CXKcOopEw1vCp4Tm6l/TMJ49UTtfD3MJllug8gghgQG7vD04bxSHGGPmwicVTuwjLUUoAkgqGntjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgoMee/U; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgoMee/U"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ddd1fc67d2so397810b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 06:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192985; x=1706797785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dklMvlN+hkfw7f1s4bwiZ+J+3zXS8Ln0cXYFoGxDekw=;
        b=LgoMee/UjiGwD3bQGs/q9sMlfmR2qgHBm6qKXdmcVra7I8lPFTWxOgEDhjXvFAiMnf
         CZMR1GPiHY/zqGCkO/O3W4bvnTPDEZQ45PsEM128DrL9LyToSLgIpJdP7EommNlI8KmR
         af+imNQSFCsLAzwzF18MvnMze4Oi9zyntvKRUnDrRKCeaawngR3xfma+WIsNhxw+bscL
         W2J2OiW1hkHrv0s5ZS67B1Lr2qD+7Umjtmx4Yv0Nm9ZLCc1RoXRVNNmaZ6k08tDbQTDp
         FXUhCwlyLJ8pBZ8UCydEMlGWqSPZ+GElwY4Gvs49P5KOMta9byQ4wITYG3qiDmT5zvL+
         KF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192985; x=1706797785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dklMvlN+hkfw7f1s4bwiZ+J+3zXS8Ln0cXYFoGxDekw=;
        b=mp2BdoC6myKFA4LzAjPjEdWwMbxIOVDWfciG0WNvpTRWKrmg86yIenzq652xv0LIpU
         D7/DnT5f7/wPgd67cJSrDYM9JGkPsw6E43TnD+6jxJtuHXb3eSlNXDHTtuVsIHZJggVm
         jDsaHHWpj1XVVs0We0KfEZHfo6F7Fw2oIOp1LMxiGsHm/BaNKkDWyC81D/if2h0gZ4bu
         MLhEWrUjFAYTXiinW3xejFJBY+wWWAR/c5o1htK63QwN052BXnwpjq5lvalzWdImIF4M
         UztNl41YgKPagwBVICYl1EXEemtozUnIVU0zfgixKSK4KreqvDkUrc+kBN+XY5Q15Oe9
         gdVA==
X-Gm-Message-State: AOJu0YxbLkP9KDvCU+S+x7WzSC7oWKJjMHpWpYSLApro9EsHY2FlnvCg
	MG620oZEUnDvNtm8pfmqzvyWRxBU15fvsVwtf1X3UCqOHnVpbfReijGt4GSb
X-Google-Smtp-Source: AGHT+IEhclc+0uWvjWxXXU71S+p+ySwx/3QvVyWleCJotd2Z9fQDAfsi4yZ7RpUNGyKUEvP1P3XN3w==
X-Received: by 2002:a62:cdcd:0:b0:6d9:b5ba:3ddb with SMTP id o196-20020a62cdcd000000b006d9b5ba3ddbmr741211pfg.11.1706192984724;
        Thu, 25 Jan 2024 06:29:44 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id x33-20020a631721000000b005ceac534e47sm13646143pgl.51.2024.01.25.06.29.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:29:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] bap: Mark device as connectable if a broadcast Endpoint is found
Date: Thu, 25 Jan 2024 09:29:36 -0500
Message-ID: <20240125142936.3373953-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125142936.3373953-1-luiz.dentz@gmail.com>
References: <20240125142936.3373953-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a broadcast Endpoint is found this uses btd_device_set_connectable to
make it as connectable since the Endpoint can be used to setup a
broadcast stream which requires the device object.
---
 profiles/audio/bap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a4036bbbdfa8..864761dfd919 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1378,6 +1378,7 @@ static bool pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 							void *user_data)
 {
+	struct bap_data *data = user_data;
 	struct bap_ep *ep;
 
 	DBG("lpac %p rpac %p", lpac, rpac);
@@ -1388,6 +1389,9 @@ static bool pac_found_bcast(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 		return true;
 	}
 
+	/* Mark the device as connetable if an Endpoint is registered */
+	btd_device_set_connectable(data->device, true);
+
 	return true;
 }
 
@@ -2456,6 +2460,8 @@ static void bap_bcast_remove(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return;
 	}
+
+	bap_data_remove(data);
 }
 
 static int bap_probe(struct btd_service *service)
-- 
2.43.0

