Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT4uWci2"
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E091712
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 14:12:29 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-59091e4a0f9so495955eaf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702073548; x=1702678348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=OT4uWci21XtDaOrvRK5HRreoyb5VYXd1C8T4Qydv0gE7aNmAsYpcAWXcw0dZKVZYto
         kCGlORimt914EwnAxMtnh6bbPx+x1PCckSlTqFhNvmHNIHaboqfQcz8ehAPAiFupHsyn
         e1XtYAcXlxTngSttvSFUxvn4I+z3opKmoYc6qJOIk4dpOdzkKhmyC4Sk+Y3t/ZcLRhsM
         hAv9Dto4ioyilc61iTCmOfc3abfUBWCVA9ef91XbIxjrz8yZx6TD64Ld4qr0rYrSBiiv
         Cuh7YtPioApN6xt/r7cX4V7uyWnWA5vL7328BbyJ5LIndLh34Ry9L9pQpi8VpP5cyAyG
         CpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073548; x=1702678348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=NXU1ei0rsohnBoDRwpWnUXciLGvuZCqomyJ5m3iIllytNMXALdNMlk74LQ5272dxtl
         JsAmjlNklrru1DqEmPaPnqqFIoHl6BygvGXkYnGJOmXrgzVFmmDkXEQB6gTcn1DU5fge
         oRhAbgH+aX3P+AjpFrI7zs+T8H8ot5tay8nP4Zc251iLRsuh5ED7snyZ1qQ0TqpUQAdw
         vmJ2KPMb9TS1g3UptY118Bi/Tirh7OfT9KV9z8OqipV2ppPonJ92w+Y1JrWgedH7+0YB
         G/1jQFJPcXjd2GLl9rYNzlXrrN8/o3ZcBAQb9y3bIN+Y4wWo7wqXbecqqm4Hr8CgFD2N
         35Mg==
X-Gm-Message-State: AOJu0YyiEcYikUGZc9ua1dyXo8Jur0TCcrGpP72hIIv128hab8V5rZhB
	Sx/oHFpKVvf3j1AFSGBdfP3AfKAqQYA=
X-Google-Smtp-Source: AGHT+IEQpp9WkSrl9wJksWivgIl7sOmeulk5DrGOzNSz9UQQJvqQ2JPLnQCcIFZ+vQM5F81wP/79oA==
X-Received: by 2002:a05:6820:47:b0:590:8cbd:5b39 with SMTP id v7-20020a056820004700b005908cbd5b39mr836005oob.15.1702073548431;
        Fri, 08 Dec 2023 14:12:28 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id a44-20020a4a98af000000b0058df21de4fasm378195ooj.10.2023.12.08.14.12.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:12:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties
Date: Fri,  8 Dec 2023 17:12:16 -0500
Message-ID: <20231208221219.54529-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208221219.54529-1-luiz.dentz@gmail.com>
References: <20231208221219.54529-1-luiz.dentz@gmail.com>
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

