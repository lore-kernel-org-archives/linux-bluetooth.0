Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1615CD74
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816942; cv=none; b=Z16Ny9cSos4KH+NAjEUjBmMTUfz7AuklVmT1qAQrOYglylD94uT+FiW1C5H+7gOJt7QDoPtG4TPkh/V5m7aIP8FJcnAD1IQq2NN1GPozTDGZteafS4beG3I85q7pAoWHwA6VEyjpPlNphEcBv3PMjRKqNSiUgJ7nNYf8GImVxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816942; c=relaxed/simple;
	bh=95GjdPQCE3+RKR48hQU4SFq+hTxXCPYGY73eYrqfzc4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=stimx0NnXE181BQfIWcdvFqrq8LdQsrPHboVCPgCqPzJ54V5RE0ljoo/7ac1YT8N7gxuYTh9rN9s38x91mY+oX6UxogknRtaenXF9oXLAEJBpBN2iYjEnlmXpPVUKvStO2Oi+Oeo1Bwu5vmzWv1Lnk24ORQa4TWcOnSu+3tx8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcIZsdC/; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcIZsdC/"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4e7f367ea11so2376049137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 12:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753816939; x=1754421739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOye+LSQF48d38goL8rHDjP8OtQ5zyx+w0WsI1fDWkY=;
        b=BcIZsdC/JQ34OXHbewSWojAqttIZsJHNKk0Ur9Jc51Y0ogr/KVs9aU7yY8PIOMXnZ1
         DVekIO9SSRQGfXBIOLfLYZjxOV/ZiVj7icIWgC84KnFm8cJRy5FIVjWHhldHlJfqYPC/
         R/CQZsMkaaxJhQy3GwwEKIG/0LzNh2p+xvl56EwYLKhBlZPZmk4SuVj7/MvTQDH27z35
         /Y7khfkmTLsHoPGjiISwCc2W42ZbE5nEdkhIm1wE7ymYQKL2itx5aNTz/eSCGS9/7gXU
         2EmCcW0H0BV9HwQ35wN14XUNBa/JFK0iNDBK8qWS4AD1zS9NKOjqIDP/L5ril7/hroWh
         NMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753816939; x=1754421739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOye+LSQF48d38goL8rHDjP8OtQ5zyx+w0WsI1fDWkY=;
        b=Q9S4Y4u3eh5uosyH2rMgIxYPEkXaQ6m6FjuPk2EO4ijbZxK+tJSyE8rFaVOFmyrV5g
         xw/QoY/43qvoWy1f4A/a1NGyB7VCv1CAU8a8IjIj3jxpPEtQp6htpplotnd1Ld/Inpwy
         m6GK89+nVnHBEiEXzCFrDfGCiz5btXAmH4OXyLSpjvbfoKP54RvWRzP4nIGHK1z/nXK+
         BCp4dL/xDTj9o6VJkpLGvbRa5euq3yX833rB32hyuEzrvuWtB1u4vNWFHXUyrKQ4Obrp
         m1dG1fdEH3ysipCwdKKm3ZQwW7jtHg1CWOALfOVY4vIscABInsPSi2b0qF10+N/xeMjP
         pGzg==
X-Gm-Message-State: AOJu0YwOXF+ISY6nBKFcC2bYyMwuHjoK4wclH8sdZurErol/AbyUjghv
	xW7cA6qPY2lIqsnWo75CTFjjxtFuO0lnrxIfAo64FVzuf8oXe99NLygYox403vZU
X-Gm-Gg: ASbGncuw9uptlZOnHZAK1MNSU/aNoLJACF5kdsFcpZ1KwxS3AxzmP1W3RaqR/QEltgb
	33OeDPOFtv4N9kbYX58A3ONsS0y2Db790PHOY/MRyoZmbXatBXRY8whA3xizyLtse+rwuG+d0oA
	ffjaffrInzGFS3/yKSu0if1P/MMbmdA0YdVTl93Ak2S5OsKgiP46WP9geUpcJg9nFmoXaSyO2mZ
	EEdEKnwKldbI0FUU0l1vyH4RHfRzahdz8+HavEKe5t37Tgrk3CbS9cPdI8vnlip5+6M6cBBZw/r
	mD2nYU3WzkOThXdEAwc6A6ctaFLwJr5fyqbjR44fkDkpP5O8IrzzOMxaPH/mFYW3IVISLKYimZd
	cp+9kDy2xFpMeIi5TQ1ZSbEKtc1eK2tw6EpS33yc7hswnpZWUaeLtul/izUshf1V6Uagxee+V+u
	s=
X-Google-Smtp-Source: AGHT+IFLFGgRVliQNdNjedy5dvwOGjhM+DPUYCfUky0GmiaAvJvB/yycY4+PQUetTtR+iL+s6NTR4A==
X-Received: by 2002:a05:6102:54a4:b0:4e2:82b9:b377 with SMTP id ada2fe7eead31-4fbe8766cb5mr785867137.18.1753816938683;
        Tue, 29 Jul 2025 12:22:18 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fa46d0745fsm1684577137.5.2025.07.29.12.22.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 12:22:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/5] bap: Fix crash when Broadcast endpoint exit
Date: Tue, 29 Jul 2025 15:22:03 -0400
Message-ID: <20250729192206.272462-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729192206.272462-1-luiz.dentz@gmail.com>
References: <20250729192206.272462-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following crash can be observed when a Broadcast endpoint exit
when a bap_setup exists:

Invalid read of size 8
   at 0x4075B30: set_configuration_ready (bap.c:1120)
   by 0x40766C3: setup_ready (bap.c:748)
   by 0x407809C: setup_free (bap.c:998)
   by 0x4078301: bap_state_bcast_src (bap.c:3012)
   by 0x41319DF: bap_bcast_set_state (bap.c:2392)
   by 0x412CFFC: stream_set_state (bap.c:1537)
   by 0x4131AA3: bap_bcast_set_state (bap.c:2404)
   by 0x412CFFC: stream_set_state (bap.c:1537)
   by 0x412D0E6: bap_bcast_release (bap.c:2543)
   by 0x41314EF: bt_bap_stream_release (bap.c:6518)
   by 0x4131607: remove_lpac_streams (bap.c:4348)
   by 0x4108444: queue_foreach (queue.c:207)
 Address 0x56f7758 is 8 bytes inside a block of size 16 free'd
   at 0x4B85E43: free (vg_replace_malloc.c:989)
   by 0x407472D: setup_config (bap.c:1778)
   by 0x407A869: set_configuration (bap.c:1175)
   by 0x4102A8F: process_message (object.c:293)
---
 profiles/audio/bap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index f39a4045813d..d90d39bdc134 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1783,6 +1783,10 @@ static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
 		bt_bap_stream_metadata(setup->stream, setup->metadata, NULL,
 								NULL);
 
+	/* Don't set ready* field if there is no callback pending */
+	if (!setup->id)
+		return 0;
+
 	setup->readying = true;
 	setup->ready_cb = cb;
 	setup->ready_cb_data = user_data;
-- 
2.50.1

