Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108D1DED6B
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jan 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738098267; cv=none; b=YNZlMZKTojargA5EQBiO2B7XCcUrRoeFR+wYo8kbObXTE992AjWdMc7eFYupE27pFGt+ceaypAE8Wtgh4gd2w2k6+AJ/FY3MbxGZM4/kDqpEoItJOhYGnWRb1FuyLcz8dHsz8v1G+scilP1mVYNXd28wmyQsk/0ZQMGSVvGHeUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738098267; c=relaxed/simple;
	bh=oMPnq0+Qe5fSLo+WSJ9sjrMrpV1bGwTMsuVNIH0GJoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lRdUc98sxQoR4vsBGhzGw+coCW94eOicH/ejZz8bT2VB3X7yYVc2uBZ3DTxHI+F4ZjHfGN30/hZJQ5tFnFrzDDZJGolDCxvFNc/c2LLpVUhQIHI/fZlWNoz2T6jkMxrkhOgJj7kNNxQvP2lPK2vCTobEdK5u1T84nvF9Nm+VwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IqX5XqZR; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IqX5XqZR"
Received: from localhost.localdomain (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id D23634078508;
	Tue, 28 Jan 2025 21:04:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D23634078508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738098256;
	bh=P8iXNQ7IQswExgxbXFXqGUmjiF03DUoFzsSQSVqaebY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqX5XqZRwW5JeqESlIfwD0w803Tt8B+pjHXdud1bdna3RSt6W1d40WLYdfvXKllgS
	 pdzxTeDCzCEZFC/czlAZibIfQS17m92/xxRKXELNbGktgn0eobQPMbpGwo7CTl232w
	 ot+D6iIrIPeHjCjT5SHWU45YdoSEaInVk6ErzP5w=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: linux-bluetooth@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH BlueZ 2/2] a2dp: enable input MTU auto-tuning for the server
Date: Wed, 29 Jan 2025 00:03:54 +0300
Message-Id: <20250128210354.73732-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128210354.73732-1-pchelkin@ispras.ru>
References: <20250128210354.73732-1-pchelkin@ispras.ru>
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
index c97bd6e89..05a2e2e80 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2592,6 +2592,8 @@ static bool a2dp_server_listen(struct a2dp_server *server)
 				BT_IO_OPT_MODE, mode,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_CENTRAL, true,
+				/* Set Input MTU to 0 to auto-tune */
+				BT_IO_OPT_IMTU, 0,
 				BT_IO_OPT_INVALID);
 	if (server->io)
 		return true;
-- 
2.39.5

