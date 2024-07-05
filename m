Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514F1143887
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169985; cv=none; b=Ry9FOEHJmHywgxUfbdFR4NTFBuo1q4VceATnhV3tEbLtl4Iur3kYm/jhRqGR2Vkq+kep/65B1hJvqQCq8db9aNDZ5OdGmaMmqe6v2Mx5aNeW/Qk4PTKEEAYgwQv4fWmzKnZaFcD4Gf5cIjFE97gaX2llQEphdVhiMn32ZZTOFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169985; c=relaxed/simple;
	bh=++1Pw8cwKxv9whpIErI5pPogT6xTef5b3bUsfOY8AUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7U5NJfoUwdyB0odKKiP/v3PjNN7d/GVcLlnNdWSdgtQGK3IEgUOwqjrPFvGLtr5anOHYS9DSFZKWpLeAeq6/MnsDTCzmFMU0fv73XbT04lS5Ikc+oSFZz+PzGI57zgeIv2iPs1GHtL8nvATGjeNaTNKOwZHqFEwyeQ/4t9HeY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE14260009;
	Fri,  5 Jul 2024 08:59:35 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 00/11] Fix a number of static analysis issues #5
Date: Fri,  5 Jul 2024 10:57:28 +0200
Message-ID: <20240705085935.1255725-1-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Fixed review comments in:
gatt-server: Don't allocate negative data
shared/shell: Free memory allocated by wordexp()
tools/mesh: Fix integer overflow due to cast operation

Bastien Nocera (11):
  gatt-server: Don't allocate negative data
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
 src/shared/shell.c       | 29 ++++++++++++++++++++---------
 tools/btsnoop.c          |  4 ++--
 tools/mesh/mesh-db.c     |  9 ++++-----
 9 files changed, 44 insertions(+), 27 deletions(-)

-- 
2.45.2

