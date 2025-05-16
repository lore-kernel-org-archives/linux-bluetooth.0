Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD2276025
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419457; cv=none; b=gTzL0goZvT0Atq9jY3gwtvf6g3uy9KpIXIn0do5tTw2O4525bmHb71FipC22MmNpa1ThEouevM048ouBbHOwaxjwbsztyPkD/R2w7UUVtaF21vI13UocTSLeqsASle1z2n7MX6NstNDaXuHn9RUqf+gbIf5cxJkSvaoMSV0Ww+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419457; c=relaxed/simple;
	bh=D2rs6A2ndYwJpQgBvQtK6TGGR/77pIA9wg2IyKm31Z4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P86/qOi/T8nQj4b8dptVyPuvcJvUcikVasdsyXQoHELUgFxUvJopSyO85PFHrHE4F8nht6DPToVPirEBzAeXx9WKNikAkidT6sbrGAlrOyKs0+qzncGYaft99sn8mdOk1ut0v+sHxGLIuxO0JwE3N4440EgKgq4ZETxo87wtxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmAh4ymQ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmAh4ymQ"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-87bfa88c10eso129513241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419454; x=1748024254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSjLveC7pr58rI4iZYMvRk3A4I96+OZTMyaZRirpzlU=;
        b=QmAh4ymQ4n8GUebpLdBVc4cZUzMceVOsMa0nTbdgHaEVE5p2Q3VIQLv921nseopzQw
         yFa/7tdKe5ij1JVtgetZsDmdYkY9Gktg3NAvuqdA3supWz3ijmKt+Mz0WC202E7qBlab
         pf+F/4PAnej5zqKOITqFdjuGLERn6ofC87vERPTdxibDCU1D1DmS2dc7znohRSNvap6d
         B38x9OKVv400r+/+Y+nq1DOjAFoa04TlK5bMvFMW+X2pfPTddqWN++/hQ/lE+x+QRJ2j
         t3xvTbkUD+mq4Z0QWxCF4ssxQM2puTL7oqePlwHBy3bwe8MeySdLHmbQdQ2ND9fApuKp
         IisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419454; x=1748024254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSjLveC7pr58rI4iZYMvRk3A4I96+OZTMyaZRirpzlU=;
        b=v/vs/t5TqFH5ZhqjaNkhp407M2cJnC1eSRdtgblYg9ZqY9V1SPaKtIYcA+f0n3Exz2
         4pYHJ6NW56hm+4UNVmTcl1U2GGzfmo5qc5o4fz5E49Rp6UovCRVb6beKhsZ7c3hllIOG
         KNzId4eVoxogMHiikJI9MYLZIAqmPU3Cvr/vIkeKv3sCFq5S0dwAeQXXGqWf7n4cklen
         is0/VvFXkyXuU6sWYMtiU+nJW3aGJNzRpURSx9vuZ9hWynUBjh6ffOHCG2xZbP2OrOo1
         Ge3PeyJRK96LTf2cKf3bXfO3hpYSJOzEcEVbPM8vfpZ8wq6esF4Z1ICKdINQMRO19Cf4
         kHUA==
X-Gm-Message-State: AOJu0YxaDpEjeUBwfG89pIbtRx6qxljeGZ8I8nxp00X1+l+YDr1srrwe
	anVkwvJrGMQ0xKghQ1438GnfzkV6NOzrybND/LLCQPELf4xERsc1LHH68HeNGkxAQqI=
X-Gm-Gg: ASbGnctcB0KwplviwRV/svUPU2WTmJWKbmXChe9hjaAl73c2zUOQM/mE7M0ICWqWiQo
	RpXjKE13q+acE34sTPRVgEUhcpHougEZn9VEhnKeR081oULCxXNtp+alQGvKQpUEu9tIQ6pjHL+
	j0ssk/JU0HqPiXtQz5DV3737dQhakuKVI0vksglobE1iRBwrCQhkR+PpAXVYr1sPxaBuIQ0Df9z
	0TMAC/qxW1PZfARmzHeNJA9znjxtNja4ACmCXDA9s7LTNLBJVNmnNxB0YKfHw3ZJAsnTo4Cq3YU
	4auNFwnTZBAoUKWbzBNZLpjNwkSCV7MtgLVsk4eMnCG+I/DFeZgvkrvTe73eB61oSBvU2GzjR0G
	Txn6Pm4bSTv00ad8MulVb
X-Google-Smtp-Source: AGHT+IEFoWRCbP9NuBjtQ3pcLgRxvNT1WXEiuLnMRCK6DEeMfQYYeE42Hd/CIyeLPXrLhvDCda4J7Q==
X-Received: by 2002:a05:6122:4d12:b0:529:373:fcb7 with SMTP id 71dfb90a1353d-52dba971e52mr6039786e0c.10.1747419453865;
        Fri, 16 May 2025 11:17:33 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec1efc05sm2116134241.22.2025.05.16.11.17.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:17:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] org.bluez.Device: Add last-used option to PreferredBearer
Date: Fri, 16 May 2025 14:17:30 -0400
Message-ID: <20250516181731.1967217-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds last-used option to PreferredBearer which when set would
make Connect to use the last used bearer first.
---
 doc/org.bluez.Device.rst | 8 ++++++--
 doc/settings-storage.txt | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index 80501eddd055..205f65761b75 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -369,9 +369,9 @@ string PreferredBearer [readwrite, optional, experimental]
 
 	Possible values:
 
-	:"last-seen":
+	:"last-used":
 
-		Connect to last seen bearer first. Default.
+		Connect to last used bearer first. Default.
 
 	:"bredr":
 
@@ -380,3 +380,7 @@ string PreferredBearer [readwrite, optional, experimental]
 	:"le":
 
 		Connect to LE first.
+
+	:"last-seen":
+
+		Connect to last seen bearer first.
diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 4e9881eedf02..fe862c7db78b 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -294,7 +294,7 @@ Long term key) related to a remote device.
 					separated by ";"
 
   PreferredBearer	String		Preferred bearer for remote device
-
+  LastUsedBearer	String		Last used bearer for remote device
 
 [DeviceID] group contains:
 
-- 
2.49.0

