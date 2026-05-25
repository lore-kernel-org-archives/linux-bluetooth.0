Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73493A8739
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691908; cv=none; b=GrKK2HyGj9trK75O4wR0jEuTiqdMOe7BWRvl8jnD+s0br5zpmbqLW60uP7l/zSGzTkZR3myf8kQs7+89Vus0CGbSw+JHaUHLrf0tCK5k9eung8Sv3Xm3RUmo2MaODLgOI7hiMJe8/txheaVaWGX/rfWoe301qC60wchYL7yCXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691908; c=relaxed/simple;
	bh=i712aeVZiY1us4xT3HM7vRqdl6qj3F8Gbb7uyPyjyr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZCl6FGXivfX1FpG2ms5J6gB+DgLLrRXcPnaTgRpx/0UT6YXL1//UdekCXOMoZKtTD2dvWS1PA8jMy63Nu0ms/bmCgeHMKTm4HD0tdK5P+KopEmhl18+0H1r6zYq7k09A8+6VcX7SrzoOa/zSNDgM9ib4HcQ6nG8ezKKMiTSnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebIqEz5D; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebIqEz5D"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490426d72f7so25017675e9.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 May 2026 23:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779691896; x=1780296696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YejZgxA9MxLt7t6kVK5ieEYJz27fZcS4JxcaGazJhu0=;
        b=ebIqEz5DQ0aCdUUCmUKjNBx/sC3XleBJYL/eA9V7YAZpYEwiFH8fG4Gqj0NhsHcbh5
         wkAmu6I7c8LnZ5bKqqHTR1nLZ25wSeNx8sZWNgFrDM99S3HSEPDer1SfTvIPiKCNQtyX
         DfQxL43zBwJpKwjhj3IBOI1tQKwPGXR/Ga7soaa25+gYDXeIc/GoOe328WLKyDex3Wg+
         nJ5WRWeTdTtuyuI9LuHYcyQQz991ugYtWFZnRLvElt1wRTny5mWxwzTphqeevHClK7nT
         crmZRIjyLXiKpySMiE2Mgf5YTaNn3QuEtuwMjKUsfPh3YGBcT7ikVvlnoPtR+WO1ewdV
         LIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691896; x=1780296696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YejZgxA9MxLt7t6kVK5ieEYJz27fZcS4JxcaGazJhu0=;
        b=qeqkUQyMQIS2dWyqTWQ9ulJELHC7UyqbrnGYLz5Y3VJqpYVPpySHoKEc/ouo+ev5Tx
         e0HsT7VNVdbeo5RF+EofAL71WgYO38HAvwAP3Djrix+0a/+eTLivI9tVhXbkuiHFmJfU
         rJINCwL97KHWMhZpn2WzsdPo9qAo/clojx1V3JzHdDmfS/mwb+8eFFRXvaEol8jTsJRS
         TdIEFZBcZ/Tz4qTikiqhoSnyhASAdDbh4HhiAne1w2pZob5NE2rNGfvTsEE2O9eWbDyv
         2VPNxlJIvM5iJfH70/mh2U68AwvUOlqqr0vF4ZXXILNDne3tQsjmCEZy2elN0xtdwcqv
         VbqA==
X-Gm-Message-State: AOJu0Ywdhk3M7XDaz9wGz2vUVStAxkBUL6XYw2pghTnGEwTZwltIsQca
	wr7/MMjF9QytZRIb4+cZvJjN0mkaqOMeW1QmOYQg0UzaH4H34KlNzNrMSGjz49afg1o=
X-Gm-Gg: Acq92OEJDlL2kQFQKDwcvsYKh7xFf6q6KAJFSU2bxM3yF89Y8Ev8hW1IKhbZ8Mq5Seb
	CJ6WKFpkCBdqHcxn/nzyAswyEHMUYV+jke1liepFL6uKRvOL5aJnoYJKHsrQ4Y0HOxJeo1vYNbo
	RHQiSdjePWg4p/1e3UVk7NEdoyog187gndCwpUCs8IYdm9/SHS6WzDAZ3Fn1KdF88AYV3ZwthrK
	uCLuMdLu0wW+qYi+WHImvGMibnXMPNXSuWjUAO7X2gw2p91uwu0oaclkGo87FldJp3OZR4GgE8u
	phqodh4X5VcB4ujPvV4mpQH+nxUCfsm02A7bre4R/TtGbimIz2TgLe9umlYTNrDThD7hDTE3jwr
	brqq+YQvDnzyt6gEcvCXkgu1ZF5SmFJ9iMj+82UCAIFDSk4wecg+8EVJndzAdl83/Yf9wKS6hAk
	UuTT1BY4QVghRrvHO4qSBm6nK3Dmh+YCsy4dYehDwx13ILPkK2VQ==
X-Received: by 2002:a05:600c:1392:b0:490:46bf:17ab with SMTP id 5b1f17b1804b1-49046ce6026mr201959795e9.29.1779691895476;
        Sun, 24 May 2026 23:51:35 -0700 (PDT)
Received: from bazzite.. ([141.195.57.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042ce8722sm77507645e9.34.2026.05.24.23.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 23:51:33 -0700 (PDT)
From: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Tarjei=20Bitust=C3=B8yl?= <tarjeib@gmail.com>
Subject: [PATCH BlueZ v2 0/1] Add configurable default LE PHY policy
Date: Mon, 25 May 2026 08:50:43 +0200
Message-ID: <20260525065045.27375-1-tarjeib@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524221421.258593-1-tarjeib@gmail.com>
References: <20260524221421.258593-1-tarjeib@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds an opt-in bluetoothd setting for the adapter's default LE PHY
policy.

v2:
- Check MGMT_SETTING_PHY_CONFIGURATION before sending PHY
  configuration commands.

Tarjei Bitustøyl (1):
  adapter: Add configurable default LE PHYs

 src/adapter.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/btd.h     |  2 ++
 src/main.c    | 61 +++++++++++++++++++++++++++++++++++++++
 src/main.conf |  8 ++++++
 4 files changed, 150 insertions(+)

-- 
2.43.0

