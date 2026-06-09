Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4B34040F
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015028; cv=none; b=jn2chGqbljMQtTBAWD/td1YEI1OgbUM8JGIynFlfR3dIG6U8T3TFbtdz/Q4sDkuvDzIz6dgHN3toRpA6ho9/Mm95BaqeZx9Jr6D27ZLhcXTbPHwzNWDEFf9Hg9S4OAA+nsWvjFmQu5gEufLG5dhl64o3ReKpU9WuTovnj2ltg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015028; c=relaxed/simple;
	bh=MVflxJhAcQ9gnPhD1D36CXbF0dfUmW5XyoV5snqRA0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRzV3dxeJbumVnLYgf5kr1mgtTJvBbw30H8xCqy66CDwcieMh8pyBS9HwpECrL7/PHcrmIAKxYEdM8Ya993AuVZaHzmfQvnEe1TDy10RegdBlE62+4kP70DfNCxthh1pdqCGUPLI7CvoLu5BLYo2q/ec2ugpjWu1Ij/uV5FDoyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 5AFC9582994
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:53 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 909973EDD7
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 13:58:46 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 5/6] client: Use _cleanup_fd_ to simplify urandom access
Date: Tue,  9 Jun 2026 15:50:57 +0200
Message-ID: <20260609135837.476561-6-hadess@hadess.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609135837.476561-1-hadess@hadess.net>
References: <20260609135837.476561-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTEVlSdXhFUvSV8QQx6yOrxge8LgLVsxPuUsLns/yksmkNx+qdDvLvza5bKGN8WNxSHwt+f8VbZ4lJPoURNdRMWp8SMuewEQUfgBMkY/jbgr+LyXuM7iW1giNJiHgNHw6TWCI3u/pWopj0uku4KXuEzF2U7Jkv7EHtBXrrJV7gBwCRlXQDiK2LO8ylQk6uzIFcjqpCrorpKwg3w0D6ojMjAneIde2+9Xgn2LOidAqfgBRNsXEa58H2+xUe5E0Ri8LlvlWBN+ajBkbQKIGVS8FIytq/3m1RxPUluCTzu51875p3iUUbERbtkhDOOaRjgxLdx7vcvY3Bj/fS1GlcpyS/+RnVESAA97zOGpkwgH00GJyahY8dFhWg8ELEGEZEmLNDSoNrQY6+ml87t5W2CGdCkB92bo52AXT3LA2+2UgI2/GeZJYARvoSjua31BJo42AbLkQoEIeBQ/sXFXmbTK5nNtVlw2aqJluVDiOCctFAiaQPxcHjfHZ27IEEabfYW85MKmsjznDqSgkU2kTu3QO0YgDDUQh031L6APaN+5JX5qTvLzrMc9t83Dix8Kh0nGr9AyojR0m8rJvu7UI5uytItSE9VJvS5ZGZ2AUlg9vWRMjb3dR49M8GuS9S4F7veI5Ziu4EOuwdCtQzqaepM19AvT/WN8QzpO08sT9X2mcREg+Q

fd gets auto-closed before exiting the scope.
---
 client/mgmt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/client/mgmt.c b/client/mgmt.c
index 50558a313866..e199c30540e4 100644
--- a/client/mgmt.c
+++ b/client/mgmt.c
@@ -2681,7 +2681,7 @@ static void cmd_privacy(int argc, char **argv)
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 	} else {
-		int fd;
+		_cleanup_fd_ int fd = -1;
 
 		fd = open("/dev/urandom", O_RDONLY);
 		if (fd < 0) {
@@ -2691,11 +2691,8 @@ static void cmd_privacy(int argc, char **argv)
 
 		if (read(fd, cp.irk, sizeof(cp.irk)) != sizeof(cp.irk)) {
 			error("Reading from urandom failed");
-			close(fd);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
-
-		close(fd);
 	}
 
 	if (send_cmd(mgmt, MGMT_OP_SET_PRIVACY, index, sizeof(cp), &cp,
-- 
2.54.0

