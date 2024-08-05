Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCA112D20D
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866927; cv=none; b=QOlHbz+rU4idMlVC/b+w978D2J+SkB2Mo52BdAKh9T62ixDyvXZDEO2V56SDvOXOnvU0wW39mhsSxDu/Ujity+tLai5VRforJe9NQT72Gu04liJyRAqTXAtuYuHqn3Y0Uwr4+pcLvpQOR4krF3RknT4TLTSmhAWXyMAxVrF5HEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866927; c=relaxed/simple;
	bh=0wqNcyaL74Bj6IpXL6qGatPX6UlTMhwbuxzp+0BeNmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFckHxRyfzgHUQKig9CNRRzHliJxb9Dt5Pd+2LyzssVhF0DajQKwwQeL8tMPUD9sUpKY0+Z/yawEX8xIrQYwP+ZW1UNNllzfp6CX5xionxx+V8VGV4sblHjmvBV8oPfcIl32WQrNX+9VcBZDgr32D3V18UKRAd1f2PQIbJrXU1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82ED52000F;
	Mon,  5 Aug 2024 14:08:43 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 7/8] shared/btsnoop: Avoid underflowing toread variable
Date: Mon,  5 Aug 2024 16:06:45 +0200
Message-ID: <20240805140840.1606239-8-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140840.1606239-1-hadess@hadess.net>
References: <20240805140840.1606239-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: INTEGER_OVERFLOW (CWE-190): [#def8] [important]
bluez-5.77/src/shared/btsnoop.c:556:3: underflow: The decrement operator on the unsigned variable "toread" might result in an underflow.
bluez-5.77/src/shared/btsnoop.c:572:2: overflow_sink: "toread", which might have underflowed, is passed to "read(btsnoop->fd, data, toread)". [Note: The source code implementation of the function has been overridden by a builtin model.]
570|	}
571|
572|->	len = read(btsnoop->fd, data, toread);
573|	if (len < 0) {
574|		btsnoop->aborted = true;
---
 src/shared/btsnoop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index bc5f7fcbe84c..bb0bccf0dd01 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -530,7 +530,7 @@ bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
 	}
 
 	toread = be32toh(pkt.len);
-	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
+	if (toread > BTSNOOP_MAX_PACKET_SIZE || toread < 1) {
 		btsnoop->aborted = true;
 		return false;
 	}
@@ -569,6 +569,11 @@ bool btsnoop_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
 		return false;
 	}
 
+	if (toread == 0) {
+		btsnoop->aborted = true;
+		return false;
+	}
+
 	len = read(btsnoop->fd, data, toread);
 	if (len < 0) {
 		btsnoop->aborted = true;
-- 
2.45.2

