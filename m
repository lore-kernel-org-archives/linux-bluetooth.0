Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9D56A35B
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE3LbSKS"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5906c569a1fso472486eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 12:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702587363; x=1703192163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=IE3LbSKSoy9/K7yDpgZK5A09FuMJGKyHssJQC2c9w2kvcjZYe5usI7AVGHB+0tiGXo
         GMxEhOeR176GWnUFB/4gJZu303/MVovmUWVNBenrZv4wqTWtaGMPYXhoJ+Vgcua0TKqo
         U+wo9vjajC4nR13vnQeb9qoWUBn9DQ8+zJD7PZBq8pUd/vIBfOE03IkwaA5UgBTwBPTt
         o7lm0oq3KnRr+RPz3l2WwlonJ1JqbFww/T63yJGlKTUHK8FmP0rj7Mb9HZ4nU/Jc64d6
         wBle7r9+hlMShRViDifzPUVjrz1bshQpg3g4SuIcII/nOX4vaJgNJHRKMwpKjWgiOiG9
         dlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587363; x=1703192163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vzaXJZMWcqXVLM/38ZU1rhtJvEz/oxxRs4GNt9sjWQ=;
        b=hi+HzFwN0wEJspTNA6o2HQ+854UVEZ78e2j2XnRnO9PIHzENq3hPq0En5vHLsjvwjV
         siccvLuyxLOdLJ2yQt24Ao6FoO+Wol6PorfitMBgTfr7CrN5oF0tZMx7YKDBmFGn20oC
         DfBHiMu9nEKMZW1C8+tthsJf7l4aFRtiuiZjkTk35BDaMox9t2A1ZJZYpR5eCEI9KnHg
         7wtuXGoTIv3s2+mi07Dtnmn14kR/n5fORCmdLpOPW5Yg6ZpVfmqmLaSF0rzLqMZKZj/o
         uCxZ/x05Xju25ci5nqPzZ/HcwKgbuTnu8q1ur+pv2yJnlOeo2Rtz5zhERtau5FZb/JEM
         liYA==
X-Gm-Message-State: AOJu0YxnsJfIwohtEVP3078AjgvIp/Q/70+mX4zBuWwOOeHqcpxE0UM1
	PDrkwdTdhmED7Wt0PdQKWq4z2HjY+hM=
X-Google-Smtp-Source: AGHT+IEjXYfltJEPvycCc09+5O+/98V6vwFFsynmw1qeJnRM5AvJgYsSFSD16qib8cKWBry043iG6Q==
X-Received: by 2002:a4a:304a:0:b0:590:2190:93de with SMTP id z10-20020a4a304a000000b00590219093demr4539411ooz.9.1702587363000;
        Thu, 14 Dec 2023 12:56:03 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id m20-20020a4a2414000000b005902a5bc3easm3658057oof.22.2023.12.14.12.56.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:56:01 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties
Date: Thu, 14 Dec 2023 15:55:53 -0500
Message-ID: <20231214205556.1320286-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214205556.1320286-1-luiz.dentz@gmail.com>
References: <20231214205556.1320286-1-luiz.dentz@gmail.com>
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

