Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657D3542E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810606; cv=none; b=T6aSo0qRUlfLh390OmGqf2eTNX4iqhANL8NaIvrEPf3o+p/mYu6+JWpW7T+5zwBaaQ8StamJHRsYbfDdFY8e81J7la7ReW/UPlGJfjec0ub6p0+xNC3JFU5D3mfvvx2S2tpRDhZXtgH5W5Xo6HO0SAYM1ufQc/9932/1e5p1WcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810606; c=relaxed/simple;
	bh=o6yGa9bji2Vz3W1QgcMtqeOfg7Gg/fBFIW3u5f2x0c4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWJsZF0YKAee8Jl1ilIhK6RYaeo+ksF0hdTwQmxAe/uaBJeUNCHPLXute9BbDmn4bzL2n9+QgFABAshg4xullqVOt6Kmw22flCUJQSnVhMXyI9K4p3mBInndZyuc2B3jL8DJ+/jhPZs0hxlPasTYNfXnio2UtxnQCx9EtSOLFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNbiSrm5; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNbiSrm5"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5635f3eff8aso733734e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jan 2026 14:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769810603; x=1770415403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3PMEfaezkdr86KarKqAmI4O8BowLuKFZtAK6FKaSs+w=;
        b=XNbiSrm5iW3ftgSZWtKDDbzvP6rM045jehncxNekndR4McnVVbSC6cJP2DWsDewg/F
         cAsBHAXoa1TtSCbr67ZyjuSwOtUaFO18+r5m9jD5g6iCNR3CjsmAWFGDx5ovNUf3qcL7
         A+Go47pJ2DomLBu2C8N/SYwF6FAvUVg8affOLnwVPzpaF+4ZqdaAUd7dn64uDipiEowT
         cI8b2oSYL2ilefR5022HT8mQOD9XKwIQoy7PzVBY5+Ro24Qstb7pwxVX2fXcO7OniciY
         F2DgHPoObkioT0NI7a+OIj/wTrZFZnpipboytAQDFf6y4AK3/US1HNGlQqLuCWy+W7pL
         1x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769810603; x=1770415403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3PMEfaezkdr86KarKqAmI4O8BowLuKFZtAK6FKaSs+w=;
        b=aOdofMmrBx14K8ja6aqSpa9v7tCOteMtohkXkQ3hvDcPCaV/iUWkQzQMBqYR6qZfFo
         mXX632WlzjveByG+bHZHpUGBFNqxcCoEUdzgdPZqzozn2aPowSfMgMTICl4rm4GHY6hB
         dYTapPmOS2qsKeFTgzCiqoxI/fgCqQGHeWprabZh16pxlxJKGU/EsJyAiki1rFdeBBLr
         wUk7Bgg6tfonK/3F7z/pgDeceFOHksMcRi3wZA09RNwJdjNTaJKqg1dmWX7QiP0fI4Oc
         RMy51zBvhH7VXonoMjNSpE5b0ugKXNg5CjplSWtRy30dMpJiG51a3BimzSzROQrwptlZ
         0rAQ==
X-Gm-Message-State: AOJu0YxiOOr2NFoLSr+cPCq4JaCipK/b2Z+Ve6ixxQ4+d+F4PD0gVMF/
	MJGWIITdstrJ72i4ZWeqmyZ+vRCs9ErlpRTIeSPlAHO1wLMu3WC6efNczRlovg==
X-Gm-Gg: AZuq6aJNaXpfuQOMiEBB4oh2DDZhqzavesdtjvMP4I3tyVfUytjTfnkjaH4IqN1oT0w
	T7qBQlwXW6x+i+ph8B8aeWFQLZz/SxYVCTUc0Vq5lYN5pzH6nph6oNjOlmZqOV3yPZx+GhJCVfE
	KsYkVP8woeSqsKJirpFwlAumLgCTnawG3FNTcnxH7zbn17hf8n4/gvEXlYzntSn2BUjWb5TzpOC
	wYE6iRjWvirl/d0PONVstgSMqO0eX2FinOMkCZgknk99RcpaxKJBTDg9pbvafo9cXnDbBV0eyfH
	TfS/zX6yMeS/ORP1TPuCNV3JZi5sZeMVMzO1+2uDdybj/OfcetT56PSRoIbohIioIota48xwsNc
	9O7InIm6GovpfHybbzYrk4o+1qPyFLvW+311g/cmlC2bn4ro4R5NggDou1Rh0PQCTeXiz2sjM6j
	HS6SvavzYd6byAKJIqZSmCzki/wV3CN8uu0Vqu73uyVIYjIo/a77bx+ZjTb5vNb1LXnpRkqLvor
	ffXw+pInXJBSFk1
X-Received: by 2002:a05:6102:6c3:b0:5f7:24dc:3ac3 with SMTP id ada2fe7eead31-5f8e23e69eamr1317403137.7.1769810603545;
        Fri, 30 Jan 2026 14:03:23 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-948723adb7csm2404052241.2.2026.01.30.14.03.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:03:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 36/37] doc/org.bluez.MediaFolder: Add Used by reference and Examples
Date: Fri, 30 Jan 2026 17:02:27 -0500
Message-ID: <20260130220229.1346261-37-luiz.dentz@gmail.com>
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
 doc/org.bluez.MediaFolder.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/org.bluez.MediaFolder.rst b/doc/org.bluez.MediaFolder.rst
index d868c5ebb380..d742fa8561d8 100644
--- a/doc/org.bluez.MediaFolder.rst
+++ b/doc/org.bluez.MediaFolder.rst
@@ -19,6 +19,7 @@ Interface
 :Interface:	org.bluez.MediaFolder1
 :Object path:	freely definable (Target role)
 		[variable prefix]/{hci0,hci1,...}/dev_{BDRADDR}/player# (Controller role)
+:Used by:	**bluetoothctl-player(1)**
 
 Methods
 -------
@@ -36,6 +37,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: [player] > search <string>
+
 array{objects, properties} ListItems(dict filter)
 `````````````````````````````````````````````````
 
@@ -47,6 +52,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: [player] > list-items [start] [end]
+
 void ChangeFolder(object folder)
 ````````````````````````````````
 
@@ -62,6 +71,10 @@ Possible Errors:
 :org.bluez.Error.NotSupported:
 :org.bluez.Error.Failed:
 
+Examples:
+
+:bluetoothctl: [player] > change-folder <item>
+
 Properties
 ----------
 
-- 
2.52.0

