Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA136216D
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801907; cv=none; b=kaokKKPD6wHBfOqIOefUKr20rY8gf3J7fpenCyA4BxY+Grb5Nemil4GUSvjfeTmSA5J97IiOE6KkqBmEdjxWsYLMvYLi461fBxvCWJKMoJbPnh0OSEfHlnZtABB1hyiXdMwWXZgHrLoIqa+YQB9X/d7Ha8eIi2RZkDxRYd/416Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801907; c=relaxed/simple;
	bh=K2Utrlr0vp3zrSHviTPgil48gK7pFEhzpZMuTmocHs0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqLNmZEve2U8MwsqOEDttB/hV/4r1jBK5EFS15rcOr8UHSmzuYpdCVYj1ehop4a9pq0MOuib5/sgpD5Thkz1xeYjFqgELCgsyfE8LFgzZSH7iAMf6+z9dvHkaY54gzAgq6jbzsV9nN5ApVYlyrR1lF9ffaDDs8OUEwzwLPrUYhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGYzJcM9; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGYzJcM9"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d5cbc4a585so372651241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 07:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706801903; x=1707406703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WYVVWhi5KB9maEQKsM0GSDViu6LAYuo+A4YUpEmhnjc=;
        b=jGYzJcM97rBdqQbUMby1u2S+6cvoV3U5Ko0uvu+g1yg9WwH1DMpRnW2F+Mlrmb5kIt
         Ftypd98+5mCalzph6YyIOt5ZHNbsGWumJR45MwBNoRlFiHCSrfdnhtYWhoYHmdR92FwJ
         bGaJiFoAqxIzrweQFE+J1FogsDk7T3N+/fSy6yhKVqpF7CYbnByugsjBe6WOQxXW5Yc8
         e9ogaislxaimixNetG/ckSAeyT1tSR+kI0Bkyf0uCxMJ/YI6Wgm+pKqO95QgYjqXAPdi
         GizqRJAAaIUAKN5z5NwF72r1qbGVaHWNV5M7FgcVg/mZ629yRaXva9Kjj/8+9UysSDUM
         GkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801903; x=1707406703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYVVWhi5KB9maEQKsM0GSDViu6LAYuo+A4YUpEmhnjc=;
        b=mIGr/v7QM4AwNkX00NMF+EKX03U9J9Bruh8aPC44YHyy2riXkjVCMZQSVx9WSn3M8k
         ZuHZOqpeDDS30O0dubGmYqVpsyN5k3MV2TATJB/XbGx4B1OD3qjQOSEo6uMWkQUPQA9c
         NDgIGH6BHSdNTGdCN1sEJXYXIujDT4WWjmBDIKMXPXOHR4ykkumk41N86FgFAk18uTgl
         TuPxjxVYm5hMuEChshI6/oqAm5tOpvQmX9jJWNbbfj8/gFLAsVA+QwD/TsmS4TmmAkT9
         ygi3D8gKH1mFQqLj+fEPCWlVW344ukKGZ+NWK3lP1gFVHExVicn3i1ZBc+HmCu+6Vgej
         WSFA==
X-Gm-Message-State: AOJu0YyHtTjJYL7jfk1v29FK5GUnYhGXc1wAj4ED7yOFHp+gvyEakv+X
	LDQxgffzUXcS/aWQYBNUop8zG5owreQsGSXLhWFlrctgWUDkvPQOloOhOESf
X-Google-Smtp-Source: AGHT+IGvn0lRUUgG5vmDbRViKcL+LMx64f9k06396Ir3pNMnQg4/Cbh9kpcNuZ2eTXKPm8RfiCBThw==
X-Received: by 2002:a05:6122:4e84:b0:4b6:d63c:ca8f with SMTP id gf4-20020a0561224e8400b004b6d63cca8fmr2271765vkb.16.1706801903128;
        Thu, 01 Feb 2024 07:38:23 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ca5-20020a056122400500b004bd503f054asm1624586vkb.42.2024.02.01.07.38.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:38:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/5] bap: Fix passing ep instead of setup to config_cb
Date: Thu,  1 Feb 2024 10:38:17 -0500
Message-ID: <20240201153820.1016507-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201153820.1016507-1-luiz.dentz@gmail.com>
References: <20240201153820.1016507-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

config_cb expects setup pointer not ep.
---
 profiles/audio/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 7faa6be7f90b..7e87d12d02f1 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -948,7 +948,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 						&setup->qos, setup->caps);
 
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
-						setup->caps, config_cb, ep);
+						setup->caps, config_cb, setup);
 	if (!setup->id) {
 		DBG("Unable to config stream");
 		setup_free(setup);
-- 
2.43.0

