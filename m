Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF3344D81
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638558; cv=none; b=HttBsubQQoCs1LzvVVuKV/Ana66r570uXoXSzDZ2025NKog/OrrL4LCkEauJ0I7a2aEIWuK7swkVb+4e8zB/CdW0hzSU2lYXZx96o6PMeZr7KzKKkUq8dedCjGmJ81ckBi7hZMmi/sMlHGJ1gRJSKA9Q4dXP+QcpBP+ETkiYRtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638558; c=relaxed/simple;
	bh=pUJHXX6NIBSH5rAWW5GG+hehx3soziL4GKtUvS+QZQE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5MTNI6PcihNC3HwJE7/MkezFWaNdheTNYgSswTTMh4HhrkDxYWJMGPRpOHCsSZPOiHNJ6DGywEqtv3Ehg/Lh+Le+TsTohtgA6QRlIPi3Nw5lLWdjmsEL1acdqoPQkA9Zi/n5MvmR1cmBpp/27A2jFNornqYSAN9ZGGboTqPw6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 996684440C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 22:15:48 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v7 14/16] github: Add docs deployment
Date: Wed, 28 Jan 2026 23:12:04 +0100
Message-ID: <20260128221536.2319084-15-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128221536.2319084-1-hadess@hadess.net>
References: <20260128221536.2319084-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeeigeduvddtgeekudefffeuueeitdekvdduffduvdevjefghffhvddvtdfhudegkeenucffohhmrghinhepohhuthhpuhhtshdrphgrghgvnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepleelieeikeeggeegtdevpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
2.52.0

