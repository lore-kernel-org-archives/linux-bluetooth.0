Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F0C1DA0FD
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458672; cv=none; b=pkRBmtCSGUZNkNh6Sgqz72kIC3JvradaqQtsJG15kO5I9et0fqm6HPjmdB/h/q+kCbPR5jE/GqYlV5ijfwRuK8bMI4uV1up32V1EZIAkJcg3Fbe4ICP9FUR2a3Dzlzg8k4Vs9ZSB+7F6JyRdYV2bkKQL3OOSk+Jp5SVNgyGtCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458672; c=relaxed/simple;
	bh=xELgv1b8dIpW+2I+xyFL3lP1VggVcHiyHqFYQF383GY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhED0Y6myV58Qjm8zO5R9zpqnF5FT9n0x6wosquFK5zX2HTF7RgWz+5RrQUO+ECW/lOqPMBjSs7aARlURGNML8HlU/PzG3c1VabvsbdVAZc81RpcLkpLq2Wf8pPQWY85tQe7t2CIfPxuHFdj9pbMV3OAMxEps+FVV1l5uIagd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RtOFmquX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RtOFmquX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725458668;
	bh=xELgv1b8dIpW+2I+xyFL3lP1VggVcHiyHqFYQF383GY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RtOFmquXE2SZln4x5Ffw0RaqsKFD/+riHVdUmZIkmQMWAT2VLNJsA+GBfTb9i4090
	 XcVVqIhiNwPtcS8x/UgDyxKj8i+zBlrPdcuLJq4JFjnC14iLeIZQptk6mgUvyqA3EV
	 HPiOayIpP69f3TE2SXIALB6g1Ta6jSWor6TDeQGKYhHb7jQ3SmO8/R3tRRFD48zgdq
	 zIrHGUZ1UUe7yiDjUhv6F5Y8wbT0bakQhKAkoOKqU6njQUsRj55dKzL61TX8I1GH0j
	 iHYIVYhgkiDhiT6n73cA+FDEC7CZ77Q+YMmhcpbuDgPc03J7L9LsShdxURME6NZ2JU
	 45yutfj2CKSMA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C0A1C17E10FC
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Sep 2024 16:04:28 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] player: Add image handle support property
Date: Wed,  4 Sep 2024 16:04:17 +0200
Message-Id: <20240904140421.283166-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904140421.283166-1-frederic.danis@collabora.com>
References: <20240904140421.283166-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This is part of the metadata when the AVRCP target supports covert
art download and a OBEX BIP session is connected.
The image handle references the cover art associated to the track,
and is valid only during OBEX BIP session.
---
 doc/org.bluez.MediaPlayer.rst | 4 ++++
 monitor/avctp.c               | 3 +++
 profiles/audio/avrcp.c        | 7 ++++++-
 profiles/audio/avrcp.h        | 3 ++-
 tools/parser/avrcp.c          | 3 +++
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rst
index f1e999bdf..5bb38e7c2 100644
--- a/doc/org.bluez.MediaPlayer.rst
+++ b/doc/org.bluez.MediaPlayer.rst
@@ -237,6 +237,10 @@ dict Track [readonly]
 
 		Track duration in milliseconds
 
+	:string ImgHandle:
+
+		Track image handle
+
 object Device [readonly]
 ````````````````````````
 
diff --git a/monitor/avctp.c b/monitor/avctp.c
index c59e93b20..4da448750 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -156,6 +156,7 @@
 #define AVRCP_MEDIA_ATTRIBUTE_TOTAL	0x05
 #define AVRCP_MEDIA_ATTRIBUTE_GENRE	0x06
 #define AVRCP_MEDIA_ATTRIBUTE_DURATION	0x07
+#define AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE	0x08
 
 /* play status */
 #define AVRCP_PLAY_STATUS_STOPPED	0x00
@@ -582,6 +583,8 @@ static const char *mediattr2str(uint32_t attr)
 		return "Genre";
 	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
 		return "Track duration";
+	case AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE:
+		return "Imaging handle";
 	default:
 		return "Reserved";
 	}
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 61558e492..fe24b5a92 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -417,7 +417,8 @@ static sdp_record_t *avrcp_ct_record(bool browsing)
 	uint16_t feat = ( AVRCP_FEATURE_CATEGORY_1 |
 						AVRCP_FEATURE_CATEGORY_2 |
 						AVRCP_FEATURE_CATEGORY_3 |
-						AVRCP_FEATURE_CATEGORY_4);
+						AVRCP_FEATURE_CATEGORY_4 |
+						AVRCP_FEATURE_CT_GET_THUMBNAIL);
 
 	record = sdp_record_alloc();
 	if (!record)
@@ -883,6 +884,8 @@ static const char *metadata_to_str(uint32_t id)
 		return "NumberOfTracks";
 	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
 		return "Duration";
+	case AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE:
+		return "ImgHandle";
 	}
 
 	return NULL;
@@ -1197,6 +1200,8 @@ static uint32_t str_to_metadata(const char *str)
 		return AVRCP_MEDIA_ATTRIBUTE_N_TRACKS;
 	else if (strcasecmp(str, "Duration") == 0)
 		return AVRCP_MEDIA_ATTRIBUTE_DURATION;
+	else if (strcasecmp(str, "ImgHandle") == 0)
+		return AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE;
 
 	return 0;
 }
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index dcc580e37..59117e946 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -46,7 +46,8 @@
 #define AVRCP_MEDIA_ATTRIBUTE_N_TRACKS	0x05
 #define AVRCP_MEDIA_ATTRIBUTE_GENRE	0x06
 #define AVRCP_MEDIA_ATTRIBUTE_DURATION	0x07
-#define AVRCP_MEDIA_ATTRIBUTE_LAST	AVRCP_MEDIA_ATTRIBUTE_DURATION
+#define AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE	0x08
+#define AVRCP_MEDIA_ATTRIBUTE_LAST	AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE
 
 /* play status */
 #define AVRCP_PLAY_STATUS_STOPPED	0x00
diff --git a/tools/parser/avrcp.c b/tools/parser/avrcp.c
index e73a6317e..d574c7ee3 100644
--- a/tools/parser/avrcp.c
+++ b/tools/parser/avrcp.c
@@ -160,6 +160,7 @@
 #define AVRCP_MEDIA_ATTRIBUTE_TOTAL	0x5
 #define AVRCP_MEDIA_ATTRIBUTE_GENRE	0x6
 #define AVRCP_MEDIA_ATTRIBUTE_DURATION	0x7
+#define AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE	0x08
 
 /* play status */
 #define AVRCP_PLAY_STATUS_STOPPED	0x00
@@ -933,6 +934,8 @@ static const char *mediattr2str(uint32_t attr)
 		return "Genre";
 	case AVRCP_MEDIA_ATTRIBUTE_DURATION:
 		return "Track duration";
+	case AVRCP_MEDIA_ATTRIBUTE_IMG_HANDLE:
+		return "Imaging handle";
 	default:
 		return "Reserved";
 	}
-- 
2.34.1

