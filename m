Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349180;
	b=Dfnj0zIS+cfvTxuM43Cm9pnqshmM+06YRvQW/Cvzs1tlfYPgjN9+lmRdTqv6jEZVrch9
	 ESm033vs0RX8q+DY9kgfo1sdrgrmRC3uvmKK7YIC6bkyNCcoggdkfFmhaZb7hSkCdk5yv
	 VGjclOX9nR2fZBb1Shuy2IuF8jxGTZ9vFYdVTPsnqDk8pu9kPt91ZtfkT/tKT41u9wwtP
	 qFqdmhzKYf18L57v5VhJo19liYierphKvozJw0JSO2/UXhKAjZ8ZbeeqlhEsam3mrHdyX
	 StQsaWyQNaTz6yBzBvymhpiinCCYUjWqYXH5smO9lAlLx8dc2Q8hcj1Hr6ySWqLmFzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DyHJgA4QUlv27BrIaycarYSRXQktkTDJ0oSpKfy2Acw=;
	b=QPtYnJDllqVO4gHkYL2lAPzVrHmzSu9H9n7DREopxQsg94WbULuhzJYdR2uUJgMmhA0N
	 3vF0JlNf0QxYHRlmAFSbscztluqZVqho8jRGQRBcDAxyBetfUWbu5nFzRbMGI5C48yHlW
	 J/FZq1uFzMXeJCde281K/hf4ixobjTcz1yUHjZOuEnV6Uaa1z+Dh0ei4NkWtwDG+50pKY
	 c41hjV3sKtn/EQIUClCo27wQz4bhPsUQCYAeFoV5V6Nm4uG+7tjXtpSPuWL38Ol7eSzyz
	 ugwNY9o0OzyuFub7eUpQ5xmSCaZ8KeDxPWVLaj21ZTEZHUdtkeccwHJMxtWNMeYY2Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rZWLaICb;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF02606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AF02606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rZWLaICb
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so1843084e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349179; x=1794953979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DyHJgA4QUlv27BrIaycarYSRXQktkTDJ0oSpKfy2Acw=;
        b=rZWLaICbLAqjjXp9zwYmedCH4DvVfXTesx6RE0wdDmR2lHycGEFQZLwyY1abl/ujsl
         0jcmWes33Ahe4dhi2t3VHY5V+Yy1U+It7URnfPYkE8GEJaCmk3B1U5M1Mm0SzblYyXnr
         2Tz7bU8vZsYrMbtNT/kLBqv0JL4C3+yYO+hSXJk92TUlkH9vd0oMu9WYNSuK85MZchqS
         dnuYHVcnY7S5MCTtaac13NYqLNtNbQUnqzIooOkPKxEzM53aGQwS1bW++vZTasuo9HZH
         9TYnx3BFpWI7+mCZTbetB2qWY+ulFVP1e4+uW3A8B71PWzgix0UotvntQJNqMJ2bPZ3R
         j5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349179; x=1794953979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DyHJgA4QUlv27BrIaycarYSRXQktkTDJ0oSpKfy2Acw=;
        b=q75ZKhv4/K/eubRqsKQeqbBMGzacgvxEHHJfOFXrGD1KDSsFGm6Fy4iP/bxaRUKsyy
         DDLW/ckqC8r5hj4NX+NPicWw9zvc6I/j0NAGqznPvVQHeyNcj/lJJqE/LJ3X41IYkfJZ
         YgvMuimXBdHtUw/I6o/7tKAGq4KqWWj5fuOsStev7rHAot+ZDmLXKABodxs9odMvHXCA
         GLrzqaQ5YlHM1QoprplCOT5oljnaiT5a6A/V2ZPk/9galrjyEVNEQY7I5wg7Wtu2eL+T
         6dgAgQWuUJwTLnQqnadUbkxtkTcuBa9jE1DpqGwGo/smrTJcEDuNsgBUPaPzQFURCDCm
         qSkA==
X-Gm-Message-State: APuU4Z+6aH/VkDPxmKjTJOaEg2OLR9f5mj5Xt3IK77lDf7CrcqdrM9Qi
	4qqphXCA6pOw/xg2aNduM+NHN6FFeSF5Abriu1wB4/ZS7BaDvaQA7W5cwOkp/Q==
