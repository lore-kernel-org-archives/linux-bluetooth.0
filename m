Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03311D9A5F
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353970; cv=none; b=iaEOq34r+cCGeYsdZYDnyS7gbJTPpxZw76zI7Bett9NXALiD7Ydk/spy3PUMKlvO/DK2/Q0ivR3LJ7bMT3O6BdDBchxEDL++KvzjPh3M15hIwvkOv0FgDeyOwGmWSHoy19YsHxQKiKYwxoaaSFSs2ITEtsY7Z86aJjkyOnwppe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353970; c=relaxed/simple;
	bh=fVYzPjaBR2QKict0WM5LnKS/wlsnGePhltq2sai/IZ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DNAK6c2mNWBum68OCiHNUYbtmqHPYC3k7qYeeL9SnOUzya0jkujxNM3A6be3i+9e4nEtsJHMTlXm0j8rLR1VtmFvKFPN6U35ltGYF3akE6wl9tyr9CdBtQSmqFZlXiRALu3QoXVvINxoYNIAwMvEuIHsbmnNCtlQFbMKm3csKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4+JN7vY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4+JN7vY"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-52410fb2afeso5060843e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745353966; x=1745958766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tABl8E+XYecisizvG/jjuaOmPzCF5bu8hph3AFnNDVU=;
        b=g4+JN7vYK+vx872rCPIH8x+6TP94bdJ8+dvAhJwHVQ8WCQ7eHQiUI5dN/uT/6+poiz
         h7L2M/bfmlX/XQ9F0Ds65U44TFwtlw/GLQ4Xd98Rco2yP7/Y/I6C9VA5GSUnlvWcZ6ZR
         g7ljxW9F/EirPr4OAKUJjEQT3MEZoYn5Og75eC/Kq6gW/CYUPV6y4ZexsjaBUqAlA18f
         tmJhkUxdOu75svhiocHY7HBjA+CgCKm7bd6AhKtTBrFhjwpFQfWhRJxwgt9nIEPOfQK0
         o7qMZI4KMDj2ugHxUn5pH0Ul/95YPMDHgDz0c9pEQ0laIPVKtfSeq1g5f+LviwRol14w
         xtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745353966; x=1745958766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tABl8E+XYecisizvG/jjuaOmPzCF5bu8hph3AFnNDVU=;
        b=cDaPDjAzqEQ4/4TAsEStkXYGnIdzV/2zalgDy3OgGQti2LwD518VMQ5xl5cfQx8t/b
         VvsDI+9aMr7Fpa6sJGS+jCckCxIL4oxerhonNPWbKPwxo2MyS2zL+a65zh8OtP0OEGFJ
         bfNnVbiAq6H+qK9m/m3tQHZ7QpgDTQnmYQw6cEZ2+D/tnH/DKnj0pbNmIOLWWI2VHYV4
         9wgaSbZWnrvXTXTVeDB0YjGL4i3V2n79OIpZMpUL5MABA1VHaafPiXmTFWu1oLpZwA9i
         4h5P4xzuIdoXWYygjEnpI+Wv87F4vrwviAitt9XDiL7tz9ptCKZ8M6T7IADsrODLVL3I
         7CNA==
X-Gm-Message-State: AOJu0YyajKD5rROm9BcA6nRB1mkQkGd6RrgoafhuC7RCyNjzrO/1pdOQ
	OgDHUoUV04Z2wHkPSoEIO1FXy1YzVNahZLGucTb38hBIqdv88VVxaTAHHv06ksQ=
X-Gm-Gg: ASbGncu7BPU0iEeWgzMU61BOkDcnqdK81E0tMR8tUyDtxlp054QD4sIU+ClX7Ek4WgW
	CBUHhxjUZwpBtFG/Fv9p/C4X4eNU1X/WWuvk/49RScqFL6WpmG1u2GBvCWAQd6kIyG57m3RjGei
	gUgRKH5ETeLodVfTBNuaCdQFyOyp7ZcYecVUHnYYQH3q2zqMT7fmfRV2Ga44Oj5hS3ZYnsUETht
	tT8zHUSOvFVtt7dME9X8hbZVVADf/V6DbuR21KicwFX9fU3jft3dxkpJ8TDYPpyAa358kdYqgwg
	jMpzneT1bqqRSaBr+vNAR+cd1Kt5NQJK9LTvzWRpMqnn/nE23Ue02q/PdGx0MSaRgGyDx3YWQnP
	Ka5CH33OLVA==
X-Google-Smtp-Source: AGHT+IEBsIMKRmNxaqiiC8tSMwumc4y7A/R2KHJhA1ERoY4P6cDU5E+BUkTMgIQbCW7vQjQpTgdBGA==
X-Received: by 2002:a05:6122:1da3:b0:526:2356:f3fb with SMTP id 71dfb90a1353d-5292553a2ccmr14627678e0c.11.1745353966566;
        Tue, 22 Apr 2025 13:32:46 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922c35e01sm2107086e0c.23.2025.04.22.13.32.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 13:32:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5] workflows: Add CI action
Date: Tue, 22 Apr 2025 16:32:43 -0400
Message-ID: <20250422203243.980887-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds CI action which was previously under BlueZTestBot.
---
 .github/workflows/ci.yml | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 .github/workflows/ci.yml

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
new file mode 100644
index 000000000000..9d267e1ccc95
--- /dev/null
+++ b/.github/workflows/ci.yml
@@ -0,0 +1,24 @@
+name: CI
+
+on: [pull_request]
+
+jobs:
+  ci:
+    runs-on: ubuntu-latest
+    name: CI for Pull Request
+    steps:
+    - name: Checkout the source code
+      uses: actions/checkout@v3
+      with:
+        path: src/src
+
+    - name: CI
+      uses: tedd-an/bzcafe@main
+      with:
+        task: ci
+        base_folder: src
+        space: user
+        github_token: ${{ secrets.ACTION_TOKEN }}
+        email_token: ${{ secrets.EMAIL_TOKEN }}
+        patchwork_token: ${{ secrets.PATCHWORK_TOKEN }}
+        patchwork_user: ${{ secrets.PATCHWORK_USER }}
-- 
2.49.0

