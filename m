Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AA165FDB
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332708; cv=none; b=EPbOOjd6YBmDtku9yIgrsjGlx+iAIT8ckG07vQSxba28aJhK+02hHj9XghcZSmWiIjzs27z9m6oXKkhoc3ysSsU5lm7aDgsvch/9IszqXXiAlWEF5UGhjxetYwAO5jnOsMHo4KG2fn60BWYwxL734xDojaMnzInAkbeH0kNg5Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332708; c=relaxed/simple;
	bh=Z4Ect0czkbLcBsbsoMl8fFiwHYkN+tVjcHoe1Tp/VkU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAW7H39KdeWCueR1Rm0yJG27vbijEdEIttY313fxBcySal3wzBTrz2QBfLpRHTzBPNOcVMsZ7CCVbNeuhMnHxHOQtlUn6HVRB9NHO0113LE3rE4dSGmAC412rwGmfEqxEoeaiHjx02KOVM0WLZuWywKRC2zvC6D5Xgv6W+rGccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC53D1BF213
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:17 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 12/14] isotest: Fix error check after opening file
Date: Fri, 10 May 2024 11:11:10 +0200
Message-ID: <20240510091814.3172988-13-hadess@hadess.net>
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

Consider "0" to be a valid fd.
---
 tools/isotest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 810d15d2df2a..ddace0da3044 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -720,7 +720,7 @@ static int open_file(const char *filename)
 	syslog(LOG_INFO, "Opening %s ...", filename);
 
 	fd = open(filename, O_RDONLY);
-	if (fd <= 0) {
+	if (fd < 0) {
 		syslog(LOG_ERR, "Can't open file %s: %s\n",
 						filename, strerror(errno));
 	}
-- 
2.44.0

