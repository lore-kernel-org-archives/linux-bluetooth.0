Received: from mail-vk1-f195.google.com (mail-vk1-f195.google.com [209.85.221.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA743446A5
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 18:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439483; cv=none; b=nWJmPWJBgA5d93mBcHM667+tXuJh4229TUkb6OjslHPUjpnN/Qm/n1YqRNOLJ5dpKe7e7yceYz+tv693OQSw/hjMrr+WJWpq33XfKpW7K/sreCZRIZH1809Cv8DUda+0JnyDDiZHsqi2zkSZ9N2NngRl0Ndx8yieXZag5dX3pnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439483; c=relaxed/simple;
	bh=fuUQdX6CZRNZEMmwOUyrN7ojoLw4NDfO/mVJ3T02KTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Nx70rY5UbzvZxbHD/ek+F7TAIJj5VK2igrySWigsyC15byIcq/XGwei7PC8CkmMfrb6Yzxt3xh/ZztJCZTqBSmqBnWo6eMCE/SXEV+PmXE8w6srPsXZr7kl+/fegTAVHIF03NTGJbCOjcO7s1Q2OewuK3h1umzdsLJNWO146xLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G65hOLK/; arc=none smtp.client-ip=209.85.221.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G65hOLK/"
Received: by mail-vk1-f195.google.com with SMTP id 71dfb90a1353d-5674689e507so63895e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Feb 2026 10:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771439480; x=1772044280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xgpWV7SaCAkmBJJvYVr1KKBvX2KdlgsaiXoeBQcaWzg=;
        b=G65hOLK/BvdImztCDKaFQeLlqSPw/Y/Mv7zv0bvth20ZiH2cZeqF7fwh6zxA6glP3o
         xi7EK7tj00OV/yIyzH8V0M9HV0XRF+E78YHKKLTrpPWx6n44KZfLZW9wZxbldifejisV
         Z4y/M4Oica0/zCSG2kco5IjUWPihYF9QhF1Y1WvpFztOSzshdihU0IBG3w82Q5X4V6Cd
         S3IYApxgkuGpnEHx8skDNATimnhC3/GLFJeYXSKpqf4Ayb4VbG8MDGi9VhJNks018cwI
         FJplmrYfIDgt0Y5qCDueey9tGGLXHPWEyyOqJ6r8OkUm6BWd3EWy89z9B7VYt8PVlwl2
         8mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439480; x=1772044280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgpWV7SaCAkmBJJvYVr1KKBvX2KdlgsaiXoeBQcaWzg=;
        b=vUaj7pmreBghSkAk3kYKXzGVY54nN8Tt8p+QzRYDvHZumtPq/9qRnoCoJUgA53FST1
         sjx14F06B/X+ULwt6WlKlrRezd4KD6Fxv8OgrKoHFYnmZgOLmE9l9OS1iRCRRkEx+GNG
         7F5pGSYMIvKSCd4fdNFwhywPt8lV1CWj0dbuYRQVgATagDSWzVy4CedI7oQYrdgzDlma
         jB6lcZjNud42WayC0t7Hk+FXcUanUEey/Rmenz23fjB5g6S3mRqlojbSO/mhswmpXs5C
         YeuM3TLaxV1Mex5KRm9fgdUl9rCa4KcfikmSkqk60XgVaIu4BuedLbvRkcc7bgp+fOrW
         XLXQ==
X-Gm-Message-State: AOJu0YwZNBRQgbWpGADfcBC2qml+E4jNMs6h0zFTC0XrGjStOxPJqb0b
	EjjO8VeeOMPW++pz9wFeL0zfEJxdDLn6lY+ReWk3/KxSyPhDuwLCE51nw8dX464IkOo=
X-Gm-Gg: AZuq6aKUA2ZG4BjM09IC7rjTb8hQoOuL3ZXic8UjzKZFQiHEx5ARHT9MYhN1/b0NqQ4
	zsxU4niDwR8n8Rc8hIx2iPDRC3coBGfr9pChMcWR4fc+96sJwU6OpbZrYW8+r8L4Qi17Gz8vnpT
	Ui6Ts8PSVRkwiyoNlcffVGGYkBuMSgtvrgF36q+1a05vUl8N3iGgmFb5PALou4numoi1ulBny+u
	3y7CX5ZHsa+2UDgqII0QGvnO7SQqsz+PuEMhHhHpq8obB372Z0m9W95UwhyA9/qYog4yUj8vsMt
	pt/SpWCJgaUAXy5ByH7borjqWYbAmtsy/pHkrjFk9gzB2NAz+TrmxCtJl0zQsJig5sKaqffMz3a
	WqzZpfHFDDMPtQQwyVr3UvjYI5wtnqprb5YnUTtD09/jX0fDYVca6Yn4XxwErA5lBtR+Zuig7wW
	nfjcR51gVp4S76D8/38/Lco6hP5Zz0J9CG2FmvMIXwpZyYE8h3ETE2LgKafi0G5Zw3rrlk3Z3nL
	iE4OvJCyOTWKLAmlQ==
X-Received: by 2002:a05:6122:328d:b0:566:398d:96b9 with SMTP id 71dfb90a1353d-568bf50ee87mr1104004e0c.1.1771439480303;
        Wed, 18 Feb 2026 10:31:20 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94afd1f1f82sm10959316241.8.2026.02.18.10.31.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:31:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/5] doc/btmon: Add missing documentation
Date: Wed, 18 Feb 2026 13:31:06 -0500
Message-ID: <20260218183110.2840582-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds missing documentation for -I/--iso and -N/--no-time options.
---
 doc/btmon.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/btmon.rst b/doc/btmon.rst
index 11d98a93b4b0..e51001921ab1 100644
--- a/doc/btmon.rst
+++ b/doc/btmon.rst
@@ -84,10 +84,15 @@ OPTIONS
 -T, --date                  Show a time and date information instead of
                             time offset.
 
+-N, --no-time               Suppress the time offset display entirely.
+
 -S, --sco                   Dump SCO traffic in raw hex format.
 
 -A, --a2dp                  Dump A2DP stream traffic in a raw hex format.
 
+-I, --iso                   Dump ISO stream traffic in raw hex format. Required
+                            to see LE Audio isochronous data in the output.
+
 -E IP, --ellisys IP         Send Ellisys HCI Injection.
 
 -P, --no-pager              Disable pager usage while reading the log file.
-- 
2.52.0

