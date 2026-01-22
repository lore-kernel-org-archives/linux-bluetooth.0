Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785829A9C9
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073023; cv=none; b=qfqo3nsWUiyx8861Yw5S492i+xEq65bgbGi/hKXndMvVpxKqOLc439cxU6n+CutTvaLzsS5Sn7pOmYz4cJnLlMT7dhv5apqqMoSIqlG6uAjhmnp8Poqnm7GLeSVyEJ+/Lqtw49EA96W+vK4e7ckDxOCc6AycEgVG74hZtDx1eXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073023; c=relaxed/simple;
	bh=0uiKSFoWh3iUf4963zIv7sEhWCR57pwLJds8tokROB0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VE/UYhwvive/JwjFMw8pz8xd2GljucRHlP+yyKHLJO2OXy+BAUVOpVsAuT3ExMjWJ6+AHmz/i9ioERHwGXdvFOLeLyPQkstzeU8RwBEqBTc6dqoRBVNaua83iFERy1Gx59qcmmWdaGA16YGjB9nVgdMSTGW4tJkZCO/pnfqX+fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 550AB43140
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 09:10:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 8/9] doc: Port maintainer-guidelines.txt to RST
Date: Thu, 22 Jan 2026 10:05:07 +0100
Message-ID: <20260122091003.398400-9-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeehjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeehhedtteeugeefudegtddpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-State: clean
X-GND-Score: 0

---
 ...idelines.txt => maintainer-guidelines.rst} | 62 +++++++++++--------
 1 file changed, 36 insertions(+), 26 deletions(-)
 rename doc/{maintainer-guidelines.txt => maintainer-guidelines.rst} (65%)

diff --git a/doc/maintainer-guidelines.txt b/doc/maintainer-guidelines.rst
similarity index 65%
rename from doc/maintainer-guidelines.txt
rename to doc/maintainer-guidelines.rst
index b875f008258b..44d3e258db6e 100644
--- a/doc/maintainer-guidelines.txt
+++ b/doc/maintainer-guidelines.rst
@@ -1,25 +1,28 @@
+=====================
 Maintainer guidelines
-*********************
+=====================
 
 This document is intended for the maintainers of the BlueZ project. It
 serves as basic guidelines for handling patch review and commit access.
 
 
 Rule 1: Keep the GIT tree clean and linear
-==========================================
+------------------------------------------
 
-The bluetooth.git, bluetooth-next.git and bluez.git trees are not your
+The ``bluetooth.git``, ``bluetooth-next.git`` and ``bluez.git`` trees are not your
 private playground. The history is meant to be clean and linear.
 
-	- NO merges
-	- NO branches
-	- NO tags
+- NO merges
+- NO branches
+- NO tags
 
 If anyone needs testing or work on a feature, clone the tree and do
 it in your own copy. The master trees are off limits.
 
 One advise to avoid any accidental errors in this area to set proper
-options in global ~/.gitconfig or local .git/config files.
+options in global ``~/.gitconfig`` or local ``.git/config`` files.
+
+.. code-block::
 
 	[merge]
 		ff = only
@@ -29,7 +32,7 @@ in doubt ask one of the seasoned maintainers.
 
 
 Rule 2: Enforce clean commit messages
-=====================================
+-------------------------------------
 
 The commit messages are required to be clean and follow style guidelines
 to be consistent.
@@ -45,20 +48,22 @@ job to ensure we get proper firstname lastname <email> authorship.
 
 It is also important that the committer itself uses a valid name and
 email address when committing patches. So ensure that either the
-global ~/.gitconfig or local .git/config provides proper values.
+global ``~/.gitconfig`` or local ``.git/config`` provides proper values.
+
+.. code-block::
 
 	[user]
 		name = Peter Mustermann
 		email = peter@mustermann.de
 
-Commit messages for bluez.git shall not contain Signed-off-by
+Commit messages for ``bluez.git`` shall not contain ``Signed-off-by``
 signatures. They are not used in userspace and with that it is the
 maintainers job to ensure they do not get committed to the repository.
 
-For bluetooth.git and bluetooth-next.git The Signed-off-by process is
-used and the signatures are required.
+For ``bluetooth.git`` and ``bluetooth-next.git``, the ``Signed-off-by``
+process is used and the signatures are required.
 
-Tags like Change-Id generated from Gerrit are never acceptable. It is
+Tags like ``Change-Id`` generated from Gerrit are never acceptable. It is
 the maintainers job to ensure that these are not committed into the
 repositories.
 
@@ -67,48 +72,53 @@ reversed. If in doubt ask one of the seasoned maintainers.
 
 
 Rule 3: Enforce correct coding style
-====================================
+------------------------------------
 
 The coding style follows roughly the kernel coding style with any
-exceptions documented in doc/coding-style.txt.
+exceptions documented in :doc:`coding-style <coding-style>`.
 
 To ensure trivial white-space errors don't get committed, have the
-following in your .gitconfig:
+following in your ``.gitconfig``:
+
+.. code-block::
 
 	[apply]
 		whitespace = error
 
 It can also be helpful to use the checkpatch.pl script coming with the
 Linux kernel to do some automated checking. Adding the following to your
-.git/hooks/pre-commit and .git/hooks/pre-applypatch is a simple way to
+``.git/hooks/pre-commit`` and ``.git/hooks/pre-applypatch`` is a simple way to
 do this:
 
+.. code-block::
+
 	exec git diff --cached | ~/src/linux/scripts/checkpatch.pl -q \
 		--no-tree --no-signoff --show-types \
 		--ignore CAMELCASE,NEW_TYPEDEFS,INITIALISED_STATIC -
 
-The above assumes that a kernel tree resides in ~/src/linux/.
+The above assumes that a kernel tree resides in ``~/src/linux/``.
 
 
 Rule 4: Pay extra attention to adding new files to the tree
-===========================================================
+-----------------------------------------------------------
 
 New files that are added to the tree require several things to be
 verified first:
 
-	- Check that the names are acceptable with other maintainers
-	- Ensure that the file modes are correct
-	- Verify that the license & copyright headers are correct
-	- If the file is supposed to be part of the release tarball,
-	  make sure that it gets picked up by 'make dist' (particularly
-	  important for documentation or other files that are not code)
+- Check that the names are acceptable with other maintainers
+- Ensure that the file modes are correct
+- Verify that the license & copyright headers are correct
+- If the file is supposed to be part of the release tarball,
+  make sure that it gets picked up by 'make dist' (particularly
+  important for documentation or other files that are not code)
 
 
 Rule 5: Keep the mailing list in sync with the commit process
-=============================================================
+-------------------------------------------------------------
 
 When applying patches, be sure to send a response to the mailing list as
 soon as the code has been pushed to the upstream tree. Usually this
 means one email per patch, however patch-sets may only have one response
 covering the entire set. If applying a subset of a patch-set clearly
 state what was applied in your response.
+
-- 
2.52.0

