Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626147;
	b=Fkr2ro0497timYbSTYWtpixq4a7RjLbcvvZfvq1Xp0MCBafMqBCCDjGah2NvZ33nhkxr
	 m7dGFfIjA88rmhi6bb5myn+bG9eDLk4bG3DE8SxYWZgrDaociYouH+VtcoNa4mBWNrvzV
	 KB4dR7qAOBhx35rlMxwbyJ2/BpJWINIWZ1egfaemaKBNoUbkUCn81TykLaT/jjuH5sPyl
	 dIdBIkfbxIGlynhbSnIj5Xopr6xEzi+wfRqx2hxgIjO+ipCKz6cAMAx+D48B8ScyuBpZt
	 2Gcz8MWCiGfic2gNeCZ66Qbn3UVIty6Yyl4nXa0E/QhUd8JcExFfurGoC53pn2qY2jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SErjOTrSGSDMiLGjixQ2gCs0KfJD9qp9egXWIClx/iM=;
	b=TS5faT/FpsZxNof7k1rOdFG3L3m2Za08P45n3Ko0bKwdIB2wwsZMYKA1RnqPhQQpO4W8
	 tIUfa27ulkK2SyILsYvbl7f7GhpXO7Cpxjh3X2s2ybdb5JwWFAM6NvtcNtQMnk/nFAsyU
	 z73ts/Hd6PkYQkdxC9Rnf/YnOtt0RUbudw3XlCt+2ZoEXtkLxSg4N9EeXF7BvH+RK4SPP
	 ySPULocRDOtTSNFpByJQ/lCxK2aTGzOvAdnuJ5Xa7VlczSh7oi1BTCWrWquf5uamSDh+B
	 SaBHPFbRklsfFRU7qY7TLrb4kwfnCmeiZ86PgdmvE2k+/0I1T4jFG/QO29tAnKNfGDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=a97pRdpc;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72500606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72500606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=a97pRdpc
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e46e449e8so3902641f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626146; x=1796230946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SErjOTrSGSDMiLGjixQ2gCs0KfJD9qp9egXWIClx/iM=;
        b=a97pRdpcHICr6Rnkb4JvtGhIcJWtRyZpiUB0VKsxp1ccqGWzRYuuIzqyZgh+iwuWYY
         7+XA/7FrxxapbacvUfrekhr4cpF5Hkzt9oruf+016gs2CEuiPgFW5tFvLA8Swpp2Y+UI
         HXV+tG+mSXrW950DybabP2/RFKHaYapgF1SlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626146; x=1796230946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SErjOTrSGSDMiLGjixQ2gCs0KfJD9qp9egXWIClx/iM=;
        b=UY5RRUJEZWAihzwI/HDKDADSKFiVyvJLwo0no5jPx7Sg2AcJ/0oxc7uPOOaRF5s/f1
         4A7R8TSeygdv7DpZIwgk0JhmpvoAz85ZcrsEmRryKUMP+f3fO2YTbItYrbODM9vbKyI1
         eezacNBFjoRexdeaaX7aaAeQ57KuX7i7ch0sUWLlLcOKDoL/hYKMAZLCTC7kKlw14Rdg
         j2bWX94+0PhS7uqL0C8ZboQX3upU8o2trezkImQigtPYH6leTGvvjqPru+LRjSwANuKs
         eUn7SrvAAyg4PvHgHnLWE1Qfe0ECj1GTTKwTcVjQeXo9dPoR+V1RoDEjwphfX7wqbjhc
         s3sA==
X-Gm-Message-State: APuU4Z85bYJbgAOJwUL4NSXweWB1yvpt0BcZbxSEwnGiEdJSC7WIzIVt
	Tl12VDvS7gWxYS3JY+DruYDlNIVjRfr4Uxs6U+yp1vhh722u5WKSWOgtWCMLMMI3KzBH2WpC1ZR
	cl0io
X-Gm-Gg: AZFdTZeZIB8MXpbrMv3qhrAINMGu3oL3NmvE6necapSnw5ooPCVyIA02DH3JdqSoTT3
	UFjRdnY/xg+d7hi2LAIoq92l6+liYBkyv52qNS1mt/55uy61amR5I7I8r8zHEspJT+dKAmzAd2d
	ujW60W+3cAjd8wRJe2e6p4ZtkWUJ8/hMmmn6nW9f4bpLOVM8qbl49BQpxSV7rm0JaKi9xxO85PU
	WIP+JTvXmc58CPYvfd6+PYHZR53OfPP2rk88vL5+mVXlnfoebvp2uDXH7No0hiofHYAPaj6wSNu
	YMN1EsqiCqQRufPamV1LnvI+/03R/6koxWzin/YnCT7e+tl9eGdXJCqKmxTiNvtFq+HmfFC1u+B
	QABmCZIt1j1jMCy9snE1tTCjaFa/qkgsmhUYf1qMIaUOvMKsvL49SiU6rtb5ikVwFuqz4bt23RP
	5e4cft2Plp85utiH+Staos8YE9BXfM94ZkDxVHE53mgIeL5MGZholZcReOW+HsfXMYyiRUNu0sH
	RrW9fkBEae+VVX8gksJy10rjdqpqhyVkh1ZBCyXNRnyi23pn5WILb54PKJ9enqYh5BUFFYDRaFd
	JNo2RvamN9jWtIT58qIDFITnQW5ni8ow3Dwjj/goAU2WyctLvQ==
X-Received: by 2002:a5d:64c9:0:b0:4b3:f000:1bdc with SMTP id ffacd0b85a97d-4b3f0001c13mr17325814f8f.45.1795626145853;
        Wed, 25 Nov 2026 09:02:25 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b9add26sm35745748f8f.44.2026.11.25.09.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:25 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2] a2dp: Don't suspend a sink stream on our own
Date: Wed, 25 Nov 2026 18:02:24 +0100
Message-ID: <20261125170224.1648830-1-simon.mikuda@streamunlimited.com>
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
suspends it, and source streams keep the timer. A sink transport whose
owner goes away while the stream plays is now pending, not idle, so it
can be acquired again.

Assisted-by: Claude:claude-opus-5-5
---
Changes in v2:
- transport: a sink transport whose owner goes away while the stream
  plays is pending, not idle, so TryAcquire() works again

 profiles/audio/a2dp.c      |  8 ++++++--
 profiles/audio/transport.c | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

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
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index ad2fc2c1c..0e22e1188 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -458,6 +458,7 @@ static guint transport_a2dp_suspend(struct media_transport *transport,
 	struct a2dp_transport *a2dp = transport->data;
 	struct media_endpoint *endpoint = transport->endpoint;
 	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
+	struct avdtp_stream *stream;
 
 	if (owner != NULL) {
 		if (a2dp->resume_id) {
@@ -469,7 +470,17 @@ static guint transport_a2dp_suspend(struct media_transport *transport,
 									owner);
 	}
 
-	transport_set_state(transport, TRANSPORT_STATE_IDLE);
+	/* A sink stream is left for the remote to suspend: until then it is
+	 * playing, just not acquired.
+	 */
+	stream = transport_a2dp_get_stream(transport);
+
+	if (!strcmp(media_endpoint_get_uuid(endpoint), A2DP_SINK_UUID) &&
+			avdtp_stream_get_state(stream) == AVDTP_STATE_STREAMING)
+		transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	else
+		transport_set_state(transport, TRANSPORT_STATE_IDLE);
+
 	a2dp_sep_unlock(sep, a2dp->session);
 
 	return 0;

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

