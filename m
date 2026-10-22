Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684039;
	b=hsGbLzI/pIRSWjwEf1V0Fkva+5l3Rl5kaCjUbNVW7N3eEvOBCCULhkFcQD6RQj8Zv5I+
	 xJq7lANJJLCEPG57YzmFAopiQwI/m/8vRI74I6i0h81mVVYzaxRjtj2KRvEBArqJlFqdz
	 AC3izbb9U4BNsgAphJBgH8F1HCkKgrDU7n+uP8hEDY/khsHzvO9Y0QH6hZIE71f3m5noV
	 5FBbKrh2GURYlxFteH/TmKbxRD0++3dv/UpCX4Giya+9t5JcOCWVWrRBjPBIbnOGb4wAJ
	 V/QtUGjsOAkwGZciGf5AesrEJi1FU1UpM4kpHsCmFoLYSRkNde6iLQuaLHneToeFDxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rnuptemPiZ/BoGkagm74GMqUKk4lhV3Px0zl0KGb2Ls=;
	b=nFReh6qMm24lRi3bhl3acYg6RQSy8bD3uq56CX6StRyYxiQNCFhi+0bj5WeshUZ4mGoA
	 mdgV3m4Xmx75QV+FV+VvcTmYOVg93NBFEKt8VbiKD9tjZkeQZ16isfU3jmxQFsqX6rkP8
	 OTlAVDzR5bzqClu7sRtAzt9k5VLmSQZ+FBVEw/LXamfpx4sdS9LFsvBVKjtwt2M4tpjwa
	 A5lb7FIXcG4xG3aaqwljqIhZAnKzxjnTNBzqLKf99Dx6Dn/4I+0YmiRlJxXFqNLBpAtBG
	 IDhIXPvXWlLTdsRJRm0+E93Ck5J8sXe3kCMNOypS/j0gN/TXjVeKvEQKTfmEDtqrtYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g9fDv+f9;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3697606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3697606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g9fDv+f9
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so937123e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684037; x=1793288837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rnuptemPiZ/BoGkagm74GMqUKk4lhV3Px0zl0KGb2Ls=;
        b=g9fDv+f93W3XGV2sBtjsMqV+p539/lk2BoPPzV+iQHesvj4JB3TIINl3OlFS8P5mPA
         nPpo9oB9BlOkZ0RSFGFMgCGwFpb8Im9etSIO3zO7XIw87JZRqbdQAhwh8pifSrOuKLTW
         d4GcnMYLi6a5ClShkqJ2l+A2dU0mpCSOVaLkMoQZZMcrVvSgK1WTsGE+j9EILrE4JUX3
         L+uvBMyd43aawSHtlQ0Y8YMXo1xRv22+6kXWf6MjqLRdypnWq7uWTOwX4KVF0tNp0YR7
         zb6C5hCLYnR15vNf5v1P7vsUDQrann8bnebXCXvZNGh2JDimACnbcwRp2CCnc0akq2R6
         jG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684037; x=1793288837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rnuptemPiZ/BoGkagm74GMqUKk4lhV3Px0zl0KGb2Ls=;
        b=1/JYXqtgSnrgg+OxX14A/CS+fWqWoq+vAdjmUp/P7hBqv6IymWuw8VVK3u6FaqsZwj
         wU5Auu4YgndAd4wjIdxszzU2wdz56qipD2eVAxuQdixKAdQPnQJIKs3PeptO5xGmZk8v
         h80ynEzndKG7/Ri4/GZgDT8xWkF2rTQojNRhZbA0UEOS3eProII9xJUJlqxM7NTLr8pA
         fov/3Z0imIPeMaAPWs/HVN7e3sqzjSmgOEp8waJfalcmmxMJxw8OoIJlPXuDm/VSneOS
         570RMVnciWAzst8cwJWaeKPA7spvQAngqKfmWoWjfdzKkuE9vYuvksY++IDuNMdJy2S5
         KPiw==
X-Gm-Message-State: AFq9FYKRwwEQGJm6gIgsdNyAcxsgZD2JkuJfDsxydliZ3JR7mOrpL9vk
	lJezVNk3v4DealrHAYCKm/9UgYTS/+090mJefN1CTwsyqYAhFaxL9NQ+X5xDGY0w1rY=
X-Gm-Gg: AYBFou3LjYf6Hz+YsvpCALrfeDGUUPYDIi8apSCVZEl1QVMx8Y+DT7h7f/Mc5U3u4gw
	ATp09sfVUkSjC5LuWa1GNI/u8TaU8s8+lGVN9AkZWdlsrRbpj2+uVxmkTsH006lKnraX8ZOsCFm
	rPX4JUlK3/fogW8hL7zVovDSM5OQLcBKhvCDbHVRW+NwLx4qK0qL9Equ8O9oUOgd/sqo82TotX3
	gryi5swVtEOSw8PVoaSs6Sh85jNnPtdVbQbilEQNHtFHnU0oeHMmKo1ggXvJN4sgyc8KPHl/Bio
	/FEFfAb6GFgGgVKY4QgJ+GPotj29nP3+hkeH1Fb1juRDFSVDBfyic765ndZ2WcETabV7qqHo33u
	Y+AVDdvMgAnXw3aPAb3Bb2BobTxNmhbWv8xH7i4DkVUdHAfDSb1aH1omuMfD5GkgGoStpVgvoc9
	iPNJG6xlUt5jqar5vB7MCpPEoEGTwhdWAK00PBcb4HqFMfUB2F8cKfVLew2lbj/L03lHo73Hcey
	71c2//DI0CMa9ZHZlCMMruJrpq0yfVsbFgwhZ5R8hahC6T+pdgQeqrhpKgoFv6eGY1A22iDmLs+
	IxdENiInjHvCYpMsTGsU1ZoAG/YB5ZhGEjM4Jw+0eghtMA==
X-Received: by 2002:a05:6122:4b8e:b0:5ea:c77f:2f2f with SMTP id 71dfb90a1353d-5eafa3737a7mr952694e0c.4.1792684037375;
        Thu, 22 Oct 2026 08:47:17 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 07/27] doc: Enable IPv6 in tester.config
Date: Thu, 22 Oct 2026 11:46:40 -0400
Message-ID: <20261022154701.3959500-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

6LoWPAN over Bluetooth needs IPv6, which tester.config relied on the
default configuration for: without it 6lowpan_enable does not show up
in debugfs and every 6lowpan-tester test fails, as with the User Mode
Linux defconfig.

Assisted-by: Claude:claude-opus-5-5
---
 doc/tester.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/tester.config b/doc/tester.config
index 34f1530e174c..58b7c592335c 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -15,6 +15,7 @@ CONFIG_PTP_1588_CLOCK_VMCLOCK=y
 
 CONFIG_NET=y
 CONFIG_INET=y
+CONFIG_IPV6=y
 
 CONFIG_NET_9P=y
 CONFIG_NET_9P_VIRTIO=y
-- 
2.56.0

