Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588391635C1
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332705; cv=none; b=NMQt5huzusHLMCVCTVpy3ehS4mWsnmPKwHVi7EMBUa5V9eKItt9eK8RQr1RLaSBj0jt9EuExk5yrN8bTci45EPGDqb0w4zPbwjBUqhs6QXHpVderygLwfFnRDA0cpzY9SVl43bwaYW68gNp4yx+EEzAwdRIr8s39NQSYTFLEMLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332705; c=relaxed/simple;
	bh=e4R1NokF9Tm1x6vun3UbIi/yRcfytl5Tuws8X6RCSk8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HqN5gmvvTBTmBaYKsV43ns9dZtW8YFkGCPlwp2NbftqwGKHeaVNRYL+8luNBnQtyP+vFYAPivDEkE2mfUOPc+uZc2OEd1K1bX21QcCVAvUUE1V6pa6+a+kS7KY2XPhNilR5zhmjbhs7MY/e6um3ZoL2ew7falJd+ygu4sbfAitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56E001BF203
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:15 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 00/14] Fix a number of static analysis issues
Date: Fri, 10 May 2024 11:10:58 +0200
Message-ID: <20240510091814.3172988-1-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Hello,

This is the first batch of bug fixes for issues found by Red Hat's
internal static analysis tools.

The best course of action would probably be to merge the one that
are ready for upstream inclusion after review, and mark the others as
needing work, so I can include a new version of the patch in following
batches.

Cheers

Bastien Nocera (14):
  adapter: Use false instead of 0 for bool
  attrib/gatt: Guard against possible integer overflow
  client/gatt: Don't pass negative fd on error
  client/gatt: Check write_value() retval
  client/main: Fix array access
  client/main: Fix mismatched free
  monitor/att: Fix memory leak
  bap: Fix memory leaks
  media: Fix memory leak
  main: Fix memory leaks
  isotest: Consider "0" fd to be valid
  isotest: Fix error check after opening file
  client/player: Fix copy/paste error
  shared/vcp: Fix copy/paste error

 attrib/gatt.c          |  8 ++++---
 client/gatt.c          | 21 +++++++++++++++----
 client/main.c          |  7 ++++++-
 client/player.c        |  2 +-
 monitor/att.c          | 19 +++++++++++++++++
 profiles/audio/bap.c   | 47 +++++++++++++++++++++++++++++-------------
 profiles/audio/media.c |  1 +
 src/adapter.c          |  2 +-
 src/main.c             |  4 ++++
 src/shared/vcp.c       |  2 +-
 tools/isotest.c        |  4 ++--
 11 files changed, 90 insertions(+), 27 deletions(-)

-- 
2.44.0

