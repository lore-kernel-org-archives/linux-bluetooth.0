Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E85429825
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925304; cv=none; b=p42GsLIaqf4bUPNmsf6wtIxGsDub+lASAFsKYc2bCD/6v8JUJvGCjSkqBcf44Ra31DAvREUJ/TQ6oIrrAA+K3fMidTENxEXFqKkxeO5nQushhQHicl27FHvGyhFUFFzyIOB2bpGd5gbPKYBsZsHD6OuBqtXw282zquS7Mu7D8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925304; c=relaxed/simple;
	bh=5MpZtlEjdiZg/YhqE2it285m9F7K31KvkN2hpGUigT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Shy6k0pN/hWp0DOwOUxSGLpbT+nqGJbxplxy0YKx/xkF+1I9Ax/U8WeMq/HISlWcvqzvnqOV1r/mh5ci9CUAeLF8PZGLAoOJGO9j+WUgKf3N3rYyHf7ZnQ1+BVRHNma+RFgRguiOK6SO582To8rIMTTdqhsTrAv2/tLD4oDJ5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6699A44029
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:08:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 1/7] doc: Port assigned-numbers.txt to RST
Date: Tue, 20 Jan 2026 17:05:47 +0100
Message-ID: <20260120160811.3394320-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120160811.3394320-1-hadess@hadess.net>
References: <20260120160811.3394320-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeiieelleetgeegtddvledpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
index 3adfa6cd51c3..acd28732aa2d 100644
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

