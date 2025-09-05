Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B017F4F6
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082084; cv=none; b=gPaDrO65zkGk2asDdk8VVMeaT61oWGbsPE1lKFFB/MaV8cQq/T4y5FttuOoy56+OFJpGikYndN298RxeM3gGrBxlEQGLBMQjT8w0FOSn/mvWLY3B1BzTyuYHWF4wclrIwc3yqL9jkIA5IsetCXdgwfmiJSx9slDsjQdfqOiy48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082084; c=relaxed/simple;
	bh=tUj+kfTITSjno64Z++o9ktv7KrMaYty/jXwtXufJi64=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s3gzeph29+0BhmxGP3ox/WTz7/VpDVRjDB1XfHhfzwAwbhHUk76E5srouENFIu08T2LuMmqK0RuZuRk9NAYVdZTIi4Z3cYay3mdqKOlJfRtwyZ507GSJRxzI5F/IXvzQTSB/vLZ9lUExGg3Jmit15tCrUcJyUaMGYJQhHyk414o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AiwYlKC1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AiwYlKC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757082080;
	bh=tUj+kfTITSjno64Z++o9ktv7KrMaYty/jXwtXufJi64=;
	h=From:To:Subject:Date:From;
	b=AiwYlKC1eBrhe+nauwtjAgL5da4OXQvkwyyQ+PyAqKkwCtUM5eeVQZRsA+6T8Kyli
	 PPuUN++O5bfN9yMiX8sFlGU//knUHnRm0GaqmTMILluRCqIOUav5OoUHhD/5zVvqbf
	 FwdOAPaEtJvJ10AJEZWl2+agC60kmZ8nS5jF4cQlA1pEDLcir+MCClPnUeO5LDx2Uu
	 Jr+6Uq2T1zxKYpFuK4xEU85xGhIftzaNioMRfqmUtcBCb2QVzPyu3dqbVYm9vTbNvj
	 JbI+UB00j+tr0FYWd0tIe07j3M4EOUDjZCI06ibj/nBy63z+n5T0O72nUlGNByCX+G
	 04qC/gx6J/J8g==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-F1Dd-893b-C7A8-9733.rev.sfr.net [IPv6:2a02:8428:af44:1001:f1dd:893b:c7a8:9733])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5886117E11FF
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 16:21:20 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] unit/test-hfp: Fix MINIMAL_SLC_SESSION
Date: Fri,  5 Sep 2025 16:21:15 +0200
Message-ID: <20250905142115.942982-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Fix missing commas in +CIND reply.
---
 unit/test-hfp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 9b4d60a3b..371415a68 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -705,8 +705,8 @@ static void test_hf_robustness(gconstpointer data)
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
 	frg_pdu('(', '\"', 's', 'e', 'r', 'v', 'i', 'c', 'e'), \
-	frg_pdu('\"', '(', '0', ',', '1', ')', ')', ','), \
-	frg_pdu('(', '\"', 'c', 'a', 'l', 'l', '\"'), \
+	frg_pdu('\"', ',', '(', '0', ',', '1', ')', ')', ','), \
+	frg_pdu('(', '\"', 'c', 'a', 'l', 'l', '\"', ','), \
 	frg_pdu('(', '0', ',', '1', ')', ')', ','), \
 	frg_pdu('(', '\"', 'c', 'a', 'l', 'l', 's', 'e', 't'), \
 	frg_pdu('u', 'p', '\"', ',', '(', '0', '-', '3', ')'), \
@@ -714,11 +714,11 @@ static void test_hf_robustness(gconstpointer data)
 	frg_pdu('(', '\"', 'c', 'a', 'l', 'l', 'h', 'e', 'l'), \
 	frg_pdu('d', '\"', ',', '(', '0', '-', '2', ')', ')'), \
 	frg_pdu(',', '(', '\"', 's', 'i', 'g', 'n', 'a', 'l'), \
-	frg_pdu('\"', '(', '0', '-', '5', ')', ')', ','), \
+	frg_pdu('\"', ',', '(', '0', '-', '5', ')', ')', ','), \
 	frg_pdu('(', '\"', 'r', 'o', 'a', 'm', '\"', ',', '('), \
 	frg_pdu('0', ',', '1', ')', ')', ','), \
 	frg_pdu('(', '\"', 'b', 'a', 't', 't', 'c', 'h', 'g'), \
-	frg_pdu('\"', '(', '0', '-', '5', ')', ')', ','), \
+	frg_pdu('\"', ',', '(', '0', '-', '5', ')', ')', ','), \
 	frg_pdu('\r', '\n'), \
 	frg_pdu('\r', '\n', 'O', 'K', '\r', '\n'), \
 	raw_pdu('\r', '\n', '+', 'C', 'I', 'N', 'D', ':', ' '), \
-- 
2.43.0

