Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4334D4E0
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810585; cv=none; b=hGQr0taL96Am6+S6TKA0cxwr1Tx0Qw3d18P9xmFVVNyazv42Uh71ijsr5GJvr2SNLs7jJ7PBE9PTbLM7yohd9XQRp9uWKeQcddTFhi6ZMV+Qjvx/1Lm029sv4bcUxNGAPN/g+z5FkFHU3Jr9EpnCoN3bTN0EAdYu9uAYfFlg2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810585; c=relaxed/simple;
	bh=is+1b0WjjpyO9YYEFvpFspqAlW9puUvIAOguU0ShuUI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQZ9EbUAqilYUQejtswJxXkBfXHReRlHcwO7XFLWPECxW+aLfIPa/a7tkUDNnyFP+XzlbBCnsS4/8SYdVNGmrzbDsAtwyTcX9n+Fh6KUajmeK3GOdeeKclfsil9+Xa2WjKIP3GPVfz2EGlIckm2NHnzC4Y45oR/kZ75Uiw1ElRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQY2F+kc; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQY2F+kc"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so777253241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810583; x=1770415383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nR61vLy48uIjAcZWLVw094JSelS8Pam3NnHyQiQ50sI=;
        b=UQY2F+kcqpgqqL8NRQ02cS+AegrS50xYpAui8jLlYGJ45fri9YEw6C9/KxzI8gWShk
         lvCr5Ec3XgATJ1ivcRra7TzsiV1WJcnlWhBmUeeEgK12baMF7ax47G9Tjkm6Kl5wl7J6
         WyJygyTVYaC6b27zDgL/fMcQd000dcVbn78mvtLyjShR5egV5xF5WTziC+kWcP6Mukj6
         ttEEJNJClJoPhwfvAveJMkYaQAgm/pClitUP2WN8oboZ6g+Zfq+55jT/xCCsveN++x3u
         EDaQnHK+DAeBXdVOCCVfDvhaIP8C06o9sWPEKfI3KMctIjQ8FxS08D63yC/fRl6XOjZH
         COIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810583; x=1770415383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nR61vLy48uIjAcZWLVw094JSelS8Pam3NnHyQiQ50sI=;
        b=ASNjXZ03LVfwjpXJ7zwgh+xwkSH/oyfrAjvqz6hWn0HrWme2EkgF2AvWMLS6kXua4G
         OZdzitTJXf4t6V4YpTWpIEnNmznnWLjdqpKLdppSCODD0qttjjK650ttTvPXI73p9xcG
         qVV2CUPeWvuJXQBOy48DnfX+G5ngpqC2Vr0EcYCmOaG0TduImIYHsjkousOPNfhYVChy
         fW+Res6cNYs7OBRzDR2fAB4tcfALiGXJTPGmxRM4GczrDOb+lBJPDZiOm6cFeTcXQBt5
         wZNj0aCIWTpNIaeHlxcUmYJWPzZJfPQLYdfFfpdVgi9cNj7AXoeUqI4jjAeef6iTLyUk
         LYoQ==
X-Gm-Message-State: AOJu0YxHf8actrPTiLVb+hUdRQoElXUoaT3wJyUNLNIwG2F2vPPbjedN
	I3Zmw1KEBXBvigfjjjfoq1pZN+/zA6rzrNvULpmYj+nIfBcS5T+O8+5VV5b5sw==
X-Gm-Gg: AZuq6aKwHHV8/kn8Gp3UruWSuODwbV2/rSzV2hxn56bNAipfHha9HasRGR+IJAhUkSL
	2cnJVpH50GoYYI4MCZy8Xlm+JM5C693nnX3vg+khIBC09vrafS32hHameuxAmVuOig21ZFKLxsG
	9qySlVk+HRGpxArohnVWUPnf7tGKidt6r72iZhp16mr/lZRegDFEgRjFMiSbLHkWaMIVMGhZcQX
	m5TIrwnISfDVCcG142ut0Jr3lJ4qXBXfU2gmOCiDduV7ZR2zLAas4k1iokv6l174dTksRfzxqfX
	zvLtqlN9XuU8j+ahY7hDfS3yrsvVhN+QtjOp3tHOzrJDfzVCPM2VAAaE3p4OLUZRK2l/NgpuYKa
	5bjRJiJIEh8oO+uOReGvBBp5srgC1AoeXa3SNxx3DBfppZb81orBmIgT2sIZ2Q6tzojWgkhInNY
	3Zms2BG3Lu8mIJfJCtDL511cho5eW1+UsfTNcn8ImppgEOB0Ic1eu8oyWsMbtJE+QAIVD86tCLS
	2xvBA==
X-Received: by 2002:a05:6102:3713:b0:5ef:6709:4738 with SMTP id ada2fe7eead31-5f8e260dbd6mr1578298137.30.1769810583327;
        Fri, 30 Jan 2026 14:03:03 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:02 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 19/37] doc/org.bluez.AdvertisementMonitor: Add Used by reference
Date: Fri, 30 Jan 2026 17:02:10 -0500
Message-ID: <20260130220229.1346261-20-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130220229.1346261-1-luiz.dentz@gmail.com>
References: <20260130220229.1346261-1-luiz.dentz@gmail.com>
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

