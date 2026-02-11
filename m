Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45A36BCE0
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813979; cv=none; b=Ud2MW6An4At+zba1z70jNHRHWKxL4DoMswdyuPFGXSH+5hhToAEQiOx6OPD+zwV5wfBCr8Haqh+UFTmLgpWJAUSzl6nmrcNdRcKIBiWuer/62hJtbSNOR8qr0q3GG2OvTDLh7fADniGqmBXXeSzOKyf7HrwELIXzfRLLXGhST5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813979; c=relaxed/simple;
	bh=GfoQ6+rhmPOYvIhMQka8JWFHjj0k/JBNZYOnHMwxrZY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGiUXProAV0r+xVSqPwyPxWBWxWIUAEaGWu5U2W/GoZyBPuuheHWH4rG949TSe5C84Sx9/xIRWLY9+Scu80me2Vey31CyUseFj+yrMZjeQl5DrOku1bSS4jS/2OF6Ju4YcfXgLUE7JSsFCkmwkhOmMdMF1qsS8NErvZ/BYDQsH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7574944217
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Feb 2026 12:46:02 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 13/15] doc: Add HTML documentation
Date: Wed, 11 Feb 2026 13:42:09 +0100
Message-ID: <20260211124550.3830639-14-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211124550.3830639-1-hadess@hadess.net>
References: <20260211124550.3830639-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 49
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpefhvdfgvdduiedvieegveehvdfgteevudehgfffueejtdelgfevtdevieeuffdvkeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhsphhhihhngidqughotgdrohhrghdpphihphhirdhorhhgpdiffedrohhrghdpihhnkhhstggrphgvrdhorhhgpdhsohhurhgtvghfohhrghgvrdhnvghtpdhgihhthhhusgdrihhonecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemlegsvdelmegtugefieemieekfhgumegttdelfedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepjeehjeegleeggedvudejpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepuddpr
 hgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhg

Based off the XDG desktop portal documentation at:
https://github.com/flatpak/xdg-desktop-portal/commits/main/doc
---
 doc/_static/bluez.css      | 452 +++++++++++++++++++++++++++++++++++++
 doc/_static/bluez.png      | Bin 0 -> 18354 bytes
 doc/_static/bullet.svg     |   1 +
 doc/_static/card.png       | Bin 0 -> 35387 bytes
 doc/_static/figtree.woff2  | Bin 0 -> 14364 bytes
 doc/_static/toc_bullet.svg |  39 ++++
 doc/bluetoothctl-cmd.rst   |  34 +++
 doc/conf.py                |  39 ++++
 doc/copy-subdir.py         |  14 ++
 doc/daemons.rst            |  12 +
 doc/dbus-gatt.rst          |  18 ++
 doc/dbus-obex.rst          |  33 +++
 doc/dbus.rst               |  76 +++++++
 doc/deprecated-tools.rst   |  22 ++
 doc/dev-maint.rst          |  17 ++
 doc/favicon.ico            | Bin 0 -> 29152 bytes
 doc/index.rst              |  47 ++++
 doc/meson.build            | 121 ++++++++++
 doc/protocols.rst          |  20 ++
 doc/qualifications.rst     |  76 +++++++
 doc/tools.rst              |  24 ++
 meson.build                |   6 +-
 meson_options.txt          |   1 +
 23 files changed, 1051 insertions(+), 1 deletion(-)
 create mode 100644 doc/_static/bluez.css
 create mode 100644 doc/_static/bluez.png
 create mode 100644 doc/_static/bullet.svg
 create mode 100644 doc/_static/card.png
 create mode 100644 doc/_static/figtree.woff2
 create mode 100644 doc/_static/toc_bullet.svg
 create mode 100644 doc/bluetoothctl-cmd.rst
 create mode 100644 doc/conf.py
 create mode 100644 doc/copy-subdir.py
 create mode 100644 doc/daemons.rst
 create mode 100644 doc/dbus-gatt.rst
 create mode 100644 doc/dbus-obex.rst
 create mode 100644 doc/dbus.rst
 create mode 100644 doc/deprecated-tools.rst
 create mode 100644 doc/dev-maint.rst
 create mode 100644 doc/favicon.ico
 create mode 100644 doc/index.rst
 create mode 100644 doc/protocols.rst
 create mode 100644 doc/qualifications.rst
 create mode 100644 doc/tools.rst

diff --git a/doc/_static/bluez.css b/doc/_static/bluez.css
new file mode 100644
index 000000000000..e0e281d79cdc
--- /dev/null
+++ b/doc/_static/bluez.css
@@ -0,0 +1,452 @@
+/* XDG CSS theme for Sphinx + Furo
+
+https://www.sphinx-doc.org
+https://pypi.org/project/furo/
+*/
+
+/* FONTS */
+
+@font-face {
+  font-family: "Figtree var";
+  font-weight: 100 900;
+  font-display: swap;
+  font-style: normal;
+  font-named-instance: "Regular";
+  src: url("figtree.woff2") format("woff2");
+}
+
+:root {
+  --rounded-corner: 12px;
+  --blue1: rgb(153,193,241);
+  --blue2: rgb(98,160,234);
+  --blue3: rgb(53,132,228);
+  --blue4: rgb(28,113,216);
+  --blue5: rgb(26,95,180);
+  --green1: rgb(143,240,164);
+  --green2: rgb(87,227,137);
+  --green3: rgb(51,209,122);
+  --green4: rgb(46,194,126);
+  --green5: rgb(38,162,105);
+  --yellow1: rgb(249,240,107);
+  --yellow2: rgb(248,228,92);
+  --yellow3: rgb(246,211,45);
+  --yellow4: rgb(245,194,17);
+  --yellow5: rgb(229,165,10);
+  --orange1: rgb(255,190,111);
+  --orange2: rgb(255,163,72);
+  --orange3: rgb(255,120,0);
+  --orange4: rgb(230,97,0);
+  --orange5: rgb(198,70,0);
+  --red1: rgb(246,97,81);
+  --red2: rgb(237,51,59);
+  --red3: rgb(224,27,36);
+  --red4: rgb(192,28,40);
+  --red5: rgb(165,29,45);
+  --purple1: rgb(220,138,221);
+  --purple2: rgb(192,97,203);
+  --purple3: rgb(145,65,172);
+  --purple4: rgb(129,61,156);
+  --purple5: rgb(97,53,131);
+  --brown1: rgb(205,171,143);
+  --brown2: rgb(181,131,90);
+  --brown3: rgb(152,106,68);
+  --brown4: rgb(134,94,60);
+  --brown5: rgb(99,69,44);
+  --light1: rgb(255,255,255);
+  --light2: rgb(246,245,244);
+  --light3: rgb(222,221,218);
+  --light4: rgb(192,191,188);
+  --light5: rgb(154,153,150);
+  --dark1: rgb(119,118,123);
+  --dark2: rgb(94,92,100);
+  --dark3: rgb(61,56,70);
+  --dark4: rgb(36,31,49);
+  --dark5: rgb(0,0,0);
+  --text: #f6f5f4;
+  --tocbg: var(--light2);
+  --tocfg: var(--dark3);
+  --borders: var(--light3);
+  --link: var(--blue5);
+  --link-underline: var(--blue1);
+}
+
+::selection {
+	background-color:  rgba(153,193,241,0.5);
+}
+
+@media (prefers-color-scheme: dark) {
+  :root {
+    --tocbg: var(--dark5);
+    --tocfg: var(--light5);
+    --borders: var(--dark3);
+    --link: var(--blue1);
+    --link-underline: var(--blue5);
+  }
+	::selection {
+		background-color:  rgba(26,95,180,0.4);
+	}
+}
+
+* {
+  -moz-box-sizing: border-box;
+  -webkit-box-sizing: border-box;
+  box-sizing: border-box;
+}
+
+html, body {
+  margin: 0;
+  padding: 0;
+  font-size: 16px;
+  font-family: "Figtree var", sans-serif;
+  font-weight: 400;
+  line-height: 1.6;
+}
+  @media (min-width: 700px) {
+    html, body {
+      font-size: 18px;
+    }
+  }
+
+a {
+  color: var(--link);
+  text-decoration-color: var(--link-underline);
+}
+
+p strong {
+  font-weight: 600;
+  opacity: 0.9;
+}
+
+h1 {
+   font-weight: 500;
+   font-size: 2rem;
+   margin-top: '0';
+   margin-bottom: 1.5rem;
+   font-family: "Figtree var", sans-serif;
+}
+h2 {
+   font-weight: 800;
+   font-size: 1.7rem;
+   margin-top: 2.5rem;
+   margin-bottom: 1.2rem;
+   font-family: "Figtree var", sans-serif;
+}
+h3 {
+   font-weight: 800;
+   font-size: 1.3rem;
+   margin-top: 2.2rem;
+   margin-bottom: 1rem;
+   font-family: "Figtree var", sans-serif;
+}
+h4 {
+   font-weight: 700;
+   font-size: 1.1rem;
+   margin-top: 1rem;
+   margin-bottom: 1rem;
+   font-family: "Figtree var", sans-serif;
+}
+h5 {
+   font-weight: 700;
+   font-size: 1rem;
+   margin-top: 1rem;
+   margin-bottom: 1rem;
+   font-family: "Figtree var", sans-serif;
+}
+  h2,h3,h4,h5 { opacity: 0.7; }
+
+ul.simple {
+  margin: 1rem 1rem 3rem;
+}
+
+  ul.simple li {
+    list-style-image: url(bullet.svg);
+    margin-inline-end: 1ch;
+    margin-bottom: 1rem;
+  }
+	ul.simple li:hover::marker {	}
+
+.related-pages {
+  font-size: 10pt;
+  font-weight: 800;
+  display: flex;
+  flex-direction: row-reverse;
+  align-items: stretch;
+  justify-content: space-between;
+}
+
+  .related-pages a .title {
+    color: var(--dark1);
+  }
+  .related-pages a svg {
+    width: 32px; height: 32px;
+  }
+
+  .prev-page {
+    border-radius: 8px;
+    padding: 8px 24px 8px 8px;
+
+  }
+  .next-page {
+    border-radius: 8px;
+    padding: 8px 8px 8px 24px;
+  }
+  .related-pages a.prev-page,
+  .related-pages a.next-page {
+    float: none;
+    max-width: inherit; /* cancel furo's 50% */
+  }
+  .related-pages a.prev-page:hover, .related-pages a.next-page:hover {
+    background-color: var(--tocbg);
+  }
+
+  @media (min-width: 700px) {
+    .related-pages {
+      font-size: 14pt;
+    }
+    .prev-page {
+      padding: 16px 48px 16px 16px;
+      border-radius: 24px;
+
+    }
+    .next-page {
+      padding: 16px 16px 16px 48px;
+      border-radius: 24px;
+    }
+  }
+  .related-pages a.prev-page:only-child,
+  .related-pages a.next-page:only-child,
+  .page-info {
+      /* align-self: flex-end; i wish */
+      width: 100%; /* big buttons instead */
+  }
+
+.toctree-wrapper ul {
+	margin: 0; padding: 0;
+}
+
+  .toctree-wrapper li {
+		list-style: none;
+    margin: 0 0 1rem 0;
+  }
+  .toctree-wrapper li.toctree-l1 {
+    font-size: 14pt;
+    font-weight: 600;
+
+  }
+    .toctree-wrapper li.toctree-l1 > a { color: var(--tocfg); }
+
+  .toctree-wrapper li.toctree-l2 {
+		list-style-image: url(toc_bullet.svg);
+		margin: 0;
+    font-size: 12pt;
+    font-weight: 400;
+    padding: 0.2rem;
+  }
+    .toctree-wrapper > ul ul {
+      margin-top: 1rem;
+      display: grid;
+      grid-template-columns: repeat(auto-fill, minmax(12rem, 1fr));
+      gap: .2rem;
+    }
+    .toctree-wrapper > ul ul a {
+      background-color: transparent;
+    }
+/* tiled TOC with images */
+
+ul.tiled-toc {
+  display: grid;
+  gap: 1rem;
+  grid-auto-flow: row;
+  margin: 1rem 0; padding: 0;
+  text-align: center;
+  margin-top: 2rem;
+  grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
+}
+  ul.tiled-toc li {
+    display: block;
+    list-style: none;
+  }
+  ul.tiled-toc li img {
+    display: block;
+    width: 100%;
+    image-rendering: crisp-edges;
+    image-rendering: pixelated;
+  }
+  ul.tiled-toc li img::after {
+    content: "";
+  }
+
+  ul.tiled-toc a {
+    color: black;
+    text-decoration: none;
+    font-weight: 600;
+  }
+
+  @media (prefers-color-scheme: dark) {
+    ul.tiled-toc a { color: white; }
+  }
+
+
+table.docutils {
+  font-size: 90%;
+  box-shadow: none;
+  border-collapse: collapse;
+  border-spacing: 0;
+  border-radius: 0;
+  text-align: left;
+  border-width: 0;
+  box-sizing: border-box;
+}
+  /* reset crazy */
+  table.docutils th, table.docutils tr, table.docutils td {
+    background-color: transparent;
+    text-align: left;
+  }
+
+  table.docutils td, table.docutils th {
+    border-width: 0;
+    padding: .25rem;
+  }
+  table.docutils tr {
+    border-width: 0;
+    border-bottom: 1px solid var(--borders);
+  }
+
+  table.docutils thead tr {
+    font-weight: 800;
+    border-width: 0;
+    box-sizing: inherit;
+    border-bottom: 2px solid var(--borders);
+  }
+
+  .hig-palette-table.align-default {
+    display: table;
+    width: 100%;
+  }
+
+  img.hig-palette-swatch {
+    display: block;
+    width: 42px;
+    aspect-ratio: 1 / 1;
+    border-radius: 50%;
+  }
+
+  .hig-palette-table colgroup { display: none; }
+  .hig-palette-table .stub,
+  .hig-palette-table .head.stub {
+    width: 50px;
+  }
+
+video {
+  width: 100%;
+  height: auto;
+}
+
+footer {
+  margin-bottom: 3rem;
+}
+
+.sidebar-drawer {
+
+}
+
+.sidebar-brand-text {
+  font-family: Cantarell, -apple-system, BlinkMacSystemFont, "Helvetica", sans-serif;
+  font-size: 14pt;
+  font-weight: 800;
+}
+
+.sidebar-search-container,
+.sidebar-search {
+	border-radius: 99999px;
+	border: none;
+}
+.sidebar-search-container {
+	margin: 0 var(--sidebar-item-spacing-horizontal);
+	transition: background-color 0.2s linear;
+	background-color: rgba(0,0,0,0.06);
+}
+.sidebar-search-container:hover {
+  background-color: rgba(0,0,0,0.09);
+}
+.sidebar-search-container:focus-within {
+  background-color: rgba(0,0,0,0.12);
+}
+
+@media (prefers-color-scheme: dark) {
+  .sidebar-search-container {
+    background-color: rgba(255,255,255,0.06);
+  }
+  .sidebar-search-container:hover {
+    background-color: rgba(255,255,255,0.09);
+  }
+  .sidebar-search-container:focus-within {
+    background-color: rgba(255,255,255,0.12);
+  }
+}
+
+.sidebar-tree .toctree-l1,
+.sidebar-tree .toctree-l2 {
+	margin: 1px 12px;
+	border-radius: 6px;
+  color: var(--link);
+}
+
+.sidebar-tree .toctree-l1 > .reference {
+  color: var(--link);
+}
+
+.sidebar-tree .toctree-l2 {
+	margin: 1px 0;
+	font-size: 90%;
+	text-wrap: balance;
+	overflow-wrap: break-word;
+	hyphens: manual;
+}
+
+.sidebar-tree li > ul {
+	margin-left: 0;
+}
+.sidebar-tree li > ul .reference {
+	padding-left: calc(1.5*var(--sidebar-item-spacing-horizontal));
+}
+
+.sidebar-tree label[for^="toctree-checkbox"] {
+  -webkit-user-select: none;
+  -moz-user-select: none;
+  -ms-user-select: none;
+  user-select: none;
+}
+
+.sidebar-tree li.toctree-l3 a {
+  margin: 1px 0;
+  padding: var(--sidebar-item-spacing-vertical) var(--sidebar-item-spacing-horizontal)
+           var(--sidebar-item-spacing-vertical) calc(2*var(--sidebar-item-spacing-horizontal)) ; /* extra indentation */
+}
+
+.sidebar-tree .reference {
+	background: rgba(0,0,0,0);
+	transition: background 0.2s linear;
+	border-radius: 6px;
+	padding: var(--sidebar-item-spacing-vertical) calc(0.75*var(--sidebar-item-spacing-horizontal));
+}
+.sidebar-tree .reference:hover,
+.sidebar-tree .current > .reference:hover {
+	/* background: var(--color-background-hover); */
+	background: rgba(0,0,0,0.03);
+}
+
+.sidebar-tree .reference.current {
+	background: rgba(0,0,0,0.06);
+}
+.sidebar-tree .reference.current:hover {
+	background: rgba(0,0,0,0.09);
+}
+
+.sidebar-tree .current-page > .reference {
+	font-weight: 600;
+}
+
+.theme-toggle {
+  display: none; /* just go with auto */
+}
diff --git a/doc/_static/bluez.png b/doc/_static/bluez.png
new file mode 100644
index 0000000000000000000000000000000000000000..105aac0e1d857e0ced2b931a54153ff1eb8a285e
GIT binary patch
literal 18354
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
QL_|a!?Om@jpaH4>2jhNBdjJ3c

literal 0
HcmV?d00001