X-Gm-Gg: AYBFou2jLD+WTM4lC91fjdUn5pWUc3jyOJHRDQmAAXVCZ4J94jqHI3m6x+V0klR78VI
	bgncDuaD0Zn1c9AkLGmhige7KP1grBfsblwRrYc65bEi7cVXMbwfh/SB4jhdF2SEQS0sIoMa1Zl
	XYiXVkyt5B/xJ0vok2O2BMjH5vLYRdBxBGWBw8J1cvFu1KenGPBGrOVooyKNfNi9YNVxUjer9GR
	ypxBAGbVh7w+nQJKCsEn+iMMD5BAeQ59+KTJdNEoFieO5iq6c13GP4WdcUWRrrIeyrJm9/BoKMd
	F18MMijbqx25sTY5POZFeUHYVTQY4EVhxh+fWhTnplPM/cflMi5fYh+P7iHvnpCIsNwdDZ1+wGJ
	Ag+VsSpMBRAHm9mm2u26GUBMwO6Oblvd/yVj3oi7kGXPcYIQWLiMGkr98bqZqYNXn/Ay074+Zym
	q1/6qrTFp/QPabXoq8WJOghgY5BnLkEQwyK3cQobwCkjZpwdQY0EnLDzzcyg4uBdgnhlYYrVjzV
	oxY8Y1yJJ/yV1jEpg2galXMcaajXYwJuVq8jsSdQ8dhKUH+aG8/fQz41YivOQHID0NKnVfVoRQq
	Ou8MoTOcbt5aSmJGoXf4tL6YJkYRvmLcdAGYsMxBr1Hem4Bya9tK5sYAJtD09oYTOtLOTULhyl5
	+NWY0B2Kfs1b6C6Id77i+z//oP1ByYOoZLF3bkub3ZVKr0gZ3qYfESR154Yn8QRnFtHbmNNoGE9
	d786I=
X-Received: by 2002:a05:6122:1d47:b0:5ea:bda1:7689 with SMTP id 71dfb90a1353d-5ee1c3da49amr131149e0c.4.1794349179400;
        Tue, 10 Nov 2026 14:19:39 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:38 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 7/8] doc/functional-bap: Document releasing a shared owner
Date: Tue, 10 Nov 2026 17:19:16 -0500
Message-ID: <e50c3cd9ba331056f05f22b8c514e7f3a9f30aca.1794349049.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794349049.git.luiz.von.dentz@intel.com>
References: <cover.1794349049.git.luiz.von.dentz@intel.com>
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

Describe the test where the audio server of the acceptor releases the
transport it acquired, whose link shares the owner.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-bap.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 453458feff4d..7dbbb7eb39e2 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -339,6 +339,31 @@ test_bap_unicast_duplex_disable_one
 	owner between the two transports, and set it only to disable the
 	ASEs one at a time.
 
+test_bap_unicast_duplex_release_shared
+--------------------------------------
+
+:Setup: As above, with both transports created and linked.
+
+:Steps:
+	1. Initiator: ``transport.acquire <sink transport>``, without
+	   desynchronizing, so both ASEs are enabled together.
+	2. Acceptor: ``transport.release <sink transport>``.
+
+:Expected:
+	1. ``Acquire successful: fd <fd> MTU <read>:<write>`` on both hosts,
+	   and both transports of the acceptor move to ``State: active``:
+	   `bluetoothctl` acquires the Sink ASE one as an audio server
+	   would, and its link shares the owner.
+	2. ``Release successful``, and both transports of the acceptor move
+	   to ``State: idle``.
+
+:Notes: The audio server releasing the transport it acquired has to
+	release the linked one with it, even though a transport leaving
+	streaming hands its owner over to a link that is still streaming
+	(see the previous test): a transport that is being released has its
+	owner removed by ``Release`` itself, so the link, which shares it,
+	has to follow, or it stays owned and never goes idle.
+
 BROADCAST
 =========
 
-- 
2.56.0

