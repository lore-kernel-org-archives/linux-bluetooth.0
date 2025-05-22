Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4B199230
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935002; cv=none; b=Tf8LaMu9ttvf78Me0E0muB31kYQ3t8pbWqy0i2aLIMeEWwDDGTIc0pNrzCi9H7+ciP7ylAD7zDvza0gI64QAOEDjqstkSXSsbjVZIgDoiK4PjEtATz6Ql0nNN9WXqldNNh4s9yuWj4MXwG/Xp5VV5qqzU0QvvwS1F652wYVVNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935002; c=relaxed/simple;
	bh=V9moyCEvcreBrmKtmYS+DmumWNR2WbQ6dAJHdwX3Rp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIRhtl3SNwKNolmwkCOfHlGsgu1xhxz6/aBwcl8Oj+3ryuKwwIXb6ULh6QPzSY/ZwWnmnlz6XIHWajDVXQv8Ux6sRnY1CyaDiAdm/ew1IJCYTY+C4fwfgI/5lf3LwyhF5MtNdHlwdI7Ynga0GdZSK6aHNIO5DIbehz7aMJZLPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbmLA0Mg; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbmLA0Mg"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52934f4fb23so5497466e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747934999; x=1748539799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9m4+0OIIskS7vHvSoBI6wzMv5zKIWeD/uVc6SDRQhLc=;
        b=gbmLA0MgSXzAqMQCPp5iNauIVVJKC3XxvdJJwnfX+5TRWFaF+gsQMR0rrYr2KXIRIP
         ZOyri0RKYWcrCWwBoWVLYGaq2SghphC89zQx4S97BQwwAbfDED3s/1kWaZGtik69ftGn
         A+BMxm9hHgDioT65kcWexfkVnpNobtr53SjwJpTxm4To///t41c0fzpZCabxMzCxGGQa
         PKhtWR47vrZquGZ5iWJzfUeWfHIg8FjPs74bDGxmuX3M2y+FJCXdMS64S/8amR+v451e
         DctVc0y/Ew1oFKVaRHG8ijs4J8eSXlkOCxQbB3OiclnHVAtauSI2XZiMq8vQwUZHdL2B
         VsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747934999; x=1748539799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9m4+0OIIskS7vHvSoBI6wzMv5zKIWeD/uVc6SDRQhLc=;
        b=AuJVILFT9NvkptiUiW6dWQx05tPibtak7dIGnX7xYzydUhD1gtTw6keToc3o+jMmUl
         +mLwuC1aj2jVW4L/GrzrtbvHeHRSgUJwDtbm+PD8xly/OaX1j6utxMXjke6RuVaYJXeL
         otMjvmvF1a7PeBobu+f/tY9KbcSvGdPLWkn3LB5XhwyylAJrctERLjHI6hZej2WIyFPz
         HgMCVobJxH6dKIrKoA0yQTrVSEyrtKRkFtm0c7o2Ej4nTcW7zJ0pimoowdIPuHEYrjxq
         tDtWnmMN1UOMgDfp8qeWGzWXEkXaDNDQWVd8H/WPS99rlwacpkX6wmVxlF5pq5reg6Nu
         QiXg==
X-Gm-Message-State: AOJu0YyH3IXQ1kfUsY0vRtHhGFg4dX3SKY77i4GedCc3w0BgZhYLWuEt
	cz3oa8J6SQ6bAlWreiDlV3GkN1cyROdR2qpFK2eVSwyx2wha3MTjxcGueQt6kGOM
X-Gm-Gg: ASbGnctRCiM8X1EjfgTdfRWEV96l694qbB9O6omoGaDDghQTfDTlrC8s9OY95eUhATT
	ATcgog4K+moXFrHV22AJNVauIa20/WDeARdt4aSvxZmAeBMu0+neai1C4Y0FWdq8Upzf+mWFc1y
	xGnTilUHpcdGmqRq6h1cNBAlrvjDMD3xJCXwOupr7h6+nHj5Xy25eVQTiIIDN/TnFlu1hPydiWE
	yUyeN940cpI/iWk+LniqTI48zQ8WvRbXi1OCcDmG1km+bJAhS0Fr7JAesERSLH0mq10bffo1JlW
	ItbK8uc/wOunIaIcUDGvyEczFGZUn9LL6ORiaqSreleNdNfmfR5kgB067TCgL9K2WkY6N5ZofzP
	nrhDhhmNdCKsDCj8607HK
X-Google-Smtp-Source: AGHT+IGF7OHmMFMutc7g0hXmE7L2SER26MRxuq5x4Kn7ESipmnKAMMvOC3DS/mgWZNu7wHtzhh9puw==
X-Received: by 2002:a05:6122:46a7:b0:523:dd87:fe95 with SMTP id 71dfb90a1353d-52dba928373mr25711335e0c.9.1747934999444;
        Thu, 22 May 2025 10:29:59 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba91076esm12220321e0c.3.2025.05.22.10.29.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 10:29:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/4] bluetoothctl-scan: Add documentation for auto-connect command
Date: Thu, 22 May 2025 13:29:52 -0400
Message-ID: <20250522172952.3312270-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522172952.3312270-1-luiz.dentz@gmail.com>
References: <20250522172952.3312270-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds documentation for auto-connect command.
---
 client/bluetoothctl-scan.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/client/bluetoothctl-scan.rst b/client/bluetoothctl-scan.rst
index b4b8315926a2..cee255131622 100644
--- a/client/bluetoothctl-scan.rst
+++ b/client/bluetoothctl-scan.rst
@@ -122,6 +122,16 @@ When set, it disregards device discoverable flags.
 :Usage: **> pattern [value]**
 
 
+auto-connect
+------------
+
+Set/Get auto-connect filter.
+
+Connect to discovered devices automatically if pattern filter has been set and
+it matches the device address or name and the device is connectable.
+
+:Usage: **> auto-connect [on/off]**
+
 clear
 -----
 
-- 
2.49.0

