Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478E2D3A64
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533010; cv=none; b=cbzHMh4hhjlvNd5eDjcT4ZDVtqOjZGuk2I8B5Dazf0ehm+zMDxAeZ+GIxLFRPEWi//jeCUy4OcaTv/9U5MFydnQDfqE1H+CR6kvf6PQ00xNV6PFlMW/udVNyDoBr+xGPsEjuQGXYkbxFeShqRU3J9cOZ2nBFw3bn0XqJ9Tj11+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533010; c=relaxed/simple;
	bh=7zESJXTQaU/fR/867sQaAt66oo3IiFbYVL9/7MTcodQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hE1VNfU2cmJZVAcZbVFqerNi4MqdLCYSVVur25HuX2wQXTx1SFy3YhkB5TdnNJx9Bq0iFf4gDJUrq3VMClyPNzRtP4Mud4oM7I/L9mUy35mVfbNyAugW2tb8i4tzyzKUHkxtKSIisbegs9I4N/sQUMXg/Takmc+wlEf+LxhpjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0864943180;
	Thu,  3 Jul 2025 08:56:39 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ 02/19] Fix typos in top-level project docs
Date: Thu,  3 Jul 2025 10:53:10 +0200
Message-ID: <20250703085630.935452-3-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703085630.935452-1-hadess@hadess.net>
References: <20250703085630.935452-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: spam:medium
X-GND-Score: 300
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucdnvehorghsthgrlhculdeftddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeelueetveffuefhieeutdetheejgfevhefhgfffieegfeetfedtgfefueffteekkeenucffohhmrghinhepughishhsrghpvggrrhdrthhoohhlshenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrgguvghssheshhgruggvshhsrdhnvght

Found using codespell.
---
 HACKING | 2 +-
 README  | 2 +-
 TODO    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/HACKING b/HACKING
index 5e07d91eacd2..84f67cf34a60 100644
--- a/HACKING
+++ b/HACKING
@@ -141,7 +141,7 @@ backtraces, compiler errors, etc.
 
   # git config format.subjectprefix "PATCH BlueZ"
 
-7) Add a cover letter when introducing a new feature explaning what problem
+7) Add a cover letter when introducing a new feature explaining what problem
 you're trying to solve:
 
   # git format-patch --cover-letter -M origin/master -o outgoing/
diff --git a/README b/README
index 6c0777046545..c68f12de31d3 100644
--- a/README
+++ b/README
@@ -242,7 +242,7 @@ For a working system, certain configuration options need to be enabled:
 
 		Enable deprecated tools
 
-		By defauld all tools that are no longer maintained are
+		By default all tools that are no longer maintained are
 		disabled. This option can be used to enable them.
 
 		It is not recommended to enable this option for production
diff --git a/TODO b/TODO
index c9b30641d141..f816e8153f64 100644
--- a/TODO
+++ b/TODO
@@ -107,7 +107,7 @@ ATT/GATT (new shared stack)
 
 - Add complete GATT test coverage in unit/test-gatt following the GATT test
   spec. This could use shared/gatt-client and shared/gatt-server at the same
-  time to test both against eachother. We should definitely have tests for
+  time to test both against each other. We should definitely have tests for
   gatt-server and gatt-client simultaneously on one side of the connection.
 
   Priority: High
@@ -212,7 +212,7 @@ Mesh
   Complexity: C4
 
 - Merge common functionality from tools/mesh. Ideally, source code from the
-  tools/mesh directory should completely dissapear.
+  tools/mesh directory should completely disappear.
 
   Priority: Low
   Complexity: C2
-- 
2.50.0

