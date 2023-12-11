Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBoE1QnQ"
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46568CE
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:04:38 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b9f8c9307dso2268556b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702328676; x=1702933476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=ZBoE1QnQVH4ez+YAKUg6Jlwo/KL5sLEaxWDKseOFk3uqBd/CiU8VjKFsgCiSgDQIr5
         e/WO5/IFlB/CueWkj0RI32VLyMDJLK8E6YQsSM3eRrquZNH+5B58lvAUOdGow0PMkQWn
         djQDRehfdbITi8T5F2Xd/dWnxZeV4ZFEt1+x2gmsedWOBrCsjKYiP0Djqgy/I0CNiETF
         x2Uwfh9gdm73GPRGCVh9a24ULxhRi+iPK/ylzSF0v0aZB0S9x1m/4f0nSGvm1TzLbpq0
         o6aOmwTRn0CK9wBH5REluChGcO0DTUyOutrhNhPLh1YrxHuox2mFfBT6KoQLu//c7s5I
         Yyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328676; x=1702933476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=haGRp706/Xwiv4nVEJpRafi9j/aNUXbKnf+EE2uuN7f4tgpoLHCDWmfItLK0DesOOd
         NzRNcrAM+zRYx9KJ5msw1xdms0SK4SxyU7I5adLPEXm/hy4xWIg9MlSBVAbmxish+8KT
         ejkfH9W8xZjgx/6GHXhdg0mqXGr7DFL3cwJyiGUdyep2+BATi5ETOTVvgoj2fmK2tTq2
         oKUSTGLv059mNj8Jo0urk0MuSesneLVV6u5+GDK8ljv9l2z0bDhtsDeEvuOE2vfImpl9
         arrVkUiDYmH0MQ+oGEUlGMxN/mOtpIuHacFEaEQMeTqKOXedPNr2E62xTfZsaLROt0jw
         Gu6w==
X-Gm-Message-State: AOJu0YzFCt3rOJnc72oWeZ2ZNT52xN1mBwQyZLMVjy2SkYLtuErRKSNu
	e1xtTzhc0lkErwPjqWNApU+C6XdCL00=
X-Google-Smtp-Source: AGHT+IFTnrULTKz5WFj8Su+8PMuq2MMHCDG6IYa04CXImpn2zkqXblTAoloMKxT4nLygGU4jnGPOYA==
X-Received: by 2002:a05:6808:3012:b0:3b9:f1d6:9b82 with SMTP id ay18-20020a056808301200b003b9f1d69b82mr7296563oib.43.1702328676447;
        Mon, 11 Dec 2023 13:04:36 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id k23-20020a05680808d700b003b85f47a3e1sm1996852oij.43.2023.12.11.13.04.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:04:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties
Date: Mon, 11 Dec 2023 16:04:26 -0500
Message-ID: <20231211210429.530964-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211210429.530964-1-luiz.dentz@gmail.com>
References: <20231211210429.530964-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ChannelAllocation to SelectProperties which when set can be
used by Endpoint implementation in the response as part of
Capabilities, note that it is not mandatory to use it so the Endpoint
may have its on logic to allocate channels.
---
 doc/org.bluez.MediaEndpoint.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index 6754d6e3b7eb..f2b830ab0949 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -79,6 +79,8 @@ dict SelectProperties(dict capabilities)
 
 	:uint32 Locations:
 
+	:uint32_t ChannelAllocation:
+
 	:dict QoS:
 
 		:byte Framing:
-- 
2.43.0

