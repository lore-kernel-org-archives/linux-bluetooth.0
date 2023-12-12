Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYeuqSHB"
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A3CBD
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 12:58:12 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d3758fdd2eso60639297b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Dec 2023 12:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702414691; x=1703019491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=EYeuqSHBsa22Jazh7CruHs8BZY3h95lfPSVwLl41LTnkz971BqFAl1Fcjonce80vca
         zH+ZBMRasK1JFNYjgqj/665Q2xY1u3O25Bg+WxlGC8wr6J0OfGw/MaV3xdd+UDBPtVYN
         PtZ4kkWplM7lSshcHFDOftMhDW/WR2tHsjL3lHwJ6INifoNIFBI97SZhYXkgVz5lxcM6
         fP3IpkEdHe9sFtHG3tuewEizEJjeLs8kFXHKsM9eHZFD1Zm+pgytlfr4PRNn9yjzyDFW
         fvV6Q2/+FyLBW/YQCSdm/RA752zJ95xAhFIm40zdCNXmanVIQ+TJj12EWk5ji9JmiRuO
         S+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702414691; x=1703019491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=BcrNCJPWk5m1YKYRE3RdHXYlsqNnn8grjcCYL1i88dMA33fj3tRmwXAZiYLj4QqvxM
         GREuUdihxxAhIspkwLouSLX8PYoLquybBkD/jcA8ZlLewt5bzYn34MZXbGK2/96jj3Bp
         q55P0avcdkE90AXAZ4gPBd24jyycVX6FHGRWpt78fTLTYKtHImcetlJggDMLgDMl3NVD
         N/Y+jn6Oro5lGAR1bbqHSUtHCqFOn+iqk4PubtaX9fJlrVBbf/Os+Ep3zTTcAzATOrmg
         VlJKO4A1JuHEISKg+7VRRgEwdtV76tYsO6alHmVnnRPhdgkkinMqAnujAE3sBuRMPJbA
         6ZKg==
X-Gm-Message-State: AOJu0YytF+adEpU4xakEPWZg+b7wXTbHc8lzN+9sMG/V9cjXeXwN9r7y
	tvUvpt54YyEFd6LuKrGLFxavYFEQ4sc=
X-Google-Smtp-Source: AGHT+IFgnl1mzQCay/G8W6R4Ptxi2GZXYxU4mB3/KCpNGLWNMkQR/oMNAWsBJdSD7J2S2gsz0g7NdQ==
X-Received: by 2002:a81:4945:0:b0:5d7:1941:3574 with SMTP id w66-20020a814945000000b005d719413574mr4952878ywa.91.1702414690689;
        Tue, 12 Dec 2023 12:58:10 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id i16-20020a0ddf10000000b005e28951e3a4sm144735ywe.51.2023.12.12.12.58.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:58:09 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties
Date: Tue, 12 Dec 2023 15:58:01 -0500
Message-ID: <20231212205804.881265-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212205804.881265-1-luiz.dentz@gmail.com>
References: <20231212205804.881265-1-luiz.dentz@gmail.com>
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

