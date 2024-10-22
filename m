Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4D19C553
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598463; cv=none; b=IsAfzFgZxIBps5rCVztcMrHTW+eEfhfz+OUq7nV/Agr+XC/zBnv2LOV+3te2GwlVCgSUIPjZvHbrqUiNKiMzZYJ2sVEkEiDBCQdPqj7fyG3a9d43I3h46LMnkzjvwUZRez4x6X6fof3hu6jb/UnXiFbh7vWI2TZPYcIXXTXY/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598463; c=relaxed/simple;
	bh=cVssVKnGPA4PcuDBwv+YjYR1Myp1n+85YewD7ncPBvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnKxae5bRqjuERtTRqcIlGp0J7SXL+rWYJbtxF5q3AmRcuMwJ5XabBuRJD8gg6zqIwRhWac4XoVEFDWDqI4JZbGxUck2CWawje0TOqUJDkcZ5DtZFMpZ1ckfsFp+8p2FVDYJSr/AqKQpwduF/6HaPckSYB9evUwICevFSxEHfYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6BC71C002A;
	Tue, 22 Oct 2024 12:00:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 7/7] client: Fix --help hanging if bluetoothd is not running
Date: Tue, 22 Oct 2024 13:58:37 +0200
Message-ID: <20241022120051.123888-8-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022120051.123888-1-hadess@hadess.net>
References: <20241022120051.123888-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Exit after printing all the main and submenu commands.
---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index 144e17622e95..798472ba2660 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3193,6 +3193,8 @@ int main(int argc, char *argv[])
 	assistant_add_submenu();
 	bt_shell_set_prompt(PROMPT_OFF);
 
+	bt_shell_handle_non_interactive_help();
+
 	if (agent_option)
 		auto_register_agent = g_strdup(agent_option);
 	else
-- 
2.47.0

