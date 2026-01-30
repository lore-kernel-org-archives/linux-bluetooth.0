Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2972FB093
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810589; cv=none; b=OU3YbOrPoSfrd45p35sUsYp6J77g6u7V4Uu2cQQZjTPDKdOKlD0fF41UHtTC5B7Zob367NO4bV4EoMHfGY/rxTtqnVkwZq1B4Mk+Ir/hTgB+Wbnwrz5P5XcSQavEl6ifGXFkRoiVYsDHzXluYe27XexW9uQQBbBfjeLv4PwF/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810589; c=relaxed/simple;
	bh=97iaxbmHxRCrzqTA0eIv1AgGpdyo+bz9Fu1vB0S+KeA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HT+g64tfHWdcPNckCeSaQkY/wzhX+tSJn+zakoxw6Mq9i24PW0/Z+qMhQQaKj6HyQ9sovVfx5ByCRtJKNyY1C4N9jbd8RBDOKg3tqpzoGIIV+yhSl0C66HT0Kj6NvdAEvOFChejGIKoC4cg9+bJbFPGhZpYPcvlrN623WI+zxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX3eWu0B; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX3eWu0B"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5f53ba9c548so851190137.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810587; x=1770415387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KW+BI2EIG0luX9ZX3JfBIxvdJHtkw7e92yUGqvUkq/M=;
        b=GX3eWu0BuMy+ePCayT6jBozIP9bGfNWca0HftGumdr9twveAGa6cJWC51kd8K3CMe5
         hbzZYtGXrtXyWPBmsR7uj/sFHHqMvNGWgZ0nkusLB7Dvws9ZHKcJvPNtteoTRgjlHCQw
         SFp6rFBAPpgtGkZAJJAC5fe+9gsvfPy3L7UBOmAjGgMaRXp2xOce3Lf4aPBKXiWPPlOy
         F2/VhzkkTgsGCeF2FsZ4KbpUtQvirHCczBIpV3daN3ECe87BXvS1GUDa/cSYqLiQW7ea
         1CXDXGSZ031+GOFirhPYRFUWv+UQFH802FpJrANXnYEU9eJhjVpHhZyc/erfQvbatdHs
         +//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810587; x=1770415387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KW+BI2EIG0luX9ZX3JfBIxvdJHtkw7e92yUGqvUkq/M=;
        b=FuMUw7XqrY54AT7+PAmY9OSgdD+cl8vuhieHkYwj2yoj2OzYFy4vObaZt0mPbJt/1e
         7yDTEfjOC32d3WdpoTNY0LzW8dJoddwVxQVJb3KjfflQQXAJn3rn6KXPO2fCuzqHPNo5
         pqiYmMSmizYAvwonim+Lg1JjdsAoj/i4q7Ch1CoClXpsfQhs0isyhmDvlvNx3N0/p4mJ
         WcW7JHJMKwI6d6wdymSWH5EC3lbT7KxMw41X7zS2wQnFjlOYsBr5y9Pbe5Lyb9avh9T4
         q5cSY008B36OKPmbI7oyWLsSRf3C5IgZMLxxYfff7YkQOlarOOdX7Mz+5LvpJQ1WuHYH
         Iejw==
X-Gm-Message-State: AOJu0YxBeSCpXeknldWUSDyWdwpqaVw8CbwwctJsQ36/AQ0lpAQFmgWq
	JUpNGnQch/O40HcZVtmhvK9Tx46hIfvANme7iCYTvRUw4+K3d6Jz5vB/BLXL+Q==
X-Gm-Gg: AZuq6aL7XTNPnJQamZAyYLFDzHxaq7KNYiWyoVq3RmypLj7VX1RvKHwIYPVav7aC2Av
	CmSTuRYmNkWWB/j8/HWdzPHP7vOMOsx7tJ6VromJGArt09zXFh1N5taFr68Igz/X7jhCpO8FLlw
	+SU6RV3JmzIiG4yFnw6u1Xw2Y4XAY0PszBDbjVNRvD4JaGVC0wmuxvKsm/bltvKBurPw3c7/CeJ
	YB007UbH2mCbQ5p4N/kerUAx/mQ3BZ46WE5uA7j47HX25nlgaRztEgF6Z+gwlcByn6ToUtR0X99
	aVTBeGlzKvE1170QbEVI/4aXOYEat0PRXWKyL1Gh2WaFEO7nsb3LeEcP5XX3LVaI4uOb1j2Yb32
	yV92hw9C9owln26VbSQllPRHFm1iltUVPpIEWjov2uRejkyN0R8mkt07V8N1UWEkKUF0d1ttixd
	WR9QtwsYVDx0ZHHlSpsdt2kkL5sMgkgOBTfRMSduDWFD6ddAcNUZteb6o1e6S6Pigcl0cbvgNiJ
	X/iGw==
X-Received: by 2002:a05:6102:c16:b0:5f5:3ba4:312f with SMTP id ada2fe7eead31-5f8e255b88emr1255506137.20.1769810587208;
        Fri, 30 Jan 2026 14:03:07 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 22/37] doc/org.bluez.Call: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:13 -0500
Message-ID: <20260130220229.1346261-23-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-telephony and Examples
sections showing corresponding bluetoothctl commands for call methods.
---
 doc/org.bluez.Call.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.Call.rst b/doc/org.bluez.Call.rst
index 8825e0f17231..e4e043f49f96 100644
--- a/doc/org.bluez.Call.rst
+++ b/doc/org.bluez.Call.rst
@@ -17,6 +17,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.Call1 [experimental]
 :Object path:	[variable prefix]/{hci0,hci1,...}/dev_{BDADDR}/telephony#/call#
+:Used by:	**bluetoothctl-telephony(1)**
 
 Methods
 -------
@@ -30,6 +31,10 @@ Possible Errors:
 :org.bluez.Error.InvalidState
 :org.bluez.Error.Failed
 
+Examples:
+
+:bluetoothctl: > telephony.answer <call>
+
 void Hangup()
 `````````````
 
@@ -62,6 +67,10 @@ Possible Errors:
 :org.bluez.Error.InvalidState
 :org.bluez.Error.Failed
 
+Examples:
+
+:bluetoothctl: > telephony.hangup <call>
+
 Properties
 ----------
 
-- 
2.52.0

