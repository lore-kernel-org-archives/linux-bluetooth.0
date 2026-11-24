Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526474;
	b=MovmADKJHydoWPNc7FAaST1arXev/BT2AL2WAbFZpDfggXMkdw5ZHm4vgwqdQoYVR46Z
	 +yMqmdvPdENdxmJqqJbpWsKN6x87aZy8AFEMEmqxcGbTjQ+RZkvcKR84FCnf3xBp3NlHD
	 WhIacd/vlU+McphCuNHWMkDTqJLIQp2C2ftbOxBP4hTRci3SyijBr63IEPoCff3dCy6WS
	 WPZWXSNSeyngvyjO9s4BRLR7fajalJss0Vi/MjpcjsYWCnALsuZOp7vxHPXYh8X/2JpCy
	 pJ3jkDgQ1N1TbHOkkGW0+MtSBCkuKMXamWlVPg6FiJ00bV9Ka8xKb6/g6vkpPVMNxVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mgkzoSoDllfe4Yk0ejZrRMoveQiBeEuwFfwqz8fIJI4=;
	b=hhrecjc8jMIxcQ0OHbZzv6iCGVq9bdAMoR5JCn3CDhkaz2fk8xCw7SRSDOwS3kd83kUE
	 nePIQxLp24kktHz51M0HbUQwHjClCAQ9TnD0QtAuXhUoHaMnutGa5JiE6bPZ8JsgSnzwS
	 rjzxGlJ9uuRoBAen30MqcBImzRZSkAoIBiNXYr2RYlbNMquTk8Ztc8yZHvbdL7SM1iRDS
	 7CH7sO60wqIkVGv/ROakI5TiRceJgy76f5VT5PJxONNJ2S3+06GXeySHfBjdkzUQ8KTbO
	 evdlN6L/6k00ANXGdnBkV83RNuGzI8vAwZpjtfPBGhoh7eZbbeJhCwNmIlKRODF6LYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=PA0i6rDy;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3A606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 13:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=PA0i6rDy
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4b52fcb410dso1014678f8f.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 05:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795526472; x=1796131272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mgkzoSoDllfe4Yk0ejZrRMoveQiBeEuwFfwqz8fIJI4=;
        b=PA0i6rDyLPR/u15gH17IwRcGsHbZQHiT/S293Oyexy3zV4Iznz0UbHAgMfkrtTvjAz
         ojQj319Sr2L5r2jEOfLt15rqtlbvaTNq6aWpM3yGrbSCs+eKUV9+Nv0jWiGAsjMVNT8B
         DlE2eRZrokfVTfvo8SJ9NZvpTnUzkBHJ16tl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526472; x=1796131272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mgkzoSoDllfe4Yk0ejZrRMoveQiBeEuwFfwqz8fIJI4=;
        b=LixacIdfsf2+EFLjc9qJbr7Y96x+JKwDxEpdAjiLRgY83+or+2nUWgbxXAqyUL+qnO
         aj7A4fk1ncUdGl8aQ5gpC9Fo+qgZorbPt4VxXxxsOuEnDBspmR6kt9e8NRb/yB8oPufw
         O58mz5hD4nUZUVnThWSuPowoSQLLOkkjMHerQ7nsvogcqj8g5fU5SJLrtla87NqygXs4
         t2KTeJeaERHMUU6QBU03Hbe8ZYt/OupI/SoI5/S6f3tHG/Jbs0+SgPjn9Skzty+UuF1w
         5N6SZlVsQKZCQBnb3sJplFOHDccmgbdPan+nLsaFOaUObx72gqT4yBM1gMruc6PIkIW0
         /AqQ==
X-Gm-Message-State: APuU4Z8N9N1KwQyCeagdKtm3ooGrV2e5wjXLbiAeTDjSKo6pLx+55ang
	R+qRj3KVN80YyRJHPpZ4T9INL5muG+EoKYlojHt0n+FZQn8Zc053vSI5/bthZAOEfqFLgJ0iTbm
	WwJpx
X-Gm-Gg: AZFdTZdIKhqWVpKapfm1A6h121WcsR66WPF3rrCP0zbWN6KI4Hdb1LRdZWW7XfniGYA
	zXcPJVFzAX+Av03QQCzNgHOlFjs8TCg3RHIz5UllMgFs2JZFxHbxNJ8vBAGAR+Cc1asApc3gLa+
	bGgcYDtNq/bjMSigHsDkPgcCYq2AQ/O7V4kQJKYcEyoUq2w2MHpQc8fYOrTtQCrwLRyVVfoMiaT
	cqmbajWsvw+V+qh1SyBCH+UMRBPT8VuGImuWYFEKIZfNxqKsllj3xuh7HlIHP0X/818VXVAXah9
	b6P7dkk+tdrNr9+cHcddyXUAiFX+Pn/JM/iRRjh+CRfTd4oa/SZw1w8oj1QrLTATrEMmcEAUhBC
	oTjVAJqW0QtnxkzJ6S8vv9jjLJxZl65L13B3UsXjEuEGLImjCmlnTfPg/S4LDcVjL5uH8XDzx6J
	r/10i2Z+I6Uz289kPCb54PFg4eVZ4i9FD/yDVvaV3/m8tG5vie3C1yaUrfIrU93siFWpTMuZryu
	IroZ5FgZEbrIQbJsmI3RzWZvFvJNs3GhUy7xM8ZoLc/+fiO+AK19LYqqnVWvHk3xesHgTt8IJMH
	Kj/QSrjPi/MJ120+uCyp2N3bb/HXw4KpMsKBE6hU8O0ZypAs+Q==
X-Received: by 2002:a05:6000:1acc:b0:4a7:a8f:5297 with SMTP id ffacd0b85a97d-4aa57b91bbcmr33868959f8f.19.1795526471938;
        Tue, 24 Nov 2026 05:21:11 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b33a596f9csm8731934f8f.12.2026.11.24.05.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:21:11 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ] a2dp: Don't suspend a sink stream on our own
Date: Tue, 24 Nov 2026 14:21:08 +0100
Message-ID: <20261124132108.3899705-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the remote source starts a stream that no transport owner takes
within 5 seconds, or the owner goes away without Release(), BlueZ
suspends the stream. Some phones then wait for us to resume it and
never start it again. PTS GAVDP/ACP/APP/TRC/BV-02-C fails the same way.

Leave suspending a sink stream to the remote source. Release() still
suspends it, and source streams keep the timer.
---
 profiles/audio/a2dp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 3eb3e3bfd..d4d100986 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1409,7 +1409,10 @@ static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!a2dp_stream)
 		return FALSE;
 
-	if (!a2dp_stream->locked)
+	/* Leave suspending a sink stream to the remote source: some phones
+	 * wait for us to resume a stream we suspended.
+	 */
+	if (!a2dp_stream->locked && a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE)
 		a2dp_stream->suspend_timer = timeout_add_seconds(
 					SUSPEND_TIMEOUT,
 					(timeout_func_t) suspend_timeout,
@@ -3604,7 +3607,8 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 		/* Set timer here */
 		break;
 	case AVDTP_STATE_STREAMING:
-		if (avdtp_suspend(session, stream->stream) == 0)
+		if (sep->type == AVDTP_SEP_TYPE_SOURCE &&
+				avdtp_suspend(session, stream->stream) == 0)
 			stream->suspending = TRUE;
 		break;
 	case AVDTP_STATE_IDLE:

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

