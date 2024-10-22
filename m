Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49902199938
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598461; cv=none; b=mXbuduVIwU4Bn9L7nKdlarRUYDB1FI6sYdT83rnXih8zi/2CeVLeAsOP5KiEy6WXUHRrqbuPTxXBYDJwnB8QXDtklSzMIzZR4MN9Cxn3syDkJ2U4/tdmx5GJK9TybSzxwo1OUJa1BvHShhK6I61Q+FMwUU3PODEHL3YhGt4DoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598461; c=relaxed/simple;
	bh=9Y/CFdXkR3Dh+SAzeb5OqTJ5CDE0EEUzMDxPlk94g00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OkWoQrOMj5QGQOkI3GHWw8kIQ8Ba2GbZ29/iRjOcD8TsCZslc1smf+zIX2GOoz46CYwPDSei2ulL8BEvnC/30jb3L4w1+slPRmiDci2BlgRUiseO6nHLG1YElipKNGiNWPb8XJ3H5PDldSXbrD0uppqzIEqOueKtlXEHUMQrP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43BB41C0024;
	Tue, 22 Oct 2024 12:00:53 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 5/7] shell: Document "mode" variable
Date: Tue, 22 Oct 2024 13:58:35 +0200
Message-ID: <20241022120051.123888-6-hadess@hadess.net>
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

It's unclear what it does, could probably do with being replaced with an
enum to make its possible values and meaning clearer.
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 2100434f6b15..9ff774fe43a2 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -71,7 +71,7 @@ static struct {
 	char history[256];
 	int argc;
 	char **argv;
-	bool mode;
+	bool mode; /* whether non-interactive */
 	bool zsh;
 	bool monitor;
 	int timeout;
-- 
2.47.0

