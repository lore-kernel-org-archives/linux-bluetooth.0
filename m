Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CC21AAE23
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066290; cv=none; b=GFJQ8V1PX0uCWOgLyRsckeKPDZxuL5u7GjdGnFYjYPoX1zHrVh4cdflLtCX7GHhlo2DGyFFg5suuuvvZWGzEfVDDB7c1gq/fc7kPTBDas5BKuz6fiX5jWyTurfTDyIeVJiKegYILev5H24sjwZa86GVoT4vgsjZx9LLQQJSOHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066290; c=relaxed/simple;
	bh=6acP4DT0RWXg1w8zoMI84YVCKF3hfcZFyavi1onXYwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPpTqx/7Bw6JbA2ywwWtRFVJbaWciRMnvyjPXljTHxh1XF93tXcv4IjP8S3aowz1eY3izniix8qj4yJU+A03/gJ2cS6tdMts0oN+WnmY1HnFzwh6yDnq4xom2uvubmV56pSG5bgBr4HH4nTlCDIfVdtyLouVMdASeaP+mcy1PwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C302cKNf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C302cKNf"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b9761eecso1644560f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 07:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066287; x=1726671087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dO8mvOVta2kBXYCz2E0HVGW4ezYp/G6MUNiDNivvII=;
        b=C302cKNfBDb9839Vvo4SZA/HhfejXqtVgsuXjWESSN0n6vpKfTkUUZAHVq2Eapsj7C
         tzqUzwiWRdMHFIqLZrhgILtA3wa8Pv9bbzdEvVeYJ1lTcNKLVkuRBOcZbw7QfYp65U9b
         8OaVIBplH+wESD/RXZh+NX6RqCI+jDkqUvxB8M2RlkyFaLe36Kw3p6BmbSQaOiWqTwy7
         SWOaRU1UwJ9/wt/3xaqlmQ7i75D9wGQYjFqEqVmP8Uqe7M21+uZEKkyrPCC4vvKhO6fm
         o4UW/mdoPz1a+5BLIYtrXXrgHAQhYFWARUXwtw7Cf4n74E8CNdqKeuGn51TY30qTvYkS
         ay+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066287; x=1726671087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dO8mvOVta2kBXYCz2E0HVGW4ezYp/G6MUNiDNivvII=;
        b=KYsabem8nYrDcM/ZnRwEYHt7iLdn9v/v9F8G5LQRYUh6Vab7HMJaZYNQ4+7kKSmnWM
         QaC0iNbMUBNSDGgoq7/1I4JdPbmhKdTp74lHeqTKmMrC+m4VeL4vjkQRbWOlSE3p34AL
         s25rHnj+9WNmeUR+vg96cRvnWlYk31sc7Sd7FtzAYeyNypWNHr0GHAbtMtQLA4fzCzYu
         HOnPdeJ/J42v9B4J8jb3sbFdi2rYwYFVQjQl9pW+on05jdwrXgfg6nuoaet3V/kpnyLj
         ULL3FnIdXRgd/g7BWFghCWTMz4g1nFJv2D2EwLwBNAxN1vYaKev23OaCSyXMd17kbXUu
         PJQA==
X-Gm-Message-State: AOJu0Yz5X+Ih8hsiXadVlsNxVYtK5zhLWHdOdLpnOWprpOCVQF48M0Ig
	Cxr4ceEMfCPnG4iriaW8eAFONMayVM5b7y2TA+6yKyoCqDj6ZQzkosHZyg==
X-Google-Smtp-Source: AGHT+IFoDUP/DOlcGMvsWFHzq7xpoTquxN0+FYRId9gLnRB4hKOzwB2ITSVirDkrKLQ9/NT7tLk9tQ==
X-Received: by 2002:a5d:624d:0:b0:371:8ec6:f2f0 with SMTP id ffacd0b85a97d-378b07a57d3mr2192097f8f.16.1726066287431;
        Wed, 11 Sep 2024 07:51:27 -0700 (PDT)
Received: from vibhavp-an515-58.lan ([2401:4900:1c63:4161:2261:f710:6aeb:b934])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665517sm12081277f8f.36.2024.09.11.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:51:26 -0700 (PDT)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 2/2] org.bluez.Adapter: Add documentation for the Connectable property.
Date: Wed, 11 Sep 2024 20:21:14 +0530
Message-ID: <20240911145114.103340-3-vibhavp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911145114.103340-1-vibhavp@gmail.com>
References: <20240911145114.103340-1-vibhavp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/org.bluez.Adapter.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/org.bluez.Adapter.rst b/doc/org.bluez.Adapter.rst
index f53728123..3f5fdc8fe 100644
--- a/doc/org.bluez.Adapter.rst
+++ b/doc/org.bluez.Adapter.rst
@@ -283,6 +283,19 @@ uint32 Class [readonly]
 	This property represents the value that is either automatically
 	configured by DMI/ACPI information or provided as static configuration.
 
+boolean Connectable [readwrite]
+```````````````````````````````
+
+	Set an adapter to connectable or non-connectable. This is a global
+	setting and should only be used by the settings application.
+
+	Setting this property to false will set the Discoverable property
+	of the adapter to false as well, which will not be reverted if
+	if Connectable is set back to true. If required, the application
+	will need to manually set Discoverable to true.
+
+	Note that this property only affects incoming connections.
+
 boolean Powered [readwrite]
 ```````````````````````````
 
-- 
2.46.0

