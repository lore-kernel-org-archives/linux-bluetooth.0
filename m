Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94653143757
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850233; cv=none; b=HH8HtTnP6kVf4waw86e0w+sGT92XdxYzklfRqIjAgraZJlWukMsH+SoG0VKrkuGNu+OjPIVfBR4LX9fQTZk8kM/uGL046oyu52DWp1V5+3GomtVYoZ38z0mBUIaO+eRekw+AdfL2Hd2A92JrnfdrfPYCZaMCrOpr+CNxu4HXPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850233; c=relaxed/simple;
	bh=wBKaBDtRcPjNoMraWYoXvslQgUVGW3mNUPea6jugRso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0qwA3kg0B5Qtk3glesYChZXyQDZxvGntVCrMYkXOUKobRBmsSPEi8mQ1mb0BJu6IHj3OJmqm8pFbjEsVl5iiu2Ap/4jV9Ah9BO3ifKTULpKCTCnCX7WtcrpsfKtXcnbb4DeKUWaRuTSEGWFV9i362/VqCnsP+ZtZOVRUm1zzFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D9A71C001B;
	Thu, 16 May 2024 09:03:44 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 12/15] mgmt-tester: Fix non-nul-terminated string
Date: Thu, 16 May 2024 11:03:16 +0200
Message-ID: <20240516090340.61417-13-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: STRING_NULL (CWE-170): [#def59] [important]
bluez-5.75/tools/mgmt-tester.c:12670:2: string_null_source: Function "vhci_read_devcd" does not terminate string "buf".
bluez-5.75/tools/mgmt-tester.c:12677:2: string_null: Passing unterminated string "buf" to "strtok_r", which expects a null-terminated string.
12675|
12676|		/* Verify if all devcoredump header fields are present */
12677|->	line = strtok_r(buf, delim, &saveptr);
12678|		while (strlen(test->expect_dump_data[i])) {
12679|			if (!line || strcmp(line, test->expect_dump_data[i])) {
---
 tools/mgmt-tester.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8a4fbc2eb6a6..8076ec105ebb 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -12656,18 +12656,22 @@ static void verify_devcd(void *user_data)
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
 	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
-	char buf[MAX_COREDUMP_BUF_LEN] = {0};
+	char buf[MAX_COREDUMP_BUF_LEN + 1] = {0};
+	int read;
 	char delim[] = "\n";
 	char *line;
 	char *saveptr;
 	int i = 0;
 
 	/* Read the generated devcoredump file */
-	if (vhci_read_devcd(vhci, buf, sizeof(buf)) <= 0) {
+	read = vhci_read_devcd(vhci, buf, MAX_COREDUMP_BUF_LEN);
+	if (read <= 0) {
 		tester_warn("Unable to read devcoredump");
 		tester_test_failed();
 		return;
 	}
+	/* Make sure buf is nul-terminated */
+	buf[read + 1] = '\0';
 
 	/* Verify if all devcoredump header fields are present */
 	line = strtok_r(buf, delim, &saveptr);
-- 
2.44.0

