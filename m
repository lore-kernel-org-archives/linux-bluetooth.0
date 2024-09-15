Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45236EAE7
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Sep 2024 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.189.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726431817; cv=none; b=IBhIzAlGVK0i4jRF0WKB3cReSmMOKQkVz+T9TX1fDka8ZbomsEGpjNvGKGXaNLc0Utl7ock4vHqn7+hL24WNyYFG6fWdlzSp6PRxA+rTQtuF1PF9SA9fWPvMZVIP9b408yVH4QfCtCrFYpMdcxoaLhM0AiTnTSeDFn968C4iJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726431817; c=relaxed/simple;
	bh=9UAlNbsK44WllH3WOVkvaQQdcuMOigu1CWQ4SzqWMqY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1DCm5dG23VwlB/bRHtDGtCFIK/A6KUOUBZxqHL95TGlGcern/ZCKNfTn1jGYcw0zzQgZbnYobjZkytF7YE1+BijFdn+rN4uCh8OS0LDTgSAml9wZXOb8C36tGFqwOhBYhYnVK4tvgqzYpoS1bKRyT/48NTijjNELBXoHOI1+Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk; spf=pass smtp.mailfrom=iodev.co.uk; arc=none smtp.client-ip=46.30.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iodev.co.uk
Received: from localhost (91-118-7-60.static.upcbusiness.at [91.118.7.60])
	by iodev.co.uk (Postfix) with ESMTPSA id DB1AE346337;
	Sun, 15 Sep 2024 22:23:33 +0200 (CEST)
From: Ismael Luceno <ismael@iodev.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] Replace the usage of non-standard GNU-basename with strrchr
Date: Sun, 15 Sep 2024 22:23:30 +0200
Message-ID: <20240915202331.8232-2-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes build against musl libc, since it doesn't provide a GNU-compatible
implementation of basename.

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 mesh/mesh-config-json.c | 4 +++-
 mesh/rpl.c              | 4 +++-
 tools/hex2hcd.c         | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index a17a48b6d11f..49b9d01a7ef4 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -2708,7 +2708,9 @@ void mesh_config_destroy_nvm(struct mesh_config *cfg)
 	if (!hex2str(cfg->uuid, 16, uuid, sizeof(uuid)))
 		return;
 
-	node_name = basename(node_dir);
+	node_name = strrchr(node_dir, '/');
+	if (!node_name++)
+		node_name = node_dir;
 
 	/* Make sure path name of node follows expected guidelines */
 	if (strcmp(node_name, uuid))
diff --git a/mesh/rpl.c b/mesh/rpl.c
index 2fa17d72f6cb..ee360b832764 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -147,7 +147,9 @@ static void get_entries(const char *iv_path, struct l_queue *rpl_list)
 	if (!dir)
 		return;
 
-	iv_txt = basename(iv_path);
+	iv_txt = strrchr(iv_path);
+	if (!iv_txt++)
+		iv_txt = iv_path;
 	if (sscanf(iv_txt, "%08x", &iv_index) != 1) {
 		closedir(dir);
 		return;
diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index 452ab2beb572..25af71cd29d1 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -303,7 +303,10 @@ static void ver_parse_entry(const char *pathname)
 	}
 
 	if (S_ISREG(st.st_mode)) {
-		ver_parse_file(basename(pathname));
+		const char *bname = strrchr(pathname, '/');
+		if (!bname++)
+			bname = pathname;
+		ver_parse_file(bname);
 		goto done;
 	}
 
-- 
2.46.0

