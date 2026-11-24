Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535618;
	b=5Ot6L8AxAsfjrmgPomRooMWVXNBg+IxLT5WfDp4yqDA7xIQzAXvV0CyGu6ZHI7b1E3GO
	 wl4lrspX0RLW68JcWUKEfoIiv9GMnLK+b9ADU9vTDEWanNk0MwYkTetmdJsu/wqjYaik5
	 PdpbNAI+yQRkSlDZbYV8g1suYBLJVgX9vY6a1a4wAwQAr1F5/1dKMqEdM3jcVmtHxALv4
	 uPTZ7g8xL9doF01jNnbsaU1yfXfKfa9wm2bXRLq50qgtlsUn12xSjgwoQKafqGuvpXdqG
	 GFQzwzp+XGuWY8/P79RrfzHFWy7TPpyoQFBj3gVvH2UwPfg5WtwJkQdlCLem18TZtJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535618;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=JwjH8jPXZLQWqy1Q97PDf8fY7CnZHSI9wRezoExhAng=;
	b=jvuRwBL5hEURuNvGDQ7NiPDiBuB/qabqolsEPf99ppWE00x8CWiESYp+HR+nwuMx0OMg
	 xw9zM+JoDEKcvSVeWa8Lm5tWajWYFy68bluF57wuJjlkV6md/NYeGFuLtD5COgTCXILZ2
	 Rd2WMAU4RLNrQErt9fRC8HcmxnicP4NgrrOw53uY8eol/+S5JfqokIdUVJ0VwM53HlG8n
	 JHDwPK4BUFOm+1kLvH1fOaagU/EcLp1RphQBXZK5b1U0hoLKcJdqC7cLOjxOeHTtV9AS+
	 CGpMK5EUpyKrwFnTMtMBa1UZouneWk6oev50ORb/9/MqWQTfGXdPoFBFs1Diwb6dFGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F77606A68E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F77606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C7B493F5BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:30 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 13/14] github: Add docs deployment
Date: Tue, 24 Nov 2026 16:50:44 +0100
Message-ID: <20261124155319.1752879-14-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124155319.1752879-1-hadess@hadess.net>
References: <20261124155319.1752879-1-hadess@hadess.net>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEl1HvpEMdP/OkapW9gaMSRNrF7roNtKXbwKpGs6hhiGaPpXZYLJohkYQyFzbqDEYzcZ4fO8HjOoRHUMpoMAi3jrSkPTh4wA00NcG9j4sxgNL+JbIa4KvtNS6hr//jTv3sOEnQcnSGUjhhZAvG03Pbav7BVidOFGZV0W8su5GQUJBAfOA1X3C+a+eJP1dV7opwlPwtdbzp2zbdrasVBoCsDR5GVX6rgCEkc7d9ecfXzDL5rb9i8xLVCKE/Jc0ox3/5kVkjbWzJcI6/8MwndlOh6T2KF6ttQbCgeDxahX2E9KtaBiVgaZEsDDgAa7w5DM4f5npwoNbxi4OKLlBy5UmFpJIzfYzNVQzmsqZCpX7eWYkXLfITVEq7XfLwJdboBbtd6l/xBNO51BdA1DtPloOfgVfT4NuQoNiyoxet4skuko75Qmtq2r0983BEmmcjtxSpJ9i9DIX5HaufX5cx7CET8WiMzV8tHmtSe/pNPOdMG51Xh6BfvLZvvnjg3EZNZY6z8wt+Gok0SoawqT7j5gXibVvOnHuGcwIy6ZFFX2T23cHOUDLgoB2Z2L6r4XKKXW83dpROR74X9/u3aVXtu9Fw6qmFYaBzyEg6mm9rAikA/YWF7wxyCvW6kt2QTUDIauZrc3/NxrkxPWDesIDA5j7gM2w4WbPx/L4JPM+OEXpZWzQ
X-GND-State: clean

---
 .github/workflows/docs.yml | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 .github/workflows/docs.yml

diff --git a/.github/workflows/docs.yml b/.github/workflows/docs.yml
new file mode 100644
index 000000000000..e21504a4edf3
--- /dev/null
+++ b/.github/workflows/docs.yml
@@ -0,0 +1,54 @@
+name: Deploy Docs
+
+on:
+  push:
+    branches:
+      - master
+  workflow_dispatch:
+
+permissions:
+  contents: read
+  pages: write
+  id-token: write
+
+concurrency:
+  group: pages
+  cancel-in-progress: true
+
+jobs:
+  build:
+    runs-on: ubuntu-latest
+    steps:
+      - name: Checkout
+        uses: actions/checkout@v4
+
+      - name: Set up Python
+        uses: actions/setup-python@v5
+        with:
+          python-version: "3.12"
+
+      - name: Install deps
+        run: |
+          sudo apt-get update
+          sudo apt install -y libglib2.0-dev libdbus-1-dev meson python3-docutils furo python3-sphinx python3-sphinx-copybutton python3-sphinxext-opengraph
+
+      - name: Build site
+        run: |
+          meson setup --prefix /tmp/bluez-install --libdir lib -Dudev=disabled -Dauto_features=disabled -Dtools=disabled -Dclient=disabled -Ddaemon=disabled -Dsystemd=disabled -Dmonitor=disabled -Ddeprecated=disabled -Dexperimental=disabled -Ddocumentation=enabled -Dlocalstatedir=/var _build
+          meson compile -C _build
+
+      - name: Upload Pages artifact
+        uses: actions/upload-pages-artifact@v3
+        with:
+          path: _build/doc/html/
+
+  deploy:
+    runs-on: ubuntu-latest
+    needs: build
+    environment:
+      name: github-pages
+      url: ${{ steps.deployment.outputs.page_url }}
+    steps:
+      - name: Deploy to GitHub Pages
+        id: deployment
+        uses: actions/deploy-pages@v4
-- 
2.56.0

