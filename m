Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF403890F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022026; cv=none; b=c/GOFKjs/ypWoMmncYQqWBm2cp25I5MVf9PxkndR+Zq6LFHChI5Xyju2I9lMSqY2AhzQj59mRZ3hTf/8TaRj+ok1lbaNMAvouErxitLejOKjQuOtFLS+JLGnMaxkH/siqFqBAA5wg7Z6x1JlceoT1Tz5BfZpv1a0X42ch98+LhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022026; c=relaxed/simple;
	bh=qywWzpg9JSKXLUvmL1s7e0ItVAJDpIzwHdeztqzcS8k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ef4ebAlKUq83u0oL6G2ZVLeEpbg0jP3gDM8ntcu+63gIe9WkhSLsc29m0eM8adlv8LU7qiq7m7Fq7P0rGnHGvjPaFatk1m5b/nEqtnOMOuVYcoeU5wTYwOGFJXoGFy0Nwm+GVeubiuMBVNu5W6RLFJYROfeiLgeXCTC1SYRmxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C3EE43EC02
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 09:13:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v9 14/15] github: Add docs deployment
Date: Fri, 24 Apr 2026 11:11:17 +0200
Message-ID: <20260424091324.3097084-15-hadess@hadess.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424091324.3097084-1-hadess@hadess.net>
References: <20260424091324.3097084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTF2oVnjzQAIaYUvFdpmXujzDYkRRa9RW8oLgRO9k4pRvcgOB+p3Lwm+J45g9pcvSLgkpfFn3m3B447oxuRu07iIk1Kl453Y5nLjCFTnEOzvOYGjHKfOAPf5EeZL9uh7Nh4OYFW/ERVxzlDjO7l6ULmxTOSMT5hJ5yTHvjKkAn6Ow8G0gAbfprHGDhcf0fOepzKjFy+SEJhdKxgpj/rrJqu03arNskxxiZZAlOoEkAhktzgFT9WUngioJo5E0T4+RCq6wEnJjlAxTd2OlXAVDL43eCm3okFVg5GlfR+QJVGYA84pY/iQ2P4RXkv2HKnI6WKFvaHKUoSTaMOcC/oyd+9LYEZepBrtb3ipQ0EoETvXALX3B1rfe/hAs91rq/8U1Tpo+FCkRC0ZUOT57bG4CprL3GD0gMUd8X/7eCVSO5gqWMreIhEZOc+lOlnGousnawfAaazcU/jP/uek5RTm5HUCUc3xSdHaQUouJ4lUoC1NnkQD3GWZuQO1yu4//NAmkBEXM2hBVvY5H2vrOT2jGWmTss4zjHBo5SBSiLcF/xynmiYlv63gngZy/GTGQ/a0dvZPiKgOGgmLh++Sh2Kwt1zGBlQ2O3HvVfZXncjrbWJALNqSV9tznAyxZjvmpemeW2hYk7aQYt9NShHClwWeGqib9l7QSRjtXYIEbn9qHnMPdw
X-GND-State: clean
X-GND-Score: 0

---
 .github/workflows/docs.yml | 54 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 .github/workflows/docs.yml

diff --git a/.github/workflows/docs.yml b/.github/workflows/docs.yml
new file mode 100644
index 000000000000..07169d0bc5c9
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
+          meson setup --prefix /tmp/bluez-install --libdir lib -Dudev=disabled -Dauto_features=disabled -Dtools=disabled -Dclient=disabled -Ddaemon=disabled -Dmonitor=disabled -Ddeprecated=disabled -Dexperimental=disabled -Ddocumentation=enabled -Dlocalstatedir=/var _build
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
2.53.0

