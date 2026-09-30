Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C42EDD40
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790763181; cv=none; b=qhN4a0Yj9JzvdVOdzsZN0CGsXIOqUKXuk0I0r81esa1r5s3L3o+3uLici0vB7EG9hSTc5mn8G3ErIqUvLj61pwGVDGeagC72oZ+BfTsLuapjeAnNR6Mvb636WzisK8Mt/PXtWwSKJIdvn2ui/rZTriqAoDOcdD6+pSrmb5OScvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790763181; c=relaxed/simple;
	bh=QW3A3LglbgqrfhIVCmI/pHu0FXSTQyDDp2KpxEICGNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPZE7erGHzABOl2WnhJeGGl1FuNNkr9HbbSYtOZCy3LpJhs7z1pqYmBIrBUQqBebKJ8EclZPy1U7+4pMk0/yGOyDg10YMcL+Z7XQaPEhkJsE0mo7tG2nR5F283A/Lj2bGIKzGhi+aYHksc5ZQEIDwmgiVgzosPZgLFa/4bMeK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzEO7Avv; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzEO7Avv"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0aa9d356eso4006976a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 03:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790763179; x=1791367979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9nJguM5oSneDAdz6x2D/8S9jHeo9k8F3yuv0W8uop2U=;
        b=pzEO7AvvzraFyyw/0o9v6bZ8lgtgkTxAWCcEmAdE65RY09NKJN0zGO1hfYtRVe+XFG
         5pPEOmaVKa0VAu+BXIsgMjd6fEROwBhm4JxwsIxa9Dy7lp/Or8Fz+VTts9XGl4hagg5s
         J940Y/kwDkTNG/QlfNzsQYfvfDFe6uNkEoIxHTJTmyw15pXRArrkYhK2d8URGfFQboKw
         2y+ptB7enyjnOD+x6RjmdUa7AwbP3q5UxKQ4pLBTOJ3QKJXLbKoIVnp+WG2gqdYjTUWa
         4qXd2G8u8hoMUnihT53YnFCmry6p/fzGmRQIpQwcRtLHm341rlcUutLWNaHMBO1xJMis
         Dmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790763179; x=1791367979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9nJguM5oSneDAdz6x2D/8S9jHeo9k8F3yuv0W8uop2U=;
        b=LYfOypvJli8lqQq8n8b8JlgbRbezmnp60XK0/Oadu6U41AZK/JgB8FaQChsy4hhp2z
         R+QC+6seXwLPCZgcPoMgt8ArHaKig3XAO/TzCqkD19yhSl+BS2SPNqt3BIfVcCKKD8pi
         E2xJBhQEEZlY8BgdYhQQ8rYixeyeoygETDLGf1tRVBbU/NdDrg8odMMgH8kH+G961G0h
         XqS+fdwcUCs7/ZnMeFmYixKx01S/IZXk+QfUG9lTLuFxiXRSTw9a4jfyafKDFwhq/vMz
         ObJIEeBC2zXhqUMVCXckD1IC3SRKaz8bizv448qr5+Tib7lGn8s7yPECG9oYqDK4Xs/i
         wHzg==
X-Gm-Message-State: AFq9FYJUDlfaQ6V9dL3UA0DzBC3Bii1R4O8ut0dQBAZ+B4UGISsrva90
	zqwW+22aIqlqPxg6bwpinNu8EI0EN588DBzAXf8XMUOuXHkkMtBEO1+YUHE5jL5IjEg=
X-Gm-Gg: AYBFou2+StTvEkZFiIjd6LA5Ri8AYJaDdcc6LOJI2tnyYu8HQ9U6fTIYLXAUsTn+tk1
	0vIp6YGutYCCHOGBvm3zt+JREZgt5+HFgbVRFQ8b3IzN8f4GX4MUFl/W0GHAJQIBEkj8cCgNQYr
	4o+kW93srfG25+sfV1ZZG0+syqgfel4UhyISEJoNzcvKSUYmcsyxETZD3dV9CM7v7dvPmYz3bMO
	0Xr4o9znAyROY4/J5TDtBlmlKaNKUa+ahV6dFUrcMlgrnB0K7un7u0TNYtqOStpbHKCG8PnVbjU
	LxOYCdHexZSRJzRiMmoSJ3fJTYmoo6b+b4rJrZ0Ha1CC9VEXclKFrj1N5lCHlUd+xQK7UhD6Y2Q
	n7Fv0qiq1Z3fhJmzX6ZL9kGVeccwxViOWHtgioGV6KQ0yiG2bvR/gV2nzAv6cwa714Q/7gxCZEY
	QMXisV0/6O+ac3YphmfmGTClOctIhwbq4pkqmr7C11KnwtqSzDt0JKbfyHT9ysHhI0Q8eDiMY=
X-Received: by 2002:a17:90b:39ac:b0:39e:2f57:67c7 with SMTP id 98e67ed59e1d1-3a4d102d0eamr766006a91.3.1790763178922;
        Wed, 30 Sep 2026 03:12:58 -0700 (PDT)
Received: from laptop-of-k ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cb1919ecsm2799318a91.1.2026.09.30.03.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 03:12:58 -0700 (PDT)
From: Kun Ma <mk02092022@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kun Ma <mk02092022@gmail.com>
Subject: [PATCH BlueZ] audio: Fix stale AVDTP connecting state
Date: Wed, 30 Sep 2026 18:12:40 +0800
Message-ID: <20260930101242.43592-1-mk02092022@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a remote dual-role A2DP device reconnects autonomously, both sink
and source services transition to their respective CONNECTING states
upon AVDTP_SESSION_STATE_CONNECTING.

If the remote device only configures one direction (e.g. initiating a
stream from remote Source to local Sink), the unused direction's state
remains stuck in CONNECTING even after the underlying AVDTP session has
reached AVDTP_SESSION_STATE_CONNECTED.

Subsequently, when policy or userspace attempts to initiate audio
playback (e.g. via sink_connect() or source_connect()), the call fails
immediately with -EBUSY due to this stale CONNECTING state.

Fix this by only returning -EBUSY if the underlying AVDTP session is
actually still in AVDTP_SESSION_STATE_CONNECTING. In addition, check if
a stream already exists on that service to prevent concurrent stream
allocations while the session is connected.

Link: https://github.com/bluez/bluez/issues/2381
---
 profiles/audio/sink.c   | 6 +++++-
 profiles/audio/source.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 81d5a3a6b..3363f421f 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -281,7 +281,11 @@ int sink_connect(struct btd_service *service)
 	if (sink->connect_id > 0 || sink->disconnect_id > 0)
 		return -EBUSY;
 
-	if (sink->state == SINK_STATE_CONNECTING)
+	if (sink->state == SINK_STATE_CONNECTING &&
+	    sink->session_state == AVDTP_SESSION_STATE_CONNECTING)
+		return -EBUSY;
+
+	if (sink->stream)
 		return -EBUSY;
 
 	if (sink->stream_state >= AVDTP_STATE_OPEN)
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 6be4de74e..54f9c4a4e 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -282,7 +282,11 @@ int source_connect(struct btd_service *service)
 	if (source->connect_id > 0 || source->disconnect_id > 0)
 		return -EBUSY;
 
-	if (source->state == SOURCE_STATE_CONNECTING)
+	if (source->state == SOURCE_STATE_CONNECTING &&
+	    source->session_state == AVDTP_SESSION_STATE_CONNECTING)
+		return -EBUSY;
+
+	if (source->stream)
 		return -EBUSY;
 
 	if (source->stream_state >= AVDTP_STATE_OPEN)
-- 
2.55.0

