Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CEA1BC4E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088782; cv=none; b=dfQAqEfu4PmNuFGVDdtbLOyMU/tUt3d1Hj1WmrCrsC69EP9RIi8GcYWET4Qva8i2qwpM6DUAhotuIuvWsNvnHW4mpiqZdt50JWInaK7xq4L1ZKq9irCBHImAdQX7YYZBdNXHeD6O0IkdKgUBg3R898LXw9qI3G+yec2izMzc2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088782; c=relaxed/simple;
	bh=wf/o8GcTLLeGr32onp5gExCZuNMuccno7TokktI+NJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbXijaU+PpxI05aQGGrTXomPblfqw1IDJcql1RT+tEkbYi1DHfULrdvyTsPVda6plC4t6FalEIguGbG3gEz7k9ZNyDMTN9KDqnOsS9tW3AnTtFCwpRz4Vu2ufxVDjDP0AyN6yo/gQrNSqERMy1nllWDGq3z4nPKYF/XCAw4rvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E56A240002;
	Thu,  4 Jul 2024 10:26:18 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 00/12] Fix a number of static analysis issues #5
Date: Thu,  4 Jul 2024 12:24:31 +0200
Message-ID: <20240704102617.1132337-1-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Bastien Nocera (12):
  gatt-server: Don't allocate negative data
  shared/shell: Free w.we_wordv on early function exit
  shared/shell: Free memory allocated by wordexp()
  shared/shell: Fix fd leak if -s is passed multiple times
  btsnoop: Fix possible negative memcpy length
  sdp: Fix possible null dereference
  sdp: Fix mismatched int casting
  emulator: Fix integer truncation warnings
  gatt-server: Fix integer overflow due to cast operation
  mesh: Fix integer overflow due to cast operation
  tools/mesh: Fix integer overflow due to cast operation
  unit/ringbuf: Fix ineffective guard due to signedness

 emulator/amp.c           |  3 ++-
 emulator/bthost.c        |  8 +++++---
 lib/sdp.c                |  6 +++++-
 mesh/pb-adv.c            |  2 +-
 src/shared/gatt-server.c |  8 ++++----
 src/shared/ringbuf.c     |  2 +-
 src/shared/shell.c       | 20 +++++++++++++++-----
 tools/btsnoop.c          |  4 ++--
 tools/mesh/mesh-db.c     |  6 ++----
 9 files changed, 37 insertions(+), 22 deletions(-)

-- 
2.45.2

