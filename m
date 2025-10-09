Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DF21FF4D
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026888; cv=none; b=sZWgKerlH+Yp/6pNUOuGMSXR8PqP7ZBMoP9u+j8idVOjomBQ0JxolZtdrANSYJozir0Da1m1H+cF5jvW0UbIOYY7pSFlDBRUTX5pYxoDKfLCX/RRwgA6syrMse2t6hoFgGexsB/Djq0Pv6/gCaE4ffAsxhVKuua+J5GJ2FWLbgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026888; c=relaxed/simple;
	bh=xKfVP1Nx1jMwfvCG8zQGGnH+oLA4TliE/b/OhobOYgs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zi0a+qVRqR17aL3h+0O7gc1SAopod6of0VU9PP8NCeXnD4S6422LAW3/eGbG2HYvaTbqAh7Azc+OZGviuAyLsXOczwRyzSM5BiKvtcy8IzOUiO+ytVjbWPsciEGBUMEJHTQClZfQrNPc9oDv3rg7y1LOkfc2ZBuCPgEPPtxy248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/SK+rH/; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/SK+rH/"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-58d377d786bso917492137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760026884; x=1760631684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nktRPBHUdJ+IAm7k/FoDjXdeBp0PfK8bn2T9Zzp5eE4=;
        b=G/SK+rH/abDEpnoyaXqD21aqBVRU149OE3MPrYSjo0tnJSbkkTIWoQgVJ9GYQjgwel
         gM/GB2Hb9Ru8y4m96mE7QrOIXYJIDIbH9aHZSP6OOmxeo2hESb/AgvPL2XXhUI1ubVAK
         bEFcWV9EXLG1xfx8u7KPIp0aqbOyAHT5alst/U6CvVI0WvDQvLJd64ued/RYaK7ziGmC
         9TxTFVFXzxyB9ls12CyeVgCiD3HKls46EEx2YNl4ysOm0zl0TLw+t9yKfKrdct2ewOvD
         lyptpFaA9om17WkSvLhZKbndE+U88Q4uM7KvOR/moNlnSkft96R2hG+njL/2Qs1dOySL
         xZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760026884; x=1760631684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nktRPBHUdJ+IAm7k/FoDjXdeBp0PfK8bn2T9Zzp5eE4=;
        b=PtEBnPG6tj13c7crDsSmpUEhtbLqnABdd8vHjq4laxT+cb9A93DDf4/yQ4PwHnEYz+
         ppYTzA4EDu+STMiEzW5zudxQyNdlGy2RCSRWy5ufUSdLe4GYtSWobHnz0yqUsvAe1jE1
         pQL6NkXUqppHr2g//DzBtYKmXQeHWACaqTGEpQnjnNiWvSNyHgGkApSFaYGwobHaLriK
         xXSP2ANOWEiR3tktMWn6N2P24y/nrtpH2DM3y2GwBEfDYpTlXbb1KOFKWfOCLMvU3b+I
         XDd+VPrbQGft8JGWSxm2YIuTTbgQYIVk1LurK2M5HVAMDKc73sO54+sL6hlla6rW5r47
         MADw==
X-Gm-Message-State: AOJu0YzEPqQckWOvpF1HoN8YCKRet5U124lSmlSfls1BV3LeFPfLpCVQ
	NM/f3NK9uLBeSMLNM+6a26UM0FsD3of2pOC5/0wRPuN+KZIDx3rdRRGjFwqj9qhd
X-Gm-Gg: ASbGnculhQU/SmdG7Ivj6Fo/8xoAmdY1gYzhewzDJgkg3qDNLY7rC91CLqaY6gTCGmO
	eVj0xYTIeDp17yvV24a886AOv0RaT7kog+lkfGNji/wDaH+3YP5t7AqcxwogCvgwiBrP38mJFNh
	hLyZ6ITjuKRfA6/zGxPbeMAetU1/rmNnVG2qKEUbQUufL/bXXgF9hHxArwvzTE0RDw09nZ+gYNE
	8NoRqEPBSjXZI+P0hmdtrljwcknHVab9ygBW8qmIJ+kyJ6u5pmhT1F92hXWxx+kDllXQf/hjIvQ
	vplmk6alDN4BWVr3e2jLMaIfFJMC+9LcSqL8lKz9MTInBCU0Z6pgSMKpBoJA6JyAKqyZz28am2G
	3zosXzKWvanhlMqMWcNkU9aC8aa/uF+zYEAW0NUiUCsklTCdetxPOXDxLLLKMT7k8kdGjkC9I3I
	C8a5W2IMcD3NWTJum1Dx0xVqvL
X-Google-Smtp-Source: AGHT+IF73o4bjttpSUk7WXBnGnAGPbhW80HMX6Z66GlnJfjzfpXPlDZi5yMNOneNYL63mWsz34FNyg==
X-Received: by 2002:a05:6102:1a14:20b0:5d5:f52b:81c4 with SMTP id ada2fe7eead31-5d5f52b81e4mr890406137.8.1760026883694;
        Thu, 09 Oct 2025 09:21:23 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5523ce69b52sm5454703e0c.12.2025.10.09.09.21.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 09:21:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] bass: Fix restricting the BIS indexes to 1 as assistant
Date: Thu,  9 Oct 2025 12:21:11 -0400
Message-ID: <20251009162111.221677-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009162111.221677-1-luiz.dentz@gmail.com>
References: <20251009162111.221677-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

MediaAssistant are created per BIS which creates a problem since
MediaAssistant.Push could only push one index at the time, so instead
of always using the index use 0xFFFFFF (no preference) and leave it up
to the delegator to decide.
---
 profiles/audio/bass.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index b7d39165fb13..70ef6f932ec7 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1034,7 +1034,10 @@ static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 		util_iov_append(&iov, &meta_len, sizeof(meta_len));
 	}
 
-	bis_sync = (1 << (assistant->bis - 1));
+	/* Use 0xFFFFFFFF to indicate no preference (any BIS index) to allow
+	 * delegators to sync with BIG with multiple BIS
+	 */
+	bis_sync = 0xFFFFFFFF;
 	meta_len = assistant->meta->iov_len;
 
 	util_iov_append(&iov, &bis_sync, sizeof(bis_sync));
-- 
2.51.0

