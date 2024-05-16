Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A3142E8E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850231; cv=none; b=IAVUyVpnWF381rs5UpEig/LPTOFoRaiZSfbOPrS03mrkQKWFqG4FEOhu4qQtMT0HGaZoR2l963051oQlEU0ckznrBq2xtLnC6K4GBLAYJdbHW/SAFp7HyJnTEqtHVuXLTwy4onOYPgqqmlzOTp+x/r9HJaUBMGy/hR/SxMIc/mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850231; c=relaxed/simple;
	bh=+Phm/GPIQ/Kb58wh0VebLZB5wfxtrZf3uXZjO+mnDKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu0WH/iw0XOExKBuLbuj+ccXx8gNYMz4O4nqIX/08PQc6XUxvGB8pHL0wc4jmxNQFnpZlXlXDq1vWq9JWLGh7AkB/IQf0p6K9anvAjakrYjhtF+fPe24wOskuKdZFD2mm5PaGqSTLT9p++sS8EX98o8WVoJO/MdFfg+vEfrzdF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2FA91C0019;
	Thu, 16 May 2024 09:03:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 09/15] isotest: Fix bad free
Date: Thu, 16 May 2024 11:03:13 +0200
Message-ID: <20240516090340.61417-10-hadess@hadess.net>
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

Error: BAD_FREE (CWE-763): [#def58] [important]
bluez-5.75/tools/isotest.c:1461:5: address: Taking offset from "strchr(filename, 44)".
bluez-5.75/tools/isotest.c:1461:5: assign: Assigning: "filename" = "strchr(filename, 44) + 1".
bluez-5.75/tools/isotest.c:1536:2: incorrect_free: "free" frees incorrect pointer "filename".
1534|
1535|   done:
1536|->		free(filename);
1537|
1538|		syslog(LOG_INFO, "Exit");
---
 tools/isotest.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index 58293133a304..fc1c26b23c3b 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -1457,8 +1457,11 @@ int main(int argc, char *argv[])
 		switch (mode) {
 		case SEND:
 			send_mode(filename, argv[optind + i], i, repeat);
-			if (filename && strchr(filename, ','))
-				filename = strchr(filename, ',') + 1;
+			if (filename && strchr(filename, ',')) {
+				char *tmp = filename;
+				filename = strdup(strchr(filename, ',') + 1);
+				free(tmp);
+			}
 			break;
 
 		case RECONNECT:
-- 
2.44.0

