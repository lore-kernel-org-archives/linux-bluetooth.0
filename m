Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01663C1F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680920; cv=none; b=sQuX006K70cNR+CUkArHJSU0IJHDH/UvM8iVKvrN5MGtMvRDLV3S3KZGmxGI7Isf57iKA7BExeZQhdROx0rgF8/3qmWlADyMAmWx8075iIbIDutYdYrLHLOjj3w9sm4xOXSfdI3wncHppqyixWocLkzZNS+OodVVtPCzy+CaWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680920; c=relaxed/simple;
	bh=4o6p5IMu5XO0FEAwLuD9xjvbmId8l++O7tJcJFCNOGA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uKhybAU/APX+1p/KfNoqa7LdCBGJKCI6F41dtSCPJJl29Dd3K4YyNvUuFNO9f9jSuUb+rR3YY19Dewh21te0gqiMYmj+ErlCIDioaBWzlbQD7/isy3x9TqMb4eUCaATAx7J2aev95hgMpTpLdN4Hz/Ei11NpRUJvbY1EaNzENi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWr7H9xp; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWr7H9xp"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-520af4b872bso589813e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 10:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740680917; x=1741285717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9/aqkfFo2WZcpoxaLYSNpXO+vyH3OcXO27TPQP3rs5s=;
        b=fWr7H9xpX0Hm9WFncMr9H07w6ewGVyallmp6hEKpp5ndXOdzZSICCpyqOYWUiLpjyT
         4JCkrzbMy+u6XHPqVgguBLLEUxwWQnXdcsEn+xXihIwhev736kihkB0Aiq2AjSQGnPuY
         fIfNu3BIzD000l5BV2CBgUZsgtOGoj+2jRW4USV5yDDBlhj2mIMdpEAwxYnrR2Zufz2A
         6W2GQpRZtatjXorRLYacEYGe7HsLu7+D7G7mXw8SjMMmAjqXtziaCGdyuuAtN77NMmHb
         hocFXl0n7x/TY5Wipsr+3ZckuIr61UERGCS/YsSCVisRF27cXdFxZbA5FUeMWbTB3sta
         n7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740680917; x=1741285717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/aqkfFo2WZcpoxaLYSNpXO+vyH3OcXO27TPQP3rs5s=;
        b=O6b07v64V9Oz0qgcoKJ7b6/c1xesnxd2P7U/eL2srfMyY48/K8Ug8XjU1sv1qJhPaL
         S7K9MB2RvffDP0K4VV1xoKrP0RueuoXXdU5p5bIQadSJdpi5BTLSLqq+NatP0F1LCnq5
         aPf0msQjM8aFaDd3jmi1odhNyV+mse1lqKdFEq3N9jUHuwBOzF5PSY3w0ZTUaufoNmTD
         DRJk6cwMdRekxBl5q1Uo3RqLoXncWRosul3IgNhorZADnkzumlBsQRIdM/73tKTEq5ZN
         H0Tzbnd49ECVXWKbxUfaUreFrDi0cyIzOQxK/7KP0C5PkKtDIQW8KbP0I32qVPzgeQy9
         LAPw==
X-Gm-Message-State: AOJu0YyhALFxU5IvB+LJ1YBkvjQx4C3+oVtpgrZHYdegTPokb/EuV2Wy
	aptpiqCs7DnaAvzd73P6G4YjWpbNFnBY9ZdzhKnRaxXA6Qb2P9b3dWHsyPn5
X-Gm-Gg: ASbGncsUg+H9wLEyNCY1pQehOwam1kd5EnTam3HQTtuURQ9tj6TGjSCQ+mgQRQ+Xney
	QJ/YAXo+I4WUQR0lrAaQTXGiAnHpWF3Ca8fYIsNCNSlYL5VUh8LOI7kenaHKo2DEI+pMufzog4g
	0tiXfe+hyGNOEjQISCymQU4qO/UIpabgFSiPx16A5C7HpbiGWVHLi7jujvi7LsAm9ixrm4R71Lt
	gfsZQOhYrVNyeyFHQky4iWtgpuNm/Deiab7Ml2+LKTIiQvoXKSAqIM9dyf5FIhEOoFf5vXDXEON
	CpO3PUPY4ri+YGm/u2+QvWvsfjyOOKS9bb6SoBGbeR2h7ZGP+K3ZwlfY33kMXk5qNkLBxRg=
X-Google-Smtp-Source: AGHT+IEdKPa+Z+sR5DL6fAsojGv0t+l4EmCvkVLCzJr45J9V2iaJ/sfQ4wOFGcSvjhFN+DdOt8wZ8w==
X-Received: by 2002:a05:6122:8293:b0:520:51a4:b819 with SMTP id 71dfb90a1353d-5235b519b28mr119432e0c.1.1740680916920;
        Thu, 27 Feb 2025 10:28:36 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5234bf07749sm304317e0c.20.2025.02.27.10.28.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 10:28:34 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] oeg.bluez.Adapter: Fix DuplicateData default value
Date: Thu, 27 Feb 2025 13:28:32 -0500
Message-ID: <20250227182832.3228513-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The default is false not true.

Fixes: https://github.com/bluez/bluez/issues/1113
---
 doc/org.bluez.Adapter.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/org.bluez.Adapter.rst b/doc/org.bluez.Adapter.rst
index 3f5fdc8fe994..021e4f8e5a9f 100644
--- a/doc/org.bluez.Adapter.rst
+++ b/doc/org.bluez.Adapter.rst
@@ -125,7 +125,7 @@ void SetDiscoveryFilter(dict filter)
 			LE scan only.
 
 
-	:bool DuplicateData (Default true):
+	:bool DuplicateData (Default false):
 
 		Disables duplicate detection of advertisement data.
 
-- 
2.48.1

