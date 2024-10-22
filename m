Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817519F47E
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606283; cv=none; b=XjGfOW4t/iTc/PB0LpLhyxV55MZ0KBB+1rPHSxJ/qQYIJGCLmGwXYK9OglbkX6cUvBFbg9PBIdUsYbk8Dqptn8RkxUFOiyfInxiEJz+0j5UwfDBFJ6Kc18UqqiaVytdCZxzooI1L9mDwIYVkaghxM4WwtNXZst9avEMs1qD1F7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606283; c=relaxed/simple;
	bh=ULD+6IBmG1PXoku2Q5jp0LOXbS2Lr7YqhrvFwviTOuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk2KpnX103+GXeczxHFbOZS0/r9Tvl58a2meHau+43d3s/z3O29dOJlHFZtLD5KcBoaLUa3sq7mKJtoyyXDjgpAvo4ZxtSjq7eoydlB36NT3kTALKtcRBzVOX4Z+TEUaV8hjZUya6lQI1mYJPSlA16T1OMvlrx2khaULBVrJeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1542D240007;
	Tue, 22 Oct 2024 14:11:19 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v3 5/7] shell: Document "mode" variable
Date: Tue, 22 Oct 2024 16:10:36 +0200
Message-ID: <20241022141118.150143-6-hadess@hadess.net>
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

It's unclear what it does, could probably do with being replaced with an
enum to make its possible values and meaning clearer.
---
 src/shared/shell.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index a8ad956c7948..2f83717b2d39 100644
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

