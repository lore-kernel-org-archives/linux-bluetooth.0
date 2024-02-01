Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF9C84FD8
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814635; cv=none; b=HMZiRbTYnTu8moqZN9aW0yUarSw2GWLyylej0x7kJ+hY/nZ466PfQoi+SnbWKu0YLDncSgqYH2nb5I0ZC2M98tQqQSQNNtZr434uhqbyH+51MhToSMoeUB0gkVl7VHr5xVa7mGd3ivZwhWqe8F0G4CvA+WE0aLZUKDQudvE1L3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814635; c=relaxed/simple;
	bh=uM8Gep3U13CUEwBIglcJfDvyNyo5H9RIH/fAek0o15c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7A7rlFrXqyPnRY+A45L/OVo5nLjwthrfjT7Y4qv2nv8MD5Yof+C2KxUNCn3X4BwxQGI2EerGiKu+xT0c1Di3mFKgHd1ZqsXAHQfM0C4v+6BUV67rGwTeIw0YbCA1Abw0H/EyMNGe0mSoLaBi1dF85CRuJT0klxPxnE+/thnuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTAR8xzw; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTAR8xzw"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e133d5271cso628550a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706814632; x=1707419432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIl/eGvO+Rr3euE6aD0rfqQ1CAoMMey4PPG/IxwCfDU=;
        b=PTAR8xzwG91cbyQlSJnv+IaiOCrCkoW9i5wUOgnkiM5fi3rVLHtVTSZk0TmBxafwWa
         F5gUP3WKFqU9rjlPtTaA6ZamJzew1n2CNPzJZhgJLoFRlA0u8+0Ig11oB0Hpvzva4wUQ
         n95NgDVgxr/TcwEdIG2Yg0MLV1WQiZBVB8S4Qndxp/XPDQ76iyHlqBjgcyg6CrwSJwFR
         1kQVgijfQBBXHmjCvTNjxPpkr6kc0AqNL9mVPkRyOLYWx9KZ00gE7zjPdSi2eI49PByk
         tQqiLJEisQBDDsxVzhM5Dg98mk3jlAMd992RfZuwhVnrUY7suyFf8KRtzTKg3bVELUDx
         cTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706814632; x=1707419432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIl/eGvO+Rr3euE6aD0rfqQ1CAoMMey4PPG/IxwCfDU=;
        b=bNa2VxJvJqGZ6faMNXqSmwdI0IU7CQzJuaaAA77PNsYAM9A+29jmg3WN3ac1g5CH2z
         WBAD0g6wm/Zroageg1Mva1eBp+ZZbLi+FfrubYssp4OiHkkRXv0swzh/mFWaX61wUglE
         N+JbW4Xs6GOi/yzDx6UQsqtTZ3p1LKgGwWXiSBFCV4gYsOGcPDr8s51FyDXrNJHj5hzE
         cLeCRGRwL88QdSSHtrv0P8O4H8q4H3/lUusxsIFyYvlt9ecbcEO/c0c1gLp7A0bY7dJ3
         uQcStNpD2wO4X595s+47geekI6OC2sgmvfpy0ht7CL1mlj34BeHwOmScfFFiXefeh+AW
         q14A==
X-Gm-Message-State: AOJu0Yz/V5hGP3FyjsfUYn2xo0Udl4NOwz+FqvTxe8HTlsAv0pZsXAfv
	0J0VXx3+QUZpczFlVtGMr5gzQ2759rdQ3ev8PV0pp4W+ixFWm2vvY0874x98
X-Google-Smtp-Source: AGHT+IE4L75FrR3FHXaD41QLfnkDVdezCXtHq8Us/L27p12+zg9H1hnxufUkeqLQSzF3aJLAMjQu+Q==
X-Received: by 2002:a9d:618e:0:b0:6e1:29f3:6fbd with SMTP id g14-20020a9d618e000000b006e129f36fbdmr5605440otk.22.1706814632091;
        Thu, 01 Feb 2024 11:10:32 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db16-20020a056130239000b007d2e2f14bd4sm35912uab.29.2024.02.01.11.10.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 11:10:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/8] shared/bap: Make broadcast disable and release more consistent
Date: Thu,  1 Feb 2024 14:10:16 -0500
Message-ID: <20240201191016.1122194-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201191016.1122194-1-luiz.dentz@gmail.com>
References: <20240201191016.1122194-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_bap_stream_disable and bt_bap_stream_release use disabling
and releasing states to be more consistent with their procedures.
---
 src/shared/bap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f2d2ca09bb24..ac17eea13556 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1377,10 +1377,14 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 	case BT_ASCS_ASE_STATE_IDLE:
 		bap_stream_detach(stream);
 		break;
-	case BT_ASCS_ASE_STATE_RELEASING:
+	case BT_ASCS_ASE_STATE_DISABLING:
 		bap_stream_io_detach(stream);
 		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_QOS);
 		break;
+	case BT_ASCS_ASE_STATE_RELEASING:
+		bap_stream_io_detach(stream);
+		stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_IDLE);
+		break;
 	}
 
 	bt_bap_unref(bap);
@@ -5064,7 +5068,7 @@ unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
 
 	case BT_BAP_STREAM_TYPE_BCAST:
 		stream_set_state_broadcast(stream,
-					BT_BAP_STREAM_STATE_RELEASING);
+					BT_BAP_STREAM_STATE_DISABLING);
 		return 1;
 	}
 
@@ -5161,11 +5165,8 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 
 	/* If stream is broadcast, no BT_ASCS_RELEASE is required */
 	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		if (!bap_stream_valid(stream)) {
-			stream_set_state_broadcast(stream,
-					BT_BAP_STREAM_STATE_IDLE);
-			stream = NULL;
-		}
+		stream_set_state_broadcast(stream,
+					BT_BAP_STREAM_STATE_RELEASING);
 		return 0;
 	}
 
-- 
2.43.0

