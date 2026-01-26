Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEA280A5A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769438837; cv=none; b=TXZjiDs2FsIDtwWRi61ApDLxzokN7eETJ4/788hyZiFlERzhmg5wzwAVJKe0kX8bfWKBzEHa5BFhQDitaeQ/pCFrTiELsNuIf/cSwYwmH/S1oU5c+UStrVS4zCXl2vD92LU/tMXLhd7Blgdn+4asWESYZUaNKrUGZ+cbRIDVYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769438837; c=relaxed/simple;
	bh=lUC8DDBvMhI0kQe1EfqR866g9h2a45E+fkOEdb9ZiN0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oeJBkh1HFiyY78hx8XOm/xszkArgDNY92JxrknCE8TWYN3kUVYEEPqGNPgw3ZXDmS7Fztsi0tV58F+LLdOODdIUDFWwuRuc/0AocoG2gXgcm6YBqcw0i7tyXiumoagUrh6AUenkVl5SphhnVqxUkvU5i0VcUCQXCf1ePC3suNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG2t+ae8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG2t+ae8"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78fc0f33998so41831927b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 06:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769438835; x=1770043635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CyXzXm9DFLWKKQM971RlgaJrivuTiFh0esBc1rsJWAA=;
        b=iG2t+ae82+28XiVnqD16zNuXpPAhz+zdTJckBurPdTitgxufilaJHmE527bU+rqEZW
         nKZ7rOKQdjs/GqO8z79PycdDs7/Ku66t2xsuJTfPtd38EXlxngYZjyzK6BIHtC0eqG/C
         8eINsn/00vyF2c9mdbCBEWcIbNeJ5EBoPXkNVc+oUvr9MS0mRhruM7zn9aHhmrR56K1a
         1tsg3kiQOtlUFt+jxBt3Ljbr8VMrsIJF+rQ/kJXk042dSoy9wJ5Tb3YP0VZBfi5TvGNf
         bYwA3BtY+x0689LNwrO38r4BwQQqjdM7rhCuG3UZN4KJkGiii4nq70JImqDB3rTYnLse
         Slbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769438835; x=1770043635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyXzXm9DFLWKKQM971RlgaJrivuTiFh0esBc1rsJWAA=;
        b=o6b1SHNYCQ90IlSr5m00/w2FOX4/bzlqxS0HIUfkB41jEEBOFc21CVMRH8TzQHUvnC
         1UD9SsdOMt0/MvxPMf/yFUzDnWrSfMTl8PJuOugsiAlh4wIMTPwZnBjgvDaKCbUEdzpE
         Po9i013RvD8YbaYZ1VGgdCC+w22ztFNX1VmYDeGpFyTacuJUcuO+XrPZdZM4IzTj/Vj4
         trHPi8r5JL0RwIYId7Oj25NjcH/zZOIqp0GqltuWX04DcTIF7OroUwpVsByGoaZWpG2y
         l4MTdv/bIdUnahNdhP8NVCQ5FzehcNCEEltps6dOIa0rwpSRREqDCVW+mHWmWxqmeCNU
         AW2w==
X-Gm-Message-State: AOJu0Yx3DbrgExYFUtF1JbzpcQylCNMQUGU5joOjorJZQNIlhwacEtrF
	rwhSMlPJZ+aGqah1a1CZerjmOnbuqCDvuCsFxHkCM4t6CYH3Ay0Re4wcRtFSGHYa
X-Gm-Gg: AZuq6aJl871g0H0fC2HTKMesd0Q2sJ4fGVAoBASt49/UXD7YU7B7Wo/IGDZf1CyLoLL
	fMlNuvj4U3SlYiSQxUdLCwhxJJQr7qRt7RsNV8e6rMrnxl0Bk1StZ6VY+s03UYC6FLr79aSybq2
	EksauFwEpgDGUv+uWxYPYnLvsVe6g3HDFZeAYEGR9gbcQyePnRrrIirZwd11HdOdmKpE6WXpusH
	2IdP9iitIJPvyCWxbj87MtkNdwfkD9qNj/Epp0pwPn3HloMF24dcTeH0FEYUQEkaRZgEMHCDjgr
	K1ydKg+F1uV52+XpoQw3Ug63W4FSGGGN0dQpV/MxKLMHGt9hW+o3Xi2eDX6PkJxNbg0K3aPxmAu
	nbN5mq1pqHHd8+lOpPJDVJMHdKl8768hvd+DQYxj4ciJCp8ICmM6xKYAIMRTkpkiTQXRE9UlXp5
	nFmTmqeubiWRCRLLcCAGUbV4F37rTKZVXeC50bMdeXQYPuR8PSaaovCYf5bmm5Ez73wsXtCPxWx
	MQzEQ==
X-Received: by 2002:a05:690c:ec7:b0:794:2b18:5464 with SMTP id 00721157ae682-7945a86bab4mr86019427b3.11.1769438834923;
        Mon, 26 Jan 2026 06:47:14 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7944aa7b302sm35811327b3.48.2026.01.26.06.47.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 06:47:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/shell: Fix not dequeueing command
Date: Mon, 26 Jan 2026 09:47:05 -0500
Message-ID: <20260126144705.3516388-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If script execution started with command that call
bt_shell_noninteractive_quit directly it wouldn't execute the next
command since data.line wouldn't be set.
---
 src/shared/shell.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 15f21efef61a..f014d8f7c2b2 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -269,8 +269,6 @@ static void cmd_export(int argc, char *argv[])
 
 static int bt_shell_queue_exec(char *line)
 {
-	int err;
-
 	/* Ignore comments */
 	if (line[0] == '#')
 		return 0;
@@ -288,12 +286,9 @@ static int bt_shell_queue_exec(char *line)
 	}
 
 	bt_shell_printf("%s\n", line);
+	data.line = strdup(line);
 
-	err = bt_shell_exec(line);
-	if (!err)
-		data.line = strdup(line);
-
-	return err;
+	return bt_shell_exec(line);
 }
 
 static bool bt_shell_input_line(struct input *input)
-- 
2.52.0

