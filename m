Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90673326938
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648252; cv=none; b=X+7KbqVYv4kpIhcxTvwV5RhZTudhBXIcwioOhljuCwOWdJRwbUAhn6sLsgWVf3okhIeqW89u+c4Pt8eFtOZYMuIoMy/TUvnl/WiRdgP2S33VMTUt7lzEZb34N8WlrskGjNR+8Z/LpOkG/W1sqWHE1az8ML3nbSamMbEUqIFrQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648252; c=relaxed/simple;
	bh=Tm24pgsx0Q6jwyEAL9aJkC8UTxpwKchrgrNUD1mvlhc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U/b1Hyp/ov91KxxLIifttZKi9IHUnT4k96vX6Iup0UBIa8OW+alNK+1TAz5vCLnT6q8dV1EUKLLjEepw4IK/gvg+4AuC1lb2NE78W02qdiNxlAi8niFQzCZkLLyirr1mHOR6/CouoHWBHpqr1QRMg8bue5m8HqHOzyi0nl5bOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF5E13EC03
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 08:57:22 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] SECURITY: Add top-level security doc
Date: Tue, 25 Aug 2026 10:55:53 +0200
Message-ID: <20260825085714.448937-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTFqhw8A9t2rb3goBchi88s0jTyxmT7ZluLJC/8fqKY0VfLkg8F6/ZdnLV9G3oyhpYlPrt9QKO6+lRiGVKoxbGDCxF1y3WMXCInH436wwxw18UhOg0N5x/6UkSEzWfX7ZjjqHCjthS4g/vpRVcVegozZ5gy9FsAxkJ3xxJXytKkRNI5/EEtzzbr6vaKIOApWs1eQFFx4Od5rLxkn2OGvUQBepJwZKygUvm/Y8WPtMFqVYgCrbHFDmumomNlBEbwWoj7FUYyUc+Kg8gRbJzX0bzqRIEj81ToczmjWI976eR8aBmqqSn1VpMkPY5BEn7b2TDPnfinQPgZMAiohsu/qUE30TdHqo8nW8snoK1UyBXN5hTCVuefrExtRpFI/V6Gr8LJrv9ea197WAMAsUuEMNElU+5/90ASGZLbBW5E9hCjXsMze8PT3tQVzUSm/xzqrdIEgprONOPoJA89QPGOOPbO70ccZFYqMc175kSOiGiWe+h8J0c2imoBM63g8UW2FKsppgQLfkxZvJdBRjHxB5Fy81GLEjTZ621Gt1EI7f07T5YvsFCb5ZFJHSZulHLmq5iGD+BCAW3Y/caUQ7faFpvTkSmD1g2qvkT6rs/P1fUwOYSmgklSebHUkYUyQeHK28zxXnU6GMqmSUl4bUOF3fG9OswtaGpOurG26P7kypexKmg
X-GND-State: clean
X-GND-Score: 0

With reviews from Marco Benatto, Senior Product Security Engineer
at Red Hat.

Bastien Nocera (2):
  SECURITY: Add top-level security doc
  doc: Remove obsolete security-bugs.rst

 SECURITY.md           | 88 ++++++++++++++++++++++++++++++++++++++++++
 doc/security-bugs.rst | 89 -------------------------------------------
 2 files changed, 88 insertions(+), 89 deletions(-)
 create mode 100644 SECURITY.md
 delete mode 100644 doc/security-bugs.rst

-- 
2.55.0