diff --git a/doc/_static/bullet.svg b/doc/_static/bullet.svg
new file mode 100644
index 000000000000..e75341131991
--- /dev/null
+++ b/doc/_static/bullet.svg
@@ -0,0 +1 @@
+<svg xmlns="http://www.w3.org/2000/svg" height="16" width="16"><path d="M6.662 4.586a1.143 1.143 0 00-.838.334l-.531.531c-.458.458-.442 1.21.037 1.69l2.873 2.87-2.873 2.874c-.479.479-.495 1.231-.037 1.69l.531.53c.458.458 1.213.442 1.692-.037l4.068-4.07a1.22 1.22 0 00.348-.986 1.22 1.22 0 00-.348-.985l-4.068-4.07a1.249 1.249 0 00-.854-.371z" fill="#9a9996"/></svg>
\ No newline at end of file
diff --git a/doc/_static/card.png b/doc/_static/card.png
new file mode 100644
index 0000000000000000000000000000000000000000..60383d7e792ae320f226fc5540dd10a232e92243
GIT binary patch
literal 35387
zcmeFYcTkg2_bnV$K&2~EqzQ;f5kz`diYQ30p%)S9(tEMcn+O4<3K%+s-XW-jNbd<f
z8l*QVAwUTE=JC6~Z|42x-aqdD?=TFL%!KEhefHUV?X_0o^mH_6uHU{60)c3rKT|UR
zfv(hoK$q`ar2v6I;=gh(fj}TK9|H{)ve|y&2oMN##p#Lm6A-8_h3edn90UU0ad>8+
z4FUz<1A!txfIw#;5GZmT1oC?b0&UuYKyq0i5c8Ydc6|j92t;A8rJ)8Q0Y6{5O4C3f
z(6u+uz&;=lM-1>wma?+%2m*m9eV=QqQ*M%R&~x&fa%~VnpgW-FYEO&;=e8GvLaqGr
zlrQjY;P#RSP{s<!t=CWJuRMM8g#J9<oFV2Lxw;VrIZpneh(nY<Q`G4tx+ive3GqDV
zMrw^ba#uN6g&A`NuMZex2tXf$g?+omB-;uwT+ionB%Y@o-BXkeQsPRP{Hnd%R&Xf0
zmLH-F3(pXSrUO9$c~^V|q6GRWPR0cMZM)Y4ynhFM#SD1)CmTcs?A`LFEg1*|`sjK|
z_}{0rBY`MAuDMqG@57S+{qTPS_TMA{f&P0jK>sZU|E-???HK>NF4+`p3<81PJKz!+
zmX+s=cp}O6dzdxr_JqW5J>lMX`=1?E^(q<2_M;^0@5@tWvgMcK|8?B=cL#ZtIxXV+
zg0C^@SqMO1k9{xgv0MUy9=@g-ise#bU?{A-q8C!&YC_4FDf^$j`PEf!5Qw_yJyK0V
zvW)Uev!FoH*M#fjK);WC;)_oZxQ8yM{L-A!tY##*`4)S_mJHP6|N8YMP*>@DZeTnA
zm(XCk@)8Kd!VXqrZ!nD4r};bpa;bpc&^OJT+m+B$0B{7$T>+l(u12DK<lLENg4~x@
zYVIrlfjziCfIts_mYgxtPR&#>HQ4C8Ey)2<c?s^l*6~yVRZjJ#*__|Yl#VeIfGHHu
zH3e$ICa&!E^vDz=h*8)_l>doofd3!)<dY)<{|@W;x}l7ogMhk(R90Ue_5gJa1bRQy
z(|NYfn5NxGJvB3t5v%JdLCJ*R0|K-&Hg*LRJj(u`ph)}!J@8b41Q{HJfj9IzrArl`
zx`b32W&EH8KL|wqNi+Urw|J9`g@qJQ{D0bCY)MLN)=U{^<lNlYgxn}6Bjn#+#*4QM
zUbyPhJ$840#vo8m8LtIEuJ>-KaT#yP?(`J>9Qywy%>RO5uV{hDN|d`_2A!$U{crP7
z(#KZ+*<i*4!)tj{)6?qZM)3yajDCK8sgB?&G+HC9Yrf}k@IHdsfp~^%6Ee+k6!XHW
z@n5yA-Giqh7;f_PNt7jYH<{PpmsC%$$8v4X;kK~QCfD{>e{-mkrTe0myQzcP?T>N~
zroW~u5?^f&FE^ktu0eIOsH*ZKECX0sD^H4Kfg*LN#_TnWC=a&FrsTL5$vW1BI`Z-K
zwL9qzwOlfO%)s%chfJ`LEh#C9<3h=QduGO|Aj}?Z6_CUcupo9%CzqvTyIyO%aZ*Rj
z3){;g?O`b)CG}KQRaHVlLe0U!Azf3>^Z2Qjme%?CnsQ3RsFHku<9rx?(P61GDAn=v
zP4b7a24Ax}R1}Y<@hPx`w53^@7s>ucYA^2hc)eWgz8-uL<X$c4nfP9Z<fE{EepazI
zB$xgbS5W`6-hg>!yNxx^ApRKxSRg@ouxMiM$K3e>cx`m9T&~B3ZqPt2Lw!KdUD-2i
zh&N@2C5D5irzq=+8RNt!J}n~^u7v<hnBv8GEN^nG^JEEPM1GGw?VfggX4kf39g;Jo
z*P~;HNq(=>XKH%7yw}4>5MpValE$y=?+s$PQIb50Rn(B8PFOO{aZIj$TGQtITsZty
zSo&sVL5pOrCfHQ5{EU}o+siS}R8-q4y`_n|pQn^D3q&<j(dM((x6tO(a)K`@DVYh`
z>snsi3lCuT9eYxTUkX8fxOUTid#29f=;#t?J;gJujJq!d<&f1Ka^UH@e3nzN!)Wct
z3#Ik?XubJS`I7J#%)pBGLKuG03%?lPdDaqf5)%>Ig<q1lCT^M{xntOGOqOVik1~PA
zME7zs5Oy%sWKMUbk-<VJ(#H!=HQW`U=ZEJbWBQY9!l!2_y%gxM5V)L_b8(T;(#fZE
z{+kZDWkWj4dgQ2?$faz}NA}Ro5zNHD%PIE#?yf~9&k|uIdd9Bm&f9Lnd_2v5KbP`N
zXn4x?7hTuu>V@ZzLIj#<_=a43U^AV%cT^(DscYvwIv#j*>@;V|`MI!%pZwmBmhR+!
zHI&5=vRxO`)&OGhH{e60Fu8s_?)x2*fsMT^VY*)6Y1MMy-d)RvNv&$SQb8_BeH$ra
z(5lswA<RcX9nYtg(c6T!W-BcS5AMX?g2jFock0UvSYickmn`TpCGQrmNN9v=;*?=h
zc;HJf*>JzL_!$u@r_#ottv!*VrZr;%MdJ-yvUvnF)B5&a=$ia;x}i>-5Ulf2hN#Uh
z&23O@Y%JZ5aXitc5PvJowES!9F+4ws(nQMBkLS25rdm#I?opykT&yPAg7EIG0FPj~
zpH{ga_qU}A+HV!_s%n&koXTB%&IDxkuJ`yGiexTFvw6g_d9-qiw67P*kj@X6|Nfv$
zDK{*wU<X|n7_2{u5dbIt73hq)!h<c|b4je@H6{<k|Gg=S2vUxa()8=ff>$8*oDUy%
zr#t3-FFgKGQHc(mP6#msF{MK4QR7j>=bz;$O&7_1E=0559ip!N`Cg=+fK}x>(_{DQ
zW$?nr@%QZ`xwstq66-#QfucU~AV|X1y?0fY+x>bmXe1k6O!r<`OC28q53_0H=-|Pf
z_x2;rXYO4RzGJ#NlE>z=Hj)Ia|J6t?t7qU3wxYT^eFR94TEN~}YpXBApN-XPz=Ex4
zM2-LGhiXc7{1&NJ?%<eI0M1aKKl>o}{F~HY6zI={w)7$+e}15Su2&!H{?Vjv4i^<D
zUPPU}!P9EHqjbsi$V!V3frdp0W>h(A#~5nrmm4*E7S_8RzJ8b9oU2($<U0G<3QgxR
z7PRvCefWr+zvq&-YyT%cuUW@Tg!09*a^HiNg&S<r9!3HnJtJ_hGTcc`;wNl9MxNBJ
zQ1iLNE#XOMxj~#J^SuA*=y*DhAOz(O%2#euresX#{_uEr5x7_9`$!~n_unWP;?bnT
z`N_T@c_g=hkfYa}5+AoV^DzddR03Zh!6pMlt6k#?E;jprZnkXqPg&)r8N>^_a?MCT
zGnh7bE1*7%l)DbQFGI%k@NW9xiVR`9Vfh;+S7O76oY3)NfDPnQ&&M=Df$mdVb#>o^
z%{p-I*;_dun{iRRV*R6<){X^7#%V*fscd{>w34C-d%8i)oho<&wXt#)v8|!`bDhD1
zcM=I)`frwaBDq)Ew`vjs;Dkjn&!x`S&SIBEK-58ySO?mggsy<e2T9%YW0rB^a8h7z
zpGPp4BN%T1siqZp;e3eloGp2f@OpUUUsbJ^)9tUl|B#I7;U8i1#``*Q8(&WlqT$@V
zmm&*2UNDio7p~$S!_QwWVX(;>))S{!qsdgSzU6ivFH+yHO9>MmSn<vc#Kw)!%#;~`
ze!_(loRb*jgXdjf$uhY0vl-{kqqp4_;3XC`arHBMl<Df1cW>|ZT#BypZeuSv9dasy
zLisK>3N8dTw-zTrKjGJC1fHU(+<18IB@JWUVV)21w}{@zu0d>RM37j$0rjrsHe`3T
zZjeU^=WTx?Jb!K>pdJHm_T_&s;=DtqYTjm<96>}!Bt=I@%k1~wj4}iLvC#AyO<)Li
zQB%|Eb<~jTtx5Z8dbGGHIV^T4pD<^wr7Hi|OFD9C--C=gXvJIhV#Vfy&!hD>1%wQw
z+Dj%XiqIgX)TJMd!aS^QP-WJ5<``LBx$@&Ji0b|a?>2U){GeA0erPKT8+8iMOwH4D
zo^D@X)kHRjGRCkLx0SP#C2d^|K0yXB)bGTqTA2jhl)NnO(Uf7V==3$V>c+VL>n^jr
z+OTUsHfiFYN0Kx40hhR;fas=hJmVmE8RWhFB@W!V@-g~;KWsf_i$wU`8umN8`9tZ1
zRE$xj8{2A%rhxlg{p;Z<IZuYmjP}OL8k(ulX1$vFrpJPal18ma^>5c|BURc6yB*6^
zHYX~=Hr<wvppS;mfu0WpUU6brZXz{d>m8*9Hq16%{$6T%?dxYtmjEz!eGO&dndA!V
zlFH7>F{S|h8S)}bAuQ<J^car7T6~CMc*vvt&~YaPmgFmDkADLRPdu7jKA!h9Wd(iY
zb<kwslCR*-e!3B+j(K3!EpkC*9`#qO5P?2}Xc`GZcFg;XoF8bIT95+F{d&MCulIIp
zk>rdh1hWmht}?MP9u%qYi~*Ko9^b<0w({g`?Vv!BQ@69$&aB(NC`_kngpHaPR{^?T
zA?vf+yFJ^m+&HO|VDQ|U?lJ941{fFfxCFI$ZU&>*Z;hu<i<zzx|BfwJE|>b`bCg&;
zthnd1w{WP*FC5L_$@RD}>};|iS-NXO+iUCzWjQs-dz>~8E{OPJCqss#w6@@a<-b~W
zKdWiuLwJU_++~7oARcyB+`1+|?;Z7B+m+dWziF%Mr2voP;@VT^$X&Lad@;Z9)#mRn
zFB&qiH*LwH@YSASLKn-*7rcGR9F>niKck=zeryG5I5F(W){8w&8MFG(ZE-%NwSQWm
zJWrrJl4z_^-GgeX397rQOkM0jE8zZI_I`w^%WvYG@|NqTPER{)SU7tdAO9w9J1Hkn
zat1zD2lX6(<XP&92xD)CLnt>oG~-);QKmd~d#%s<aA@N#`TO-R?`h*5l4bARzD==q
z*-}#g1+(E|lX8odbVc=67*}FPBQAV|&1!AUrbF5+lfezI5KkyM7?YCjC6h-!aetFI
zgw3T(oYMFZ-WKq!z7?lC$g4@-`c4jZ&ulBq0`jp4UQl+4MFAGFxMjaO^jXYhs%+;d
zfA*}TEu45}*5qQWfM4*bdp%wh`1c#-avXntY-xV5;Ob}r*NS)B8$Z$yu8W6C2dOE&
z7ML>=W**SIc7}SWTd-8sy+_KwjB)z`qSE+VVJ&rSH<ZtY4fm(!2EN3IR~O_Mids*C
zx$v`aq=zGNI>PI>p4lZ~mMOYwaJnXRr<-SKeZ1J=XnkDFaUfmhZ_njr#l0ZiDyt4D
zlNw7_txS=mkli-^npSLlD`B^T%9sQ{n}%V>ROuEy$ap|s8TW}A(fXIg6Iw|>c&iki
z!54^Q@vYmdP=<q1rG=M9WQdjOE3vV$`o&KXW%|YT1L*?$+33!DIx@dMwC;5iu$l04
z#|8g+cd>|zbMA;l5)nh<7*!&;y~vRozD61O<n^-xTykF^Zg+z6%wsWH)6##q_?7$a
zq-#w;SD$T}w>+p_!oD|F=H%D=Wg(kW&2!+y0oYQalPC8z#rfMi^8F4BaipI-^2y%{
zj(V9>_tpHb5xYTuqp}EpwQ`tew8{z9nFg91&B<C6%`wUl)buq1>lKK>mSB{Xd*1cQ
zI$^NZw8_Q~ag!JmuvzLyp2^Ep>!<hhZMY0eb&^sd&X>Jr>|zj-Xv>=z(gogOV*;vr
z5ZHabB8ntnNEfeNT)e%>SVF<Q3^yBCjE~4q4SMG>dR!elRls?LtMZAod3Y(nyB~qj
zuW)Lc&<COmw03%=8e&xpI%2b4c$&_Is<3{9%z{qWjCe)wPjk5-DA*O&bsX<AswfTM
zM*cis17Y*V*FQOaeB#r>ibkAjvHQ>1>D&j+BidIPY1FwW$LYPkC#LE<by5=l=3tbW
zrO&+_f16iQ;J-C9*ph`k0z$Z5`vVJ<v;@&^8Q{RV1E>QQ{Y*RelROjK<w!!*J-=FP
z*I**y;>R8Q$%%P=TCnvFh^R**$@94AiF0{LdUFt8Pcq@zyuVLu>~L4vQOUcJ&Poum
zel0(wkDS?(-sT+39Ai1V2Pa+J&m7d@0Z~Uv?-|6i!o=~n!ZLZVx_Cvdmh-(iB}I`0
z;d-}26oLOmsvrdQ0H+)}r;ur^mZ1(G_#{~F?wS`Nl(0_Ne+(4w@SKNsD!D<cpS_M}
zo#@KFZ9;aM>fB}@@zaA`s&DLHNK5xlJ<n!6TGVpQSw6&AFm9QjG2Mf%OK_k0HzL&b
ziSy4rk|_^*=~ZlVBqSvfL!ZT$5zID;TB2RPKhp_?F`V&mLI>RE5*dpTSOD8d)Ew6{
z9kRaV{E~?)40)A5JN$ItGd~foR9CXMC@dGFFkgo@aMd?3)|blUOIV_L<hH2cIC*y$
z{QM3z!zJM_6xrF?SQ`?~W_c-OFR9IEjW+JlXpXe#60RmdHV8!RvD|!Pf0$q%AM^$q
zYZLC`o5)#Sr;Q=HpSHK!jeNQfX{QZ3o1!Z>aON6B$1tz;e6TIA76xbFYE|r*1cdy;
zroi(_#b>G0j#`qUkN#wUsLJ9p;pZz}-^iJJ*)S)4-1<vE+xnNHW%|Xr3ZSyLEjz7(
zw7E)xD46Gn)ogu5Uqr>MQt>EZJ6F_~)LIiUF=NIIeOJQhLppIA0yj!&a*UW5CmkKv
z8pdm<={H5};8ZJvb=2pM)$T)4;<HlYA*kVNx?r`8dL3k|?2e|h52kv=$KG)|GjTkc
zF&9Kt_W3=Xl8i|A2{udC=hg0DyUTP%;6XpX1FY-V8w;|{aoo2_5s6>aJu#fNcbTTy
zF~HkBPEm9WHWQN(^0UZz<~PnQBIsz<c+wI4T2+)zdaHFb-#>d({=zzdZm=Fz=(A<2
zQDrgi%*7zT^GJ@9aG^gg(O&q*bkt`MjnsfQj9nRioN~qN@s7uR9L{S<4B1N;{`b9E
zt?iSVL35GJ<&Dw;CR?&vs~1AQc)~`V1P0io@!b`>0-u7f)&^%|N}EWU0pCpN7PSqK
zNJvFKucM-`QGYOVp|3TE2#&?p(F*lkO$|C_S6Z#?S)=CSv3veu{|AXsp%QH>z!UDf
z{N2oEi3OT}X|VezSX7di@a5@_wlQdG!a8K<78h|{V>wZL<YySTAoSolKXv32&wfrZ
zu>^g@Aa_x?G1H1<*9js$g((d8VXiCBGUV|<>Rj~4rp)4mckC^mhU}fB!Rx1=0$*)t
z?N3@1#65$czBJ6oZ?32tR<>2n#qjvoVXEjH`z!D*kW56$QmhH*hZ>BN5t*LrUI>N|
ztrm%EffFBO=j0T3FICe=KKaD6Dk5aRERkTA(@YJLA~iawq*uVJeHRRkJ<B=e!8q>H
zG9y7_!f4SHlhDgNT5c%ktKOR6@9A?PF@E}EI$aIzm1(iD27Hylf%A8tLUbq>KViF&
zFH+)`6WZFB=^_r*&NpUp7N`hQ^o)Pl4()>5h5&z|$e%pBzQ@Bm^@Ac_XB(w!-MK(V
zN@A0ivjaWM^-W8CIqqZI+;#or_;NsE#JO?^(}9t~xti?74u3*%MUKJfyvde3NY@rN
zFz&-@0G(JtwGY_t!DzwEKOi2IkB5`kWgpSX{`t6&>9a8b9bZ`3{y+w5ljyEvv{4Ge
zu*{m7wmP_aJQpJ<lcbB<1UviZC=EOWw!HG|R-5-TcU1pM?eXJUT8!rEujGUqIa?Ul
zR>n9&)`KHmn84*Z*JkRgaMBa2OYw^cTd*r0KK$7x4}I-N45!)SVMj1i$WD{#i+lxH
z^okpo%2g0`6)IWCx$+Q1qXRaGaTki(b=)g>yFWtgLx#iV+CHLtCr7(jFc&)$OA+0P
z&5=$C57e0;KZ~F^SIty)0#m9n#V_{bRyZRAWM+Y_(f}tpuP|ziLv76P_ytt$bS!qG
z`P@V=3EMv2u0wK)*?s?DnYmww<V?uOVB)8We3Eg!6X!d$<4!vNVAh6W->;+FWp;Ra
z%X91npStByv4%r`#p)ATbk6sDO~ejm^h4FFZ^^`*C%$IMc-hwsw!R)OGJ}VArICaF
zjPNh**9RVA_6&YH5PlFvdyPp%%Yt@8Ut0DCH^L~;T=l*i{kXP7V6Q6KER5H43$`V@
z%rjUob2O&vV>2>cX(|r}>B)rcaA&~A%{r265)3ioikn;UXiJNhLcVaKO@h6u7DliW
zt*YE{@?y@e)jBB})0A0kP<~WtskqZ%gEJ^s(}b{$#ckWkPhO^Cc}Uo9(A^zuwfjNA
zf1M?J_)tm8`(Vt1EZEQ8l;&`tzCGXi$~1FeDOGnzp*=VT43ob?F>4|>deo?9Hz1cT
zWUT!w4-$-*^N2_)VcgGne-9BJ!tAqK8Kqm3OhwuvXAY(loQA!vwp4wXd$l%_EDbMP
z%fln(v9PX2*479>yoOiW0IWh)fo}?#RK-qLnj!}vLJp?~EBoh%qsYTiWv&%(SyYV`
zn`qaOfx_XCc%9p9ebz%el^35M@nvUc7nPSgPhtX=g4VJmoDH^Xf6$6~EVQ!7`@1D_
zD$4aGvffNeN)ilv_>y5#<LL{xq3Z#*TGm7M{q5#^Eq=J>xm{RJ80xJ2%)Gw&_v=&$
z_K-{d&h5>3W;xH-HNBr3>Ls&6{>KZz)L5gCh4W1=qT?@~`5o$#lh}=xEWFGFu=Er|
zW%|Vjq$iqm!nPsOI&;C1>4PhQ+jU6n1z|6RoQkOz*cKxG7O;G?&Ok3=^Tx80(fO$<
zMoRWKkAcnjFL)sXSA=X>VPQM24h3Pyao29%Q!6)`aCMDTXqQ49eXr)sKu{bypnHS%
z!h*KDkS8jf^9#yKY%LhLz2R!(%DKLA!q!*eITUANjY`D;)6IG(cg6LI5*P#cWqHl~
zh!3PpEnVtXi4^`wlaFVR$94WpysGxFOB$L{L2Tl(s5F4KQ+%1ZV%8JMD(n4ncd(3-
zsa6p<p9~SJ+qz1pFBQ)J{_sLu1pvTKyv*@_<{-c%h(!1w^z$QgFz2iP9}V1}#!uDY
z0<B&=U2ng{Y2ov&BmApT!^dKI7>i;2@=~)a_gc4kM~!TF_#rm14q6&qMcYucJT_F_
zRWtWJFS$d<BEojw;V|M9+DtE`J~0??rx{63y|6a3y1I~AXD_>w4Q_p7r*QC-x6Sp>
zD=-r*g1F@n!{LAbTsCmGZSCJ+A~O1|FoyH?a$gc#Gb}|DdIOkTqNterI06<J02HUN
z-+L3-&Psi!sg<9xrQfvi_|z1mXXrB9zXJd!A8W!Kx-U!2p~&bFH`Na#8q=J4do(1r
zm~Ni?__U)$#boiE(mGbi)24=8?$=)1W+c{|0HPS0YjX9mdFs<WHNu;saAPkR-QjIo
zQ*KxaJX_4|Qk6pf`;wB9!1cnIXvfGV|D8D?Db7zvBa#6W;?aG&%58k%-Nx>-Iur*C
zs{jKDKx^?)1#w!%qp>Wdu;4^a#kt{>OHJo3dy~2>rd*`p?;cU?6wPPQRhbafyV&FH
zj;_in|2@rgn%CGgm(b9zSsRD<R}ujE=<=)KY{@p!Vo;_3!5puHjAZShT(9f-$^MVc
zrm=~M8^CS+pCK72hlJe@7(KH2W&bCcoyJM~xkl$YOgI67R64Gc!N&3)4Qx(!J;IW9
zP2(A8qB<@k3U-AMoqR-R2(mdwqlslHvuINDJ(wCbv<nr+7U6doJ6_z@Z*^6I#?G&a
z#)TAEPG*CRiFcZYw;E3i&R9>5@C%u8HJr24ev6p*OP%eG&D9}WddiAj=oY2Y{U|_F
zVtJ^mu&=f|ScV7b2|+aZID`JAX2}P5gdXN#63MBU7>~`EADA;HFg=K8^XwE`x;Sn@
z3Y6yF0EkJfqiD!yD!WSb^WG|g`Srk;;NJKQ)MYo%M$e|guG6|j?fSfWMur?bcrkEP
zj*`|mLYGKwWa#M7NNEa=SsN_+H0?(SUDUW)?q{%fjM*%)E|H!_%+q4{HZ>7jiVgl&
zKB2D1ShM+0?d|mOTrFQ4af4UZZ;>%QwB2o6%U{U!YQ<5Lxp@AFrr94;r9((}?<buU
zkWLF!C{3+Ci#zF@U*O>>VfaO9rTsYF-Z~^F+cGjmdPBY|11`kpcj$R}l1->dEjM&q
zq;75S>8*ovYy3RF!w9jGw{ov!H=gsauS_?if$+LA8Pmf%K>egs`1`nKP{w_(kwwxa
zJ&pXRLHiT7o3NWO+u(#eT`N$o+A6XXL7tx;I$WHedJ%DGWT_IaJaEur>4rmJqE}&$
zNvD4cgV#Yv3FE;`ewdwA=vsRe$M?#r7!lKQidmfs&TeJ~D5pxX0iElqk!Jah9eCc?
zsyu*v5qnY*{mjI`m9kTKUgB|+GP1>a^rAS@?r9`Bb*xi<&^=W3ApZ7m!cL3L6uN`v
zQrP6e0{f^U-f}2gQYidvvH&2sj5HxRp53y$orfd;*0h!%;<4Sa*S*TNJ(ZD%VyRn>
zt$IUwysZTm2Cp&V@2dN*r%vh(V8xNUj5qsk?MWIu7uY>t{?v;1WQ$(Cl{e>8F?XD;
z$)N8-m*4F5312-NN3LGHLO~siNMHsUPr=qBog69c;_K^aw}edou|?mhL>Vn{Uo1tC
zNzzL!EsOpZxjrMZ`-OC2_e)-UF0!A?{zlj_iq}s<$k*e9crs)Vid&3ko!<5ioy1|o
zqDVs<#3r+J9~iB`IeaTE{&Ev{&n1_dwl-PL;Pt}$nS*U2Yk=HDLqns(Qfs`0hNZyI
zS472pR)?~rJ@c<`K)u`8#hpeHfg=M7LIepPp}f7<A)vl+;tP$`$WTuwzZGT>CqwvS
z<uGw#-+iy!k4Wk(9<52Ls(}lgPOnQcORg(J43hRPTMLbGq2wtjz7__|ySJ=#=K?|t
z_lF)6#nV4&|E3~+4GzA}&C=7uHRSx#adYd@gw}Etv$Y<#I;5hzS(_^zdRrHqXMmo6
z%waGes##7nYo9$^o*`-=<!#^&+@ev)jPzyZ7KLg2Ul-7bbH&#(BSHOgqccwSCJ3Kj
zz#^_Rx7^QhU}Rp(rdS}#GO_5UEtzD?o8RACe@C-<TlM`f87xouiv^psM<TF}Yy7$N
zYk2|IyCINOt2WDI@evu`fBer6I^`-#6*6N=6R=vkfvZDtBZR)v;j#j5;qTt7gpnUp
zF7$8w0+ThNNRZIh^5L`-1An(qCW~})U>8gf!q~EiGdf?1O0s5rti2Honlke7@fpgN
zbbXfYH>!yD{T?Y&ZQUgo{`WmsFEFxeWr`ScOZpxTOC#fN31PKt&I~%2Irdom745X3
zv7_u}%rt)FIY;*sS_v>{YuJ7XoVLEvD!&P?u4s$b-yiuAAn-@>Vu;Fhd5TMTWPJ8D
zTuLs2Jo+{nlb#_S6A`fxyj9&My5^*G_?bo8BljkSo89m4QTuJ9VItwgEt|?jvWcaJ
zoe3?`q~#Q4rM_eidAH;)gSgi1{MAdGV5Zr4CguRo^!nC6h9SLW3<x&rNrUJ6xJs@>
zvj%R1>CHfJ40yAHE~S}0`Lh&_wl*<uL&<gaJQo~4V^kx|v$Do+M8`X%38iiN3Kwi#
zR5B*h69QW277QN#tZGQop^uuMdgl8=o6qu}G+icZns?r9>|CT1<Z`7A(WT0~Ni&M^
zg=WqgM}?7K(EYK<(adR!(oPSzb7Ey5^Fb$R4-4@+w2E*YOfZ;6!O~0yslFss-v~;I
zKB9YHv+<UEYG|hg!^v#rtG_!K)XSjJD`dTYou7K<<zl<v{+10%PDg%6LY0DY_H+#(
z0%f~T5TboL@;hHu?l&{;FBRKxI%qJ%SThXbw>-iXIIYKp-;z;$049E*`2)4??m+O#
z?-)Q+&6T*r!vnz2Oe=q|rSG`<Jr|6QNXK@)S(~?`<(qHh00n60HKa|>PPt#C)#fCC
zZGDeKTF{ED4!n;D4^$6bIV)|ag;j)fJLX)>D3unr3p-D8RjUuyUu@U9m|;QbbxpR`
z%JcxoVNzwrz-$w`{}F6`QC6HBA017>PaA7oX@aN%Hvnn$X<%lgru%Hutl13=6u%Ok
zJoB05q59b3(wAcGb#FA7s8Eh|wpIZ&2byXoo5ywY3%^F|lS5b|gW3rNhDJO*3H!yG
zUL(&t)WfXyzsLHqnPUlPMaD&%{z}@H^*_%7JY48E-598$10_^^^BEt@N(;*+?>pV=
zc^6A>OE&*{WdP!}+qTvRh(z4_ORVCrdbwlRvAtw<_K5g@isXcrs4=VTzheMo{!B~n
z=P$A)%0D8r40^Rkjeu7AQuKH%Ru}S`#@jqXx`O|Y4zx^1LN1y^ar@DhSse$bsi5Ck
zRE15_1vz*5rfj|NmaNhG*m4=JRr#W?WX5&0M8z6S#SDv`jWFB2M?rl*t@SeT_&b$o
zFS`4<>7-A(TkPck0F{((v$5qVydmANUYP=zMu16MK3yv?WsQPF+q4NWaLM?Ovdo%w
zu9`wWVT)Wj<JQpBV}j|IQK$E*()_-S6;U#c;Zr;X5LiUQa#h1fyeq8B|7SXZxEB$@
z{-%da=MJ@xkZDcg;i$5*2>jd|l4@vb9pnh`VW!;&5Egm=s_S;K5pUv8w#DR;PeM|J
z{`_7%P#*0~*$eD$;<d2o%RI}Y@(Z`MfOQEcR2k}aJ##kHZ5_xUZdObgJEj;%EocTp
zps4Ekw7H}K5H)@<xVzJKhTfJetUjE0mL=_J9eO%wliab}?)nTuJXuajiMz=!7xyr+
z>u5r2KglyxHBj<OC~?asB`;t}R*ATwi;QL9z3%5W`BZINrs%bza($qOHj@?#?GF=x
zqGZ$NayC@oh<w?&xrsF-$w+FF=OW9_C;Coilc*?vH@d05Xi(2CLEoY_z9js`G&?5;
zAbgUwMB47wz%S0YTZYa<mJah}&en_bp0V@+umZR?Kob;nh&{naknl4;ql(L|%gG7t
z?d{*$(M33hQBPrOcpNjDZb-}+U(M=0t{NYR$?=bM?qKrSt&Cw3NvI^X8r;1?eVvSH
ztT-bh0|3SLBe}Bw)Y?ycTG0z)FLI<FjL0k}ekal?jm1d4)bv{PLnFXWdC*7E9|2jA
zu&`#IY2_dHgI2!E3~AC6v=GH&)zqxHzrS3nZbjzAX$`NtAr9ZSRnvm%DlWTpeYe(h
zW{Vc~x2fTT;kwghjcLF`6kps-?!S~-G%zL`JEigd5lvI~YB;+UzZ9}OAOuTPzSvIz
zv<U8y7yS8wMQt$KEDYMCZ6)L6s8qT7QS=wUZ~!R6t*hCt_Gd>Mf_F)<)|t%(6?gZu
zs!fLZLKex0_8QCM)J)`VN217|&ljf=iktxo^}&;2%{GNPG~X+SnNiIJf0v@oh*XOc
zk?BG=ZN(C=)<)jX9IW%*m<T-EC|%x1a-{%u3~(~|tc`FSAdk<`aHWgW0+Q_Q+qZLH
zvy^a#pZu2D>pU#76sb()cDXn|-RC0hb9wdiW%ico7aKj(fu_&Rtve?~`=QE-`Osmj
zv3i4Yv^HUhf~nf^IY++3p^xYOU=I9&W0#0VK%oku7aOy^K#$~<g?{9CX;Nj)1wR?a
zDp-YbsEQTRGJXP4QH(pJC^C^w3rMWI8p#VHT!PYWGxS@i>IA<n6atWnfGI-x{5M^l
z_sYObt(|I>c~gZRO(!rD@nu@x04y~7-yZ&>*#2SO^V37)K6+_aRMkuXCTuya;QVE}
zrfP%&YU<Jje4xVMLsqLX^u|7&=V$f~xZ4Zvls!CNff?Q!;MZ%bqn!!Wsk~+qF}8T5
zF`v?)qdcVbWxC@Q{o9&rwYK!bpT+rChdvkcQ1q876E^}Ex2#KfY_rVa;bEa`@|d`w
z!`1S{cPDe`ZYD~u&^PR%f4`{`9vj4utLNMlNSM*fyjDB+B5Q`FwA*u3g>$}snhkr1
z39Lo_72GP<vMPrweibxs(`^pY0$X^(s|MF#FCUD%+oo&kZ#^te50-nkTCujJz;BYr
zOzRc}qPqXpP*+h>30JPG9@aI_PHhS&Ebd_!d`68K$m?H^7yYvY@GGA_2iOhOqx<F-
zEh#lZzpiaI*4yLgJAO;(>V^p<fcf`s-|UlQ+MN*;K!|!+v!p1%!#leCr3RaS*UghS
z$LgH2IKg9Ve8wQgVPGsK9ea|P9QqRVSs%Vo1m^laR;RMqOWER1I{$*Oy7~(8M5JrO
zk;bcc%RkP5Ogs)!iAGA2PL00)QMmkG7k%Z69<AK^m)7%xL5CE@V?EY~FMzt_g}7zf
z8-`yrU0=?XayMrW{Pk8W=->~FtoO@A7BQZui7X5Nn!s(Lk?nq4*weLw6!--Ww!dDS
z!n8RPaq@$!FOgLoD+voqqRM|Vm7wP05KjjWXvuoytj6v7YYwBp8So%fph$_WR*?O=
z3#Q|tyO!N`Q}`GM8IxXF-vSzbfdfQ4V+v{q=|x{d%ka~cD7ljUG=2>S2ZzwV@3|6r
zQxqN@&p4z2EFG|>+qZ8Q83_VrJK;edC?iCZPY|N%w$Lgj<u*e<m?@fq<cd)6=)$2|
zFV41N&Wkvxn1o}2ve->n+@ozXzSba|kcJmgclf3h<pdSp4g11)STNiC&~}ic)Z;cD
zj4|Jm+<4T8>+hjkbaLz5s}>dg)8+TuP_z%KY(3*1I4wI>PU|lS(cFSJO=BJh{L;L<
zpk8%&LEx~5Ry<#9Fi(eKRY6hrdM;hJ+ng%@R~d6K=dU1SKW2d51&Dmy$<Xq00l<tQ
z^XH?gJ&A}<0sLz-bq<6kSbrKnaw%kwL;TfHETE7viCD7W7kqRVg4Xi9h9%L|{b#4+
zDdCKs5rp~W4>xsK3@UGwq+=^$%&(tp4)U0ooLLAcp4UR>ufZFp!eSxyyKJY5uW07!
zLldh<u?hU!Ob$<P!Q!SDK4DkqITMhk()cquE}iJDP|t?|q4ZJOZ*%J8xCPF!7l@QM
zqM&vFAbr8bQE8p+w|Cqj)M@;>$z8{DLOP1LsldY=47>bpt3%>#$%+!1BCqAXf3h;b
zl!gAf%oPieAg@OAIRMfI(D<HBqw#POQRd($@A8UhL>n_`evvJJi@{SaaP7W*cwOkq
zT<b3<-6nEL@KK5M+?#8427aOy>#}#;VX|K$USMgdohM6mQ})8~9bQM{8X8u4D=~I5
z9YEn95+7x+Um<NfDYK!i0<0E%C$<0Cq-r{LZx?H%aMqHBMIoAEfCCb+>;a>|LO5Xu
zh-oi_2D{kHO}E{Jw*5hyiwVT&aSJ!rhbzP}k<D=Ef{fYb&{m-()V+~b-_@Bg2fu&M
z*g#DSI{2W;h{w2nsd+&cuUwe{-E9dUtSAt7bv4Q4De~BIjEgmxM+>`OC>hLk;wtUu
zbrWI}u@jf6Sn7{45u}q<X*g>PXK>j-q+N}r2+|aOHqC9i3vf;I^Gi&C^<=vR6E0@o
zdz^C;1mqH6`U37-2!>z{V9pF-@F#+t!d~Ygw%Rkyb-M{|t-86O>wbS}>y5EMQOD<L
z7bz#bn6T!SxfW7w^-bCW`WP;m@{f3Q2&XxdGGWKiefCAt_tahgH1{8f+OCdnXjL_}
zB3eJ>4NCU$;6#S1jjL&$9`z+*+h=lT>&46Os6=9kc#Mr>&%;cEc%Vf9q$0QRE)kDW
z9+6$kmDwySwqI!VYP)Y(ZWN#AKPNDva5x0Ki^V30CU3#uN@!fG@5aOlkit%Rekgw$
zP>9eVk4~Vv)$e;=DL=8_R)u%1<<EDY$V<K4-*+hOD@#ReUF)uEyU}vKTNj8$WPoOt
zfIOX;nqow91Xx-I{*DrJ9ALb4sTU|x^Oy^NVXJoEp9{!j+10F*2+|%2;nA^^F?j7~
zgKz=>OubehrhTr~huN*`MG4+rF2AQuZ8-RI->7tM8p8&Nr@8{zxhVC#-Y}Nqi)Rd;
z!P7G`+fDM!2Y>T}YuIhh`fo~Z{BA5~wpQ+7b(bwgjb*u2wFlV3*2uTK9Cgxq#X~<|
zreZMwoPj{WjWX@ICyfd98Om1-`I(OYP9>TMxGy+Ewo?hyhkZ$G%m60BR#eu+mz0z&
zWcUE~H{7%-T?b^;n;#l$G~4JX;6B$p_Y-!Z<ahSGVoq*Invvt(+hGf}#!)XLMa#-C
zc=-*1CbhYvCL&?LWL49J6r(whYM=B`mIPD>W<iOTuQHyfuIfWW_rZl1R{5pF82rwe
zrlgP-L157y-qfAaxYO_o&ySal76a^UfX7fQV0Yo9mtQG0r%<ZrxW#R@zV&RgGDZzt
zs-45s;53@78-9=`7Jh!hZHVO6NKSM}QIrZlNGs?)+L-jQ7!j&z<>3ro=N66M5isTv
zthUH7cv%;;^&G`?*C<9kryFJzW4e>}GP8Li@p;ar%Hz)RGeWv~ksr^&YBOvHBOPGV
z$LKEaQqa?hBaCu&Idr<1iz#QG@54qBo}`oStG;!wzC8~a`+VRv?0?JF-O>J}yX-3?
z#GJyckdo;~CSd;K2s;|z2h2JCn6Ll{neX48%XGb57k^{8^-+LF)ay^G25tW>!>z5Y
z<-EO6C!oJ59Tn28c(=Z4vrNwMXcs8aE#SoAPKmKOj^NySPb-Nj=4ys)gbkN4!b<m;
zUyUVOqtj58X)muXB+*THb-`4*Ya?R$v*hqJvuDiuS4?Sj7us+-Jfu@(ZcTmfZ%9)x
z@oP=WUB@sksn70Up}dgKel0VPGYq~yOKn1QHGLlAh}VcD|FZ<}-ljHTe!1QQ0zgZ)
zlztKU#Ld=yfdy?75w^S5oh{{VZW*)!0rud5hfFjJ<o~SyS5^UoO>XExe_QU&EoS(M
zdg#dyu4F6!S-uurmO;D_*X!i|s6mB#vko^F?IWu=nboo9`|YNCW<P%r4&RIRu1G80
z1Un$d%8VeRM)l#*W?+>2!*o9gf0J(BE$9rp<@Bm`c9VZ~!h?x=Hz6_uK|euTm#+If
zMFtxeZy}m|^}_QKp`EI&w;nJEBna2X8pXR!ew>ZfEN52yUO#1C{h2$OG1KJE#}I%H
z09+=pa9ridAAV(4;4*KwE+-38M7IGtOcl7n+hzpNSiDYt$Ixy3t+2APvSJU}uB!_@
zJ@}WJ9S6e&%E|z;m)ZE5=53Rym5_xqDw?VI9zBtDcG41&ZT<5{sF%Bs<@sU=?`^rI
zhUV7yP?qy?H!v>EltgG|yz945)T4cS#SHkOM<n-he#mYd0P+B1%His80&WXk$;eV-
zZf=f6Dqncj49-kVF`8O>sk8eGiA8P7n%mfL0i`21{A{C57!$>8%~EL!JLa+LdC9Q9
zx0lV{q0MU8>Y&B2UkX>a*`nAg7m={&e!B=gEj1+an56`$WIp)C0AvV;u+;kN9hLn)
z79n^gy3na0OlozspkV6}Cy>V9=)&JT8wqNXbU-F2P3p)$XhHWCTpaO>ep(RF`B|$P
z#zc~FFqc3v!vv-$EaPCLlT@=NyTM&w4wGOvx@4DHZyV&TyM}a?H=Bq1FbLG5QuB;c
zfr(-w8Tj)<07pSdY3%`$8==*vavyRZeV}Lg1V~8$g|`rTIPA3n&FuR|$;A$6bQIBX
z8eCx#tHU{&^9S1b3bG?ggl+DoIa?d;0wqO&6<MG`3uO-O6EGyDrK1w*m4mQCqXBHX
zDYNGdyaChx%uRXZ<e-K|2y-g!&2T5MFUIeskn&)C#c!9c>Xs@S<@hR(%B0fel+TPI
zd*enw(KykI5U=y#i+UX&8$a%*Va$|WeAS%wqySV$71pukJ}u>G>{*|q1gV>3>0f%G
zfQfN%UDQt6yX?$z{LI0O!In&QZZQD!|AML!S$+V!0DPV1+jm+52pZ{yk6VxOLw4Kh
z(AFWhE-Z(##CVgH&emHuN^-o7YYK?lPW%13;g9ZVXQy|_RT>#s21WQhfyHLxa>*Hc
zDg!DKZoXpl;T(Yuq7jm4<pqa8<8mY1(7?gOW%rLFHMc3u9+Oy9uKshN0)}h;f>3XT
zi<4!+E7y1X`3n*~!w+-X9$)}N9suj8WPNKJo~PYIB(jQoo7NC^J4C}t1WZVso=@p{
zLF#_}bHvu=j|RO37iYc;2R{>JMI2EGOvq-J>GJj4k-tAIy3$=wGbS&L2T|Ss$3XY<
z7vvIxydvEX=P?&j=oR^cpS%vEig<QTuDe>$K&1Rq>R^4?UI->3gH+H(piQfgTadZP
zpIx#Q5GhK~y!DYsh=o4R>WMHJo8VJU?ZnubqPXnWiFN4vebF3}sJmHQ+`YZ@<ImLe
zuJK%Y_w&ZfCojP>O8E1O87Yfb0k8c1k4N(M)`Ftz<$d;K*OmnEd4}iV`43~WJvN@M
zy%@?EeQ&C_0+~KLEv|ITL;bkn@Pb&)iga#mVme@9J4cm7j}4rJ;#!jFSyEUhUq<NX
z5-Mw~Tq6YgQxkbVZ)WFItoSe<QQW-|O@HZcIwFC2tEypSVmU>*ChjKxJvF+kcT&?K
z5a-i_l^T)dptU^y0#UDS-fc9jK%{-0NAYk-yhaf1R1j98og-Cl0}ropZD22$;?LuL
z=7rEyE=Vo5UhF(=!){2UUQeS#96!m3TKP>px1W9Tg^Y{|G%6r0JO$0Pu8`ktRb9&u
zsVU8XQQlY#z=V}bx}sW}L(}+mQNO;uzqy&k;vnI-X@n*>n{V+19=JLHs_gY_Dt>48
zWdG|I-A_6S3O{lRa+-I>bEu?mSd+a`tl0zw9{w=1E3D}{Ha`tj%JUhK{a_ZU;Wk^Z
zp1>^X?|zyrzuWr3k^%SYJ)KE-c=vTGDl5a1PoHjtoo$rLZG26$40;h?5u}8q5y}g4
zD>>fT9bPg`P@btmY-ufu^M?o_3->27$hd219)vcaq;^NA`qS#rG~908Sf0p?hm=g9
zQ9(h$iJ{Npxbwr&%Jys_@*b)MCFJ5aO0L|GZ-YEMYG~!RAEF_y-`<f6ii)nqz4vF$
z%KYlXzZ!VhFfsCIIQ%8#r5iE##oLw<lsTB^L21q=vl%DIoww)GFK0eJzV?+2i=#~V
zc~l<=YiVo@Ssl(<n>)a5p>+v+@CX&ooT@5e-0tGM-->y=Z#fEPGnz)3Dn6mgymnuF
zIHb$rJbBs>c469aY~qzm)=S<u1^QdlO|<<VFF@z_?<&L-q_T;oX8b*!+-J=0cXZrm
z>(vJ{9{9MQdi(e^jVclD{;BK#`BM+SyJ!V&rc*k3OioT-BV<Zz!;6f1PRYOZ*KR47
z;Btss3|{ffag82Fs8fC^ak#piq^}{-m}<P(^Ncr2A@@eC#uYQr4HbR;RF5v42}j_s
zx3}ed@6%lB<!-@$1s;H|vATJDa<nmtgshm?+P($wQme~rr||f6q~M3$wagJ^J`2V6
zKymj_$8U1P0IjwcpG1qy5N71V4pntc0cE$6AYfwhU0&9k2brljzN_8=TQX#~u7`Cb
z?M}ZuDUf{oB&WP<dKz<W?zN6BID328>C-#Zm>K__ZXVW{76x0gXDnKoBGcQm4Y<up
zScTJQzQk2}CzERPmCXb9#dc%S?vtWVpFZ8#ondikv`1Vw&2XP@cAsl@&#8<KU^00g
zWjqwL?9Wg0e7b-6ks`QdRC;$}ShNZvDxf20^PIu2XERGl*L`P7YJ=R7M<n7T>BrXf
z&Lj}kW0jz_yZ~Pk5x=#X<7x8rDFw}?-nfGU?=T_`T_ds_O~dB90nPNTwJa$sdzK^Z
zsWWrhPybn@{3$#uqx#RwJzRQamG{vBmr4H~|2Bx;=4x#u%Rqm>KBhZNK8!`x&#!4<
zaM0M?yaJ20hoq<9o$_kks_F3kld9oz@TWgF{c-O72M_$hBFO^;g@vd3lGyxCe#Z>1
zIRw(Eh&w*3zaITHq~0TkWLl+hQP204(A+F%Z8mQG%bzDNVJhnkDJ7ao(`xZyzNPs&
ziEqBOrqBb8nr^AlNQWfCtPGRDTUVUD=GR~Kj=c<IBV(dhEiDLd2fk(iEe*J!<bh*E
zkzRlBgr<N!>z%nKEle0bui0(3C`IY)nJE0czBC1K%ha;4JB;v%i;13pU~mw3x>hhr
zANzBz$#n%!uwt-f<;@F^)PE|-oL#e$DIyQAtXGiJomCtSt*{EI_;ZM;4cES0`b?!n
zZ>_7o*^1kwC*t;n<M+7eOFx8eB32uo9N&5)epK-uNCB}as1`GBXC6JRir(xV58f;<
zJ%W>nx|Jr?69+4UO<v1Si3AJ@6-~pY;3X{OHuI&;XKk~2-owzugo&U3mv=|N9%^&C
z()p^|pGjS12xiYzQ!}1w$q9Oz!*0UuTgMfyY(;+AP!Ze`pnO(feMTVJvsrUTi$26f
zfb!KM$-ktwdsaPq^k@nm5rNyo*p%i6S7>T#HaZ|_fvN>8s1XnsVOyRN1Pkqa1u#JB
zP;$O$tF~yFxEeddMLN-dKp<^Jl)ia4VwSN_DPP?l&PuQTb9awi0lG3B?DLIT(5Hy;
z4T}b@atT}x_AIvT*!WoDUaeDd%Dy(fb7%S~dG%cloWs?e-T9}U1tuBi*Yo=VltFXh
zg?~?{np{nRbs3iGOrM_~Hofe>VHH8dc`0AnD^(_z`)|*DdqQF9F<GK5acR!+aCKPX
zlDQM~c}&UX*f*d~EcWFE2ii%%ssCzKd@_2#8nH8+`qI%wqoFBq>*Jhk(~4L2`MhXx
zb{J|${x7DmfXxKuwdq+chPtwiOs%r<uHds+eAo-y;E7_8j!$(n*cs;MEy$vv%I_9|
zUITp);^R}-;0*d2j;plU(2Y1tt7+e?XssR`fCx!OT!fwy!)b+o*$+iT`P+2DEHrq(
zXrnJ4n)Y*cs#F|X5DyAdro<L~++vm#&y(iOwx5YqNPK+AqH^_){l><|ZJ9S;cHyLO
z?L0YSpS6+c&Y(kV4JS|)bd-s{xb4}r_t#sekX#Wjc)wUFovricdG)d8S<^av)p~kY
z2%`JDM*OVy1;>;;BF)dD@sAMEby`FWcPlcm&w@YF|L`<4`=Q;tXd1Q>{o<z^H66PK
z`uh3{=@I)_#2K7KP#(?_d;k7gtDc`<Q-+9@rs@|fCBnA2v9Yn=nc6N&Q#afkLFV=O
zo9xp}%dDEabjRIuhUU;r%$W+G@o-2EdMM0=*ZkI)6u1tyF%a>VMAr#xGPy2AmnrE-
zm+S`p&U9?raPoR^zMf-IT<{G}Wxns+Na~ji%crMb5L-IgpvR5ATPST)ORuQ>h>M_G
zjEud;vwL0mrPk|<k!tk;d)AQj^fCI^_@KssJ?q<-hEJgan9;Gn;Y*f5Z#Iym$-zB|
z(?ka=xv#@>(e>(;iBeTu0cEIF3Rj~5&;y>HOZ3LipFfw|@4bl|5+Cg~j%^A$d_`PS
zCOIFt^MG2e&^-=;WMp`Y6gpakwx2Cn>Y7vsdP2eve|if%I93d1N0!6=?jh%%I+k~U
zW1x@U2L7N|0qL(Do=SNCdDeA;O=v$D5W*eLdv<gW@$vDQcLvt!DD102p-?Y+vP?zg
zx5sl`AuU29d=6hH>5c>*L~*Nl*xuEayQj6-aW|;O1EuLn+R`FA89G-Tm$erLkDsWF
zHP+&2g&#%AJdPy)@`IXF!7N}Ys8q^*?rW1Py1l!TPT_CltI_=G_q1}c?<rfKIXep^
zMf%Tog|ztZEiG=W)S3i4H54ncT1s|2u}&V>#|$2<FPK7t*CC=tzdhy8_M0B@L1>m2
zGB#I(u7`)`^h8~<Sa|9l^kOH>RrcN)cSfo?mp#kZ+ts+GM@kg3WE@c-s>d;6ee1P9
zXeR-L2N0(Sc0(#A;jt=kgG^v#f|04|<ki<L-@mKeVrK3r66Q;83>H;I$&(Q3?c3Yz
z9E~t((YPhEM(e%m1wJUk`HRZleULUi-R1Q+%g7Wozy&co<|#)gbt!@}%PZ^=QfkPN
zJbC#rCC*l)9p$~P^P3Hd;Fj-2UBOs{@jjb1*<-3e^~+<w4Gax&#azT^8eCzGTZ8S6
zgG}yojdAZOTCb8Z6*=N}7llz|&kgERYZN36t?Ij^@sMRRB5_d^H;x+k74V46#~3Wc
zcEptTh}@$=vTy3>7p%jR_;st<e*)KT!B~Lo%VP3$3EuiE<YQAzoXU(U6&m|Hr+pI?
z8<npZvRRVjF@Z%SSXlw~)2#&2?y+Cr-n%Mwg4TVhxz!q5?QR4V=(bngQ7;d@zGuWb
ztCSb~A~}>Zv=Y-*s)8P};)UNd|G8X~8ho!&#heYICotpG)xJ2}L-aEdk`TQ5aVBu<
z3ca{PU*dQotN77^&uCkFZlx&<B~Y4M^yj5D51DjXRn=Dp`dbJDB5&#PpjQ>A)rjn3
zc?Gm3eAcQByu_aP$Z1J4tfjcKBnN!I3exl>8g=jV&q`dGIfsE;Xwv&imhd_-TD-;|
zso?b1oSORzy|}EbtlUbvp{318046MxlPfaeE+60c)!6tv`GAS5|4(~w85L#wy@3v(
z0wRJUEhVKQ-HoKQba%Hj(nyF>($dm74BaUR(m6v6-3<c6Fhia7==)!1t@HVO{C#6B
z=9xA3es*5_+V>t$ihqT^Em2a19Y)10?~ZgjKN4+Az)V5o8B$jz7h+OU&u+Lt-x$o&
zg+$@%AH;s~jvn$A6~yT8jqvdY9q0OC1b-LW`fg!p(kBx|Vs~|MxHnZyfc@x0NK(=>
z3JkSsCph0$m%{lB5q*|8r-4yTJ5sb`xmy2ZG!^aPcTe=%KSVU1BAZ@TyYE3%q*7uA
zgs-bCMn{QZj2CWsRWI6AVYw%jIqxTQ8-XhGXF|KGC^J&bG<gNZW|lD9bY~1HoMMYU
zfPIjU>+PO<Ok33AeGC+Psx!uZ;PRnn>k$gfHw3Gnct^!6I5J7qPN6y`&07ds@#OU<
zSNvGJ-$D~S2g4jy9}l9J8${8&L?#|TBe|zm`$v>}b}pqcJl1R^(?JpyF_iqH2rI){
z>lhV*)q9UqbSm|pGIZH{vc(C=61<Tfs<9ec_~UB|R@ZyUa1lM>l<J|O{}nmE<XRDU
zb?!DGq?Gn7i@EfZtd>&QV-E_<Hz3Z`oE!+JMW5|lja4P<`swD7;QMT}=`n+}Xn9##
z8_F!4TK8mSzdORMGT7p<-$H}8$t9h6zrp^{Ys9367tQ_LV4xulHeE4iBbm+Jfx6g>
z*a|1&m;uw;Iy@x5jM~xaC>#+2LxN}P9y7rbI}<Crd%pKlNep`)&TC;|Klbn>_db}-
zZTCaERf+s)X%RAG+C<t1C#MhUvPj1*9~VD)I<1%3@>00RFI7C&0`W5kwlicj5kyc`
zQ`2y0P#nR;XA13*El0|j^<eNDwCd+;QPTNL4?THXjS&a9X?JpR^1+c2Pfv2>(PFu%
z-^GV2ksmcR>dDE;xEea_gQKHc(z4T4gN~Rrlc>+d`(d0*h96H7#~Sx<mxJcaoJa?=
zL<H5Bbq56S`B4teuvNkP9#7F5Sdq=s)0&%`o6RlJe#j#&Jw0;lA^N9`U1cRDCzkCv
zRfNjtT?$=eRJ*eL#^caLPnPl%ha*Ln0v-(-zWXW@ns>*Ma@BK$l5aF9PcAW2Cb{2w
zlN-Y}!}u7+`5fnXZd`d}Pk0q}9QTPiyQyaiF!H$S#$k18H!5i${3Y4o`#&@Qu0$mp
z4MvK$rnYujTbl^oUW>yFn<|Wjg(ZrJTx|*^S{41kip*1WTeo-6)nW<?iR0hyKp#Xo
zp>O=)4!0IgQJk{MkybB;`IK<pDjL05hb-5|tAY<X>IjGUQ1CkK!H8u8D7Ktzg1>e{
zyO~;Ie}?vJ(~N_%iA>#wUF-ZO0?>ND75oz>%r~H{pNFEay^fcZgEya8Sy|z7KR?fK
z>G)&W&c)50oSIskm-j*^g`JsME)<(!Yk&m%YgClcIM$H8Q(Cf5)R#0lW-l$@G9=sH
zO)NA^HK=Tjt8;#^*u3$BvFVQVx2Hoh#PgJ2f<br^#UK3QzW)3viCMwH$jI1SW5~$J
zh)ZPZG+#H6h~Vn8{TYVqdp5#vq}L%uAgYN+%C;dxt5Q%rg?JTTx$A;{n<9&UZhc(d
z+1@B0<b$Mq6~2NgVNTnHIWEX9HgFV#GRs>&Y2xilC=m6#`0e@}<-cUyYPmU>oDGKO
zex}}=2bDK9>5Ap3l9Q9S5rWvbN-|VQmG;&KS`J^Ajt{xq@^73B&Rbi|7;5FTKp(|?
ziQ{0a5~XKzzj+v25C2o$K{39?%b*PU!JU+n($W!qPj}VTJ-FU|TV)Je*AICFjinM6
zG3dm=deDTf&ueP>4#K13?6XzxP~AOG-_?cf`Q>v@d*5lQYP<X@1N;6F7Z&xIb*$aS
z15ML)VUE9Aqw6XwEBjjRf+d`hfmPuIZx}d6_REZQz6-cIY|PHC=upiOt7L^AEw*ZD
zY8C__7gI?w!#qMdKGd3^O6z3$jW@|g1bKA^<d@3zWeQDZ#HtM4DoAr^WA4UmI6xun
zhdda;qg4S{UNfojg|MFWEzo{Bq$6QnAUjCqmlVhIQsZ{t<_5=KzkbcPeXNy@ChNw-
zkkr<dr}QXbX4}cT@%24Z-;N1)IRB%=xH>lHlyTSp?$9I`;v5z8vp52|kj{>&+;i&R
z7tucA6_94jNN>PB(u}XmShd@>{p2WLtv%+8Ps6o!k4PwoSw$p{4?dO?MsMc202;jy
zF)~qMN5Xb-N=uIpRZh_Rkn+5|pHqi-BmB!HO--}4h@rv3$?u#NhI$PN2~V9Cn&Qp+
zgBAT<mKm}>NH;JGA0J#+DzT55u;iz&yf}eTOr2{Z$;!9dvtMZP$7zj>#MeV>VDamh
z#BTG}O6vwZ9sX_=8;x9nEP}j2l%2`0j>?NzE{85**8Pmr7Sk1Pz>C56WP<P0ZVe6%
zt*=Q63ks&KhMIl2x)wKRbVfMBb#!z9;i=2Ze<>b=gkWK}H24ptvg>GR5wqWuuyHRa
z?YAyH4t$keu_S)mE+2$qc-&b*>yAMfv(F7ggTuL6xn=*em@5<7-4J4uMr_@E7<lR%
zos`Jjg_f3<e!YEi@fc)ySZQ;6yS2f8Oca?3fEhYt(EHve<oWxtN@{LgCf_{XT@^9f
z!P1(uE8wGRZbo--VlG!fh|bg>Ul3t8f?OFy3+uSKFkm%k7`|cuc2Cz#URBlG6LpIk
z3)-ujQaQ7PrzR)w7N#1Xo}-e})5}613;l*#UH6OM=8|(;pO^=03&Qr67?pydPom?E
zJ6kfirUJ4>T$T(^(mHM{^VDpLO3t4(B7%5$EbE4j1rnm8IeGmadXm<cW5YQ<k9b-W
zptXk-#sYsB0kzGR*xj`|F)?v-OZ3N&9~Bf8*G<E_4>4dsy=yZ@JtkJ%CgNW;I-V<K
zWYl4k{jslhn~abkc2sq;si#d43B7PpM9l8*Z}#qA%RQnis1A8a+l5J}0fj<+SHnpS
zO-8dt{a$l(Ct{I2XvEfC4!i<4IL@sNGz1}_Iz(&F_m?|6%ZD0W*JXhMw~Y*xb&4U?
z@<Bo8aHc1tz1Sr4u32p9J>@rHl^%SY-h0O<0)73U$Wmyzj>GLWs*>GCTRUYRi@XuQ
zkp2Vt{Eol|jVhrJ@K2{Vt_>QUp;yP9IfUD~$4l*=2i5(1S>8*oR;Y(~c!-(KTdmJD
zflcb_>ON``@7Mj%NdvE*YKbD1VRh@RJ~hsie5Cui+v16m>HJ`}E}S-qnr^#WUV6y1
z^RPgD&vvw>|C5mjV%KUViE$g{^^58lr0J(a$lUe=<{w7NiC!*+Ua$r~vfN}#%+S|U
zb-iJ_Cu~5LpkV}DiGUh&RfC<Md(5aR9P#y$0X;e3QY0gTK4KPa+qK>=+3Cv%wPRva
zEuQ;N*PbgXC`>kQXYbF06ce0V5Bah_ZlzHOx-qan#3`#7jE`&nkk^-Ld7eMj`jQvw
z=cI3RxC8F2)HW*>Kf!Oj&4HETM%Z_Jx8o7kme5^K+;~^CY1;E{<Wr_>hMf-n9_AZ^
zJ8_Fdt7!H~RvFr=Lw}59u9%F1T|?6jYZ?#CTdE3VM!X|S?EyUfTg6dSUEi72eeoc$
zU0Y0_lNx0a^s~ji|2v$nE*WV%q#&Jm45#Yn48%lSC-u1F>S)R;)u<?2)Xz7sorQ(v
zFGq@QtFuhw{reR(*HX~kjqlnQ=BH@hf|?rj41O1Fh;e&TR@O+A1rf_vR?;*zkICR?
z#E*tfHz>Rf8jmMD*#qZd<IV0BKCxJp?(+POg(u-ChNW8$jB2}9qkk}1+1R*G5Qi+a
z`?a?CGcq!w`^9fp(=KjLhuA%j+mTGuf(^@oSG!?EDjz(_Nm=y^7!^~(+U-+PEA(n*
z0koQ}^?(cD0?l^>_#M8slt|K&pD~^_YMxtat7tynB`#yDjNC{h-F^TXqwB&XBsy+K
zW;?h2>1%p*Jf15h$~*i<`(n<9W+wH|oJ|h&Xt8y@1AG(MnH_L37be{A=I+jG+6B@{
ztu85f2b7KtPVkg(5Uk|nWZ&Jw)H=sGu8|CW)v01t9b@BcYM&Jhux_<vtJmS$ucvD6
ze~?qWtM6UdT2BA$IiY*<AO!_{Ef{(%@Sm&{j*FIm)E;dJ=Vdw__IR06%Bb`8yKV@?
zmJi`JJ<+iN2`$7@37`L_kL%S+`%FMH8WJU8Y@B_?jw5!f%c4^`9WO^sKI3$=e0R(5
z9I+v*;p^KHE3k$mdNFHJ$+o@rE6NkO=)E5+eDtm<H!O;Tby5_$Fm<p!W8|H6dUl3r
zKMqhOVpf?RV9u#9Zufol>eZ{<`F^t9etL~wk-Nj~Gx98cMjg9XOO)GMdYdyDcw#dt
zlZ1Y3e0YM<<)1sD;am~TE1<9tpqzcp$_fo75G$E6_G7IaT<i=AdTe}eEf-r`O)Y+F
zB%_$qqVFXuD=QnkIWJF=z3t=^tkNjs+x8r1|8pYJO@Gv8swaSR?oF5Cy2m$I4Uqt>
zxt(J?JUlI3-4gy~e~ko>A=bv7%k{XKmF`ezzFb_GExkiwbB^Yph>4?!q|rC;G`b00
z9`x?>1s20iZomHF`r~7cxx;Z!7bJB4;;MN&d+P5bmX-IF<%V-|a&lp{MZf*-WML)S
zcA~0SDb4i?b~=xpx?#iF^4+bs=;cZ%u3t9dXwg8&B%ppD{-dPiU8<2+8gNZc42}5G
zS$|<!nL?Zxx@0Nv>hK$lJMi-+<Y=J3<LP<rCK&*$pZ8u4NR~u0gt^^bH+^RIGtrYL
z5NkJ-@?{wK&LsLws<IN|B_m|gb4PDZ;aqfacbL7<W|yTjbmv_CCceQ|s#RBB_(Evj
z_=%*9V^_9=UyL4+?&y3cSnaddM+a6?he_*A;y~l)D|)~or5B&SthFBb+FE1c|L51>
z@bCt$EG<2~RJ$+YYgEmW_i_LQuYJ<RqW5x>{W^Q+wK~9qBSMP+h?dAlH^VR=85tQg
zYAmR-*?rso_cyw1QKrC76PLC>veG8H&xnb44;z<ZaF<T7LuIq9_|@E)$AW9WU2o(Q
zSLC(y!GeIG1{T4)Gt0%YvgbzLyQ^-76KVaub6#+5<K3O?W){TYmGCs-c>VjIT^BA~
z(o+oNdKQ?U%DWC{zc-}R#{{*m?sFN_{yj^c^YK!<?^c@4d6dcZ3$`JX_wT=baIcY8
zl$DiTc!cG<o#lPLR}Qg<Rp_~Ln+4g~l^%6m9X08V)Y4P=pL7ENUCJB1HFQnK-R%|n
zPh3z%s<E#;Hnq=>?bz^o?V(im8TKI5P>JJlw%-xJB`xX>#da7>dL^`9QJa*L1F5Uy
zQN{l?ysqKXJE<P6B3N0juF)pQ!_WJxIP}VEUBdetenu2x5L=jjIe17_xQIA3^$!e}
zwv5kZsRF<?f8qMCzg1C*eej4(BA7TgI{FdfV2;~)&=0DmW7idoA%xmUGzu~^)YmWj
zOcSW<zCF4row)aT^OsaGBQ#96)@BTbMIf?*)_T^17+}t^-5O4tuQHRGZqQR#&$Ajz
zv74*0YWdSg$?JFFNac4>O(E)AcY1cV-Z65TP;sHW{hIrQw$SR89)<9m&<2Uw>saWB
zyI67=mFh5iU$ntHo_o5Wyu6wk^*hv9kVg+b|IQ6^IS%f7eh5!RLFT)+&vw5_J^oV8
zwd{X3GVjuP!(%`FQb)Yg*k|?r;)fpmOiNE1(}YA`r+J=5&lw|EjV&NZ&evE)0k%#j
z72%V|Khfg3?{Qc^WB=<bF;z>Bp!?QN^LDnzaz}vYyj`)~e4X7Myb;31#kE#L6;)Q4
z_moYPeu8(ZxV&id>m@<F?&*Z~&7t@*?6Xe8?sylWiE73Aw1=m?9Zs(2p4c;}Q{Ccb
z1FYd<H3}=Lw;A>W7gUGD_eAVLTW&7kh@0ae@yZ?+`Ms&)xW@u3pvR8Fy>Jn67VV00
z-WkLEIPu%r<V|?1H)Lxxt2~X{#?6h_^*7z;9bn3(_3ZEy9^3fx?L{Mu{oPvE>E@8<
zpI@Z=S>8)u25te6-)&Q2(F^WG!RPoL01i`40`(~Qoi_%)NjQJcEHxHQ+n`x3FFD^I
z>2w^wc-Zei(?{tX-2cQBBl4Y|UK-GiFmP^`Vb1bM0Mb&`>HUM+F>QPM*Vs)|e<`jk
zXKTNrfLF_E(qS0b>8E`>*X&*l4CCyd4zX|d+P`&ks~HvAf3vx<(W}+0Q=yw%J1V3I
zFnKi%4WD}-8XFmbffgVz)l&R;)qg9^h9>~+5pZ|4JOgxT;>2%tTfL7{)&)caMapzq
zCQ6w-G!(dQAcWlx$9q)1mbd&%<zyHnPjN6vf~$Z=txMaVh`>KlCbkPrt}O_dftIfB
zP8yoZb6V~BhS%Owdn-T%ZDK)Q9d|-%$HWXE?HB2TLqo#tB0#UMLa)~2xE<-HUT?nf
zJ6>oll76jnfsv6hUDU53@S-+ncRfx#He*Sbn3&iX2nCb!%yyfD$(1iP%*=8D?)0Zm
zm^T~D;u8za?ucKcCWMwBV@z7MhS?~52~D`@{QU;YJg<(m6-t$Vs;*D7@#`Wf7CdCS
zxAt_H>pbIX6EcGhqVGTJAvEt^$EgDG+(qvo%k%Oifnu$}DFeu>+fN5s(uF+BA|8?F
z0kR|zyZrI>>sJx2W0uOMPmJ*VKYeRwyVDw~F+(*jvsG`mv%Iq_+fEh0CY{DwT3Vco
zo$CVVtqhm*E-ZqbULw_L7D(GqTxbNfsP7Iy8-$;Vqc##>zkE4Pq$-ko2yblV`&|RG
zA4*|uIcnMWSPdsFD=6qq-t^y0)&aVR_9rXdE$5Sph~uC;gI2FYH$4Ns=Cuuy$;0s*
z|8&k~7Ixpr9YN&MXM^*j^aK*OS1bcG-xTC|y-!QQghSI0Wc!5b`8%TzH;flHbWQ}A
zT(Qk<hf-L9_VeWAq@hO9;Glw*mR4y^jk@2(fts3H{MV=`Ep_!gutB5!NII{6gJaru
zoU)2aY^?B+Km>to2&XK)Y;@$lkO*oc(f7C=>2cJ&y*JD~HvQvm=*IqvygD8p9?-jC
z)vb~M;0Ni4JwReHr7CW8wmlXH7aGnK)NpA>q>Kt~KhN@-x7&k(GaLrBwY7^HmwXk0
zf$!n1)~^vj@Htv&Mz4et@OT~QlD5m9X2$eJC)Pk~Dcw!zK8>|#1&W?tAzqi-3olm3
z=C@GmG8wn}5}J4S01ef2@t{CM6Vs1+Ibs1kzUQ{86%V%_Tpf3IK79C4$lt0aw$2w}
zzvwZg+_GDgaekI_XQ)x6q}CaDla!HBo|JT9BCVyZUDnj3YZ8D+zD3V;?rmkbZ1sM5
zZ*5(~*1Ykw{cKdY@{s)5*Kj;i`_-S}6rAQ^&TW5WsXlJR4-O4Q4WdZCBqTfq8@KBd
zh+kJ32ckBc9H$i7nx*OGVmIWU9v@E_1qeB)^OG1zN#9<^LF!k;m*wr~{QJs}=}Oay
zAJE_E{@#}VAw_745nOOKDy({SI3e_y?*F&|jWqaA7)5>0-{0NdtP6EL^Z-)4qt;{C
z#y}#k&xvUa1+PL+1inUKV27K#yVPEmma%bVmaz9;IizE<I47_Su|MN5lFobH@D<Y{
zx-W*Zm_AlO5*S;)LRT0zt4|dvPle$U@dRG`C}#?&<;%rsYinzNK8EX;yL8@YyL8?(
zkg)0(Z07`tIm0>G*;RoAoQsRgC!v>HuH|aYc^-nD%8IkhFFeSDEac4%*GbrL_>MI+
zSULuY=FBDd!-rrmiMew|;VW?!d0nabF>ZJD)cP=kzMY^E`^9){O~Db7d6h=3_LnEC
zzBh;&Q7y=QJQCaPPxoU2`OJH9VyH#+f%oa==9ZL{#L(}msiu}&R`xmox#+Fm;orOz
zbQho!{dgK|z<;ww+Ib=!tYtHhz^Gqi`Q@l(pKWt<bJs@vDy=V;%77+wYh$C%&$fK|
zSVvy|i`U_NA*2JXaCf~eE?Qf5KyH({I*)tX?}dED9kcE9@?x1^k2!iImyVFnp^!jq
zJ}=1WWz?#%K@Nyo;)>7|<DHK<YCv_m)!T*Q#UPVP=6AxLHSJ2n-E`>e)5X=#G?gYd
zdpc+YB<QfYg_xLlcisV#%n(D)Eqil?oDsV^$T#bWC=I&11p+Sc^EWp(Ub3=+=RVjv
zfCmQ$>-><;#H6I<RaNizXCO1ACjPlD9Vl5!e&_RP|Ia8Cs^wzd!AKag8euMXW$hLZ
z_rj#RIT?PA7~V{{zskZ|J{c1SPF|MJq?U(0s4T(pAvk^jdaAFY63e8VK5ged>@!zo
z*281oi}RDJS4m$#9WYd&vZ3U2JaH6FWi^0V&+>TeyhrRzNNsLzqA%bsqKnk5&9~@%
z&n^t?rUri*sQQF68yDP7H^(x|RfL7$1(#}DjjY2%#lj@m&$Sj}?ETr`PVk<uMtHrX
z<J5h8O1`O+<Cab;18$=f)x2$zalRtSd*8+ZgTklei;md&!Lgbb#g<1$s38^csPwor
z>9;n-7|f`c0s!~8q{cB+!rD_s${KE5%Ts;4^ov)C)PtidZueK=y1IG%x2N^~15RO*
zFdc5aR{S;-DRw3YryJI2jmA}LtlNf>ASMR~=h)=ZV^QcNez0`#ecBKpn@Z=jc)&v7
zHBA{k_SZU4C=|~Fb9?mpF7O}x_~6si)AN;3f-<={Y9854VL#n6S^SZLzk1=lv|K^J
zmpVlj+<yXn790ko4&^!!V;*U23J%j?+1Tf$KYvP6U~wiUCgu;ZcN!jdTsi+lh$(pJ
z7=J8$`0$~jk*r0*P-kk{GqG@N7kYAKq2^XM_XOKVVNUxO>Nl71_2<(dk;q0B5Uw5i
zd{+oDt+5*b?QZehFG^GuYn~enkdPBTsOmW{H@Q(DHTI#4iKhjcCO12B;%<k%hn^M5
z)Oz~e7!JRZ)OLl+f|qn~a+a%oJ(gb2)s&&tLYM?!t)Oh+e-@lj)rY7zdUv`Glv{me
zD4G02ec30N2>=v@5ktl)30y;$l-N_VQ2hbDTRerc^9&#x9L&|)Mcx~Sn1}=PvB9CC
ze9kq)M$LT6pjqWt1ODA%CjrfNsY};aFxj(QIj%UZin)2W*DE9hn-9zZlFiTN)d<RI
zh>1AG3t6Dl0`g0qd**Dy!Uj4<p2@P&WN$5e7L@rH3v#7CPZCmp82qh?Pn9GiMf;-j
z?krVbLv!x(bL`XycXzUBhOVzsTv(iagpwfK&9d^!$>~y!&9nIBeg$>)1SXZt66PHL
z1XLuU`wbc~rJ*WXSgKLXMVcW8FeQY53vunC-EY%mjiv;=lu<X6s-uUc!#utwbpAPk
z)f$Z=oz)FdvWtS241x$Gr*@35jm&Ef^%~fNN62ymUXHe`?@VyV8mxgChF<fBj~HHJ
zz5(F^H%g5oW=xLJD77}*-{0tf-W^WW_^XExA9`$OdGCF~WBb7=a@i7yfa<U?GBP?3
zI!5zYn&j6#W0T0B5EW8fkKjZS|I{&FopFZ*YEzzHY7*f>mmG~sG|x<k!XGOu^G|RL
zk4a~;rfEw;WP5OMA>X=isz40G_Yc60OM_*hSq!|qTB#<1&DnuyI|?k$)TE>W_fbJP
z073;fE-8fi^v+gWcwQYg_Aj>Sz!c8-F9m~@pC?&)tRFm|cuNs~={Du<dwMLx>S2Ys
z!q_GQI%#_w`e1kUGmUj%k_w;WEC-Mr^V}1XQBe3=*}O$z<ob)4CjvW~j8hT_iI2rD
zO(}ZtDm>P{KceE|2yKv%KJs@<Rv5yGz<~T^)B(N>x#Z{B`$TS>EbEP+pdO%EKi-Dg
zMnC2Xy!O!!aFm&;H1a$f;otv>$6mm>cI|o70C%4H&S_!$XsqomnUUYBn1YJA?X#ba
zJMEI~=a9T_MOihlLDx*Qfm}&i=wgINln-_Y(G=E~bFa5Vpp#RX(f`Pn50omujPm%L
zm>LD5HqSrp(gKi=7;1xPBu6}_4<}D9jv6R2>K$g-=3l9p%+UB9a4M(symH<*jrLeQ
zu`J}m)^4Zovo2r09ajBvl6(N3bZ`O34E7#?7UDp7!8Yt}N3F+VKya0pm*<IeU|Wa|
zyzHUbYez0kIY8QFL#5?aRAP^sx2a=j#Eti7AjNOztL|>E_HVC_b?oiSjDv1GDHuja
z&j5NYV!x$+@{FZi;75Ig2V!?GO;F)9UV_#?2fUbTvxI6$c9p5lCS<A6!odiOpbG<u
z*o^;p>w7V0<GGb)^VGQceJY!g$7Zt5YjN?MzQ}}uL}rKiI=fSp|K5B(3;xqjw>MY&
zA=uR8<TjaaEqX()ul+@l3+_Of>|=y{+Ib$j?#9#PBIFcOrKKr|Mq%afm}rj+Bw)I9
zOTFnYO<BL(6bRJYhqMPRE`v>^8$HUufH9F&Xg&ig%4MaMyO4X5!S}l~n3TT%C1_o)
z$8EppFO24-;CIffY&{a9pnupGM+1SobQ(1`HzyP<EEsNXY>acz{T>^e$rN<=n2;fz
zAanhY3EY<OQZTI>D_f{RG{FPfEV@(vsY*}&?Czp)$;4pN&4$^+;nSP-uqwt*3e2LG
zu5!c*%Z^PZ+Nq%q{2S|y1?BRyOBdRZlUJZ%n@r!mQs0wqY$)J{dN!ju(>X07U=S0C
zp!?Q1?Gp+f+iyo5SI&q-c;l^&QHw{e+0XG-Z<oc7+gV(FJG;d>MQ;tQcgAzmxou)&
zh4x;e{Fl&6yv*I5vV5}Wk!GW5ZvJp0Dl?WPqukV`d0KId$KT%LRDpbcW_d4_0;%F+
zt9LQynl$ik5KtY5UtfuR?{1KG-*B$C_&X<_$UUF1jsKLH`P|CVvZSCO?7>4dW8>_=
zEBLbg&Uh|*S2ai>w5hj1KG9<z+-QHkGm%}E$~if4g-%LNnZ1dvsY&p-Mz#+0`w&X6
zn9w*+7~IV<7Rnxfv;@bD$pn3O!@~^&;Yk=$a+-%7HLX9+@>%<$Airv`;4{_eVltA(
zEe9lt^YspP-v~E1Hg>wPX{M82X`~0tj*gBNg}nHdl?9%wwE?1D%T~IBrlzKJzDFMS
zsDKo5Ij9pT$H$-}`gVV`nX3st)brSQRi2*tEX!Vc9h8l;5(K<1oEFP1NVgPt_?-Eq
zc~@hRL()R&bC?0FVIllYMSxzhSsi`3bI<zaD3-*+-z@&K`1RXFW>u!PuNL%jvC|fD
zqOww9t0@M~6Cby;X4XFDBqtY6Yo_GKNh>IP9Th$nY5&tlna*K`i9acS)Q&V3MNDf5
z0T-{<^52{1F*E%dC{Rj?A5tY43(dJ}Fuq&VCJ$}r6npZ467vnnm64fQj)+NV{2F!U
zxgNt`7Ib&ZqtMp*1mzD5nALw+mE7FioS=2eyaSGFJ(^h>9UV<_EENnD>mvio1R$#g
zs(Ys1xLlyHUB0`?0r+od8Qc}oS7LUs>B_+Y^IYOEmzkr7qUR6YO)zl%7A1&4k<36@
zY8-&j0_rCPRhv1du{Ls)ztHXFI^v*qY?2HNToLQJTbTL)A5xHREN%SUi&(Lb46z4Q
z^j>iN47hxfh{zC@$|gxj+v!&()$Cz~P-^}<of?(z--g~XOK*gWS3-;Tk$i8sbUR<?
zIQd6$IXI24297LA={JYBcBUH`cwg`?Y!DHdcTdec;=uqlvb=l=gfxh92A^GDH2L0Q
zD}T(|+kt_BbOG1Ar2wQ6@v~>+v={*5d{8^Kw-&{&ZEbCxfus@h7l<LbKQ}igv>wfU
zUMzki4-Aa7R||E`R$K78EQtWIpF-e+spNF?miaW()`*MeKBFkK9j_fi*x{MswLg$L
zGf?n7Vj>`<Sl2PT&FQgItZXpUvY*aya%Slb28l>uy95#FL#-V3M`>V+9;h%17{pF|
zv&Ock;^nAI0ahq_A2I`X>C8HD;_}#eFM2*M1-wV8qcll^ik<Alp3ej`0PKM5yffmq
z8MXX`eA&F2V&KtzpOnFnpi%nhqsQnD50!94I1^!qeP@37-KDyTzmBp6=*x9;G!tlr
zNl;KQUF2g8Fi8fmwz+Lar@KP1a3N3k)<#Qy{E!$EziR_-dks56xS@B8_kWR^OuP0|
zk;1CVjN5%(U&!dCvKjGM4L%FFT>T7K_h8jeueLtb95ExHlM#p-GMS9UWq>j(XJnQi
zC@qaW>7WuG^4OfB6f*ZP{k<m~pvSa=DTF6l1#0T^oG~hXrBP(N(iO5dSIdl_u;Pn6
z0t3AN^}d*?WF6zQ5ADW*XBo>o35slAY|Z_$#i@G8^05d+-Zw4>wvLM5`QIFQcTP>I
ziYxbo?d;^o!GPOtiJv_yG2qw!q4-jpf}cZ~ImX5<P<ktySuFWNQ+|NX%k0skG{=0>
zQ?KM6*UYMAeqCkaNNRvSVSO-L4ZtEzuInBL)%|7O$4hMk`SBGMZ<I6mls{8>eFyy7
z-h><t!as{yHM>Hu)_S*>NHw}?n{HL2UqMlEszfdS{Bk{R|N3lfrgluM{Nvfy1jk#Y
z95JKfEU$DG!ObLXQrdS6f?}nr)@yCcS_Zq>L#IjceSRW88`o+N)9;Y1TmzZn5_$AM
zKNLtlu1|+}1FwCkJjUPdP2^*f^4Lywg<t`<^Vkk1z4{yeeg2pq8;x&m>;QR(;CANJ
z5nXU|^SN8(z~_<;ODgwaP5^BOtiPYyFPfI6i!s$OkDS{YNcu7pl@AhM7cw)Baulq0
zrk0vveT2wemX%T6xUTv-y{t_6!+E9rj%*c&J?J727vzz|Y0<ayP3o~)j#z-lNjJ8`
z<;f}#geIq^?4F0Qval%j(*(8kMU&^F&bIgKXN;#l-N#$&F#h=QW6Q};JkMLyHt@))
z%qo^p`Q|TeXXi?w@b4iIH>|ZDnFRR3wi7SFy45dM=gm(y27u_RB8t$Ya{Em;Y(mx>
z!Nroys1k52Sed~!g-b)&!Onj;=`<F|Sf~JVrSRS3->r6WtXe2S-Czby`@+^=UJ8B6
zEtC#9vm&?9H=^NKTNrpy&blHBpw4d9hU)5h07NMF+%@dM<L4z<j|C(|{Vp`Et&6z0
zxqH%sDQuO2?5_JhsqN{;0D31s?tEN|z;5+txGSnn5V_#a>j0}L!EP-rEu|3hDA9%(
zkKhtX$;->5myjLB0R06x)n}T(66S0l0NOac_Uk&|o#G8ZdjRc$!I2ThCdr#{#C<ud
z-4aYm&oD^M;KX950bSvAmTChN;VFv2Awx;n%>HL7A6dR^NSqU^PJP40s61lZJwNhy
z7@4`CO27)tKG;g1MWHGnO;(Q@gQP8%MZsrM&n8QTUiu{~tFpYjyn>2~wz_(Px`sw_
zN=ni2uu@@hF^j0EQCeEs;Ly+%Q1Txwww4<-I`6^2lu{TO0q?j5M@PLjQDn!W9?_h8
z6ZxN2gmxJKm=%4}Lx6w;-6$%iyqSQzbRO>2#L<Ww|J87zT?Twgz6vR}a}9NMz>4<1
zNj-Lz$<k0)fBJg-oucB@?bR^^u=>-D0e~Hm@<uODRSYHV(t#>cP*7Owh)rZt1{flm
z@8ACbSaF><7wa-KBbEhd&tG~*TE=RNv82~ccRYj_^cD4cCz}`PBtu>jP)FhPUWFl@
z!2Hg@rdo?J49Y$_uCH;c9}9F(P7%pgRPTM>ySj45jK`WvsNZlfSw#Db<s>8|Y@DI?
zTyT`_>`KeZ$_(`yDverw%fKuwEC2w>>j2w{;a?gzaA_|*gg1Ko>V8X1%#V(Kl;wXq
z(6aIgkH`P=gXcaBEak^26q_&VchO{DdVFwj5O$Qjj=TcqCjhu>Jx&~U9CYUgi~(r7
zx>oOFf!o?d3X6*Dr%Tj?&W5>x;Rzr`85|r`x3_=Ies1=9P6M2?d{M8i-WHVH47M#V
za7jvzfA*8u>*e7Sm5j6^nh*17pt|iptBzy8T?ZM9+mfB+E(M2qP^yb};4dNw99SjT
zsTOL4vOh8{R5lnwj3F>Aoc5QdFvapC{QT3|NH)UGs~DgJbQQ-;R#HbHj1GnKP#om|
z?;4V&R{FhcD@!G}eDsZ@Tjf!k9S?iM$yWVq3=&XRl-JQhX}!aYJ+w><eLBRB09w99
z?$*jVVn#rG>c*z2h^Lp^>%t<iOjhQp@!Z#Tny-@wO1dKDjPp60oZVy{<K1&NprW9c
zi`4`iNf!pTEzpWO>B34*P3;$ae!o?*42qcc{Gv8@>QYd{PVD-_Lh_^G_)zB79sfh8
zPP$a~qyWlrVpDQ@K`V7cHZA;O;QLAEBir;Ko@~O!I<Y|37ag+jNB)OZ;KNa-aR1Bz
z43n?YzA|w8`u(AWQ4mYjaEIpo4BVk*ePpFJ-uxwA^}gx=G>e~RG>TQ^3kVOiVi&t!
zQd3jY@fjH1sPj7154f1K0kB|Aef_f2Q#UOgotb4wMa3%Ra@P{4rxZIk7gthxy1sa)
zfv<1NW6|^Xz!5{S31DxrsS4PPT3(8ZW}%kHFYYJRmz9;NTUiype*IcgQ?mfld8_X*
zQwg0cRIIliq0rLN;TKkAgyxhh`?=nKOjIdsQkagK*c%<%*s#PW<B$N5(7W54`n%gJ
zhr1i3j*3dGy1M$FOJrpjUX_B>qbjABbgE=@ioaKNaISb)58!qA9rZ}hK?ZRQ?F`n%
zy2tTtw|zogT(4MDpbc6im~Vb;*~tgr2ffpbT`y^B0!VOLc6Ox~M~mg{e#o-6HbX5f
zEw|@##KgqBGz5u>$q5PS;_QYhDzO0anU!TEu0*(llboFVnw1qSE{8mr%b%Q7*V5L8
zVe1EWnn0nvXOB?+9q5%(=cAu>bv%WIg|F!8rRL`5-c(I|!KwNbhVT5i>Qf5jS7crm
zoWAQJN+6>M9_L2oU(}$gd5-xef8)nyofr`s!?D0M<B4ha(B(8H=$)=u4kYjiW)~Rn
zYU$}^3k!x6JyNGrZQ{>sCtWnBPoX|Z$Y*O6D~IzPF&{ct4_ckY!Hdgwo7LS?nbvwy
z;-<oVJO>jL<R<FVamipK-f=Pw@ujiZ2*aYIWxlo;zWG4YfEQ^rECNANaG1*=shM!y
zWKnD~X9vmlOk>~jh5!rgw40=W4u%Wu-~F`ay=1#>W&;YU2;X3<I?oJMyu1DImatk)
zqc;~8q1VHtdV*klpYL{;aEbwey-0}yw)c3CU`kF1u)|nLR{~1NnzUxbcbi;KPtabh
zQD1R8lo*4gE&A`W+eoNYRlV;=EiH4+hPHI9$Dl}nI}8GWB8j?-IAUQha(Ssj92K)d
z)?^n6e_jk<EO_Xe7ehm+wIoDolz|U|zA*@@I0ak5Q$f6D;N*1yD&uQetV5;ghct;r
zF3mBIwi(_>Q3Jc=B%;YIJk;K%t828G%z&2*Y;XH>jhh>b)rcJZy3@z2%W}qB=cKoe
zp78W?eYFk$WqoK0cI*<1{?aK%37e0gHl?cSdO--m0apD5lNo;(t8Fv<h)ZaioUHZo
z9C{_x@>#L!URT8B?E9hZx+=)~eafaB93ni*6M`wdfzP=4naY7%c=cKH{(0e^NU{#h
zFwGy<J<>fTp_~Oqf5}iF5N+Srr)JdNojR|dj=m04#v&!^4pc8JC|HSeaZU6bLh@cu
zMo?IOPr+<VKb+&^H~Zu`RyQHd+E|Kzz^a7+@A)P15>>6`+07<6!I)%WoCqWVGn^9x
zQ9a@tA^0}E20T7)VxVHO?!~XHLtKF;=>YGsGlRZ$u<{QPS51gky?H#mcAq3$=I_Q~
zklK^*CHB5zSq$ac<%|@h!;3d^@8Eb1%0z1y`o8ZR;I#>0?V(pC@k!54#HV)n5xE(>
z_5AWo^6_!M@Ng3L=2nnSnn6Sxt_^Bb6xhBhiC0jq!7@8d8;biWyy63+N~?A_V=w-y
z7|7=n?(e`oAwP0@ay>l@Vh`Osd@h|7{EkySBQX*^x*PlF3iodp3;I)C_lAB7Ili;}
zyE0j#g00euXZHt#Rnf<w?DRaB#5zl={^waJe+MDmiIx(NkoF46Oq-FWiiZ->PyTLI
z=4`dB*KeB0Axj3IxOZWI)THjD04<{GQMcaP|MYr3IB0rNsO%N}TwvH{H4L^aRHhP~
zF^&anW|qLNrn|?$)Jub%(fV={&zs0!#RU!{_!PZqZ|B!g*dM_WHa$x?M52<cjMM+S
zF2956U4T?+q@75JR*8*n;!PTpXT?=#y*8g|E0e8XT?fI`yhVkRrW?^{&1b|F2i+L2
zOGZ5}9Z6fvUws7$#UoBEoRW}mz5X7rNehf07@~i5@B5l0m9661sLqlC7`)mmAxZyF
zh)rMBhVoy6zlh8}TrggdP$}m?e}O)RpP~Hg>6t?D5p^{%yV;zv8FRt(nK6Y11>Vp?
zf8L(wU{xmqQAV=QNKRnIA_zptuOw;7`$XxU3mB(n#p>U3YEZAR_KUFoe;<jgZhLk-
zQ(d9(8W-U!^n1<c37%)!58Gq<bohQGy0x^!i7FjUErTJ$Q8dzAO#vpe4TbEG`iN7G
z3KE_8I1o>K4T%S<%)<U~uIgY$a{qgmkBB!YJO@s0!?#9_WLXsV)<a(66puIxUzkZP
zcqbvvloP96i-`6~b^{IO<rtjoGw$n}g^Sf^*t3|F5hTCx5z=>X*w!Qv?6z0GIq|lS
z#ueL6QIdw=Tf_akt&vcQrNh18`00<l&Di-^!UZOhO(#|yF6xqu-LM<XclZ7~W*p9e
zmKJGtJ!f;X*7|bBc%M53^vxGr<t{dZ0O_7%rGR7h{JyvbR_ETjhPB-EW15o}{~T5@
zwyu02R9Y~k`#rpeCUi_qt8pZS+LD108h7n@E-*D{44yg>cChr9uO~Pe_#MB&bI@``
z<Edx(&Fquxml`4Zr{w>BCw<?$RDX8m(pSci;)%P4qP-ETb6kwPBIv|-r*keWk>LLv
zC!&~Mw7JeuP<{#GAa55w&wr<uH<mRWi#DKKCh|?}k)E}E9D}X;PdCgfdUI%Jrs&wk
zNDpG^45J&H+Q+vz9_qcjvIWyg&KlQxapaN~6;@mDks#_h9j4H9fv~|r(yA=&8FEJ}
zTT_-ew@mb5Iv?^$c=6Y%Ds*1F)6Mk<`yP3s0}<M;Pu?iozZ=eX948)8x6Qea=o<(x
zw>bIlf6s!3S;6{_E@z++u-kpnARNew(|@7{ec+8C1Rmow_m@qLRt5%2w!O;Idb2EI
zU)Hi-ci!$=PW#;dY3+@3CkW4WOMgeRjn~oLk{dd*C0LtBO41hlpD5}ZEf5=%Uwca&
zKQdxJr#hEb4^Xl2PjICO+`LS$_%?29T(VNmEX|@`nPD?Dn=V7C|E9yvsfFDHuhYZ6
z@v!_R;Ec<_VuLKd*Z2}-Eceg*MXItHRMeP_zWKyJJO9_|gFv>$MMNDLWD&Zutn9M5
zKL2S}d6W`;mJqGpZt2o-R&{_}0trOTmP*aBiiR(3z5hGmQSp58yyR@Pnk_u>#j;D3
z%wz4;_k$CYfl%B;Ue6yKpT2LE-%H1V*Fm#*0-rY48pUuvY*{j$LWebp?@vEYt}FP*
zCk26MwP!Z9(Pu5M@dqyggSGVcTm;E%chN#SVG_!rSd<&p4KX?Q=K{xjOyO*`lCuyy
zD`uw$_;2^%=EC0zrD!P8fs#+n$)0&xTlV-H&o#hXI|dA#Lt$=tUEhYuhyt52Fa0}K
zR<*ug;kD(&R2>HUNdA>Y@9exN?uU52?r<JLmf@ywX^DR#`aqtur@ib@5mVB~x6qRw
z@iDgokBC~sV5!CJDGC$(e{LxXA<y?}xc^;8*OScL=zI8YO)oYbPKBBCTJAgc^Ci_f
za}*Z}6OaEhBwFogp5`ERNu{;h!_kd&`Gt_kX%z+PgD>}JR|)^Q@HQrsstzH}J$<#q
z$_VE3NcKLp@muB9i(xm#WPvh?)_)({0o9AzI!1asdDXkjcc@mG%%(IDuYHYNWlx(K
zlv4f%eV}aXX(y*9`Ns6j)r<9rK05iKfj;k8NFt*J2!yLDFa1_?{$z~Gfp|zSSJDVI
z=9(#cXudx`{hd$eWnDtWI*(GI)?I2cu8;r9>u^5PpguBn4hEio-he9UA;av25}t6R
zha^2wMKBW@!IkScUe``TbQnrhaNE~nllRiW;PK&45s6&Kh`_LS9{;R@5dTRyd3S@>
zRpXcQ?kqyj=|h;TgN3t6YMduli0;2=Y0kjSqG!^<Lrd49<_L!=JIrj>309QJ)=~D>
z?FR<-@9l&AG_?-vPTx(Pe(Sb{j@*N57kKVRCXVv3yN6+9<6cfxYg2Zfmbc8)6fDTo
z)qAezP1hNn{2rK*Rje2BAJaEE98(?<q<h7vm(J1BI;mlhQ9i^cUeq_U;mw-N>2sye
zf=@A?MXK+UQVn}biS;)R>#FzX!T9?ZXyIRS2LgdAW&ddk2&D6$Hh_Z5|3zXDs0;d^
zS%FsU|6iZ*Pk<m$6UDzRyC9HZ%wIeI-`D+5cK=h9|5?TV$D;(_x%9^Z``kefPzI_N
za%T6s(*NeerpkZAMHLf}G=p@B{_Yd6!2MfZ!tVXuR_=fa<n_V4f7g5e?=e75{}Txa
i^gk^D0{Q>1hJ)!Kmp!BZ_4x`QUU?Z6=}Jk{PyY`z2lf~M

literal 0
HcmV?d00001

diff --git a/doc/_static/figtree.woff2 b/doc/_static/figtree.woff2
new file mode 100644
index 0000000000000000000000000000000000000000..857341f7c678b1c5d85729ff9ea8d486fe2b7a04
GIT binary patch
literal 14364
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
XnJx~kuFKepMr;1_w*ej>008_K_<*wS

literal 0
HcmV?d00001

diff --git a/doc/_static/toc_bullet.svg b/doc/_static/toc_bullet.svg
new file mode 100644
index 000000000000..d4a77331c98f
--- /dev/null
+++ b/doc/_static/toc_bullet.svg
@@ -0,0 +1,39 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<svg
+   height="16"
+   width="16"
+   version="1.1"
+   id="svg4"
+   sodipodi:docname="toc_bullet.svg"
+   inkscape:version="1.1-beta1 (77e7b44db3, 2021-03-28)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs8" />
+  <sodipodi:namedview
+     id="namedview6"
+     pagecolor="#505050"
+     bordercolor="#ffffff"
+     borderopacity="1"
+     objecttolerance="10.0"
+     gridtolerance="10.0"
+     guidetolerance="10.0"
+     inkscape:pageshadow="0"
+     inkscape:pageopacity="0"
+     inkscape:pagecheckerboard="1"
+     showgrid="true"
+     inkscape:current-layer="svg4">
+    <inkscape:grid
+       type="xygrid"
+       id="grid49" />
+  </sodipodi:namedview>
+  <path
+     id="path2"
+     sodipodi:type="inkscape:offset"
+     inkscape:radius="-0.81220347"
+     inkscape:original="M 6.6621094 4.5859375 A 1.143 1.143 0 0 0 5.8242188 4.9199219 L 5.2929688 5.4511719 C 4.8349687 5.9091719 4.8510781 6.660625 5.3300781 7.140625 L 8.203125 10.011719 L 5.3300781 12.884766 C 4.8510781 13.363766 4.8349688 14.115219 5.2929688 14.574219 L 5.8242188 15.105469 C 6.2822188 15.563469 7.036625 15.547359 7.515625 15.068359 L 11.583984 10.998047 A 1.22 1.22 0 0 0 11.931641 10.011719 A 1.22 1.22 0 0 0 11.583984 9.0273438 L 7.515625 4.9570312 A 1.249 1.249 0 0 0 6.6621094 4.5859375 z "
+     d="m 6.6386719,5.3984375 c -0.088798,-0.00181 -0.1773948,0.032925 -0.2402344,0.095703 l -0.53125,0.53125 C 5.7300188,6.1625593 5.7182537,6.3799747 5.9042969,6.5664062 L 8.7773438,9.4375 a 0.81228469,0.81228469 0 0 1 0,1.148438 L 5.9042969,13.458984 C 5.719186,13.644095 5.7289844,13.861495 5.8671875,14 l 0.53125,0.53125 c 0.135934,0.135934 0.3590378,0.146822 0.5429687,-0.03711 l 4.0664058,-4.06836 0.002,-0.002 c 0.08366,-0.0854 0.125702,-0.209206 0.113281,-0.328125 a 0.81228469,0.81228469 0 0 1 0,-0.1679686 c 0.01222,-0.1187076 -0.0298,-0.2409206 -0.113281,-0.3261719 l -0.002,-0.00195 L 6.9414062,5.53125 A 0.81228469,0.81228469 0 0 1 6.9375,5.5273438 C 6.8598316,5.4486568 6.7511214,5.4020564 6.640625,5.3984375 Z"
+     style="fill:#deddda" />
+</svg>
diff --git a/doc/bluetoothctl-cmd.rst b/doc/bluetoothctl-cmd.rst
new file mode 100644
index 000000000000..3fa9b4c984e7
--- /dev/null
+++ b/doc/bluetoothctl-cmd.rst
@@ -0,0 +1,34 @@
+bluetoothctl
+============
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   bluetoothctl
+   bluetoothctl-mgmt
+   bluetoothctl-monitor
+   bluetoothctl-admin
+   bluetoothctl-advertise
+   bluetoothctl-endpoint
+   bluetoothctl-gatt
+   bluetoothctl-player
+   bluetoothctl-scan
+   bluetoothctl-transport
+   bluetoothctl-assistant
+   bluetoothctl-hci
+   bluetoothctl-telephony
+
+* :doc:`bluetoothctl <bluetoothctl>`
+* :doc:`bluetoothctl-mgmt <bluetoothctl-mgmt>`
+* :doc:`bluetoothctl-monitor <bluetoothctl-monitor>`
+* :doc:`bluetoothctl-admin <bluetoothctl-admin>`
+* :doc:`bluetoothctl-advertise <bluetoothctl-advertise>`
+* :doc:`bluetoothctl-endpoint <bluetoothctl-endpoint>`
+* :doc:`bluetoothctl-gatt <bluetoothctl-gatt>`
+* :doc:`bluetoothctl-player <bluetoothctl-player>`
+* :doc:`bluetoothctl-scan <bluetoothctl-scan>`
+* :doc:`bluetoothctl-transport <bluetoothctl-transport>`
+* :doc:`bluetoothctl-assistant <bluetoothctl-assistant>`
+* :doc:`bluetoothctl-hci <bluetoothctl-hci>`
+* :doc:`bluetoothctl-telephony <bluetoothctl-telephony>`
diff --git a/doc/conf.py b/doc/conf.py
new file mode 100644
index 000000000000..07f87510be6f
--- /dev/null
+++ b/doc/conf.py
@@ -0,0 +1,39 @@
+# Configuration file for the Sphinx documentation builder.
+#
+# For the full list of built-in configuration values, see the documentation:
+# https://www.sphinx-doc.org/en/master/usage/configuration.html
+
+# -- Project information -----------------------------------------------------
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information
+
+project = "BlueZ"
+copyright = "2026, BlueZ authors"
+author = "BlueZ authors"
+
+# -- General configuration ---------------------------------------------------
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
+html_favicon = "favicon.ico"
+
+extensions = [
+    "sphinxext.opengraph",
+    "sphinx_copybutton",
+]
+
+templates_path = ["_templates"]
+exclude_patterns = ["_build", "Thumbs.db", ".DS_Store"]
+
+
+# -- Options for HTML output -------------------------------------------------
+# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
+
+html_theme = "furo"
+# add custom files that are stored in _static
+html_css_files = ["bluez.css"]
+html_static_path = ["_static"]
+
+# -- Options for OpenGraph ---------------------------------------------------
+
+ogp_site_url = "https://bluez.github.io/docs/"
+ogp_image = "_static/card.png"
+
+html_permalinks_icon = "🔗"
diff --git a/doc/copy-subdir.py b/doc/copy-subdir.py
new file mode 100644
index 000000000000..8cb64f54bf9b
--- /dev/null
+++ b/doc/copy-subdir.py
@@ -0,0 +1,14 @@
+#!/usr/bin/env python3
+
+import os
+import sys
+import shutil
+
+subdir = os.environ["MESON_SUBDIR"]
+
+input_path = os.path.join(os.environ["MESON_SOURCE_ROOT"], subdir, sys.argv[1])
+output_path = os.path.join(os.environ["MESON_BUILD_ROOT"], subdir, sys.argv[2])
+
+os.makedirs(os.path.dirname(output_path), exist_ok=True)
+
+shutil.copyfile(input_path, output_path)
diff --git a/doc/daemons.rst b/doc/daemons.rst
new file mode 100644
index 000000000000..7c5f61f74c79
--- /dev/null
+++ b/doc/daemons.rst
@@ -0,0 +1,12 @@
+Daemons
+=======
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   bluetoothd
+   bluetooth-meshd
+
+* :doc:`bluetoothd <bluetoothd>`
+* :doc:`bluetooth-meshd <bluetooth-meshd>`
diff --git a/doc/dbus-gatt.rst b/doc/dbus-gatt.rst
new file mode 100644
index 000000000000..fb026e9f9ede
--- /dev/null
+++ b/doc/dbus-gatt.rst
@@ -0,0 +1,18 @@
+D-Bus GATT APIs
+===============
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   org.bluez.GattManager
+   org.bluez.GattProfile
+   org.bluez.GattService
+   org.bluez.GattCharacteristic
+   org.bluez.GattDescriptor
+
+* :doc:`org.bluez.GattManager <org.bluez.GattManager>`
+* :doc:`org.bluez.GattProfile <org.bluez.GattProfile>`
+* :doc:`org.bluez.GattService <org.bluez.GattService>`
+* :doc:`org.bluez.GattCharacteristic <org.bluez.GattCharacteristic>`
+* :doc:`org.bluez.GattDescriptor <org.bluez.GattDescriptor>`
diff --git a/doc/dbus-obex.rst b/doc/dbus-obex.rst
new file mode 100644
index 000000000000..b3d0e5c90ada
--- /dev/null
+++ b/doc/dbus-obex.rst
@@ -0,0 +1,33 @@
+OBEX D-Bus APIs
+===============
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   org.bluez.obex.Agent
+   org.bluez.obex.Image
+   org.bluez.obex.Client
+   org.bluez.obex.Session
+   org.bluez.obex.Transfer
+   org.bluez.obex.ObjectPush
+   org.bluez.obex.FileTransfer
+   org.bluez.obex.Synchronization
+   org.bluez.obex.PhonebookAccess
+   org.bluez.obex.MessageAccess
+   org.bluez.obex.Message
+   org.bluez.obex.AgentManager
+
+* :doc:`org.bluez.obex.Client </org.bluez.obex.Client>`
+* :doc:`org.bluez.obex.Session <org.bluez.obex.Session>`
+* :doc:`org.bluez.obex.Transfer <org.bluez.obex.Transfer>`
+* :doc:`org.bluez.obex.ObjectPush <org.bluez.obex.ObjectPush>`
+* :doc:`org.bluez.obex.FileTransfer <org.bluez.obex.FileTransfer>`
+* :doc:`org.bluez.obex.Synchronization <org.bluez.obex.Synchronization>`
+* :doc:`org.bluez.obex.PhonebookAccess <org.bluez.obex.PhonebookAccess>`
+* :doc:`org.bluez.obex.MessageAccess <org.bluez.obex.MessageAccess>`
+* :doc:`org.bluez.obex.Message <org.bluez.obex.Message>`
+* :doc:`org.bluez.obex.AgentManager <org.bluez.obex.AgentManager>`
+* :doc:`org.bluez.obex.Agent <org.bluez.obex.Agent>`
+* :doc:`org.bluez.obex.Image <org.bluez.obex.Image>`
+
diff --git a/doc/dbus.rst b/doc/dbus.rst
new file mode 100644
index 000000000000..3bed4711f56d
--- /dev/null
+++ b/doc/dbus.rst
@@ -0,0 +1,76 @@
+D-Bus APIs
+==========
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   org.bluez.Adapter
+   org.bluez.AdminPolicySet
+   org.bluez.AdminPolicyStatus
+   org.bluez.Agent
+   org.bluez.AgentManager
+   org.bluez.Battery
+   org.bluez.BatteryProvider
+   org.bluez.BatteryProviderManager
+   org.bluez.Bearer.BREDR
+   org.bluez.Bearer.LE
+   org.bluez.LEAdvertisingManager
+   org.bluez.LEAdvertisement
+   org.bluez.AdvertisementMonitorManager
+   org.bluez.AdvertisementMonitor
+   org.bluez.Device
+   org.bluez.DeviceSet
+   org.bluez.Input
+   org.bluez.Media
+   org.bluez.MediaAssistant
+   org.bluez.MediaControl
+   org.bluez.MediaEndpoint
+   org.bluez.MediaItem
+   org.bluez.MediaTransport
+   org.bluez.MediaFolder
+   org.bluez.MediaPlayer
+   org.bluez.Network
+   org.bluez.NetworkServer
+   org.bluez.Profile
+   org.bluez.ProfileManager
+   org.bluez.Telephony
+   org.bluez.Call
+   org.bluez.ThermometerManager
+   org.bluez.Thermometer
+   org.bluez.ThermometerWatcher
+
+* :doc:`org.bluez.Adapter <org.bluez.Adapter>`
+* :doc:`org.bluez.AdminPolicySet <org.bluez.AdminPolicySet>`
+* :doc:`org.bluez.AdminPolicyStatus <org.bluez.AdminPolicyStatus>`
+* :doc:`org.bluez.Agent <org.bluez.Agent>`
+* :doc:`org.bluez.AgentManager <org.bluez.AgentManager>`
+* :doc:`org.bluez.Battery <org.bluez.Battery>`
+* :doc:`org.bluez.BatteryProvider <org.bluez.BatteryProvider>`
+* :doc:`org.bluez.BatteryProviderManager <org.bluez.BatteryProviderManager>`
+* :doc:`org.bluez.Bearer.BREDR <org.bluez.Bearer.BREDR>`
+* :doc:`org.bluez.Bearer.LE <org.bluez.Bearer.LE>`
+* :doc:`org.bluez.LEAdvertisingManager <org.bluez.LEAdvertisingManager>`
+* :doc:`org.bluez.LEAdvertisement <org.bluez.LEAdvertisement>`
+* :doc:`org.bluez.AdvertisementMonitorManager <org.bluez.AdvertisementMonitorManager>`
+* :doc:`org.bluez.AdvertisementMonitor <org.bluez.AdvertisementMonitor>`
+* :doc:`org.bluez.Device <org.bluez.Device>`
+* :doc:`org.bluez.DeviceSet <org.bluez.DeviceSet>`
+* :doc:`org.bluez.Input <org.bluez.Input>`
+* :doc:`org.bluez.Media <org.bluez.Media>`
+* :doc:`org.bluez.MediaAssistant <org.bluez.MediaAssistant>`
+* :doc:`org.bluez.MediaControl <org.bluez.MediaControl>`
+* :doc:`org.bluez.MediaEndpoint <org.bluez.MediaEndpoint>`
+* :doc:`org.bluez.MediaItem <org.bluez.MediaItem>`
+* :doc:`org.bluez.MediaTransport <org.bluez.MediaTransport>`
+* :doc:`org.bluez.MediaFolder <org.bluez.MediaFolder>`
+* :doc:`org.bluez.MediaPlayer <org.bluez.MediaPlayer>`
+* :doc:`org.bluez.Network <org.bluez.Network>`
+* :doc:`org.bluez.NetworkServer <org.bluez.NetworkServer>`
+* :doc:`org.bluez.Profile <org.bluez.Profile>`
+* :doc:`org.bluez.ProfileManager <org.bluez.ProfileManager>`
+* :doc:`org.bluez.Telephony <org.bluez.Telephony>`
+* :doc:`org.bluez.Call <org.bluez.Call>`
+* :doc:`org.bluez.ThermometerManager <org.bluez.ThermometerManager>`
+* :doc:`org.bluez.Thermometer <org.bluez.Thermometer>`
+* :doc:`org.bluez.ThermometerWatcher <org.bluez.ThermometerWatcher>`
diff --git a/doc/deprecated-tools.rst b/doc/deprecated-tools.rst
new file mode 100644
index 000000000000..0c86f5265751
--- /dev/null
+++ b/doc/deprecated-tools.rst
@@ -0,0 +1,22 @@
+Deprecated Tools
+================
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   hciattach
+   hciconfig
+   hcitool
+   hcidump
+   rfcomm
+   sdptool
+   ciptool
+
+* :doc:`hciattach <hciattach>`
+* :doc:`hciconfig <hciconfig>`
+* :doc:`hcitool <hcitool>`
+* :doc:`hcidump <hcidump>`
+* :doc:`rfcomm <rfcomm>`
+* :doc:`sdptool <sdptool>`
+* :doc:`ciptool <ciptool>`
diff --git a/doc/dev-maint.rst b/doc/dev-maint.rst
new file mode 100644
index 000000000000..d92e892ba352
--- /dev/null
+++ b/doc/dev-maint.rst
@@ -0,0 +1,17 @@
+Development and Maintenance
+===========================
+
+
+.. toctree::
+   :hidden:
+
+   test-runner
+   security-bugs
+   coding-style
+   maintainer-guidelines
+
+* :doc:`Test kernel changes to the Bluetooth subsystem <test-runner>`
+* :doc:`Security bugs handling <security-bugs>`
+* :doc:`Coding style <coding-style>`
+* :doc:`Maintainers guidelines <maintainer-guidelines>`
+
diff --git a/doc/favicon.ico b/doc/favicon.ico
new file mode 100644
index 0000000000000000000000000000000000000000..1e136f240e08be84dc0e214daf84715a98bcb307
GIT binary patch
literal 29152
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
Pmn=m&HQ550*YExp%bT+2

literal 0
HcmV?d00001

diff --git a/doc/index.rst b/doc/index.rst
new file mode 100644
index 000000000000..f7b35ee0925a
--- /dev/null
+++ b/doc/index.rst
@@ -0,0 +1,47 @@
+
+.. image:: _static/bluez.png
+
+BlueZ
+=====
+
+BlueZ overview lives here.
+
+Here's a link to the website `BlueZ <http://www.bluez.org>`_.
+
+* :doc:`Development and Maintenance <dev-maint>`
+* :doc:`Low-level Protocol and Management APIs <protocols>`
+
+Man pages
+---------
+
+* :doc:`Daemons <daemons>`
+* :doc:`bluetoothctl <bluetoothctl-cmd>`
+* :doc:`Tools <tools>`
+* :doc:`Deprecated tools <deprecated-tools>`
+
+D-Bus APIs
+----------
+
+* :doc:`D-Bus APIs <dbus>`
+* :doc:`D-Bus GATT APIs <dbus>`
+* :doc:`OBEX D-Bus APIs <dbus-obex>`
+
+Qualifications
+--------------
+
+* :doc:`Qualifications <qualifications>`
+
+.. toctree::
+   :maxdepth: 2
+   :hidden:
+
+   dev-maint
+   protocols
+   daemons
+   bluetoothctl-cmd
+   tools
+   deprecated-tools
+   dbus
+   dbus-gatt
+   dbus-obex
+   qualifications
diff --git a/doc/meson.build b/doc/meson.build
index 6b25ff6f8f05..112a1b492c52 100644
--- a/doc/meson.build
+++ b/doc/meson.build
@@ -41,7 +41,11 @@ man_pages = [
   'org.bluez.AdvertisementMonitor.5',
   'org.bluez.Telephony.5',
   'org.bluez.Call.5',
+  'org.bluez.ThermometerManager.5',
+  'org.bluez.Thermometer.5',
+  'org.bluez.ThermometerWatcher.5',
 ]
+doc_man_pages = man_pages
 
 obex_man_pages = [
   'org.bluez.obex.Client.5',
@@ -57,12 +61,14 @@ obex_man_pages = [
   'org.bluez.obex.Agent.5',
   'org.bluez.obex.Image.5',
 ]
+doc_man_pages += obex_man_pages
 
 if get_option('obex').enabled()
   man_pages += obex_man_pages
 endif
 
 monitor_man_pages = [ 'btmon.1' ]
+doc_man_pages += monitor_man_pages
 
 if get_option('monitor').enabled()
   man_pages += monitor_man_pages
@@ -75,8 +81,10 @@ tools_man_pages = [
   'isotest.1',
   'bdaddr.1',
 ]
+doc_man_pages += tools_man_pages
 
 noinst_tools_man_pages = [ 'btmgmt.1' ]
+doc_man_pages += noinst_tools_man_pages
 
 if get_option('tools').enabled()
   man_pages += tools_man_pages
@@ -92,12 +100,14 @@ deprecated_tools_man_pages = [
   'sdptool.1',
   'ciptool.1',
 ]
+doc_man_pages += deprecated_tools_man_pages
 
 if get_option('deprecated').enabled()
   man_pages += deprecated_tools_man_pages
 endif
 
 hid2hci_man_pages = [ 'hid2hci.1' ]
+doc_man_pages += hid2hci_man_pages
 
 if get_option('hid2hci').enabled()
   man_pages += 'hid2hci.1'
@@ -118,11 +128,13 @@ client_man_pages = [
   'bluetoothctl-hci.1',
   'bluetoothctl-telephony.1'
 ]
+doc_man_pages += client_man_pages
 
 if get_option('client').enabled()
   man_pages += client_man_pages
 endif
 
+
 if get_option('manpages').enabled()
   foreach man_page: man_pages
     man_page_name = man_page.substring(0, -2)
@@ -141,6 +153,43 @@ if get_option('manpages').enabled()
   endforeach
 endif
 
+qualifications_docs = [
+  'qualification/a2dp-pics.rst',
+  'qualification/a2dp-pts.rst',
+  'qualification/avctp-pics.rst',
+  'qualification/avctp-pts.rst',
+  'qualification/avdtp-pics.rst',
+  'qualification/avdtp-pts.rst',
+  'qualification/avrcp-pics.rst',
+  'qualification/avrcp-pts.rst',
+  'qualification/gap-pics.rst',
+  'qualification/gap-pts.rst',
+  'qualification/gatt-pics.rst',
+  'qualification/gatt-pts.rst',
+  'qualification/gavdp-pics.rst',
+  'qualification/gavdp-pts.rst',
+  'qualification/hid-pics.rst',
+  'qualification/hid-pts.rst',
+  'qualification/hogp-pics.rst',
+  'qualification/hogp-pts.rst',
+  'qualification/hsp-pics.rst',
+  'qualification/hsp-pts.rst',
+  'qualification/iopt-pics.rst',
+  'qualification/iopt-pts.rst',
+  'qualification/l2cap-pics.rst',
+  'qualification/l2cap-pts.rst',
+  'qualification/rfcomm-pics.rst',
+  'qualification/rfcomm-pts.rst',
+  'qualification/scpp-pics.rst',
+  'qualification/scpp-pts.rst',
+  'qualification/sdp-pics.rst',
+  'qualification/sdp-pts.rst',
+  'qualification/sm-pics.rst',
+  'qualification/sm-pts.rst',
+  'qualification/spp-pics.rst',
+  'qualification/spp-pts.rst',
+]
+
 bluetoothd_rst = configure_file(
   input: 'bluetoothd.rst.in',
   output: 'bluetoothd.rst',
@@ -162,6 +211,7 @@ bluetooth_meshd_rst = configure_file(
   output: 'bluetooth-meshd.rst',
   configuration: man_conf
 )
+
 if get_option('mesh').enabled() and get_option('manpages').enabled()
   custom_target(
     input: bluetooth_meshd_rst,
@@ -171,3 +221,74 @@ if get_option('mesh').enabled() and get_option('manpages').enabled()
     install_dir: get_option('mandir') / 'man8'
   )
 endif
+
+if get_option('documentation').enabled()
+  docs_sources = [
+    'conf.py',
+    'favicon.ico',
+
+    'index.rst',
+    'dev-maint.rst',
+    'test-runner.rst',
+    'assigned-numbers.rst',
+    'security-bugs.rst',
+    'coding-style.rst',
+    'maintainer-guidelines.rst',
+    'protocols.rst',
+    'daemons.rst',
+    'bluetoothctl-cmd.rst',
+    'tools.rst',
+    'deprecated-tools.rst',
+    'dbus.rst',
+    'dbus-gatt.rst',
+    'dbus-obex.rst',
+    'qualifications.rst',
+  ]
+  docs_sources += qualifications_docs
+
+  foreach man_page: doc_man_pages
+    man_page_name = man_page.substring(0, -2)
+    man_section = man_page.substring(-1)
+    if man_section.to_int() == 7
+      man_page_name = man_page_name + '-protocol'
+    endif
+    docs_sources += man_page_name + '.rst'
+  endforeach
+
+  copied_docs_sources = []
+  foreach d: docs_sources
+    copied_docs_sources += configure_file(input: d, output: fs.name(d), copy: true)
+  endforeach
+  copied_docs_sources += [ bluetooth_meshd_rst, bluetoothd_rst ]
+
+  docs_inputs = copied_docs_sources
+
+  # Copy static files to the appropriate output subdir
+  copy = find_program('copy-subdir.py')
+
+  static_files = [
+    'bullet.svg',
+    'card.png',
+    'figtree.woff2',
+    'toc_bullet.svg',
+    'bluez.css',
+    'bluez.png',
+  ]
+
+  foreach f: static_files
+    run_command(copy, '_static' / f, '_static' / f, check: true)
+  endforeach
+
+  sphinx_command = [ sphinx_build ]
+
+  if get_option('werror')
+    sphinx_command += [ '-W', '--keep-going' ]
+  endif
+
+  custom_target('docs',
+    input: docs_inputs,
+    output: 'html',
+    command: sphinx_command + [ meson.current_build_dir(), '@OUTPUT@' ],
+    build_by_default: true,
+  )
+endif
diff --git a/doc/protocols.rst b/doc/protocols.rst
new file mode 100644
index 000000000000..5e8841b850cf
--- /dev/null
+++ b/doc/protocols.rst
@@ -0,0 +1,20 @@
+Protocol and Management References
+==================================
+
+.. toctree::
+   :hidden:
+
+   hci-protocol
+   mgmt-protocol
+   l2cap-protocol
+   rfcomm-protocol
+   assigned-numbers
+   sco-protocol
+   iso-protocol
+
+* :doc:`HCI protocol <hci-protocol>`
+* :doc:`MGMT protocol <mgmt-protocol>`
+* :doc:`L2CAP protocol <l2cap-protocol>`
+* :doc:`RFCOMM protocol <rfcomm-protocol>` and :doc:`channel numbers <assigned-numbers>`
+* :doc:`SCO transport <sco-protocol>`: SCO transport
+* :doc:`ISO transport <iso-protocol>`: ISO transport
diff --git a/doc/qualifications.rst b/doc/qualifications.rst
new file mode 100644
index 000000000000..d7eb6b803f01
--- /dev/null
+++ b/doc/qualifications.rst
@@ -0,0 +1,76 @@
+Qualifications
+--------------
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   a2dp-pics
+   a2dp-pts
+   avctp-pics
+   avctp-pts
+   avdtp-pics
+   avdtp-pts
+   avrcp-pics
+   avrcp-pts
+   gap-pics
+   gap-pts
+   gatt-pics
+   gatt-pts
+   gavdp-pics
+   gavdp-pts
+   hid-pics
+   hid-pts
+   hogp-pics
+   hogp-pts
+   hsp-pics
+   hsp-pts
+   iopt-pics
+   iopt-pts
+   l2cap-pics
+   l2cap-pts
+   rfcomm-pics
+   rfcomm-pts
+   scpp-pics
+   scpp-pts
+   sdp-pics
+   sdp-pts
+   sm-pics
+   sm-pts
+   spp-pics
+   spp-pts
+
+* :doc:`a2dp-pics <a2dp-pics>`
+* :doc:`a2dp-pts <a2dp-pts>`
+* :doc:`avctp-pics <avctp-pics>`
+* :doc:`avctp-pts <avctp-pts>`
+* :doc:`avdtp-pics <avdtp-pics>`
+* :doc:`avdtp-pts <avdtp-pts>`
+* :doc:`avrcp-pics <avrcp-pics>`
+* :doc:`avrcp-pts <avrcp-pts>`
+* :doc:`gap-pics <gap-pics>`
+* :doc:`gap-pts <gap-pts>`
+* :doc:`gatt-pics <gatt-pics>`
+* :doc:`gatt-pts <gatt-pts>`
+* :doc:`gavdp-pics <gavdp-pics>`
+* :doc:`gavdp-pts <gavdp-pts>`
+* :doc:`hid-pics <hid-pics>`
+* :doc:`hid-pts <hid-pts>`
+* :doc:`hogp-pics <hogp-pics>`
+* :doc:`hogp-pts <hogp-pts>`
+* :doc:`hsp-pics <hsp-pics>`
+* :doc:`hsp-pts <hsp-pts>`
+* :doc:`iopt-pics <iopt-pics>`
+* :doc:`iopt-pts <iopt-pts>`
+* :doc:`l2cap-pics <l2cap-pics>`
+* :doc:`l2cap-pts <l2cap-pts>`
+* :doc:`rfcomm-pics <rfcomm-pics>`
+* :doc:`rfcomm-pts <rfcomm-pts>`
+* :doc:`scpp-pics <scpp-pics>`
+* :doc:`scpp-pts <scpp-pts>`
+* :doc:`sdp-pics <sdp-pics>`
+* :doc:`sdp-pts <sdp-pts>`
+* :doc:`sm-pics <sm-pics>`
+* :doc:`sm-pts <sm-pts>`
+* :doc:`spp-pics <spp-pics>`
+* :doc:`spp-pts <spp-pts>`
diff --git a/doc/tools.rst b/doc/tools.rst
new file mode 100644
index 000000000000..6da8ca58f6fc
--- /dev/null
+++ b/doc/tools.rst
@@ -0,0 +1,24 @@
+Tools
+=====
+
+.. toctree::
+   :hidden:
+   :maxdepth: 2
+
+   btmon
+   rctest
+   l2ping
+   btattach
+   isotest
+   btmgmt
+   hid2hci
+   bdaddr
+
+* :doc:`btmon <btmon>`
+* :doc:`rctest <rctest>`
+* :doc:`l2ping <l2ping>`
+* :doc:`btattach <btattach>`
+* :doc:`isotest <isotest>`
+* :doc:`btmgmt <btmgmt>`
+* :doc:`hid2hci <hid2hci>`
+* :doc:`bdaddr <bdaddr>`
diff --git a/meson.build b/meson.build
index 6d95cee1cd3c..f09ab409352e 100644
--- a/meson.build
+++ b/meson.build
@@ -147,6 +147,10 @@ ell_dep = dependency('ell',
   ]
 )
 
+pymod = import('python')
+sphinx_build = find_program('sphinx-build', native: true, required: get_option('documentation'))
+sphinx_modules = pymod.find_installation(modules: ['sphinxext.opengraph', 'sphinx_copybutton', 'furo'], required: get_option('documentation'))
+
 rst2man = find_program('rst2man', 'rst2man.py', required: get_option('manpages'))
 if rst2man.found()
   rst2man_command = [
@@ -274,7 +278,7 @@ endif
 if get_option('mesh').enabled()
   subdir('mesh')
 endif
-if rst2man.found()
+if get_option('manpages').enabled() or get_option('documentation').enabled()
   subdir('doc')
 endif
 sh = find_program('sh')
diff --git a/meson_options.txt b/meson_options.txt
index aad131212886..069763e0fa64 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -12,6 +12,7 @@ option('logind', type: 'feature', value: 'enabled', description: 'Enable logind
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support')
 option('datafiles', type: 'feature', value: 'enabled', description: 'Install configuration and data files')
 option('manpages', type: 'feature', value: 'auto', description: 'Enable building of manual pages')
+option('documentation', type: 'feature', value: 'auto', description: 'Enable building of online documentation')
 option('experimental', type: 'feature', value: 'disabled', description: 'Enable experimental tools')
 option('deprecated', type: 'feature', value: 'disabled', description: 'Enable deprecated tools')
 option('external-plugins', type: 'feature', value: 'enabled', description: 'Enable support for external plugins')
-- 
2.52.0

