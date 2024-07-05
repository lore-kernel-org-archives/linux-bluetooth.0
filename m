Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96306145FF5
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169987; cv=none; b=ASoyvSuGW4Yd53nvPo5agUel83gdTyU/aoP00qgFPWAWlZG8b3hf+M2lwJMOXr+sn8C7hzm18DDLEUdNn6i1xmLMyHaRUKBLcgfaBVVJJWZ1NeLpObo4vL0cciJio1/9rd6SiVHkJbLsb8IIIsBiK11pKXeaW9+AywKzMNnisbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169987; c=relaxed/simple;
	bh=CedVCQo+0GKkgNKCCmvoilaB3g6qvmzHgL4rtjOFtPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZFvh6pYWzexm8f5fnncmI+1ixpbkrB07J2W3Gu09vvCTsLwfzUTByjZ7Bq/zPHlm76o091FvPyeHgqiSyCdeYMK85CX2v07RwkM+6fhnf0/f5aGBbdZI35b7JIhpmvYLVfy76G+0wZT9jRhpxcm3k8csvHaKcBgy3vsa7cfMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B6EF66000D;
	Fri,  5 Jul 2024 08:59:36 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 03/11] shared/shell: Fix fd leak if -s is passed multiple times
Date: Fri,  5 Jul 2024 10:57:31 +0200
Message-ID: <20240705085935.1255725-4-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
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
index e8f75124f167..f3dc5e55b9ec 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1312,11 +1312,12 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
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

