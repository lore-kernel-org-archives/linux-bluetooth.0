Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D220CCF7
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 20:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418177; cv=none; b=Z9Lia176+cqq1iEjZagx50QWUA0tNrMwDb9rHxnRY6GZEb9D+nmxru34gTqIopG2/omZ0WWgw0LOl2AiRyXwU8JdfVtvkB2tYbVFLrR/jyxCRwOsaC8mHKeo9GacAw93o0j0jJqHdp5OjbavmP9XLODDsuV2k8KJOMmIe33id90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418177; c=relaxed/simple;
	bh=PeAzhENfQfee5EWxQIt8YDPfsBI+Z/9byNwjmqDBHBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lrQQCHfSDQ3syxQ3PnxLYCp8Jtt0tQkWg7L67nd+7CTSWgFhGI6iWbXQOig/XO35PLHnEMISaFFoqRJ9JceFhHK684aMAt6tKydLE6OaVxXWrAhS5CquBQNnJ9RpvfrFhYe5alGPl2FPz4uEyRNpRSTQ8hnPRU9i6XjDNYJ3vjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwvCbQtB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwvCbQtB"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so342167a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2024 13:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728418174; x=1729022974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4LqLabfwfdChDNDindRIOvcr+6Tak8IIeu+4JDFbXq4=;
        b=lwvCbQtB7uY+VgdeE/D0MQbBTiWot0H+9QPQPtlqy9PoLAMxEUqyu6cnCoSbyPgBXr
         6qSRDzZjYSKGr+/E8TQhCEVXWzRHc/JILb9zQBhYTpK49sulrUwGIimgswAfHfysy7Oa
         XyjjhK35tF1/+csrEiVOuYxtI3/lcCQOc+Q46WMdA5jPVmljdCS0DCbAx9zPnWCkNwBC
         /mwIcM3dtI9a0VRkNohl8MD4zUV15chXhQUV4ATuLbwnjVIcvNf9b24BEKw6W7s/8vMq
         dzi61rKTbUzIw0z4eqDGvnjlLvw6w83euGX9WfTQfhriqCJprP7UJQqvMa2dPM55g+Zb
         YwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728418174; x=1729022974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LqLabfwfdChDNDindRIOvcr+6Tak8IIeu+4JDFbXq4=;
        b=PqT0q76mVHwAzQFfg4/B4rxVE/te+4uU8CSLCIQPDHxTlhuAQ+xQ1ypL/I13WiWqGe
         ullOEHNEkeWvEyQUVnMObyd+GQVsFME9q3qTYGZtXJzctA1ar5tAD75g1BCF2y61MGAv
         EPmolbPJPFcSJnNx2lwPsx6J1MSzzvGlngjih3iRWbObk0wArFJu0DE5u9t5wNhHS4CY
         gnFZdjF9k9RUBSM8bKC2l5unJ3GRk3NwkXOU4Ur6hvqebwoF++68ZHHVg2Rnocx7YTFe
         H0PUdVdvGDY4pzxbCV4ClfeRNgsZnxQ9l51nWr2DBIpkwwdP3R39Stclg4aZqrkRKjqx
         mt3g==
X-Gm-Message-State: AOJu0YxR6S+FZuGmVmyP0lIApkWzwysPsPaW1Rg7UXQJyM+uFsV6GDYB
	NoYq6nkkkerjb84VYrnd2JWZtzVG4hpxA7XdKIGgBkyGGlFAhly3aoiaEg==
X-Google-Smtp-Source: AGHT+IGXpdYOMRG7uYjfPMZjozA4RA0+c+yOLOYn7abXw+dEtoOWM/Qm3eSgRlVe6y67+FZ7Qsfu8g==
X-Received: by 2002:a05:6402:3582:b0:5c8:a257:a33b with SMTP id 4fb4d7f45d1cf-5c91cf7f9ffmr348786a12.3.1728418173431;
        Tue, 08 Oct 2024 13:09:33 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.156.nat.ftth.dynamic.t-mobile.pl. [46.205.194.156])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05acccbsm4608472a12.32.2024.10.08.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:09:32 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] transport: Delay existence based on delay reporting capability
