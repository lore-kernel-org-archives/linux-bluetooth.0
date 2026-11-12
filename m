Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515870;
	b=CHsLRGQOWBgK1/Jp9DQKLUDsYyACefcBqEDZIecVU9weYsFDjOyQSWDRqdCz2K207x3y
	 KUZKah0OBBT0gB6GijxmXQCyzOf4NQEE52iyQPLYeenaOps0Sc4poTNDWAjHtxWF4v/aJ
	 DBjyN6BPqnnl5WtgQb5cjaQYUBdeazeS4FMK7iYi0ROkwivr9FkimfnMVyGpVODFBSfM1
	 Rxnrvu11LPN7XtU+uutYs+LbxpuAOkTAcukFB4ZTMUkJPTsq8kvNzmpJJ1QP4ZFiwgA6W
	 SqgS3dngkohUotx4pw3PSyMNyJJV0ZbmcOtdTYeYY14Ip5cUC/v2frpgBrR1j7CSD7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
	b=Y4NVuukxroJjHI5Yt3OZMAprdHaBYf9ulWbpdiEG5n+5roB0J+fJnyJUfP8rxEWnFJf7
	 tYKba6r6mcTmr6QTY0YQEIqNb70xydC7h5A4QixTgUx6qdH74uLIhHVMtboSApPoBKCQo
	 zxdrp5OIpA11WhwvhGTMPTuZuUIKH8Y8cZ10Er114q02FYC0ZEFZB8MnylYhL3YES8AIo
	 /TAyCoEXNjJTPoZx3d5+ECnbfsmLqlkuw8hCm5/VJjnYSNrqs1vlqA/0y0dURgEpp0p99
	 CNNp5rafYWnuaW4IwQZezUNl1lHNydn1bGUg6T1blQ/k2IVoCYtbF6GVbusfvFoM08w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jcmIQaeU;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEAB606A881
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAEAB606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jcmIQaeU
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso277006e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515869; x=1795120669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=jcmIQaeUmsC/+3IlVniGQmJY8riPgOppADy30n3G6l/dGmZedQTkWAIIL2Gj9VItSu
         umv82k7hgnPDI7jDZPuM0ELAvn21X4SAfaU5OK1fZwNg0pneJWF0uzjruT8FbYIs2X+A
         UMdFF8oyWnr5i+CqEbcfD16MF91xDgXwWpwxVA9nCczQQ/GWE+LSANlvnjENth1jNcbO
         ktsXyJKFXoLYkMpVTTSLVS3SvRB8+fOXFcJxKM11z7jC8St4Mi/swQ/NdI8+1/W67n+m
         QQ75a1cZ1K/A7vf1JkzzmFhAHtbqVw354j7vFRwTsDZpsOrPKP+Kz8zExGar6xijXr9T
         5wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515869; x=1795120669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5ExTW2XF0lbBjrixeixkx/iXnQf3Iu66Clw/FQQ2wvs=;
        b=VTfxrE1JuP4RegxIb3UxiXX2ebCdZ80gFAL+gLvDv5BhxyFyVwZFbFOKewNRr7Kb4W
         i0agZLQSGwqMmZPoVt1ErlXVEqgADv48o/junOvVPQP5Wa9FXO1GjlkSqR/U+CkyirXh
         qt/L5RIsfUZYKvlejz2N8Daopcfy2Y73SKRm9xqV6opYWLCrWZmXh7yar+iAF6e/DM9L
         4aTSQYGSi6mdFfxHcgzS+x0GGjODPpdpSF5gKoCdKIIb0m8AlyVNbqH7ytAG0yT7a39D
         MZCObrEbLYWFYpbYZnmKpM5i2NpDNXDsYrjIC3T154kdAwYu3A72TqIhLkWWJgMpNa7w
         HjLA==
X-Gm-Message-State: APuU4Z+t2/GASgk/blPmEoJ4lZRvPS6iWpisQW8VfOSoCy0JGiQeefun
	4fGH8I8iELB2PPxDjHKALgz7OeOqjEzITs2Gmw6bnZehEkmInV4W8NvolIGW/Q==
