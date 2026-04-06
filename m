Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D6331215
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474642; cv=pass; b=qgpP05fY04Oo5SFeccScNizC0xPaLkTmsxD0KYQphgLHVSpUvl6Br4rxK4Kfq5pqkgPJ6cUfvjOH75oRkIqmB+Z5nqW8Pi9sGszz4W4eko8EI10IkFrqiWxpz5mZB3P62Qz8fN+v4JW2OmYMRjthrKKNXAVOG4Rz10TMT9sKYUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474642; c=relaxed/simple;
	bh=out06vt6QrlWFSX4qsBSRFc/Zccjku9qfrusQfQ1u30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFnOEdKqMrWdQkAmeIOkajvLeRu/8GKi9EsAE0gLKjyZseZfGp38X6y+jEYkhyXGOrHYBhPq6ngHc8oVHb1DXAeCHA+nnT4kDcYOi2o7J3dOqbcE9NsXvJ0UK51+MAgMS+c1KVkDwghasa/9b0w6MWLlB7VD2JqZhY3mBH8Svl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gNv/gaim; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gNv/gaim"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq6R30164z1051;
	Mon, 06 Apr 2026 14:23:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775474639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYSo48PnIyC/5Ro8SJYL+vrG19RWAGQZ6prA6xTXc1g=;
	b=gNv/gaimuwdH22wytaSJpJ/E2ndrtTH1CU7fb3ecSXyJB8Gz5oPUSX3ZdPD+s8A/mOXHzD
	zBzlTRBYwV5nZwzg3cGuqA0m/l4QU8Aqpwiz7U6mdFS4hEsU4leQHuF2Vna4YUQlSh50Nc
	qj2TQx8NpTcSe4CUc/pdEp4WaPLrCr0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775474639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pYSo48PnIyC/5Ro8SJYL+vrG19RWAGQZ6prA6xTXc1g=;
	b=phxwihyJJzPdM0yBIvJaE7Tj8BrMcKE724Omlwq7vxiFy4qUQXCHd3Q5XzL6JQt+O4dGNP
	1ozaY7Z/jY1q4ozr+3ZlkMDzO8WZUjgf091tD23pW2ootTA8/ERo/COkfeglCpcu9mhnNH
	wsB20drqLjf90jEkbKdIMf/RRU3OCNY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775474639;
	b=FU0nh/XIPHHz4/lv+Ag79PC3OB3Oq4TQBLxO1XCRhfmyQ4MhIg2Gj7F96Jo32ZGuq5y+KS
	Pg/FlwyRDvOcYpXZxGcV7WNWucUKTjVmQePQ3Oa+8peYXzwTU2QlcNkixp0JdEZJFQwvLW
	mWv2/YYduiQKkEXl9w7drv3FkBZk70A=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/5] tools: Remove assigned but unused variables
Date: Mon,  6 Apr 2026 14:23:54 +0300
Message-ID: <383cdc8fa034a3d4797780f277ab6d8d8a6961ad.1775474498.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
References: <adc251f251ef88ee958f6f79cb3cbfe27bda721c.1775474498.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused variables that gcc -Wunused-but-set-variable and
-Wunused-but-set-parameter complain about.

Fixes build on gcc 16.
---
 tools/btsnoop.c  | 8 ++------
 tools/seq2bseq.c | 3 ---
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 0bd28b65b..bac901ee2 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -266,7 +266,7 @@ static void command_extract_eir(const char *input)
 	ssize_t len;
 	uint32_t type, toread, flags;
 	uint16_t opcode;
-	int fd, count = 0;
+	int fd;
 
 	fd = open_btsnoop(input, &type);
 	if (fd < 0)
@@ -320,8 +320,6 @@ next_packet:
 				}
 			}
 			printf("\n");
-
-			count++;
 		}
 		break;
 	}
@@ -339,7 +337,7 @@ static void command_extract_ad(const char *input)
 	ssize_t len;
 	uint32_t type, toread, flags;
 	uint16_t opcode;
-	int fd, count = 0;
+	int fd;
 
 	fd = open_btsnoop(input, &type);
 	if (fd < 0)
@@ -392,8 +390,6 @@ next_packet:
 				}
 			}
 			printf("\n");
-
-			count++;
 		}
 		break;
 	}
diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
index 1806fd5a6..b4d293a32 100644
--- a/tools/seq2bseq.c
+++ b/tools/seq2bseq.c
@@ -59,7 +59,6 @@ static void convert_file(const char *input_path, const char *output_path)
 	const char *ptr;
 	FILE *fp;
 	struct stat st;
-	off_t cur = 0;
 	int fd;
 
 	if (output_path) {
@@ -124,8 +123,6 @@ static void convert_file(const char *input_path, const char *output_path)
 		if (!str)
 			break;
 
-		cur += strlen(str);
-
 		err = convert_line(fd, str);
 		if (err < 0) {
 			fprintf(stderr, "Failed to convert file (%s)\n",
-- 
2.53.0

