Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6535C16FF3B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343252; cv=none; b=NCycnBPMTCqtlOHFbrkK1fB5k/PTw01tVWQgydBwWRALlCgpW9Ofa7qywjYuC4hW7i0FkoMjEmPnd8NWo1cwXln2NHCRox9n9yu1dXDPhOkO8tdiqkT/9UNLlNNrxLENwCbZRD4CYSW2kM613V9CkgnkEGyQGVyuIGb5Q5DZqBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343252; c=relaxed/simple;
	bh=P+yjKjRjvdbaSXIaURzo3y+tgDv6GopWUV9BqCIn29k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJpcLnTPJbuyOHcOsHmoQUacm0KzPLZZydIH/81ugeQUST4QQRrHA5Wp2mKcvTin882G3VMj69bCuqwvoLWewntGL+Gt8sKy29dD9OQcSLW9xJuuvWqHrjbXh5POXUAfYk2GnZH+bIzwmTE3z5X1jbu6ymVf6570/P0YbsEv4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2DF246000E;
	Fri, 10 May 2024 12:13:57 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 05/20] client/main: Fix array access
Date: Fri, 10 May 2024 14:10:15 +0200
Message-ID: <20240510121355.3241456-6-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510121355.3241456-1-hadess@hadess.net>
References: <20240510121355.3241456-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: CPPCHECK_WARNING (CWE-788): [#def36]
bluez-5.75/client/main.c:833: error[ctuArrayIndex]: Array index out of bounds; 'argv' buffer size is 0 and it is accessed at offset 1.
831|	const char **opt;
832|
833|->	if (!strcmp(argv[1], "help")) {
834|		for (opt = arg_table; opt && *opt; opt++)
835|			bt_shell_printf("%s\n", *opt);
---
 client/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/client/main.c b/client/main.c
index 51d08a67aa1a..f703cc91b24a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -830,6 +830,11 @@ static gboolean parse_argument(int argc, char *argv[], const char **arg_table,
 {
 	const char **opt;
 
+	if (argc < 2) {
+		bt_shell_printf("Missing argument to %s\n", argv[0]);
+		return FALSE;
+	}
+
 	if (!strcmp(argv[1], "help")) {
 		for (opt = arg_table; opt && *opt; opt++)
 			bt_shell_printf("%s\n", *opt);
-- 
2.44.0

