Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D71AB911
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088783; cv=none; b=WemqLlWbD7HbNxpjgxkbvt41srrgLgp7UN9/aCfl4jHmql5BEiX9aHcfEKGIwg3ENcC/S/LFRGzHFtr4OGabyQMQkYCyGKMyQO1rQ4Vv2FpGocb0joqdJ3L/DPip+88UjV7PrMMQNEXBE44/qgVyE06blLfqeb+kUOo7cLJ7bro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088783; c=relaxed/simple;
	bh=yudE9JDnTEeVHlV5siLpbDQxihf+gd9DYV9bxay1mTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md4utmdCSKD8EuBNKJHBE0T4a4COTuIwZhv8YuDeMf0YSjyF6LG6B9dfH1Z8V+sZ1GVzmBRFPz97qrliFabx+zak2Ez6fSkoi2ec4RiOjb9pSOCN8hpmX2SXpn6rT6oWQfCeJufzIXRc87oeewBMxNFVWdSJuLxKpwj6z5jLdqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1489240006;
	Thu,  4 Jul 2024 10:26:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 04/12] shared/shell: Fix fd leak if -s is passed multiple times
Date: Thu,  4 Jul 2024 12:24:35 +0200
Message-ID: <20240704102617.1132337-5-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704102617.1132337-1-hadess@hadess.net>
References: <20240704102617.1132337-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: RESOURCE_LEAK (CWE-772): [#def37] [important]
bluez-5.76/src/shared/shell.c:1305:5: open_fn: Returning handle opened by "open". [Note: The source code implementation of the function has been overridden by a user model.]
bluez-5.76/src/shared/shell.c:1305:5: var_assign: Assigning: "data.init_fd" = handle returned from "open(optarg, 0)".
bluez-5.76/src/shared/shell.c:1305:5: overwrite_var: Overwriting handle "data.init_fd" in "data.init_fd = open(optarg, 0)" leaks the handle.
1303|			case 's':
1304|				if (optarg)
1305|->					data.init_fd = open(optarg, O_RDONLY);
1306|				if (data.init_fd < 0)
1307|					printf("Unable to open %s: %s (%d)\n", optarg,
---
 src/shared/shell.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index c09d41ee54df..d500dddf8acf 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1306,11 +1306,12 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			data.mode = 1;
 			goto done;
 		case 's':
-			if (optarg)
+			if (optarg && data.init_fd < 0) {
 				data.init_fd = open(optarg, O_RDONLY);
-			if (data.init_fd < 0)
-				printf("Unable to open %s: %s (%d)\n", optarg,
+				if (data.init_fd < 0)
+					printf("Unable to open %s: %s (%d)\n", optarg,
 						strerror(errno), errno);
+			}
 			break;
 		case 't':
 			if (optarg)
-- 
2.45.2

