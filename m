Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976C190679
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507747; cv=none; b=jn7AhKbzB0tZjXP/rU6bhrQ1gcbkggea9tjGsiDeAlV+jGThMcs/07S4PqUISOvWzlPSpbRMFSTZxnzSKKJnqA8BbPpOBTrHQMMLp4lYXF+KPIoku6B61ZKQl+vrH+kdoWfZc7cgWGnfREPLO76qD2K40pem8oOMScXtbAbFkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507747; c=relaxed/simple;
	bh=A2u5Mt15lIbRF5h8w8Q7/jXb0lCsSXmB0KGoaLjwbTc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dth4sQ4bRUdmq4U7qwMvPlOVdP2Spf951N5T6zHBSZjwN3ZuBngRyLuRE5W7wJ8Iy6Ah69A3zI3OYPNg1w0xdUa88m5yF9GudtbY4ESOsyzbivfwlMAh/l8ChtAzNwI40R75BFgRB2Bk4usxymnuSI0QuQVa0ntS7iSvWKhxXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKHJoxvr; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKHJoxvr"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c172f1de1so735879a34.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745507744; x=1746112544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4X01VS80AAMNfwmsmonLkL6FFeIL6yu6TaTAwVeegwU=;
        b=eKHJoxvrDDonvLNfzImOA1+RCaiiRTu8bvbnoC/pBGRebbxXtrakFZ/lDmPD62wK4M
         vgXcUNm1/jO07b+2P/ReBzwbAau2CKluFoJMYpL4IgxsuQdX4syooy3/6MM6CEsNumyR
         ejhbs3sgBhRj+JM5P+R/p32Yb4XURk+Y2PdZExB5OsWudFJS93qx0M7XACzpbXP2eyRI
         8Zz6rt8zIgjrvJp0HjaAn6Si73VqHSegsRph4rrFSQi7KhNfLli8iS/VbhrVyBlPr/TZ
         Aup60fwa0Ow+AAoSnHyOzW5Tn643hMoIvGewSEOAwHV2/vIhvwA16qAq4F4T/l3h1N/l
         R4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745507744; x=1746112544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4X01VS80AAMNfwmsmonLkL6FFeIL6yu6TaTAwVeegwU=;
        b=fyyzpPk49C1hhvGqBXKNuYju32WTSiVi45khnO70bIhPENcyuyNyg9upE2SMoAzIzt
         LxmGYUcU7KOLnSIoprihHtEkpYCwo2uzZxSQ0EKlPzmaDSHCXpUhAzydTSOt1M8Jy6El
         ql1eNmjdvNMCa/p3jkuZ4IB2bh1kclFmp8DSMlhtqyeUq0FLQUD8f10Db2gVqUeTcesS
         PZdpI5g/4ccJ1WrHcUQPhx03D4S/EK92vZtAb3TPKmaS4MgrI0CVSygbJ/0PLqP4laRw
         IRmdR2+8RLkPpqFnONHiuS6n5xAZavFEjHqPyzcQIw6dwO3/JG/feUMoAKyWSsqf8UZg
         DpLQ==
X-Gm-Message-State: AOJu0YyIabSTo2tGkY7Irzlw7d0VWkfTXxzJr8kdwgJ4yMx/Iu0CAmPH
	y0w7A6Fv+0TWozisvheSXD4AQR8AmptI0I5Bzuvh/5FzZQXRhhW/1BMuCA==
X-Gm-Gg: ASbGncvVkYFAixHvOr/maKaOXPRS1ZkDhqyXlNG+I09zu5IeICyKwtqeXe9WTIdKp4+
	ITaLQevmq/GfDdFypAmA3l2brFh3BZMfdoQsZS6LzSNB/xBlJlCGQ3sftk+7NVRiyaI+htWXZGY
	0szGgiUqF/C3MEgNRHuk/U42bhF51qP5Yfl14nktVw5Nf5m1S7r7oSdOSNuYQS1wCcubN9b/l1a
	3ZbuWS0bkxn2iwFTg4ezFDNL+OZRpXbSoj01Y4GDxDBHTQ4ZTseu5PU63Fa7XsIk/WT6FPopUJJ
	qnpDztxrWsVQC6pP9V2wcxnSqufoktP/aP3gyIf0ZhLtw3ZIgUGCw5ViLHkwoyEkj2lw0IWQN/O
	Dje7gaNqfow==
X-Google-Smtp-Source: AGHT+IEuYnYB/9Lb7RDvHHtAReEFOo+z4GHd/jS0YUpmBJniLKLZTEA7mgz//QZDeTqYVYXFGg/Oyg==
X-Received: by 2002:a05:6830:d01:b0:72b:8274:7c09 with SMTP id 46e09a7af769-73059bc5a10mr100798a34.4.1745507744162;
        Thu, 24 Apr 2025 08:15:44 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-877aef6bc07sm324349241.34.2025.04.24.08.15.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:15:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] workflows/sync: Remove workflow job
Date: Thu, 24 Apr 2025 11:15:40 -0400
Message-ID: <20250424151540.1322778-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424151540.1322778-1-luiz.dentz@gmail.com>
References: <20250424151540.1322778-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The workflow branch update is not needed now that action-ci no longer
use to base the PR and CI tasks.
---
 .github/workflows/sync.yml | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/.github/workflows/sync.yml b/.github/workflows/sync.yml
index 5b3d7d6355a0..504a8d2ac9f5 100644
--- a/.github/workflows/sync.yml
+++ b/.github/workflows/sync.yml
@@ -16,19 +16,6 @@ jobs:
         dest_branch: 'master'
         secret_token: ${{ secrets.ACTION_TOKEN }}
 
-  workflow:
-    needs: bluez
-    runs-on: ubuntu-latest
-    steps:
-    - uses: actions/checkout@v2
-    - uses: bluez/action-sync-repo@master
-      with:
-        src_repo: 'https://github.com/bluez/bluez.git'
-        src_branch: 'master'
-        dest_repo: 'bluez/bluez'
-        dest_branch: 'workflow'
-        secret_token: ${{ secrets.ACTION_TOKEN }}
-
   bluetooth-next:
     needs: bluez
     runs-on: ubuntu-latest
@@ -42,7 +29,7 @@ jobs:
         secret_token: ${{ secrets.ACTION_TOKEN }}
 
   patchwork:
-    needs: workflow
+    needs: bluez
     runs-on: ubuntu-latest
     steps:
     - uses: actions/checkout@v3
-- 
2.49.0

