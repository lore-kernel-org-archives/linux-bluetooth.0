Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E9A2F6598
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338478; cv=none; b=Qw/c9/iTm9K2RAKT/xTbnvSnK3jYdef29/5+2kHUpe+GvZN+nYCJhVui2xnk03Q7H5NjY0RcSlEZuduP+azkrzneTQUU0p1bIa76+IqnrHa6/vqbqOkYzef8gbmGd7ynWYAQqGeEwQxs8FQiLubsfB/4UInJsNnOlY+aPA9dJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338478; c=relaxed/simple;
	bh=JQRRvvEQ3dzudaVG05JW1ndfVeZyqZYmXtlZk+kH4V4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vd+iMjKQ51noT+vkIok/SPDIKx79AnydGH8SpgZ8ZxAwBGwCLy0qlw2GQxNzUrPJfMog54aHtamTSogGnP2qbcs8sbV1cNvU3WTv7Rx8C4Gmezg6vXat7ZqK6DPSpzAj/q1+R/RiZLdd3sBMmhdWcrRvHIjudtNXMK32HkOREaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvAZN99x; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvAZN99x"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5db3ec75828so522030137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338472; x=1761943272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAeZexvgxbuGlShGJ6CUEk+YNlLf2q9zrfNxFRwCm2E=;
        b=WvAZN99xH+XhnN+TGo5vgc3xWXZRqAbs4fWuXU2oNMm/6afNvDYPZKOa9AS1oK6YEf
         84BoYfL4E/B10+OxutVFTnIrJYnP8s6cHW3iqUFbVt974MDJomXnp0ZGbyuAO20NhJD5
         2Cfm4fpDTfcN6QhbFYYga8ZQgWATb3RmnzO1dM9lB/YiuRm/t4I600b+3Wosf0q6/3MY
         5xU+rBlii5V5jlso3ZfEvvpOgKiZaKXpV1CBdropcg2JcoYA+pAl9U0jY7G0EMveFKi0
         lF456czXyvRgt8VuY4dHPlnOioRpQ7sHyPBQr7K6dUzVo7sTPTbQz+2cRj+IRZI0pJKf
         xLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338472; x=1761943272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAeZexvgxbuGlShGJ6CUEk+YNlLf2q9zrfNxFRwCm2E=;
        b=mGFK+A0vHjnadAm1aQG4H67SPq7EXjLsWSccGmHUKI7XfLlqiUBxXVcqUdIv5KcYZF
         csgBxLKDiw2IteIZVlGP5fJjqljCPrEE57rFlX329n0+8ev+bs/kAmPzhAWElnUVthen
         k9j8sJkbqtFsCtF6JFaSnxbgQKrZu56pSvaL/dGHg7TI+cyYEaFiUZuldPJHYG5Qowsy
         x/98v/Xp/Y1DPSv7NeFP9KDPCdZhHs/9XCNDDFaVTSjgFn5g9seT2Hkmo75/QYU4fOiK
         mvvfanrZk3wN9rEgwDX6YAglvgJtfQ7xopUIdjpV9+v902XTFR15jGZWsvBxXc2KhFzJ
         4Axg==
X-Gm-Message-State: AOJu0Yxlus+Aw7sswvBa4LzVIaPPf/FTKWFJSofz7u8vXNa9bU5q/neL
	+BBSKWq8Hmd/6I6AQY0k47v/1V+cXM7Y8j9zBOTCknOZxH6MUiqbMU/6eOpVIQ==
X-Gm-Gg: ASbGncvGUIgipKHyaUK1P/dwvPVS505JMAEoiqfAg6Bfy91ENvI+pkw23LmqPiPFxl6
	lYo/D/rTWCg8ROdKRBfxuNFLNFRnstJX2zbjpw4onkefBAWJm9VnZW9rT1rlTE3xMp/mLR2nBGm
	qspzk5a1lTWRlPFaeaMu4Plr9jTjH6lSNOH0oKgfNIDu+dncsigzgdQq6zNQPttjqqHBfiSDLAC
	KnMgXsFKZAAXLTv7J9D74Ti8hrmzLuMmMuj6oUl3k3Q3oUnuvhnv1Yr29CB5BDwlPzRLWrs5oGw
	DguMhr622vaA0rqwpFoVufSEBqrTtDGQDOzZCChw9g+vMdsk6LZtX4aBalXgBngm9oq9P0jRfJB
	FR+5biANlnWsTMnip50kZ+FqZgtZJ5377tl+7JgxD5B7vaK9QygINhUoflZuSHhe9UouFziQknZ
	3gxnqUJS4b/zUo3w==
X-Google-Smtp-Source: AGHT+IGXh4jMozrVli82zON8I++rr1PqwQopGJ8TihpKRVe7PjdnUKdNk8o0++uK2EuOyBuaBYUOSA==
X-Received: by 2002:a05:6102:cce:b0:5d5:f4bb:fd42 with SMTP id ada2fe7eead31-5d7dd6dc519mr9845277137.32.1761338471986;
        Fri, 24 Oct 2025 13:41:11 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb2f98asm73501e0c.10.2025.10.24.13.41.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:41:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 12/12] client: Add script for testing Broadcast Delegator
Date: Fri, 24 Oct 2025 16:40:39 -0400
Message-ID: <20251024204039.693918-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024204039.693918-1-luiz.dentz@gmail.com>
References: <20251024204039.693918-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a script for testing Broadcast Delagator role.
---
 client/scripts/broadcast-delegator.bt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 client/scripts/broadcast-delegator.bt

diff --git a/client/scripts/broadcast-delegator.bt b/client/scripts/broadcast-delegator.bt
new file mode 100644
index 000000000000..e42db7335c24
--- /dev/null
+++ b/client/scripts/broadcast-delegator.bt
@@ -0,0 +1,9 @@
+power on
+endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
+y
+a
+3
+4
+transport.select auto
+transport.acquire auto
+advertise on
-- 
2.51.0

