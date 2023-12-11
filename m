Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5wFdgzs"
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A224AD2
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:25:25 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d9d209c9bbso3884738a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 13:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702329924; x=1702934724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=S5wFdgzso/farLN5r8QrkpvQuK/DnMfIlIHTdiqC8tuhjuS4cDOLY8b7YK4a4XFj6/
         pk1NWUoEJrixkJpCMsou5ihk2UIFODA4eglE+6g5clXYPp6xsVXIcY+Mp+GaWbQNTsoi
         VwYs04kA6NmgpZCTr4+anFxGVvRjpqt2KP0FuzR6C38IFPqqpAM6SPMh6hwaxYoHU8mI
         a2iTNk+kmOh6jX+Rh6etqOAu4X2RrYlbcxpbyp3nKtRqX1qoOqBWTMscI2gGwz4TWQMX
         8mFCfiwJ22ukTTDl3cyQZNx5g0GiqkjfQOpe9sJvQQ1xJ0R5OBkuo/Qlr9b6GKuZT6Ux
         JBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329924; x=1702934724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=PLTxFaEQ5jceGwHMKznx8dL5Hq8zYzUQAkzMPjJiICh9AUcuUTVgyyf5aGLxUivAJz
         EMXfZhpiTjWjfTrKVYsOPSBztsiMOmHqntjbVI5saZNBvrZP+3Ja6KxZYcAoWmAwmHqZ
         hNML9OTqkD7cR1BttUJayWCmYM7AD+DWHYHIM+HYIzrbRyrFCL4jnnM7G8x4j+lZIeds
         xi/+Ov230v3BP2TFveRQ7S+f15BvxWlybaTjqmwNK9CrfO/93K5ZF/a6HwMPeMkg1BZW
         dqxmcxNZaqa2xOF4CUXgWwFGgkvsrCpATZqaePOIYP09ija8Ak9is2C/9ndqiuYcTSj8
         nc4g==
X-Gm-Message-State: AOJu0YyGQf8YYJp08T38TbRYgrT7N4YCbwCFpK8JYVA93jmMwo7VxCwm
	ZQs83whe72a8RrnTpAdKG7nUcpXoYwo=
X-Google-Smtp-Source: AGHT+IGIOAr68hnN0Z4ipqY5gmqzzROuB5u5Hd9PBL1PTes9clqCMDkNEHvr/aq3TgyWPnCtUy0sCQ==
X-Received: by 2002:a9d:6d02:0:b0:6d9:e7d8:a4c7 with SMTP id o2-20020a9d6d02000000b006d9e7d8a4c7mr5616530otp.73.1702329924207;
        Mon, 11 Dec 2023 13:25:24 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id s38-20020a0568302aa600b006da11489f70sm873757otu.44.2023.12.11.13.25.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 13:25:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties
Date: Mon, 11 Dec 2023 16:25:13 -0500
Message-ID: <20231211212516.577426-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211212516.577426-1-luiz.dentz@gmail.com>
References: <20231211212516.577426-1-luiz.dentz@gmail.com>
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

