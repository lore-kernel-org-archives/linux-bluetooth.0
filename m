Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7301A262D
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742980049; cv=none; b=C462DIKdxDX0SFdpWRbVF5QM4I8KMmwqMLHU7VCGAj5rZ0YtB4buvdbgy64utqE7drk875TM7aLCPXCt/MAWFmf/Umhb67uqCKFQu2ws8K4UlIjqSp5CftJAOWmHz1u2431ocWCNt3ksJTsqkjnY2rHyhZgS9LHEzvHEeOQNPgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742980049; c=relaxed/simple;
	bh=pKKkYdmRdXQLcy+r9T6Hvuf8gwrchlokRe/rp6DJ2lE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cc3qgcPbwqcOGTHIjvzip/ENaa4UvSLVrRia6DD0RPcKJWsOPScHPK+ocu7Rl88zcNlyGlcAKjBnnecPeCiRECfQs0Tw5zGFVloNTB/DR9xDe8i8e8XdK8U4rqx/2Et6VUjuWPAl0NEdVc0zYxS2/Uy8FgXBaD06Z/1VGoa4r38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bamflqQC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bamflqQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742980038;
	bh=pKKkYdmRdXQLcy+r9T6Hvuf8gwrchlokRe/rp6DJ2lE=;
	h=From:To:Subject:Date:From;
	b=bamflqQCgnMmPnWL6oPq5IIjaT+Or9sxh8C6RZiXX4c7Pzu2bD1ZHHKaYzetBwEXD
	 lzmGWUo8cq1iXeOJ8HGSFwZFQ97QEF3K2RXq0c9ky27vszswzc64dX7B+E8eDz0GTU
	 HI2jpx9EVeS+2KHlueeQc7hywEXVvSZtFPQtX5q+Pv54tf8GrS9cZxtWR6rYOP7BoV
	 VpnZqhfD3NEVX8nUTaZXaQ5/WC1bHOZSsURjTjl3uFu8Jwzh5YhufagVIJge4ZOcmO
	 qYhCW62WIR+LAzEhXq9lp/V+8tHz4JB47FJwthIswDav/EXxErpAbRDy/5NAGdlob3
	 wfqBwfZMM4aJQ==
Received: from fdanis-XPS-13-9370.. (2a02-8428-aF44-1001-4D02-0f29-39F2-0741.rev.sfr.net [IPv6:2a02:8428:af44:1001:4d02:f29:39f2:741])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 86A4417E0B9D
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 10:07:18 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] profiles/avdtp: Fix reply for bad media transport format
Date: Wed, 26 Mar 2025 10:07:11 +0100
Message-ID: <20250326090712.171313-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the avdtp_setconf_cmd() fails to check the capability length
of the Media Transport Service Category, which should be 0, because
caps_to_list() doesn't add it to the list of services as it should
be bigger than packet boundary.

This commit adds an &err parameter to caps_to_list() and set the error
to AVDTP_BAD_MEDIA_TRANSPORT_FORMAT if Media Transport capability as
invalid length.

This is required for passing AVDTP/SNK/ACP/TRA/BTR/BI-01-C PTS test
case:
To verify that the IUT (ACP) is able to issue a set configuration
reject response to the INT if the format of the media transport is
incorrect.
---
v1 -> v2: Pass the &err as parameter to caps_to_list instead of
          fabricating the capability

 profiles/audio/avdtp.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 80fbe847e..dd8458f20 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1312,7 +1312,8 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 
 static GSList *caps_to_list(uint8_t *data, size_t size,
 				struct avdtp_service_capability **codec,
-				gboolean *delay_reporting)
+				gboolean *delay_reporting,
+				uint8_t *err)
 {
 	struct avdtp_service_capability *cap;
 	GSList *caps;
@@ -1328,6 +1329,17 @@ static GSList *caps_to_list(uint8_t *data, size_t size,
 
 		cap = (struct avdtp_service_capability *)data;
 
+		/* Verify that the Media Transport capability's length = 0.
+		 * Reject otherwise
+		 */
+		if (cap->category == AVDTP_MEDIA_TRANSPORT &&
+					cap->length != 0) {
+			error("Invalid media transport in getcap resp");
+			if (err)
+				*err = AVDTP_BAD_MEDIA_TRANSPORT_FORMAT;
+			break;
+		}
+
 		if (sizeof(*cap) + cap->length > size) {
 			error("Invalid capability data in getcap resp");
 			break;
@@ -1494,9 +1506,8 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 	struct conf_rej rej;
 	struct avdtp_local_sep *sep;
 	struct avdtp_stream *stream;
-	uint8_t err, category = 0x00;
+	uint8_t err = 0, category = 0x00;
 	struct btd_service *service;
-	GSList *l;
 
 	if (size < sizeof(struct setconf_req)) {
 		error("Too short getcap request");
@@ -1552,7 +1563,10 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 	stream->caps = caps_to_list(req->caps,
 					size - sizeof(struct setconf_req),
 					&stream->codec,
-					&stream->delay_reporting);
+					&stream->delay_reporting,
+					&err);
+	if (err)
+		goto failed_stream;
 
 	if (!stream->caps || !stream->codec) {
 		err = AVDTP_UNSUPPORTED_CONFIGURATION;
@@ -1560,16 +1574,6 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
 		goto failed_stream;
 	}
 
-	/* Verify that the Media Transport capability's length = 0. Reject otherwise */
-	for (l = stream->caps; l != NULL; l = g_slist_next(l)) {
-		struct avdtp_service_capability *cap = l->data;
-
-		if (cap->category == AVDTP_MEDIA_TRANSPORT && cap->length != 0) {
-			err = AVDTP_BAD_MEDIA_TRANSPORT_FORMAT;
-			goto failed_stream;
-		}
-	}
-
 	if (stream->delay_reporting && session->version < 0x0103)
 		session->version = 0x0103;
 
@@ -2827,7 +2831,8 @@ static gboolean avdtp_get_capabilities_resp(struct avdtp *session,
 	}
 
 	sep->caps = caps_to_list(resp->caps, size - sizeof(struct getcap_resp),
-					&sep->codec, &sep->delay_reporting);
+					&sep->codec, &sep->delay_reporting,
+					NULL);
 
 	return TRUE;
 }
-- 
2.43.0

