Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D43016E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769802000; cv=none; b=kHsbxcV+GRtJaC5UPC/v3Qv2o06kRzy7fwqmgBfz/1TbPld/xYFHn9yrHjW3CUaoBhZDaEwbTvQaZqZ3sntb+onOvn5NHVAxzA7MEl/cdOSow5TLYlN9V7OaULT3RXbCCh+rorwLAR/3QmVEVCvLcZfy47DFPNFbiYhdhiY5Cws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769802000; c=relaxed/simple;
	bh=LUvx/+Q3xOMrhSXC238ySseF1NFqUwYEOKxEONrnae0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r1tkJsKde/wStzcU/dxV5ooexBfAjeFCriyC/7DnrCOBNKm4EGDZPbpVGcDwYkQaFy3RtegQn1xN7FRBd9GsUIhFYcdOmVjU4fjs5XVC3lqLh+BQ9VOKdDk5BQi9RPKLnKxPuRIvwFiFjYBXakfS4U9yFhMUEh5TSVNV4VQImlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfbUEZf5; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfbUEZf5"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56637ab30b8so2127064e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801998; x=1770406798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3dZOCvLZWCbbCQbDN29wytuTNMne4wDsKPEOd4+Nko=;
        b=UfbUEZf5PWCU0fQWCKUDt5Q2TtoXPIugdAdrBhcRWm43Nci5VPFjlmKzA9FDfwNzao
         8OrBm9iPCxwq7hyzEnTMjCdmSooBquL41OIpWCQ3U7c61f7WCnh7RyL3wKIe3pqoGxua
         e0wpAjdBh0DsSbqiTTbHIF9XYOQJapx11obeJPGtxbeDPBaReBXMYQdlFZ9s7mWGStjD
         GcdQ9yIwt2qKqvwFQ7qWjOqHn0iZ2Fx40sXz/IeLhvFvgsY+xzNeS4DY/Gzif9I3IJz6
         Je9ZYddoQuQQQBko3GW+ZsNDXHR/XGdBDOU1nyThcwjLJmzfRUzOVAHtlAUU+rNBPghq
         KGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801998; x=1770406798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3dZOCvLZWCbbCQbDN29wytuTNMne4wDsKPEOd4+Nko=;
        b=m771v1w/X+RUaNTfwin01mqAsv/I5+6lOmbNN5WhaXNznDe44goteC/7Oa+0kmj8MD
         MqdElV0P4RFj7pxwzJNmhGkYBMwR/l7GDAlywbIJbhOJDBIsSxhrKYq/aND3iPVp7CxO
         6Ee8Wc4SWD7KgXljJ+zfCpJq1F0o2S/E7gW/a8AYT1CuYNyv6sichPtEV3Yj4zAoGrGw
         DM7keC/fBN19jT2d72jELTDcRD/9EG6aewhmqEIzudSaD4jO4xu6QZ6CMtegrsCR2bkq
         EqIhq6AiN+Gs8WkzTXjOR7e6ZPUgENnGDfVn36dS5FQKnwlEZLKtiO8iYWNnbOH5XzAm
         CZVQ==
X-Gm-Message-State: AOJu0YzD0ergMhQ0JbPfTpy4DKKDuyZjbVnpJMh7vYQMWcuIXCwyice9
	DSip4SDcTsnv2bvVHZc9uOMBmT2MVy2GDcO/veef6TFhNgo9tWFsf3vBTlcw0Q==
X-Gm-Gg: AZuq6aJ1MeX1/fGwgPu4LO7+5JDStCqOLsskkVmXe6lKoDITWlxgNAbjX4w8lh4s1rA
	GgF3NKethh33aRSzWj4tJJ+d5O8AlrTRg1WYwJA1QoJYK6gO3ccySrB6nqALeUwtKVRgYDtvzd8
	Ka3azuUtCoZbHSPSX9svrEueQUW/vGsxTOcJa5T71ke9X3vWbMLn+5Y3LoJU+D0FUl03Itr7pHX
	iA0dMe3sXeeWBnBIikYp/faswW6XYWB4RrURsNTaCIoCCDys8spkpP53V0hoi8FfOBebzNR+IY8
	HZJkeFsl60x/Ze3dy5aVwAKAIuDpMsqj+mFduwsU23Rxu0iIYRatTo/XT2vFZDNmMZvoydGETuj
	xXBnBGOKDYeJFWoUSXPtYLxpItpzw+pNTswky5gOiUu06OvcBGWCt7oh8VUDa3AHjgXcKWtNr2o
	YAIkVTvBfDlVPoo5HZWWGCDDrhCCeHZrk7BzNBDERVUkV2JaW4+PpQ3ifwOfvMa2y6Q7FXIlEO2
	yvElw==
X-Received: by 2002:ac5:cdcd:0:b0:563:ba2e:91a0 with SMTP id 71dfb90a1353d-56691f952d3mr1727683e0c.10.1769801997653;
        Fri, 30 Jan 2026 11:39:57 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 28/35] doc/org.bluez.LEAdvertisement: Add Used by reference
Date: Fri, 30 Jan 2026 14:39:10 -0500
Message-ID: <20260130193921.1273263-29-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-advertise for this callback
interface implemented by LE advertisement clients.
---
 doc/org.bluez.LEAdvertisement.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index 680a6c4cb97b..aae80f08f3a5 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -35,6 +35,7 @@ versions of the same UUID will be used in the advertising data as appropriate.
 :Service:	org.bluez
 :Interface:	org.bluez.LEAdvertisement1
 :Object path:	freely definable
+:Used by:	**bluetoothctl-advertise(1)**
 
 Methods
 -------
-- 
2.52.0

