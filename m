Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B01635C9
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332704; cv=none; b=keojEzcl6i0EO5/ySrVjhtD2qdHXUjYIrOm7h8G9Pvs+tUI6l2LWrEykd9T4dlg3b4gfqBMC8WJUG1AvEPHuP81oEbm/33+O6OWIFsg4RU3tpSyhfdJUA256q417NaIpEEKpSZH7hFAQKi4095y+sr7D5rzV8lNHtNLAo7N4atk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332704; c=relaxed/simple;
	bh=P+yjKjRjvdbaSXIaURzo3y+tgDv6GopWUV9BqCIn29k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1vQhVV7rPUHJWIym6KfljFdw/zVrT8OCYIpcAA7IzWCqvJMsYaX9hKY6XLWUAqNDl2wVPjBqsEcrh32bQlXxUoUSGKrTho8HUGH/A3CUqUTSc38dUKJ18SlZlt+0+KArH9JI9DvfHLSP942NQa/qA+nYaZeaj4HOsrBfjCaOv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5995E1BF209
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 05/14] client/main: Fix array access
Date: Fri, 10 May 2024 11:11:03 +0200
Message-ID: <20240510091814.3172988-6-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
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

