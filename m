Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA4Esl6j"
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7309D1723
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 14:12:23 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-589d4033e84so1316251eaf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 14:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702073541; x=1702678341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aKrCIqNtifZgEzmFWurZkUt24Tu0FBrpZVFeJEQSHNE=;
        b=WA4Esl6j/cm4lAG4Z9mNij5kbbijdvXlzUzlqHIL/I+3U9xy3nm4gHfuwClP4PWbds
         dCCSLgBdUn9mT3vhkhNcKWqFp/sm+zeNG70mNnOlMtib+A3utsWEbYSDDfKjrIyuJSBo
         Dby7b6epqLiD2NXECJmgyZBA159NQ6nuKElKav0DOr7cIlBIuo3GnkEmDZeoexgnFotf
         NJwhDjuPrts9MBOzMm4tcYjMKR4gHJCHKZNTVu8IlafIBZXNKR7gt/3SdIfdUMthRrDF
         MuR0hdYUkxBCLpJBQV+tG3LfFsoNgf6257oMUhlKcIU2Elqx3rst7ZE450sHySCuV3eZ
         25gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073541; x=1702678341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKrCIqNtifZgEzmFWurZkUt24Tu0FBrpZVFeJEQSHNE=;
        b=OIJIl+IFpg2uL5m8J6B+1mQ1Fr18WslusjTXiPw37uHtgmwk5/Zx7uRGqVljMxYC07
         QrpmfRPSJ7IXW8RPnK3Ymm4hcou5ygIFp3XE5etza9kPCQUv7NmlP9/KNiVh+RIPZYJL
         BC7bX6Cm5zpELfE3JT5FAsrc94AUxosPy4U0Avl5yHapibboLKjr8OhJWIlvymCwy2UU
         vMQ7Kn4gjWi2GLfncyZcTwF0FVW/dazDgwmrLH/Z94jxaUxGutQngUfapqRg3xvf2RUE
         TQDk2LTTvPQp+bpSUQwXRC3NEcMB+POb2LL3vKi+SgEbl4gtMTYdTtDWwYwE4FqU9O8Z
         hnsg==
X-Gm-Message-State: AOJu0YyIvlbIuml0jhSNqySIWQamiwtLKgvmiFaIXvC42cBOYbHoEC8Y
	5NxNljSHyEQviGdiC5c3LmBJGaWBTvE=
X-Google-Smtp-Source: AGHT+IFY4d+xdMOgWlH54jRm6ak6XjkRFU7YjPbvaq9HkEgx/9BhA0WCDqFzSKqK9PNhEbCy5fWi1w==
X-Received: by 2002:a05:6820:820:b0:58d:7171:c27 with SMTP id bg32-20020a056820082000b0058d71710c27mr989740oob.8.1702073541537;
        Fri, 08 Dec 2023 14:12:21 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id a44-20020a4a98af000000b0058df21de4fasm378195ooj.10.2023.12.08.14.12.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:12:20 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bap: Don't attempt to release if old state was releasing
Date: Fri,  8 Dec 2023 17:12:13 -0500
Message-ID: <20231208221219.54529-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the old state was releasing there is no reason to call
bt_bap_stream_release yet again when IO could not be created as that
will likely create a loop situation when the remote stack caches the
codec configuration.
---
 profiles/audio/bap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c279b5b0e133..c530799915f3 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1918,7 +1918,9 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_create_io(data, ep, stream, true);
 			if (!ep->io) {
 				error("Unable to create io");
-				bt_bap_stream_release(stream, NULL, NULL);
+				if (old_state != BT_BAP_STREAM_STATE_RELEASING)
+					bt_bap_stream_release(stream, NULL,
+								NULL);
 				return;
 			}
 
-- 
2.43.0

