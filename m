Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDB3E95BD
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506359; cv=none; b=sykxPgvHTUw1vRl9Eypqk5fqkocdQ9k2tyuAxHg8QaX0F4EaxK21qXRtfjKB7YN96Z+HQ2Ut+I2006/aEc1N2Iyz805hNH2IomyoK9L8J/LUW7pyhSw3FnBv8YSTimS/SPe7ncfby5I1UOvbiWTT2hSfULfB1ywqrBWoQBnBspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506359; c=relaxed/simple;
	bh=MVflxJhAcQ9gnPhD1D36CXbF0dfUmW5XyoV5snqRA0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAs81WrOFdiJ+jTrmvERoBoKK0GCQMkzK+0ib6DOhTIrc3DnHngxGyqSq1BInP2z6AlcgXMwVX8szy6G24z1eC84AaMaw7ZCYSP1cQq2x1j6MeJYfurQYSWl/UT2B/eYafkRp2iy4TI9f/3SkbOBt4ADOT46RudBW6wU9PR4qfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 59DDC5813BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:48 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 643013EC43
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 13:21:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v3 5/6] client: Use _cleanup_fd_ to simplify urandom access
Date: Mon, 11 May 2026 15:18:08 +0200
Message-ID: <20260511132131.1283892-6-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511132131.1283892-1-hadess@hadess.net>
References: <20260511132131.1283892-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFyg4dcWaG5eSKnyQUHRkNw/X4O2fwqTBchSxLtNlc8UZkgYcvmT3qFT99KlQyk19auPdMEZcmgm/Vyr6QiQMZqh5NFE17Zc0wXOtGPQQZRz5XwT9JV83lfqcvUtVp2HNtl2hZC1BgZ9TR7tsTgsJSySwYWZzV5EPUMt6P2DJ1BVLKAGzqYnxDlPqKBHFh4XfMCnpWb3pFBFavNJlLQjO+blTA/peaWNxPspJqGVDx6v0cAbK74vnvh38G7adG+f8OSDFt6Fhdnqo3vTy+0xSBEumrusRanrze1CrRoMShKBmPygTEsg0qM+HlxUOxeeaxDbZ4d+AS9eqXKhVcDycEXpEHgLCpnIzgsnzRllFYS2D7IbkKx2l+DNG9Ojb1mzG811ySA6Lza8er7sDcBBz0pozHkzHEsPEmC7D1QnTCIqgEZQbUV143MiYIUtaSzDz1bs9dWDPsh+fyEXdhxw6A5JsXbySXLjFv94yY896/E9ntbv47VlbZSQxBavoPMsvO3+VsCVbwu+URJu4sx0dhm3MLtI8LMhE6zSxg/UVvTmbXOgal9P9HUAmKUSh4FRN5JRwthxlZn8ZJoMOfyzbNYiWn560JdT85mvmRqtqq/7H+aTE0GgK6ulCP9ZhCJGMqU6Oe3+BOInqBYCYwjPYk8JA/9SofrcmGdsOekIW+9Ig
X-GND-State: clean
X-GND-Score: 0

fd gets auto-closed before exiting the scope.
---
 client/mgmt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 50558a313866..e199c30540e4 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -2681,7 +2681,7 @@ static void cmd_privacy(int argc, char **argv)
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 	} else {
-		int fd;
+		_cleanup_fd_ int fd = -1;
 
 		fd = open("/dev/urandom", O_RDONLY);
 		if (fd < 0) {
@@ -2691,11 +2691,8 @@ static void cmd_privacy(int argc, char **argv)
 
 		if (read(fd, cp.irk, sizeof(cp.irk)) != sizeof(cp.irk)) {
 			error("Reading from urandom failed");
-			close(fd);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
-
-		close(fd);
 	}
 
 	if (send_cmd(mgmt, MGMT_OP_SET_PRIVACY, index, sizeof(cp), &cp,
-- 
2.54.0

