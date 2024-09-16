Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24614B094
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493308; cv=none; b=XmL5eH7o75hbN7zNDYh/ZLMimM0YTIHRrk6wW/PbGGQe8kU9HC0akulLDlehffMEhi4GTxnALGQ4evvQsqqwbmYEBIYKN8vd3DXQ5Sq+SSM9Dpj0+DAl1sxWP+TeVlKsqMV4YKShYRckGP1fQ61TfNXJsUZtWppvk8CjMV4GWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493308; c=relaxed/simple;
	bh=/Yph+mpTwr12Uzsk3dlhqjNxvwAaUSS1c7JzrSfIjo8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gglwlK5rkAeMque7/mdI/0lg5HE1/O8DbZL3cuK1Nk5kV/RFaj36gCkujhO/qE/pFKgNLrI86O1qo++VMhz6z1Z7LFfmtB9agWmygGfp7onr/C6nkouJIOsxpp+zHDHoW8ZPLfzuziScT4iDCRsn5wtWvua46UKyoN+fykxBJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=G6Fn5saz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="G6Fn5saz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726493298;
	bh=/Yph+mpTwr12Uzsk3dlhqjNxvwAaUSS1c7JzrSfIjo8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G6Fn5sazKtf2/zKIJ3U/8V1+ATPAYughn4LREkszldIxQhSIBI4E+gqmLLb+lflRq
	 dZu/ardTleoqwS02x18vVRYpLejAaJekb8jEkf7QMRecG6Z6QxdiPt78FbR2K9jxrr
	 CIWcAaKIW4SN3Z9ru0vbBCion+jPCx8ImYtgvixr/5/50Zfnr/B/ZMI1OmTBfe0Ij+
	 I09fLYOZtf784dEVtdYo5lf/lXEZnGAlAbAmlR/mU0oY0hRwuewEcqLZA6A4d7fp67
	 TNb4mVmvfp1ZViSKX8qKrkC/oO0mGhQuKnhfZOk9D9xGCtqJJr8eAQlZtLa08QpVAd
	 D4edZQOocArxA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD2F317E1582
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:28:18 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/9] player: Add image handle support property
Date: Mon, 16 Sep 2024 15:28:07 +0200
Message-Id: <20240916132813.165731-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916132813.165731-1-frederic.danis@collabora.com>
References: <20240916132813.165731-1-frederic.danis@collabora.com>
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
 doc/org.bluez.MediaPlayer.rst | 5 +++++
 monitor/avctp.c               | 3 +++
 profiles/audio/avrcp.c        | 7 ++++++-
 profiles/audio/avrcp.h        | 3 ++-
 tools/parser/avrcp.c          | 3 +++
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.MediaPlayer.rst b/doc/org.bluez.MediaPlayer.rst
index 858344b30..94f5b8472 100644
--- a/doc/org.bluez.MediaPlayer.rst
+++ b/doc/org.bluez.MediaPlayer.rst
@@ -237,6 +237,11 @@ dict Track [readonly]
 
 		Track duration in milliseconds
 
+	:string ImgHandle: [experimental]
+
+		Track image handle, available and valid only during the lifetime of an
+		OBEX BIP connection to the ObexPort.
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

