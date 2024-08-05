Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8717C64
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866925; cv=none; b=OBhJ/zbnBDZjykx9KLC2UNNc+2XeB+JBUxjlw1X4CRDBuTjAcVidwcBGxxfA3s19lFjiQJsJJ7NQEM8nkvHP86a6JVRQ1Pwj6mAbAep6TQX2dvfvQeYs3XBWKJeiL1MuEIU4dEgKhB77+Xy5FUG7RbhhCyvF6ujGFXZHlhRDE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866925; c=relaxed/simple;
	bh=GyATFlgg6EeorXsx6XcU2IGmI7408ImxjZZ2aGxT8ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QKTLm2AhHLmrGvCk55ZCesVgCM4g5aqrTV6jimavAs4mJLP7SDKi0V8WqJd/bTKu0IHGI7Dj7W1AcwgDGjXHp19fQpCFldiO4C55GgGQKWAyjSAG6RPMFquxNWPyGhMqJVxcsHjtII7xhNIaMX8BjoVewZJgR+0Rtz5dctpwnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5FA1D20002;
	Mon,  5 Aug 2024 14:08:41 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 0/8] Fix a number of static analysis issues #6
Date: Mon,  5 Aug 2024 16:06:38 +0200
Message-ID: <20240805140840.1606239-1-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Last batch of static analysis fixes, all the other warnings were filed
as issues against Coverity, or were already submitted as part of earlier
patch sets.

Let me know if you have any questions about those patches, or the
earlier ones.

Bastien Nocera (8):
  sdp: Ensure size doesn't overflow
  tools/isotest: Ensure ret doesn't overflow
  health: mcap: Ensure sent doesn't overflow
  shared/tester: Add early failure check
  mesh: Fix possible integer overflow
  shared/gatt-db: Fix possible buffer overrun
  shared/btsnoop: Avoid underflowing toread variable
  monitor: Check for possible integer underflow

 lib/sdp.c              |  6 +++---
 mesh/net.c             | 13 +++++++++++--
 monitor/control.c      |  8 +++++++-
 profiles/health/mcap.c |  2 +-
 src/shared/btsnoop.c   |  7 ++++++-
 src/shared/gatt-db.c   | 11 ++++++++---
 src/shared/tester.c    |  2 ++
 tools/isotest.c        |  2 ++
 8 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.45.2

