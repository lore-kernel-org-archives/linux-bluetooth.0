Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3572FD1C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801991; cv=none; b=dpO8+wlZdl4e7VvgAI7cpmiBjycKZSBag/0bu8QD2RvUHcPIVQaG5Z1ZRPkwy697Huph1DI/ceRCn/IfPIMHNJCg5GErsZwvM7IQkehTnxFcUqKhBibhHX9tcUSknJi7D9cuPf8AprnFrBa7Ilw+wN7iqKS1WGMYW2JTnghlAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801991; c=relaxed/simple;
	bh=is+1b0WjjpyO9YYEFvpFspqAlW9puUvIAOguU0ShuUI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5ya7ECgnHyfEjzX8Q6rUWjjSCMs/7dwj5r7JcM3xx7emx0OR0wiiaKpXDWWzcebKU38Q99iQaVjuzb/J3e6m53QrW1PjZQidWx4FgbX7Z9b3ax2VJtdSIhRvlziNkaBFJqwbhiZ2AV9HDGxE3qDvcdZJKysc5nWRYDFQm2p+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ5gS7am; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ5gS7am"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-566360cab07so799386e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801989; x=1770406789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nR61vLy48uIjAcZWLVw094JSelS8Pam3NnHyQiQ50sI=;
        b=YZ5gS7amd2qZeZERjSwd502r/48UcogaDaSs8BoiI5M3uaxh6hRCR5JuQlZDW5w/Q9
         nRAJjbfFZi+++w/WdFF9ejWxuxKuTR0HpQ/4GnKWDQodC+bKYFg04Cv4sNc0VCjRYL9W
         ChzowH25SycCHAm+gZPZikdBRl1/TEGPjcl8+ycrYhWTvv5Z1RwH2BbG36Xgmu55wjbI
         hovHCrK+LDb3nRj6bD1bsmg1ps/ro6SuviLMzw+B2FECzUjP2C7yd7y71bDaf/zRVCp9
         FymuLV5Cj+K6s/Qu/n4Xtfly95GfzgQ6zXRUWQLwylzWZRgoAVeM30KsP1Oiu+i2QqCA
         NRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801989; x=1770406789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nR61vLy48uIjAcZWLVw094JSelS8Pam3NnHyQiQ50sI=;
        b=WxSWX0kVwS5E8f4h4lPr0pogvdVtyCG/9d4dKEtHECY8f7uRucvA5QtewdO9ABH5km
         9fr+5lK3wuKJGNp3THFRtDZ+UCvd+jNqUIGZO4O5Hx6PUfnizIcS8HhQ2RIgnTymXa5I
         VQDt2thV6fiInlX3g5yVBvhp4DxdWXjg/QOJmwRJApmeEBeW8jhOVh2JFtfN5dCIyoqS
         6TNVWUY5BNywisCEecBo69XO+yXV0z7CoozPI8m4CUewrZ+CTAfrJB1JuNtF4WNaPDEB
         G3GLTFm2yU9Z5A5J6W6jN0VBY6Ly8tY3BesDFlDpIEYdgHaQbNjJ0LV4A1SStXlskcRQ
         fSIQ==
X-Gm-Message-State: AOJu0Yx/P8znxVzEBjbD8dvJTS5vyrFFTqNui9ufMYOkbIKs20IW2H/x
	aHvCihP1mX3CzXj3UYkEhg5gCuZUzYvdazBVD6e9Fv/HfTbZkg4I8TP0qWoUpg==
X-Gm-Gg: AZuq6aJpQBcISe4MZXITmhbqUSAIJ7saW5t6z3n8ulDOKGKpeIjNGGgSXSvNqmUyM3c
	7bNSONWCkwSDRKvbyJ+WsZJecWrdOjaYZekq9odSVlRKrTwNOJMIkeDjnasvv1d5iQaIPDT9r3O
	g/KRpkTl5pZDNsS3/P+eNfayWTMZb5ol8zO+1aBZrIkmmHIf3PntqNhh5AIpY3t6HjrdtWqhbre
	8tQa0N/ZAOIKGzHrFE7MOwTs7HAbs80hGl3zPu3tYx/8MVqDI5+p8D76J2jJVQuB9si8X3i0Jak
	y+bLoXWNP6Ow0cMDA5+VXXEQ8GtaKhGv9lQ6wirJUDCexY+1BjVUuR/YdjPMHlUcrTRrqPdLtKh
	i+tIKWf2OHwtCP7TBntfQbnGL7x1mQLw5nKXRF3UqA2L8QXRXfBupMCEzvTeXfkgKz7J4/ZySFN
	kyWkDrSxDVKLfYpRDSn0T1MzUummeMLR5H6KuJ9BHx8+OJ2wqRZjVa57resrVM4yRquFMkW03lN
	7D/gA==
X-Received: by 2002:ac5:cd89:0:b0:559:67df:5889 with SMTP id 71dfb90a1353d-566a00298ffmr928284e0c.6.1769801989258;
        Fri, 30 Jan 2026 11:39:49 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:48 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 19/35] doc/org.bluez.AdvertisementMonitor: Add Used by reference
Date: Fri, 30 Jan 2026 14:39:01 -0500
Message-ID: <20260130193921.1273263-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130193921.1273263-1-luiz.dentz@gmail.com>
References: <20260130193921.1273263-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add :Used by: field linking to bluetoothctl-monitor for this callback
interface implemented by advertisement monitor clients.
---
 doc/org.bluez.AdvertisementMonitor.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/org.bluez.AdvertisementMonitor.rst b/doc/org.bluez.AdvertisementMonitor.rst
index e08bf41e7a58..ddcc7b0b432d 100644
--- a/doc/org.bluez.AdvertisementMonitor.rst
+++ b/doc/org.bluez.AdvertisementMonitor.rst
@@ -29,6 +29,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.AdvertisementMonitor1 [experimental]
 :Object path:	freely definable
+:Used by:	**bluetoothctl-monitor(1)**
 
 Methods
 -------
-- 
2.52.0

