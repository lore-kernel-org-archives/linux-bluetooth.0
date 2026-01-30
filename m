Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECF354ACC
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810594; cv=none; b=WX2F248N5el7AcI82u8rMbLoThqWIFjaOnFk9EYer7eKAruNM+hEAEgGehoXczE+E6B17w7E/CwPw6Q3HBWnpeXGR4QopecTcF7UvYRpVCxlsvrspxFROhr5HD90By5YtoX02KJ5EweyQYs+v+fVFcakfg2dEvdbguDPAFWOMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810594; c=relaxed/simple;
	bh=Jlj1rKRjBVzxVgIBRyxKkutBwB8j4Tzz9JHRvDsiUBQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNiS6mYvX+N5Fu5g2qOwRE/bqJ0GjpssLMjuXfnc6hsrMyFc9dqV14wyDf3uLjsqGi2a/WZ+ZNbhH0lU72/TpGSL2P5y4AOTbtU2DMByyoC8G72knBIhXFW0IDpVWlbAmQx/kTvFN2kZEhM5eqKaa2nUrKUbUiQvQ0RhgV6jLOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9eDNMeK; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9eDNMeK"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5f526c39718so1561461137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810592; x=1770415392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpxokMcsUKLLXK+q7Jo4BGBByS2O/KS/N+91aOel2yk=;
        b=L9eDNMeKUD99d4xFIp48yYfm7SyTnY65EHDoo22/YlkS0bQVZe5GWH1MDN2qug4E/C
         G9O/ZNmG4rc4TVsNlRQBAHBJ0HLRiYlcjkULNw5RpJ0M1xWzcrzjU7ctOTXy9vam5KPM
         Pq1Hjl3cpKLgbuaMCOf2oBBtpD7bohme0oVlI1+Bt2HZSlcr9NhcfnK/qmcqXHzXECLc
         bnqvI7cLX+0JZrsKUoz1CAlmivns1RYnbPP2TzyQ5yFjNT9VvL8dPhhqMrU1SJiQrjnc
         9fuMqjn1n5uA607Z3UkphoyaDQY/6EhjDjl/q8TH8eO/1PPRxjlyD8THfhzudE7NaRrS
         Weuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810592; x=1770415392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MpxokMcsUKLLXK+q7Jo4BGBByS2O/KS/N+91aOel2yk=;
        b=Aj/tRgLgQMgvUvHLtCUDGa+amWLqQqfkn385c20HtlYVMgvAD5X5LqH51g4OIQhv+G
         4b/K5hJmlz7ihPsd9uvXH5jUn0ZG0lYxIZWTjeo2TBOICRkqywIAACj0FQCmU9fho+RG
         yeNjkkUcrPNNrkexWZfMGkZQOGeuc588f6iEMPeOut/4snVyUOSlZPvm2rUd7DudHDBN
         CI8JrN07kvi7f/+1uOoUwxQ9U5nawYqe7Co6I3JfW9cUAj3/hYPgcKpBIHtu9CpyjqBl
         SV3KtY+hVJXAVGmu8vOfybVm5+XL4JZBcrcC67A/Ock1EG8LPPo1GSuHFSHK78N6eh1L
         ZrDw==
X-Gm-Message-State: AOJu0YzWKJBggnuqyE+aZ0zRwGOIujPP518wZoEc9c9Ew6mObNIW75TZ
	3nJOUE9UoGpy2qL9NU39bPhZD8VmR4G0HPtJj21fwaGOkmYJUrTnANYpuw6cqA==
X-Gm-Gg: AZuq6aIFE6tg3jI3ZKFmlKxASj7OXLpgTSERhn6/9Iq8hkgA1GLvgH9ilYgXKPMVoqw
	euuK9eIB5dkOwcU5edkkPC97p8e79O3Am+apkYVGIdgPZSVM5xWvEqYYGt7ZJxkbOivj9r6NcwW
	Y2xJd0iaKWDZ7j1V0StugbR4RnySCUVJ89VZD4BVFeHhTB6+4M6WyKdbfMTTrkkazPQk3w2vdzG
	8/M/A9swN1fSY5rq3OgJnLBQmL/x8FYElRn1+BtIJyajGxPx2GbgLoOlKOB0kT0R8uMkv8CZbTr
	n8XOLlF5mtOJMPk0wZLarznsP3qh+Yn3MxNcjwLYaruKbsg1s8+B0oZkRW0DYWmFd5YHgzHfTM7
	iIchSHokuPETFgDHIkuC2NSdyybUKPtSd2afH+GNPqypSlNy+eV7sl8eXMY9JYm7P42hiwgmr8S
	lr31hyEJyWyOL4+myc6aGygDVxLp7SsugcapJ5I4t1wtDS1JqIDs7APY0bporX7hboX3c7y1+Gk
	fS3Uw==
X-Received: by 2002:a67:f28e:0:b0:5f8:ee12:db2a with SMTP id ada2fe7eead31-5f8ee12eb8dmr601570137.23.1769810591838;
        Fri, 30 Jan 2026 14:03:11 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:11 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 26/37] doc/org.bluez.GattManager: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:17 -0500
Message-ID: <20260130220229.1346261-27-luiz.dentz@gmail.com>
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

Add :Used by: field linking to bluetoothctl-gatt and Examples sections
showing corresponding bluetoothctl commands for GATT application methods.
---
 doc/org.bluez.GattManager.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.GattManager.rst b/doc/org.bluez.GattManager.rst
index 2501530d8112..cb2a7f8ff86e 100644
--- a/doc/org.bluez.GattManager.rst
+++ b/doc/org.bluez.GattManager.rst
@@ -81,6 +81,7 @@ Interface
 :Service:	org.bluez
 :Interface:	org.bluez.GattManager1
 :Object path:	[variable prefix]/{hci0,hci1,...}
+:Used by:	**bluetoothctl-gatt(1)**
 
 Methods
 -------
@@ -100,6 +101,10 @@ Possible errors:
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.AlreadyExists:
 
+Examples:
+
+:bluetoothctl: > gatt.register-application [UUID ...]
+
 void UnregisterApplication(object application)
 ``````````````````````````````````````````````
 
@@ -111,3 +116,7 @@ Possible errors:
 
 :org.bluez.Error.InvalidArguments:
 :org.bluez.Error.DoesNotExist:
+
+Examples:
+
+:bluetoothctl: > gatt.unregister-application
-- 
2.52.0

