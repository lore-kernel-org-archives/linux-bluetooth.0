Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC81DA23
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.189.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747394; cv=none; b=t0x9IyYf2GuXJRjay1W8Uqb9DIc2A0z1B170oP3BT0ju7Al2SuIt63rJi/+Nu0zDs+c4Q2PDbFx85qNyO0V6WrnRZrKDLE2oVB6FanxsdEGZtjgHqVbwxK1/MYMm9RT5iaao7qAhio1Z418adTzndmRaY26WsgO++0laF7ICjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747394; c=relaxed/simple;
	bh=BQ0bUWsu/xxRoIoqKiDPxpd/7W4IPho+xkq3LOVY+2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZwO8fdhT6t1QejPWiD5j+tYkJ4VG6vfrgs0vFiB2SX5lTLSr28g6OdYQ909iJrAxXWmFdeyyXU3iM70kEvbSyyHqvbRhqXQuH2poq1IUvpBEWpDa3iYegbwR3BF0ADZ3fMXtz61j5jDv6YeqcOOaGseEMnQ9UElEZ9segYwky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk; spf=pass smtp.mailfrom=iodev.co.uk; arc=none smtp.client-ip=46.30.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iodev.co.uk
Received: from localhost (unknown [83.68.141.146])
	by iodev.co.uk (Postfix) with ESMTPSA id 24DCD3497E8;
	Thu, 19 Sep 2024 14:03:04 +0200 (CEST)
From: Ismael Luceno <ismael@iodev.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH v3] Replace the usage of non-standard GNU-basename with strrchr
Date: Thu, 19 Sep 2024 14:02:46 +0200
Message-ID: <20240919120252.25086-2-ismael@iodev.co.uk>
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

Notes:
    Changes since v2:
    - Fixed style complaint from checkpatch.pl
    
    Changes since v1:
    - Fixed missing parameter at mesh/rpl.c:150

 mesh/mesh-config-json.c | 4 +++-
 mesh/rpl.c              | 4 +++-
 tools/hex2hcd.c         | 7 ++++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

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
index 2fa17d72f6cb..1c58703eae4e 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -147,7 +147,9 @@ static void get_entries(const char *iv_path, struct l_queue *rpl_list)
 	if (!dir)
 		return;
 
-	iv_txt = basename(iv_path);
+	iv_txt = strrchr(iv_path, '/');
+	if (!iv_txt++)
+		iv_txt = iv_path;
 	if (sscanf(iv_txt, "%08x", &iv_index) != 1) {
 		closedir(dir);
 		return;
diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index 452ab2beb572..6f7c826b683d 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -303,7 +303,12 @@ static void ver_parse_entry(const char *pathname)
 	}
 
 	if (S_ISREG(st.st_mode)) {
-		ver_parse_file(basename(pathname));
+		const char *bname;
+		
+		bname = strrchr(pathname, '/');
+		if (!bname++)
+			bname = pathname;
+		ver_parse_file(bname);
 		goto done;
 	}
 
-- 
2.46.0