X-Gm-Gg: AYBFou0U9FbYoJrsw2xg/QQ/VhaeHojeaBunls9rN4VCCYU+xpig6hVv4vQ/aTeTQaE
	bD1GD8m+O9lRDTQ/QwKZj1W0fKu2Nr75KCFf3Z31Ogjyrn+ldjyly/IlPcH3X41nVSXUbN4M/+n
	4kG1Tq6/0r8X5cLfe1Tiy9l8cSAlVNW8aG+Sn7BX3U16ip0J1URUb/tslfaBqx5dJ5i1wTXfL2O
	aher0AW6ng2cbKqlmYPIDgJ3n8rCWQLEjCPjbAfAgZ2l08zS83Ut/GumB8xTyGw5Twa5DoEdJtm
	odBT7C3FHNRZLB4K+Lmo5AFTZiz6aWPTw+R2szOkTson/z0MdJWXz2oOfSHF/YFFCvCqNhHJOLX
	IwaZbHCIP43uUDouwYB4KtiILIE0e0eyLD910QeC1z7DvK3bwiOxj5ZoDeyDUGgwm4v6hWg19xS
	aTqXIb7RAPCertHr6qNELWSQFndgfnhfKpqjdYmqmHqpJM7H9T4MNqYnCEPimPjF3yPiYLAN7PI
	4UusR9Jp7AAuf+kdl4HtOLH1SsobbfhYtI1iveG7LezuQBV4Ig1Qq/4ObTdmOGsqj3ePKVLszJx
	eU/Ez6XYvPMO9uoc2oR3Qs0g1xKU8CiDlAJnX5grf3XTxSYuiaNW9J8uMHbVnm6petXZHKcyIdw
	TehqqNhjBqxYAaldRyJUaXzW1bocTyFVBqRkE/s0qB7h2OHqa4R5GCPr39xSnjzpVdTSZohXIiw
	zkFoc=
X-Received: by 2002:a05:6122:8f89:b0:5ec:b371:ee45 with SMTP id 71dfb90a1353d-5ee34ac3d0cmr125395e0c.16.1794515868664;
        Thu, 12 Nov 2026 12:37:48 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee34bff0d2sm145765e0c.0.2026.11.12.12.37.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:37:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 5/6] doc/functional-bap: Document clearing a cached configuration
Date: Thu, 12 Nov 2026 15:37:42 -0500
Message-ID: <56433b054a2afd8eb992e7fd02541b97d1752208.1794515788.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515788.git.luiz.von.dentz@intel.com>
References: <cover.1794515788.git.luiz.von.dentz@intel.com>
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

Describe the test where the initiator clears an endpoint twice, the
second time releasing the ASE whose codec configuration the acceptor
cached.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index fc367e0f9181..eb04e6520aa8 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -230,6 +230,30 @@ test_bap_unicast_desync
 	single ASE of a CIS, so a failure of that one can be told apart
 	from a failure of the initiator to enable the ASEs separately.
 
+test_bap_unicast_clear_cached
+-----------------------------
+
+:Setup: As above, with both transports created.
+
+:Steps:
+	1. Initiator: ``endpoint.clear <remote PAC Source endpoint>``.
+	2. Initiator: ``endpoint.clear <remote PAC Source endpoint>`` again.
+
+:Expected:
+	1. ``Configuration cleared``, and the initiator removes the transport
+	   of the Source ASE, which the acceptor moves to Codec Configured,
+	   caching its codec configuration.
+	2. ``Configuration cleared``, and the initiator releases the Source
+	   ASE again from Codec Configured, so the acceptor moves it to Idle
+	   and removes its transport. The Sink ASE transports are left in
+	   ``State: idle``.
+
+:Notes: Releasing an ASE in the Codec Configured state is permitted
+	(ASCS Table 3.2, BAP 5.6.6) and is covered by BAP/UCL/SCC/BV-106-C
+	and BV-107-C. Without it, an initiator could not get rid of the
+	codec configuration an acceptor cached, as it no longer has a
+	transport for it.
+
 test_bap_unicast_duplex_enable_one
 ----------------------------------
 
-- 
2.56.0

