Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8C72DEA61
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415774; cv=none; b=UKAREiXj1PWQrHH4TT1wr5sOcGJ2EVLcjFYDFr2+R5pLyEPBIYMLnaJyJtHVK6HJhIwvg3grIgC8/fxU5S1FKkUIHO9qwCl/JlzJl3wvW4c3DzW66YZpkyG/cq0JmNdeI1uBb5AHnAau/4TbUD8fdDJ59DPHBhi8oekL9ha7zpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415774; c=relaxed/simple;
	bh=qsId6kisMoWL+67ZrWwvp3tIh1jgIbLrxxmgrHAMm0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5pjQ+tUgKNh+hE2fxXv67SzqvTpelKql04i9cstwbMY7DiA4cL7u8rDQyC+zUtS++Yr0yH5lhGHMM17pSRmE+j3m7ALOX1gImkUWGsFbJLRe0qzqItXbc5OA+cxdr3zv4GXfiXzaYLLyFyeifKJl2zIiQ+CGmO6pA088MEHSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=qlYvOp7c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="qlYvOp7c"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso5771285e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776415770; x=1777020570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6U0YROoCJ0dbL4IhFCJ9DSelYLvRbzNNdnwPhskzg8=;
        b=qlYvOp7czsXUdtzgK9xpkcxx9ZEC3aZ+Rk7hlVRq2Qc3awpi+n1QJlrqrTEti3Cd6p
         BEF+qEstVlKW0nu1Xcm1NHPFbYXLUCQE4lm9cJk75lpVJz/G72MUnxZxAqDS5IPif/S6
         sl85JBR9kpBSG5wny5upVvn8+Z0oDtGB4hPzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776415770; x=1777020570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f6U0YROoCJ0dbL4IhFCJ9DSelYLvRbzNNdnwPhskzg8=;
        b=mz8HDzDRtM+bJLnK3wIoX/zFviiQityoGqhI/uft2gawiESKCsUc7Iq6rV4r9X3syk
         v1R7O/6jezszM/+KbHruKob1ASuvQ4WM/dE3P7jbdCbBXMRfh3h43rhmnZQnh2/gxl2c
         5FjY6PcyG1AlAKjiU9apIIHo0KPImsENm7cLk35JGZ8LoH37J38onvUklGC4ed6u2HAg
         mRQnU/3Upu6MbEFwn8l23D+ACNmOLJlfsDad+XfO1uhHwYb1TgJZSPsSAQ5AImzNiCwC
         36qs6Z6AHi+etvzzHKGLOeS91PKmLssAUwBQdBNkfnPZcHrYB+sFm4qKQM3JZfrvCbNn
         9tVw==
X-Gm-Message-State: AOJu0Yxqi+gYefrt8QRaei1IOy/uSVwSk8luGOWedkJIuUWxqgtvzaze
	1df2tBIg2mpUqqIe2RC1G9ycnXIUIHfIF94MQ5NQoPIkWYnU09m7hplZ3oBcBOWQ7z9SDxfJlc9
	3POE6/Q==
X-Gm-Gg: AeBDievGI9Zj7WgHFI43yskQiFi1ojafuVR8KaDiKprQExPT+FRu8m8njlFF4BRiBSB
	NN0HN32/zezVWv3X8F7sK06pht0pUkw+GbOi6IOkxqGKtz9yxAExzqm4Z00umU9IWNxKqKmM3iq
	Hp8wi1FFIwn2ZtGXxdjx7W5SI+se5QIFmphsv0gzeH8EquszyPZ8HCjNTGRlZhr46Km5l6o8r8e
	ojShmQOc2p0hsoxyUxKnEqCeFOX8XjyLF7DdK6MVZ1DXnUROqGC2vhyxloPwVEdAfSVON1DUwZN
	r4mx5IybdGPyOLmPC/4aINtyA9T4Y9Mpjs5tc/S/IhWHDqF+5hzqKryhKzN4fnp4AHBfiIk+mzA
	tGpTkEZg8MfiKxOZEz+SfT8o5jyhEULgliPt0OGfEliliONp7aOyeDyXeiJaxbV+LCD7wCLhcW+
	CPV3+6EqLLPLlWQf5VxHKSvlqqAJKhiQ1oUQUbA5CuxCFkmcOvbNxGUC6LEC5CyNBtD+4OWxeUI
	KtgsXaKLXjDaLAs
X-Received: by 2002:a05:600d:13:b0:488:869c:edaf with SMTP id 5b1f17b1804b1-488fb7419c4mr20752975e9.8.1776415769798;
        Fri, 17 Apr 2026 01:49:29 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f8c3sm26315095e9.2.2026.04.17.01.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:49:29 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 3/4] audio/bap: fill BIG and BIS for receiver
Date: Fri, 17 Apr 2026 10:48:09 +0200
Message-ID: <20260417084809.3633687-5-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417084809.3633687-2-michal.dzik@streamunlimited.com>
References: <20260417084809.3633687-2-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is for some reason a missing feature.
We receive QoS structure from the kernel via BT_ISO_QOS, but BIG and BIS
are not set there. In fact it is even impossible to pass them that way,
as it is only one structure per remote device. That's why we have to parse
BASE data to extract BIS and set it to stream->qos. BIG is not present
explicitely in BASE, but we can use subgroup index with success.

As a result of this commit, MediaTransport1 object has now a valid BIG
and BIS set in QoS property.
---
 profiles/audio/bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 375026440..9c4428b1c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1502,6 +1502,7 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 
 static void create_stream_for_bis(struct bap_data *bap_data,
 				struct bt_bap_pac *lpac, uint8_t sid,
+				uint8_t bis, uint8_t sgrp,
 				struct bt_bap_qos *qos, struct iovec *caps,
 				struct iovec *meta, char *path)
 {
@@ -1512,6 +1513,8 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 
 	/* Create an internal copy for bcode */
 	setup->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
+	setup->qos.bcast.big = sgrp;
+	setup->qos.bcast.bis = bis;
 
 	setup->data = bap_data;
 
@@ -1550,7 +1553,7 @@ static void bis_handler(uint8_t sid, uint8_t bis, uint8_t sgrp,
 			sid, bis) < 0)
 		return;
 
-	create_stream_for_bis(data, lpac, sid, qos, caps, meta, path);
+	create_stream_for_bis(data, lpac, sid, bis, sgrp, qos, caps, meta, path);
 }
 
 static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
-- 
2.43.0