Date: Tue,  8 Oct 2024 22:09:26 +0200
Message-Id: <20241008200926.428679-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case when the existence of the delay property is based on its value
not being zero it is not possible to read the delay if sink sets it to
zero on purpose (or it was not updated by the sink at all). However,
client might expect it to be readable, if SEP reports delay reporting
as available.

Instead of checking the value, we should check the capabilities of
the AVDTP stream. Also, by doing that we can allow this property to
be writable in the future - the exists() callback is used in the
properties_set() function as well.
---
 profiles/audio/avdtp.c     |  4 ++++
 profiles/audio/avdtp.h     |  1 +
 profiles/audio/transport.c | 23 ++++++++++++++++++-----
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 448ee2730..289b40827 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3203,6 +3203,10 @@ gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 	return TRUE;
 }
 
+gboolean avdtp_stream_has_delay_reporting(struct avdtp_stream *stream) {
+	return stream->delay_reporting;
+}
+
 struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 						struct avdtp_stream *stream)
 {
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 102a2603e..500b814ac 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -252,6 +252,7 @@ struct avdtp_service_capability *avdtp_stream_get_codec(
 						struct avdtp_stream *stream);
 gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 					GSList *caps);
+gboolean avdtp_stream_has_delay_reporting(struct avdtp_stream *stream);
 struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
 						struct avdtp_stream *stream);
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index caa7287db..1a65ec6f9 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -377,13 +377,22 @@ static gboolean media_transport_set_fd(struct media_transport *transport,
 	return TRUE;
 }
 
+static struct avdtp_stream *
+transport_a2dp_get_stream(struct media_transport *transport)
+{
+	struct media_endpoint *endpoint = transport->endpoint;
+	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
+	struct avdtp_stream *stream = a2dp_sep_get_stream(sep);
+
+	return stream;
+}
+
 static void a2dp_resume_complete(struct avdtp *session, int err,
 							void *user_data)
 {
 	struct media_owner *owner = user_data;
 	struct media_request *req = owner->pending;
 	struct media_transport *transport = owner->transport;
-	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
 	struct avdtp_stream *stream;
 	int fd;
 	uint16_t imtu, omtu;
@@ -394,7 +403,7 @@ static void a2dp_resume_complete(struct avdtp *session, int err,
 	if (err)
 		goto fail;
 
-	stream = a2dp_sep_get_stream(sep);
+	stream = transport_a2dp_get_stream(transport);
 	if (stream == NULL)
 		goto fail;
 
@@ -852,9 +861,13 @@ static gboolean delay_reporting_exists(const GDBusPropertyTable *property,
 							void *data)
 {
 	struct media_transport *transport = data;
-	struct a2dp_transport *a2dp = transport->data;
+	struct avdtp_stream *stream;
+
+	stream = media_transport_get_stream(transport);
+	if (stream == NULL)
+		return FALSE;
 
-	return a2dp->delay != 0;
+	return avdtp_stream_has_delay_reporting(stream);
 }
 
 static gboolean get_delay_reporting(const GDBusPropertyTable *property,
@@ -2023,7 +2036,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 #define A2DP_OPS(_uuid, _init, _set_volume, _destroy) \
 	TRANSPORT_OPS(_uuid, transport_a2dp_properties, NULL, NULL, _init, \
 			transport_a2dp_resume, transport_a2dp_suspend, \
-			transport_a2dp_cancel, NULL, NULL, \
+			transport_a2dp_cancel, NULL, transport_a2dp_get_stream, \
 			transport_a2dp_get_volume, _set_volume, \
 			_destroy)
 
-- 
2.39.5

