Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692A3B19DA
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 08:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415773; cv=none; b=albzyd0uOjmiGhYoUwbZNPp7l4DgX5q2nCdl45sYfSdzwiHGPMp/SURfPEQmOpxeLWbDVkqHCRbp9t7+HwJqUDg06BnAvKoJB3VpLa0d2HXjQJtvJhhBy06BbixGdGmbBYL3ylT7M+9L963bmZ9FPV1/v88uDOaw24NhsoyAcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415773; c=relaxed/simple;
	bh=945W8owtOl27lJ/2AANH8/X7UDPMlJNhyUS3IIuZI7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5NzDjDCxbxQSoRkjEu1omykxHOZityK2CSM/daywxKIGm+GTE/l9rxNVdKmg4l5Z+2LFDVoh2am3OiEgnC8CGoEQ4Fr47e+jfThs/y4LfNTeWsNtSuAEtXg08eef5Vs4pF3sFVjxDNcMKAACYRLU8vQ7RxphxkzZTDT4VDsk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=MTYqwLV1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="MTYqwLV1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so6435705e9.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 01:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1776415768; x=1777020568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1tE+Q87KUMVVBwKNVYd/5/CC/4XRNK/FMVwgztA76o=;
        b=MTYqwLV1IuEjU6BGvOpgtCrF4a9peRMu/RJT2L5MyrW1ageBHWsmIulU7QQgQwvFxQ
         QRZMjRAWXI3o8+3HFHLlqrfQNBKZ/ERpu/E7ka134HN5lwa0mZZdPVmjJ2Y7FEasJdjI
         I8SU/XqF21ZoPVhdecCWdIhhd5nlJTFlmGE1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776415768; x=1777020568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l1tE+Q87KUMVVBwKNVYd/5/CC/4XRNK/FMVwgztA76o=;
        b=WB4HuIuX0RBRFwo+vCh1jD5E+E6dDXTQX9I/OH9i+Lz5YvCKHd1MUKyGXQQMcCytjX
         nIn7ZGT3WnrJZdFyXHck9UeogeP9D+Vtg8Ila/+Y6ItiUbdomtBqNtcmVgHxbNspMr/Y
         8cV8mUmCSLdx4Mjf6UFBbTAr5xTDvn7x6FvsbXGuNNKj5FGyl2M+cwOis8Wz9RAfYtva
         cHeaMWMMuKW3TTOIdjmh8r3lxvmzj1LQ00m5h9tf9RRI0Udxvup2qplu8NduJAOylMOp
         0b269n3cPJ1PSS9hnd0vWz0PsxOsq5TXDOeRtQ6MN3CggKlwsZ59RepmkrftsgtiABmd
         xjYQ==
X-Gm-Message-State: AOJu0YyNyn4DAEoUAjrBkHY78Xzc30wr+r2vBZJey/+GcYq3kmFYFGYa
	3+hT8xsmNxvkfLIUWUmKeL9RjxeS+tZuD6ExcOJsRvuWI5TSMTj4fedlLdVKF0cs4aJuI7eGw7i
	SPpQinw==
X-Gm-Gg: AeBDies2a1bDnUyuZTQYsqLISpgcHxtpOWzCozlzWtBG/NhpHxqWDhgcTCCkhS7wVZF
	tBx2RoOcBViFAUcnOFMQ+0T6yL0y9BGfZBgI0GDOe7a2hpn+fYKP7ViK9+ZAe+KmhNeAtTmbq2a
	GEKv43X4Y/kveUoON2IzZbnevCaNAzlqDYGiXFAnziH0APrkvddzjFLZ01EmY1ykrN3uEfq2akU
	LoISzW+7rxaMgHc9w6ZyG9FZRv+iNHLPo9bwmb3jQTAhUSEMX5MjxHLb030c1w7CrmsoZence7j
	18WB3WdN51wtU9sHaBdfksSTDdB1scQzHlOHriYHCKYn3TnN7GUXOW8Do0D1nZ/KRRcpWhiLwUF
	SAAIkAIf2Z9e55hWyfycwsJd0uG+HNXvJ40Lxbyz5ep3Kj/lCZmgsEcWbaN3mZBeL2oyqE1D+qR
	lVyA3JIvNNGD9hjYnZY5SoOyTkcDMYKUC5Ez5S+MZga2LRN5rjQEtgbjsmQ71sllqu9x4Ue62FF
	pIEH/4Bw5v86P3F
X-Received: by 2002:a05:600c:8582:b0:485:4006:960c with SMTP id 5b1f17b1804b1-488fb7710e1mr18996485e9.16.1776415768404;
        Fri, 17 Apr 2026 01:49:28 -0700 (PDT)
Received: from great-eastern2.home (public-gprs181528.centertel.pl. [46.134.48.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc16f8c3sm26315095e9.2.2026.04.17.01.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 01:49:28 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 2/4] shared/bap: run callback after setting the broadcast metadata
Date: Fri, 17 Apr 2026 10:48:08 +0200
Message-ID: <20260417084809.3633687-4-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417084809.3633687-2-michal.dzik@streamunlimited.com>
References: <20260417084809.3633687-2-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Without this callback, dbus property setting will stall.
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8da626fe3..78ba22259 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2526,6 +2526,9 @@ static unsigned int bap_bcast_metadata(struct bt_bap_stream *stream,
 	util_iov_free(stream->meta, 1);
 	stream->meta = util_iov_dup(data, 1);
 
+	if (func)
+		func(stream, BT_ASCS_RSP_SUCCESS, 0x00, user_data);
+
 	return 1;
 }
 
-- 
2.43.0

