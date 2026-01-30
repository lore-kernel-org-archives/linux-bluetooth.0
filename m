Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC59A2EB5CD
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810607; cv=none; b=JQxwUMiTl5I/5KS0wpAvSTgdkxdmuo7/HP4FWLFTNhCAZ9eEnkf+l/DynEYDOKwXD7PvdcN9HX+mTNWJZJjqCI1AowowSIj8pk24busIk/ePuCUSFT6uKp/CuVqeRxFmdAqtOi3Nk7xPNq8MzMbRQz6HfkqYtAUotUGXpkYDPKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810607; c=relaxed/simple;
	bh=vfedkvhLP15kN2BM14czxwTZb9RfGw8NOD+r29PNC4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1hMva5+MvekVVm0xW20o4Ej2DOBXC1F9TOAaPwks4J9drHio+03lnySxiHcWs0b6jsLFhQg8sT44oEgdQgs/3oE7NTyy12RQMqPLXXuimvOCKyfCRIgRRijXMPHYS2SEkT68/Ei2s9Vf/0EDJQ3BA65xGuXHvz3LQLwsTx3I0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcuEr/6M; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcuEr/6M"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5f526c39718so1561564137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810605; x=1770415405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3txg5Z7RHOvU/f1y0dDH0NjPsVjlM+8xe/3D8NReRUI=;
        b=lcuEr/6Mn65RzH5jG1lrip1dIlQlv/x5cHPcQLWvcVONQCjXM0nA/ukN+J5psGVwII
         9cUzixxAEmldYP63ZP6TKK213MmIaUKIWxnEbsUCp6ecFwqaxIAdIeH+Ohes9G7f1U6v
         FFaYnnoSfZmoDI6Og+Ce8smZk+9Z/KVpMZAwz6pSzQbttgmQCfud15tAOFEEVC2IwB9G
         NZbMOOhECBSYMk0Ee/oUIsVpGu/xb/pkKBVC8zDhRurcne7RCOKY4UEFG6O9xRCzT9iY
         r+l5euMmb6oaWacwupaxwWyMvO93k3s+f94rPv/7SwhG64lz7DYy2RADObmFWlxY+6CG
         FGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810605; x=1770415405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3txg5Z7RHOvU/f1y0dDH0NjPsVjlM+8xe/3D8NReRUI=;
        b=AW/QyuzEhPgpF1x3r7XxrF/ZY48D7KngiHSV6ho3cUj4siIZ2KDywXcX/l6FGW2EIu
         sBpCFx3gOlwxs4MnN4X+s9Gsa4ds7drjskXZbRrK8NUS7IrN6ywqZTrYQFI7WlIbLSzm
         yu8wrxrZb2tHtyjEp5xTTNpg1gWvk/zgZzNyExGgeCCXlwgME71jY1OI9s/WZBInRkaa
         1wCHb0KGr0v7gc2OZsH4e23zCRgCODi5TKI3hcQTDg1VbUNJRU9DiPWDemjR6cmz4OEE
         xE4KaBMUtHHzVKrfur81tqoiBkyCGz8dVQxHwqaPaWBjjqYljkU1S5mr6aGX4SBaTTSk
         PdmQ==
X-Gm-Message-State: AOJu0YymZJpRTkwOmWnGtk22MbZ/CUBUpgRPRNFqnUrtVV+qXDxID0iP
	AJDk6qpvo94sknw5s9VFWwAXNt+64DIlhccbJWb5BIsr9HjtkQFLGdmqniqL7A==
X-Gm-Gg: AZuq6aKKfEaGlp42Ix82DdHmRh7aAnHT/qRaUwc7NHgNxiZvPL+Y2yQhB0j1tsv/ZQh
	1lsqd+OrOJdGXjRnie9HHuyS3Aqc33hxCRiWJQOhl1uZjoWqW83+SP/ghUDgDajFgZoMoz9r60K
	Y9wxxmZADxWsK/fKuxlaZtD/lzvnRefKjB0Kw0Ahy0+LaYkxIofcLxO8hnsfWIzdGQubYu8oeeA
	eTpIUEMWyiaeDp/KvgVLuzpnV+sj1qW+M+XUDi32vma9FsVrhrnUwDPIMA9AM1uSJLBex4hvRcF
	xHBQbHwu4KBLag8m94WkWOXCHpmJHtL9Yfz0iJMJ4puW5EyEAmDDjX3VIZ/NtQIdVy/6Yfnztsy
	IDrZPZaIkee0fQ7pvfih/zzCn/qVR/CliwsBGWY9Bov9qeN/iXvW75Uc2Cpytt+jRkae822Ylqy
	oCfcx1AZQCrUtk80dyqFEZpaJPxM5Y7uSJdyim0tCHPSmxNi6AMsYxX9I0ZblN23Hrh0IslJM9R
	JQ0oQ==
X-Received: by 2002:a05:6102:3749:b0:5f1:6c5d:9b28 with SMTP id ada2fe7eead31-5f8e24c2019mr1439077137.15.1769810604627;
        Fri, 30 Jan 2026 14:03:24 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 37/37] doc/org.bluez.MediaItem: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:28 -0500
Message-ID: <20260130220229.1346261-38-luiz.dentz@gmail.com>
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

---
 doc/org.bluez.MediaItem.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/org.bluez.MediaItem.rst b/doc/org.bluez.MediaItem.rst
index 6e7e9adf7145..5ea02915a255 100644
--- a/doc/org.bluez.MediaItem.rst
+++ b/doc/org.bluez.MediaItem.rst
@@ -20,6 +20,7 @@ Interface
 :Object path:	freely definable (Target role)
 		[variable
 		prefix]/{hci0,hci1,...}/dev_{BDRADDR}/player#/item# (Controller role)
+:Used by:	**bluetoothctl-player(1)**
 
 Methods
 -------
@@ -34,6 +35,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: [player] > play [item]
+
 void AddtoNowPlaying()
 ``````````````````````
 
@@ -44,6 +49,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: [player] > queue <item>
+
 Properties
 ----------
 
-- 
2.52.0

