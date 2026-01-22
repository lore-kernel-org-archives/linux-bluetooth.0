Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8272BDC3E
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073022; cv=none; b=oyzZeJKvu3Q433KQZlyoOZgwOwHrBeB2D3EOJHtj6DyIxf3fv6lpWDlGtBJ9/cCsiALFlxqPIKdRcgquEJhEn+EzzK+yK2dVxKb2Lkld5/jBNlT6n4VuE+Mgt8n5JiKOiB1EWA/c39JfmeYA0601vSPzSmr3Kf3fuqpKG2cArGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073022; c=relaxed/simple;
	bh=LCNjXRZG5nahVKNi03PH6tafT2ahy5hjcX3ETkXQgVs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew76QpQJ/U4JFpVLaNexmqNzysgUwq0ysvesxWjIDlyPBa5FN9f4RfbryHsYrsHDpvsdu3wPoIPWnlJJllXTxdYafAyYvujtVbAi3z6KFPKmtBdlOc1abH1U4mCsqNYYdsM/5A60ZyogkqBHvBOHbWq8d7TGmFlq14HcS9qkvXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1F5124310D
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:10:13 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 3/9] doc: Port assigned-numbers.txt to RST
Date: Thu, 22 Jan 2026 10:05:02 +0100
Message-ID: <20260122091003.398400-4-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122091003.398400-1-hadess@hadess.net>
References: <20260122091003.398400-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeduhfehuddvgeefuddtffdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 0

---
 Makefile.am              |  2 +-
 doc/assigned-numbers.rst | 29 +++++++++++++++++++++++++++++
 doc/assigned-numbers.txt | 26 --------------------------
 3 files changed, 30 insertions(+), 27 deletions(-)
 create mode 100644 doc/assigned-numbers.rst
 delete mode 100644 doc/assigned-numbers.txt

diff --git a/Makefile.am b/Makefile.am
index 5deea67eff00..1498535e2524 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -473,7 +473,7 @@ endif
 
 EXTRA_DIST += $(test_scripts)
 
-EXTRA_DIST += doc/assigned-numbers.txt doc/supported-features.txt \
+EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/test-coverage.txt \
 				doc/test-runner.rst \
 				doc/settings-storage.txt
diff --git a/doc/assigned-numbers.rst b/doc/assigned-numbers.rst
new file mode 100644
index 000000000000..e3fcb65b83df
--- /dev/null
+++ b/doc/assigned-numbers.rst
@@ -0,0 +1,29 @@
+===============
+RFCOMM Channels
+===============
+
+Since there are a limited amount of possible RFCOMM channels (1-31)
+they've been pre-allocated for currently known profiles in order to
+avoid conflicts.
+
+.. csv-table::
+	:header: "Profile", "Channel"
+	:widths: auto
+
+	DUN, 1
+	SPP, 3
+	HSP HS, 6
+	HFP HF, 7
+	OPP, 9
+	FTP, 10
+	BIP, 11
+	HSP AG, 12
+	HFP AG, 13
+	SYNCH (IrMC), 14
+	PBAP, 15
+	MAP MAS, 16
+	MAP MNS, 17
+	SyncEvolution, 19
+	PC/Ovi Suite, 24
+	SyncML Client, 25
+	SyncML Server, 26
diff --git a/doc/assigned-numbers.txt b/doc/assigned-numbers.txt
deleted file mode 100644
index cf481c15eb88..000000000000
--- a/doc/assigned-numbers.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-RFCOMM Channels
-===============
-
-Since there are a limited amount of possible RFCOMM channels (1-31)
-they've been pre-allocated for currently known profiles in order to
-avoid conflicts.
-
-Profile		Channel
------------------------
-DUN		1
-SPP		3
-HSP HS		6
-HFP HF		7
-OPP		9
-FTP		10
-BIP		11
-HSP AG		12
-HFP AG		13
-SYNCH (IrMC)	14
-PBAP		15
-MAP MAS		16
-MAP MNS		17
-SyncEvolution	19
-PC/Ovi Suite	24
-SyncML Client	25
-SyncML Server	26
-- 
2.52.0

