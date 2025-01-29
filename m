Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE11A255C
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738140608; cv=none; b=fm2PnvJqKxMyqUKCoBMRSxQa164fS7u/BWaLc/9fIY/vOWmfUnlnoqcOG8t8Ll6hG32IZ1DOnf63es5J8Z++kFWOWzmpvYBRbh8tkLZ39OWFoduadBpCx6Uig7FoTEbGyH5JU2kGh6xIO7wXcHVLCKWgdQrRyxgS5C3yfyTha4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738140608; c=relaxed/simple;
	bh=5YwUuTebeaPs3+FgTJZi+g1Zf35V4oewlspO9XyearI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwlkyFHwQXI+/8yphyIZglSQYzU/dKCmuHji2u7UjeufXnq5agrAUA8geJhZkiSWUmkA+tNIZX5kxy7NEusk3AWEoMSIalA83Kff7GKgY2LWi5ew1/Gzwn6GkzntkipGTiZb+v2J89tzgTgbq6Kjywpm1Lw6/An5HOWWsaEJ/po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=LNM+knzZ; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="LNM+knzZ"
Received: from localhost.localdomain (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id BA4484076166;
	Wed, 29 Jan 2025 08:50:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BA4484076166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738140602;
	bh=iEU0nb1c9wTrDjZO2I85E0qgsyQshUNxdJMhuSyg3BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LNM+knzZsZ69xISKNgdsG8J1KCLkyrzt82lb+toG8eHJurwH+6i911OcDDrl645PA
	 VRTnYPfHkhvLGMk/dPsMdrKzAG+rjOCxdQ8DVhu6hzQpqld64AAxALhd3PEGd96Yx/
	 2SQd0E9I8TcPiSZrGoD7nqRj6/dMhTW7dcM6wTqI=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: linux-bluetooth@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH BlueZ v2 2/2] a2dp: enable input MTU auto-tuning for the server
Date: Wed, 29 Jan 2025 11:49:50 +0300
Message-Id: <20250129084950.41987-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250129084950.41987-1-pchelkin@ispras.ru>
References: <20250129084950.41987-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

L2CAP frames are lost while utilizing some exotic A2DP transports
usually coming up with weird custom MTU sizes so take advantage of
auto-tuning it for such cases.

Found by Linux Verification Center (linuxtesting.org).

Fixes: https://github.com/bluez/bluez/issues/1080
---
 profiles/audio/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c97bd6e89..438ef29a8 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2592,6 +2592,8 @@ static bool a2dp_server_listen(struct a2dp_server *server)
 				BT_IO_OPT_MODE, mode,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_CENTRAL, true,
+				/* Set Input MTU to 0 for auto-tune attempt */
+				BT_IO_OPT_IMTU, 0,
 				BT_IO_OPT_INVALID);
 	if (server->io)
 		return true;
-- 
2.39.5

