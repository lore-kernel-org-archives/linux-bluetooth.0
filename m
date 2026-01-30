Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509732FE071
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769801994; cv=none; b=IiBfl0gvHrW7+dlGtMtYkZ0bK2g2C82Th6vH9NYYph2ew2lhc9wtLxnQy8+SlKkO/OYByUgqMK8P7oKtQXDWOtZchBCLc5+OXIR9xIopqHl3qpx0P41lu48XnDQnf+tA1CMLcv/Q+9Wo7YgvGU6R1QIHbBf4c+qJvd7gO0Cc6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769801994; c=relaxed/simple;
	bh=97iaxbmHxRCrzqTA0eIv1AgGpdyo+bz9Fu1vB0S+KeA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqrsUaOTzOs2/LUOnOhOJdFlcJj7oa7sYOwoscExcpDWn/JpVAkL3cd4F2dK3XZ/e1IKXkbDqig9oibyeidlxkd40pRodlShE0PNbuONaiXVhif7mGL5Fu7rtIk/uish2pxpvQvCj59UTUbSXs2EttjDATQ3FpQN7MQNYqHY85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZFH7doy; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZFH7doy"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-566474a6e10so1872861e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 11:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769801992; x=1770406792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KW+BI2EIG0luX9ZX3JfBIxvdJHtkw7e92yUGqvUkq/M=;
        b=fZFH7doyt37xQC2uVFcXschv0sNMGW2FsIT6L/Xh/WKBpGytL89AO0RTlRQO+EmL07
         uH8di4V3KQIvE7QXsaRPhNPwrBqWsadzr7Nmno2AZLuhL4yNv+B/ekYkKGK+4yUP/04W
         5CDYBQAdxJ9Tvw0EG69Hdw4jtX0VJRIgUTXT1ITBq1mVkmxf1h5CnhXFub4Pb6Jr65Fr
         Swmeadt/8yvMXm9IUnqGoW6sbS5o8qwAFettUPDfLzxMM2yXpJd7JNwTrBQ4wYOiimGM
         CPKdi4ydN5FzzfP5geg2Ku5I2GyurvKVAY3me/nf34l5ioOU0J/1EQiwYUhd7JM1aAIY
         LmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769801992; x=1770406792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KW+BI2EIG0luX9ZX3JfBIxvdJHtkw7e92yUGqvUkq/M=;
        b=h6UOBq5iVloFUc5haayDJ+2CVqV01ITbwcZmI/BapI7p/Yxw6gcx0c/yUmpL9WI5Jp
         xpQv67MXNQr4j9eUhoAtVzLY/RJpDu5uYEcs8UWCD2LI1MHmJ8sIkul91/ICXiiM3X/6
         y5jy1z0Mlag65io7JncAPfx6HKSQWwyEmECO8f4psSCbd/HoRkKTcS9FNhar6vaXKrZ7
         68A48R3Mh8vmGv7Y2Aa+abFVg+pHs0FVRYgDcF8A/jdLXvjC/4BoNvRSzOn5E9AafuI/
         sdpzXgM4KQA2lGeEdLZ58LD4MdKffwTmaHCJ/cHb2b8+ydIGsl0YOz4kmTveo3vf7ACX
         iPPg==
X-Gm-Message-State: AOJu0Yyf5gzo1jTCiRebsay56hnAx67k2hL67EU2J3C9X289u8WXeBX+
	8wziFi0IcEOLcnik2PgyIM//v2lomXX622q6ZdA0rOSLvioEYGygy8qFHXYPNg==
X-Gm-Gg: AZuq6aLN5NegNNCm1X87hMFEQPaiN6JOmCrXxYTTKMxCI8vHqCN9wjTo9KxIwUp5PAF
	WfiCRPB/1F1JbHTi6WzTNFKA5eOhk+iffSzKOSCZOI+bFmrB+IZe7OM/Y2LdYDRgO6GehmuGgqU
	DHLyfIp4/XaqYPAExCWbE3VkQWeqiSk+66vet7PyBbhOTVtTwrben5XlamaIzhxEuIX0e3ydkoC
	sT2Xrv46SZbKkWfueR3pJNeY1TOHdk1M4E7TkNZCT7XELdvvja76AFwLq8h3OohA/EOGai3VmTr
	Pvgko3eg0fzInwR+AuEARpKDRadR4NICvdIZIvHISbsbgoDLYSQTih+ltnuRZkDOZlXSszv9E4s
	ri3fYXl/jx9LpJH1stcgz1hy8a7a8JWhFaV0TlaFIcmM/cwjOmW43xakLew/pf/J84NFlNlyyHg
	wG8RdA1HhFnZB/HHlnVzcr3131X7HSeu050mg3Biak2poYjEg0SKzVkOJJxFtj16HCaa8dw5vox
	4ueEA==
X-Received: by 2002:a05:6122:12a2:b0:563:7886:5e7a with SMTP id 71dfb90a1353d-566a00380dbmr1067926e0c.9.1769801992064;
        Fri, 30 Jan 2026 11:39:52 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b0360fsm2523603e0c.1.2026.01.30.11.39.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 11:39:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 22/35] doc/org.bluez.Call: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 14:39:04 -0500
Message-ID: <20260130193921.1273263-23-luiz.dentz@gmail.com>
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

