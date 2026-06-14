Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70642F3C0E
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781430975; cv=none; b=DB26rY2OvakGFEBSbBJo/8k9dFu9xo6BdXMU3AzffNXOlcuaUScNfvGu+lbUnOIX1MqEB+cITBGEyH4jl2mmDcBz1S44uFejuOEe3RltDDeu5k1GpN15CxclDLa/CtntSLBkYVbel4D8xjdcy3i+KaLu3RI+PYdNp4fhHnKcn5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781430975; c=relaxed/simple;
	bh=v5UDkw/TA8aWQBg+MDXiy8H6EVo2kl5JaqwvYfrbmUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN1NrZ7Rr7rLp5WHmXY22bvqjc/8jRy4PPkzTIHRaOCUVKUZKdKxwQn/WqkP3ppzfznLGmqjVPoj5JQrXjlNS1FsheKwK12FMHlZoe7itSb9nP3WplUK9g6l45AFn9VSwIy2iKdPsM4SnExb7Rn5PC2Cjl28mNMV52sk8+fTAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=Eh4KuEAg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="Eh4KuEAg"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490afc47455so9716335e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781430972; x=1782035772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaNJFrflklaiQTweNN7vamkhVslHOXzqEKdbVjpl2sk=;
        b=Eh4KuEAgj/EcFzE/b+2fvfGurfncciNDZJTSvx3UwcdxcdUzxoGpfvDhgFKDvjXqJQ
         dZ846om+s12v6DDj9uBBMlru0hiHJ/sUm65a/8wEaO1RhmRDTRBGyJPOXc3gsHnA70p5
         jA5ovctaaFcYOumStFPVsIU5qKcSSZV8uRl6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781430972; x=1782035772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DaNJFrflklaiQTweNN7vamkhVslHOXzqEKdbVjpl2sk=;
        b=I+knJXeI2ohEZuyJ5QEEkioOfT+cYvZJl6Uh3WfJhMEehKwxy7RcQSPs7BMzOc4+gZ
         IZeA4mDPTfLVxUL0QXPL3ncu9TliLysTMJHkFXpSZvvLpG/9kF6/YrfMS0Ds0axWXdgo
         qGel1us5ZD/sYG9yvnauqBMnZ49XCbMrSM2PkfU9bky1bT0SewUpUkNXCLGKCYfaMum+
         LIGQytpQcQdP+znsNJoY0lrLncMSx5HKxram+25RNrj6ikyeOowecRT9Y0sBZDcaNtql
         qgwXhSpTeJ7UvzibA4b+Sj3zGXwjigLDG3+D4C7OZRJUBdIWsLN3UsaYL31wdPjrRZjA
         hgIg==
X-Gm-Message-State: AOJu0YxxhLofEfWmD/XQ//YLvTOlX37qmnJUnST3q8IOv8JOaEdghLKL
	il0ZvQUG1YffZO8yVhwWgkn+92mHM8lMVBHh9+bCTBW5kA4fb+Q5b0qpyvDTUMekXzUuYvvOEUj
	uTe1D
X-Gm-Gg: Acq92OHowXULJW/WngbuXyuyz8KLvUiMQnRasJcwL7e4la0WMCtw79xSzU399hn5HN/
	EHRk3TA+JankUpvxrB9iD1rUWZU3A0VCBKi+9T8uKXAR8mkSdl25IMQHceVxzZq0JyOyRSaPfPq
	iAMmznOrkihqSjl9lHCgKHvD047IgkJl9RjoT5L0ddayhHYqZ+SrSWVQij/gS5yNyExFvXe9E/L
	bpuv+4DSIzsTtDvYdUV2J78e9wnYjt+du9hhKnTj/fq98wnkgS74QlawGpUH4Xxm+p7u87QgW3M
	soY2760PPftWhS5N/rIs7cjLj4JlOlx/wDUUV+HtEOIh2z9TQ5lr/X75AkfTuk7ty8I1rFlrwH5
	RUXKOBxdaXaMi0Cv5KG6nHQGINsYArpM265sx9G/+3E94IQ9XoDEzb01T0o35j5Lku8/B+BKY1n
	12VqkwDPekJqaOzBGvQhlV4UVr5HmuLc9ZGYnsdU0Ilcpw
X-Received: by 2002:a05:600c:4fc5:b0:490:e5c1:b8b9 with SMTP id 5b1f17b1804b1-490ec3388c8mr122957775e9.0.1781430972292;
        Sun, 14 Jun 2026 02:56:12 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:eb61:bfa9:279d:6464])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922033dd3esm144084915e9.8.2026.06.14.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 02:56:12 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 2/2] shared/bap: Don't link server ucast streams before CIS IDs are assigned
Date: Sun, 14 Jun 2026 11:55:20 +0200
Message-ID: <20260614095520.1090106-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260614095520.1090106-1-simon.mikuda@streamunlimited.com>
References: <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com>
 <20260614095520.1090106-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
are unset in Codec Configured state, so a Sink and Source bound for
different CISes get linked. The stray link later propagates a
disconnect to the wrong ASE and breaks Receiver Start Ready.

Skip linking until QoS Configured assigns the IDs.

Fixes PTS test BAP/USR/STR/BV-362-C
---
 src/shared/bap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 41139181b..935387a76 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2679,6 +2679,15 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
 			stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
+	/* The server pairs Sink and Source by matching CIG/CIS, but those are
+	 * unset until QoS Configured, so it would link unrelated ASEs (CIS 0
+	 * is otherwise a valid ID). Clients gate linking on the lock instead.
+	 */
+	if (!stream->client &&
+			(stream->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET ||
+			link->qos.ucast.cis_id == BT_ISO_QOS_CIS_UNSET))
+		return -EINVAL;
+
 	if (stream->client && !(stream->locked && link->locked))
 		return -EINVAL;
 
-- 
2.43.0

