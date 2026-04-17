Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0D3AEF3A
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415775; cv=none; b=hmyqcGbYke42wOUf7FADdSKCcTSkmbroQjvf5pEtm3ozB+3Nefh3xaX8I5q6maKuUGW7h4bdBdLyR2E5qxFGLUXsWsHB3B/HItCoDgIO5hkmwOpISVa0wlWils0AmJ92OydLaxcI+I7YvykK+dzwNujQpVqzOdYIYhU0hg6TsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415775; c=relaxed/simple;
	bh=AXIFSty6tNkaTpg/pkiGnWn7oUBFqgrc+pIdA30Zn1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2Dwh0U3l+gn1RimTKyNERXwzDKY2rteVnyqlyafDQ4IKkNDmqwDN8UVHvT4KNskR3xUOKSYSZeleZ0b8B08/rGCuWcD50VB6j0Ep/GYZsMcgzg9NbdhuEcaeAe1Vs/Mace8T0cEaDXAH3Tm6dI6h13eHVZXZO5ljlURndgckng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=XIskgPER; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="XIskgPER"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ba840146so4492615e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776415771; x=1777020571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg5Z9PvYtW+BRn3/8f5dQqLI6p7gVe1iHnqEFgYnoAc=;
        b=XIskgPERjDmAVMrojprLleddI3pEtGwvLWJnOPZayvpOuBEc33+OuabJBcahtoTKAt
         R/MyAwQbgirDzgvBBfXVzJ8he+BvhQk9HfTXlErzblaYvCSVLprhiH8sv1DT59+8LAYo
         cB/6h3P/8goVS/wz5YCo48FzijH+ps7n3Q0wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776415771; x=1777020571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jg5Z9PvYtW+BRn3/8f5dQqLI6p7gVe1iHnqEFgYnoAc=;
        b=DHPJTyBbykfKgtmvdUQtgdz+6R2ZeFP8m/okdJNlffen9X6zA/3MuZMZGsQgyVKl1b
         AeqC04hpr/nTh3mHuNZV/U3DtHJK4+x8RqCArsF9ysKwM69qqB0Kxz0KukvjQ+dgV+c+
         UgYkFAnUGbQW2K73j7kjrWwDS/AhhWLXev+ZCSPfJ07pGMlfGh7bGdXRV4jshUs60k1g
         3phDuY/do2/m71Fhkr2reBJMXvMirz6FeoXk7yhKkEds8FA1/8b7Fx48URzvnabOgQnC
         2E5E/gjBX2MUXmxuvkWx8jUMYz4D3qiVa0U48KfG3SsPDAo6MUGU26MUrxsP5FxfSOpO
         EBQQ==
X-Gm-Message-State: AOJu0Yx+QAMAwxU3bKLvrLKI+hoOvexYX9yOiSG/+gnsoy60CUV5otoo
	t08n1xn34Tp8I6cqbrEDWfeZ4U7fPsXjwENMpSs9oagyeli7sqObo2GGA+SnzYfRsA5SalmhI+o
	Z+U00gQ==
X-Gm-Gg: AeBDieuHY3L31uiJnJZVOMMF5P8T/Q7KChHw0qyN0ORa2Vb/tlIWoTSoDBk/qahozxq
	OxQX9d+gyMgF80v1zEypH3tM65+83EK8ltAQkwEWwSYEYpnLxzycdRu7LS52SWzGN5o+Vj7fzVN
	EugTH0pWhZWu6Q21phrY3XtgTeVel0McSxYbW0XMAs1EyiHkJRML4Dw1enMark0QqIBJx7BO1yt
	cgFIzsb7YJrG0m9yjmH0bVIhtLaOtEVzBrRnwD6uz4Kz7mx00sHloEdWIElvJINIelzfEjVa3QH
	/uxFse2WA+uDPalNbiqtle2kZDBZQSUL5LWIrv0mqCoLj9gZwoslM6qGkTilV3Sz6ko141KB5wf
	e8DqdykP73OpFLUhhUD31TpBDNEmH8KbciVL1BkUSQ2gGaop1UQxf0YL+oXT430ONqdyn4vGayI
	0ltwighQFN9+iVlRA+kHQwVFdI4JMmy73xSVSRw+l7w+u7jwlf7KQ6t1iUy6YmsLs4qoS4pyfsR
	FsWtV0qc2JFzLF7
X-Received: by 2002:a05:600c:46cb:b0:488:a723:ea53 with SMTP id 5b1f17b1804b1-488fb744fbemr26985765e9.7.1776415771281;
        Fri, 17 Apr 2026 01:49:31 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f8c3sm26315095e9.2.2026.04.17.01.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:49:31 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 4/4] audio: update QoS dbus property after it is set
Date: Fri, 17 Apr 2026 10:48:10 +0200
Message-ID: <20260417084809.3633687-6-michal.dzik@streamunlimited.com>
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

Dbus set and get on QoS property use different data:
- get uses bap->qos
- set uses bap->stream->qos
This works, because bap->qos is a copy of bap->stream->qos. The only
issue is when we set this property and then try to get it. We see old, not
updated copy. Simply calling bap_update_bcast_qos() fixes the problem.
---
 profiles/audio/transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 81a63c365..5c2a2777e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1556,6 +1556,8 @@ static void bcast_qos_set(void *user_data, int err)
 					"Failed to set Broadcast Code");
 }
 
+static void bap_update_bcast_qos(const struct media_transport *transport);
+
 static void set_bcast_qos(const GDBusPropertyTable *property,
 			DBusMessageIter *dict, GDBusPendingPropertySet id,
 			void *data)
@@ -1604,6 +1606,7 @@ static void set_bcast_qos(const GDBusPropertyTable *property,
 	}
 
 	bt_bap_stream_qos(bap->stream, bap_qos, NULL, NULL);
+	bap_update_bcast_qos(transport);
 	g_dbus_pending_property_success(id);
 }
 
-- 
2.43.0

