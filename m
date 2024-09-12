Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E91922F7
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132978; cv=none; b=OMF5aoyoK+oeNjhKahzk9RU7l+OOjag43f7GPNx0nQ71CYqDFMG/3wrYAiQyWFg2vCwVOd31eaCEvDMb1INAwQUuOF+eVVYuYdGHoWzXxmODIVV28tFqhUBlC+JAhr6J84FIlbcyC6I5Q/NozBOtAKa1lO7fG2O3A14wuhP6p08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132978; c=relaxed/simple;
	bh=YJWKGGl4tfwsKhgXgm2ipnc6kCTPQeU5yUKinybK5+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPUxx9olgpEyonGKRKkOHSqZNuHzBBSwD2GwxaBxRtkfe7w8sNPW2ZW6MvxHZypDiDtJ9yO4YfU5XL4jEIgukKM6YIJm1CEvtbG4/WASzOpWNbLwOoe3BZdVqb9IXSbfxQzagMTaKByQ4vb4OuHipb221+DI+EoTtO2Blz64JzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2A7A420008;
	Thu, 12 Sep 2024 09:22:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 3/3] shared/shell: Exit after printing the help
Date: Thu, 12 Sep 2024 11:20:12 +0200
Message-ID: <20240912092253.119754-4-hadess@hadess.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912092253.119754-1-hadess@hadess.net>
References: <20240912092253.119754-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Exit after handling --help, so as to avoid the daemon waiting to
communicate with a D-Bus service that might not be running.
---
 src/shared/shell.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index c31487190d0f..f7e8b3300373 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -1324,9 +1324,7 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 			return;
 		case 'h':
 			usage(argc, argv, opt);
-			data.argc = 1;
-			data.argv = &cmplt;
-			data.mode = 1;
+			exit(EXIT_SUCCESS);
 			goto done;
 		case 's':
 			if (optarg && data.init_fd < 0) {
-- 
2.46.0

