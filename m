Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D141A391E75
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425388; cv=none; b=dm3C6lj1V/KOxw2Q/zPPbNCCwsgpjv7peRAEL7p4P0ahR5ETgXSnQwLbZ9d028m7jN4RGbM9k745zpfLdtmlBlPdPJ4r539qipIdzfzym19+SlYDdw/dCgeGqAD4iYJXsbqQ9aB2K71wUQQskHG2ET09Tk52qnVAuUESLzdHBoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425388; c=relaxed/simple;
	bh=ZBy3GKls6lvORCRcIhx9MoXA0W0PjiR9l38g8U7QhWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwzm6ZNerlH0Uim2Z5/MOg0yji/yZczXa87G+w80gn35RBW8gTSx12/TxCh4PYeC5fGoshnesLMh2k40cllYHfQoFVU1T8KnDdYzlr4OwVhCb+kKWyY9u+3COk4nmXOY+MUuze0v0TUE63fQEHD/TVTK8QrpFahEcjJb9p8mL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=SwalPBIu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="SwalPBIu"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43fe608cb92so284609f8f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 04:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776425385; x=1777030185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IsQ0eg72VDUv1UOmZE7Ho060WwfI6PRYtKhDA1sHjY=;
        b=SwalPBIucN6iQoj3kLNV0q26fTPGfFPc3SlPv4WYfSgqeVqteifefErHBVLU2xO2kK
         maRbOBUUW8gG2XlOlFx0A2UyHUciuz7jinVG5sYq5JktPkuVW5XTuMDDPbZakn2jLOCZ
         oNOPAEeYrLSqxd+SGhzf4+xz7P5cbaQXUu0FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425385; x=1777030185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IsQ0eg72VDUv1UOmZE7Ho060WwfI6PRYtKhDA1sHjY=;
        b=dEKtFaTr6rzgLdRpRnvrsV8aqyFtoCcsmaBdS2REkyBzCglkDT7cj0pCqdBUJAUbfb
         kx4yzKUpe2/f0oYQeiHOq/nFCFClbUkWq9ObzeDPprrJQCe0vSCqhSecGUQS1vRsaVNA
         uqzzHUXjFOJaY6dIlsLw7JpUulkGIBYPgZJOg3q+pSAxNSIvLrLtXacW5pkskFdqGATD
         LPESkFshtRPNVf6Lgk6Ob1i7Pg0v0CWaBZMcB04C2X71FEiUq5Ji1rAPbUuHuMXn6sCS
         bYL/hVac+qCHUavRA41czLOSKICUpdVt74EZ6wUsGTiwMi6fJzVdEY56AwzUi/UuTW0D
         ZmRw==
X-Gm-Message-State: AOJu0Ywrg3JeqfVaeegxa0t36sQx5Ah7ahR1jrSpYwEkR8KANKPGcPKe
	niIJs9/uTUcEnujdnQGPgoEUul4XljQ+X1JqxIMJOQ0TuBVcpcFvo47/NSVVrGGQNcpP71WE3t1
	UaeIBBA==
X-Gm-Gg: AeBDieuQ0PGZB73TICFHQvvmiftVb2lGdh5JoyFPx9nByYTm5VzCKWdAPWgWGI7HuoD
	3R/xMn8U9uqkwm+ZgLr/RiiOXIrNk9w2/JfUzioa05Ma6H0/TwiIL60Wur8m26qx27dNbxCwEPA
	0LlPXxHFey0rlNbAXItiRK60i5+K3Kg7+eAzNPeejFZR2sOwmoCmvcPfqkhpTX6uZoR6mwdeCMJ
	b8ljLIg9kbUipSCY8rSIpRr8Ts/9lNMa/2fQ4BQV9+6rcS9MtwO/2IDlTg4pjzQeQopqb0ItquH
	GhCL8y4ugYRlIC7/ZIJIT65RHHyvFJBYRTMJM74Pdk0RWeiylNJkjOHecYlJlVGLhCCcPT6mym9
	GtK7FyWaC9VZ6h2stpNDD3NhCrZ/vGxCNRQC201xTEDU6Ei5LkALbBOEr5gMZUSbwoik0KOGojs
	i+FoYjxfcgw81+kTqXVaLENhK97Vjoahz+JTiQVlhGywcAuQJMgKpQgYlWBZxXPmGG6T7wzuO8m
	9k0eeffCAHqfxUZ
X-Received: by 2002:a5d:5f96:0:b0:43e:a73e:cc8a with SMTP id ffacd0b85a97d-43fe3e0aa94mr3444119f8f.36.1776425384719;
        Fri, 17 Apr 2026 04:29:44 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46898sm3765865f8f.27.2026.04.17.04.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:29:44 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/4] transport: allow setting Metadata property on broadcast
Date: Fri, 17 Apr 2026 13:29:11 +0200
Message-ID: <20260417112914.3752605-2-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
References: <20260417112914.3752605-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also fixes a problem where 64-bit iov_len was incorrectly initialized with
32-bit value in dbus_message_iter_get_fixed_array().
---
 profiles/audio/transport.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d9feef768..81a63c365 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1336,6 +1336,7 @@ static void set_metadata(const GDBusPropertyTable *property,
 	struct bap_transport *bap = transport->data;
 	DBusMessageIter array;
 	struct iovec iov;
+	int len;
 	int ret;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
@@ -1347,7 +1348,8 @@ static void set_metadata(const GDBusPropertyTable *property,
 
 	dbus_message_iter_recurse(iter, &array);
 	dbus_message_iter_get_fixed_array(&array, &iov.iov_base,
-					(int *)&iov.iov_len);
+					&len);
+	iov.iov_len = len;
 
 	ret = bt_bap_stream_metadata(bap->stream, &iov, bap_metadata_complete,
 				     UINT_TO_PTR(id));
@@ -1614,7 +1616,7 @@ static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ "QoS", "a{sv}", get_bcast_qos, set_bcast_qos, qos_bcast_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
-	{ "Metadata", "ay", get_metadata },
+	{ "Metadata", "ay", get_metadata, set_metadata },
 	{ "Links", "ao", get_links, set_links, NULL },
 	{ }
 };
-- 
2.43.0

