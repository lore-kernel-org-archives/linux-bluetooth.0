Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6180BFF
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866926; cv=none; b=hYTSZYXCFtL92P/AruZWGG0rQM739PcpgAfjaI5l3/Z5XDTKmRl4yQjwYMaU+byhGb09GlyoGtXRq5mODyM6GPC4GM1AYeAbwAmst7Ol4CvknNpcy7SRJZfCmWve0zRUtophG0+EQS4LnHjKxoE842WoWj6WW9AWTIYXnUwWFmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866926; c=relaxed/simple;
	bh=Ov5XOLP4ntkCru0zKxTA2tMOaGaj6gnB+WOqzlkUa5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPeydIBrlyOhdgxIjK9f7ovESMQ/xtcxrytwKv+jYRmFRyQw8Q5TBN4mI0uq3br02OtgcTlzagruwg205MlwD4qnxbbtna/v6C065U5jQo/3/navPFJ4dUt0VbMygg+gbEiGPHxTqdvjkuGCCjPnY1RraNGNHkUs2vR/xUapJwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D34320008;
	Mon,  5 Aug 2024 14:08:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 4/8] shared/tester: Add early failure check
Date: Mon,  5 Aug 2024 16:06:42 +0200
Message-ID: <20240805140840.1606239-5-hadess@hadess.net>
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

Add a similar assertion to the other tests to avoid passing negative len
to tester_monitor() which might result in crashes.

Error: OVERRUN (CWE-119): [#def13] [important]
bluez-5.77/src/shared/tester.c:946:2: return_constant: Function call "io_send(io, iov, 1)" may return -107.
bluez-5.77/src/shared/tester.c:946:2: assignment: Assigning: "len" = "io_send(io, iov, 1)". The value of "len" is now -107.
bluez-5.77/src/shared/tester.c:948:2: overrun-buffer-arg: Calling "tester_monitor" with "iov->iov_base" and "len" is suspicious because of the very large index, 18446744073709551509. The index may be due to a negative parameter being interpreted as unsigned.
946|	len = io_send(io, iov, 1);
947|
948|->	tester_monitor('<', 0x0004, 0x0000, iov->iov_base, len);
949|
950|	g_assert_cmpint(len, ==, iov->iov_len);
---
 src/shared/tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 56c8cba6f578..3053025d7945 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -945,6 +945,8 @@ static bool test_io_send(struct io *io, void *user_data)
 
 	len = io_send(io, iov, 1);
 
+	g_assert(len > 0);
+
 	tester_monitor('<', 0x0004, 0x0000, iov->iov_base, len);
 
 	g_assert_cmpint(len, ==, iov->iov_len);
-- 
2.45.2

