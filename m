Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C730E82C
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777971482; cv=none; b=Z6GqAxvpzKkSJE6VRKTiSpq93Xrs2G5ZfnJ9/OzRuHeSnzGWgRRCIAwafdr7xuFGeQFYHSj86TeLU1vTrzaUDpCO/8sxaH40C6gux1KF4D+Zqe98k1k/X9LhIlImMBuALWIjkLtNhEFM7kURsOWiU7GHXZI0KXozAljEGi3zU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777971482; c=relaxed/simple;
	bh=eiQey3IfybLtcfrkXdVDJdR++8ZGOpfLkNq5RUrrKDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=by8fUHg467h9w/EfnTBfjUbXR4MV2K0CNN9SpGEbYp6Ry7y7SrVCA/BoxbgKOrc9XTMX86Jsq1EPrBEej13eUVw5D+G/G3hrqzKrgtH965oXbATQCmNICW3EyjtouVQgyWlDVpuEZTTO3Q7UxWSP11Oox+C12EIkhxqP3qA5Z1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 94A663EBDA
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 08:57:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v10 15/16] github: Add docs deployment
Date: Tue,  5 May 2026 10:45:21 +0200
Message-ID: <20260505085741.2497401-16-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505085741.2497401-1-hadess@hadess.net>
References: <20260505085741.2497401-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTFoo97FPlLDy6h0fIFlTwZmLBEAUsmFn8ZKLZ8k619x9z100fdYvnYR7AlUkFLBwP728N+bTH/hQ8NN1Moc38kEJ19+Yy/pCZPQyS/Ex3DIggy4EsePNH4egBxfwwUNJn1MKeVUMmxEM6ZLpqADNLTvVUyXDc3gpfhbSKX1fLtwrw/Qla39cWtxjTJqZJfRkOCXzNYoSmtD/22X6gYToIcAxquNaC+OtEUtZRPcGwrlvN9tHMjr3NbzWOwY9mouGQEUGGG4b5SdoXamXbVEEe4ML2+hGYvMGZGSfbqWMSs7fxdgljHD6tDY3GtKLMyD1uhPQx8jykYAZaK0DJHQt1LRM3A2aTeqoyJrvBgOXm9RGzAbcW8dFxd8WrjkiLCOQMu9ZAbf8HwZXTpFsMJl3ks4iY6yQ3hFaq0n4dFF7K035ynQNOBmPE8ZISsBm2+eo6Y7MlhJKYgiQi6TDTAr68QRswRmPr83yz5nmJ2cnYnfbzISjkYFrGD4122mDha8XO00Wzq/szeK9161jsqlVX44Rgi+RJzkMAbVFS6L8EUlmYgk4328qNu4S1WShAKA9hwWmx7ftbzXMNF23m+zHyWxYaNVNTJLgc7JDBnwv/d4gW9C0dRNUkcn1OB4ClbSMyOc9a6KI1kiVa+D8z1MIXBWZn/OvPHMvrQpMeBHZmqz3g

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
2.54.0

