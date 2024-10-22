Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D70819FA64
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606284; cv=none; b=IDGTgJ/UI+9iyg/tXXpg/bdyY8OYcCAW+CFMWmz1skx/yXOP2Ja61pMtw8mceR0HCAc5Ri0Jo5CiEQ7SbV7UiWSkmsDLPNr8bYHr6xDBfUdct79xn0cZYJVOBGt0CcLj9fqfMvXtK0bEP647yM+QFqEaQmg2Y8FNMsZ1SiCOF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606284; c=relaxed/simple;
	bh=dLCv3QX/enuoC1+8hQH+oDDeJBEnGRJbnwINEc1PP/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFxZzbJNlzzfL+A9YhMD5JLu0HER0jDrgWsbX6L7Lws+a5nIqfpZ36BCd+2JTz4QGCqziUlBuZUsefXuBNYg6mywlyEJ6MhPqm0Mf1k96cYBN8z+cqVJfOtHzwt1XcgdnVEi/TNRkBXnVcvGbC2+l20QBIxHJ/qMWdrmUx5psuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0BFA240015;
	Tue, 22 Oct 2024 14:11:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v3 7/7] client: Fix --help hanging if bluetoothd is not running
Date: Tue, 22 Oct 2024 16:10:38 +0200
Message-ID: <20241022141118.150143-8-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241022141118.150143-1-hadess@hadess.net>
References: <20241022141118.150143-1-hadess@hadess.net>
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
index f60bef1a6d3a..f5ed9f9f5297 100644
--- a/client/main.c
+++ b/client/main.c
@@ -3193,6 +3193,8 @@ int main(int argc, char *argv[])
 	assistant_add_submenu();
 	bt_shell_set_prompt(PROMPT_OFF, NULL);
 
+	bt_shell_handle_non_interactive_help();
+
 	if (agent_option)
 		auto_register_agent = g_strdup(agent_option);
 	else
-- 
2.47.0

