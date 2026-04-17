Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BCE3B19B7
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415771; cv=none; b=anUm3lpFGjGcAKZv3NUT97wN+639TwmiNGRo75kqVx3mJc2jgtlOc4S9hwWHuN2L1cstHzQMO0ghnxyX8PNzT3bldEaXkP4opYzrn/5Zu4S3ewI4CzU36s32g7XCQYFfC+20bwGhx1ecNFL+gILddKFLGy+W707YEVqjJ39EuwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415771; c=relaxed/simple;
	bh=ZBy3GKls6lvORCRcIhx9MoXA0W0PjiR9l38g8U7QhWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZA7ZvBBO11RY7morwnvwbDNjXZFnil0zBNCSJsXCoWaa7RsbtEDhZWllzOyB/2mTdiFhuISz7Ciz22PGd3EiCOGE62PKE9fbJ+aS4EZJ23v3IJSaNEtvRqb58jhx1ZFsBZEIWbw7ibROwN5rVaVxlfsbCLsJr9rmuLpXELqZl0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=p0EN0pYK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="p0EN0pYK"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so2766745e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776415766; x=1777020566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IsQ0eg72VDUv1UOmZE7Ho060WwfI6PRYtKhDA1sHjY=;
        b=p0EN0pYKBfrVHsRSVLbDjEk1BT4D3WafwmeCIvqZPrduwgCLOtu19dUxscPOfXJUwe
         e11N0+RjspZ6JhGEgY/tKqdQivnCRkbu9BbErECKrwCQCn1npA12fIAbpsO6vHORvg+W
         /g5nFOmaV3blbT6rzTtCSUYl6EQHnpTu/nFpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776415766; x=1777020566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IsQ0eg72VDUv1UOmZE7Ho060WwfI6PRYtKhDA1sHjY=;
        b=EAJPmkt3W2pFLa7Yj7sYUvZICWK8Mk1PLii31W1eJDjPQZvY1KPNWjL2rtf+onmG/m
         Lc23t0qzVayRfnFdDgf7l21w5KIbClOc0oX4uycnZvNVi4KwEyUw9XW5JLfq4k4cWmym
         hP8zJlWtBdgSKPaxL/tccxQB4iXjUG4uG2klW5fI7FaFpGOMWcFmoBt5dUboQlEzf1r8
         qXPlqmVhqTiIeAoJH8N1g8BRF0GPGu2UzBSUcgJ/Zlneqkc+oHApLrKbNdC6lgsBGi6n
         LKImmoBtB3oph8DuXmIEOLuLJuDU/p+UpX6X/HfNWfoVR5Ne5ZnjdycaMfOUkGohPF7n
         Oj7g==
X-Gm-Message-State: AOJu0YzWwxzDifOO3A8yLhttYJpqzr1SDh2veCMdK3vT8jmr9H+k8pGW
	4favvJTBsLff3nBlPqXzx/rmRup3sy5AsA3nGiZtZ0Fa6OEn5HQai6QMFPYOA/lywzQBYoeDq+Z
	Fbr2sTA==
X-Gm-Gg: AeBDieuukfiOFOqPIM5k1XMo/St+kCKQiZvYw6T/jVAKi+m5OPV+RQcIu9BWxSr2LT1
	sueWg/BhDl3HIkPId+fNCQpn7JFgxMT63rXA8RxX1lmKSKRETuwAlloPf6CjbdOXGDc51BvMoS5
	f6kbVAUszN+Vpm4LNwmysIxAWInBNMExOLAmz7Zk1nssTU58F64aVZ7dTLHgKiBSQUhjeZLVv7w
	mcer12noVEy6kND2HXIl7ygP8Rcf6lxfmzLipAvRmo6vO0sGRiwiV9I5wMgVb2crSctpxefF+te
	tpxO+nXCDZgzh0RCK+O+HIAXwdl9TJXA8A/mSDKmo3geRv3cREzwKaCcyePiMnOakTlRBAx1qpj
	aCEQny6PmZxgL97G1V5nwyCPCq52P2uQCyntChNn4HXFYaeTzilPPoMJJLaA7qaYilGRSuij67s
	t+2+9fLoLAfe0gGECr5D08RP2evJjyzZ4J3M2zsD4z8/TSY7gI7EhUkWdV7C3SMd7gdR8C5Rb6d
	Io370NseP0/Xtzs
X-Received: by 2002:a05:600c:5295:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-488fb780463mr21270305e9.22.1776415766488;
        Fri, 17 Apr 2026 01:49:26 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f8c3sm26315095e9.2.2026.04.17.01.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:49:26 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 1/4] transport: allow setting Metadata property on broadcast
Date: Fri, 17 Apr 2026 10:48:07 +0200
Message-ID: <20260417084809.3633687-3-michal.dzik@streamunlimited.com>
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

