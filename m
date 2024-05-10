Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC716FF5B
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343254; cv=none; b=CXlSxy7c7Jgb6YsONL7ZJPVcUqlmAuKFHmtzY/q7YBe7R3UwEkbHVhHU6d/Jf19JDU+KDiwJpwBC2KjptqR1CNjsRtzj2ePzDipdozeZJ1mWZtU3FKVP6An12Jq+SPoDf/TpS60ZIPwsGLlZkuMokBJSemJRnr6Jdos0+rBxnQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343254; c=relaxed/simple;
	bh=YxeLF1Ugc5ZMF5i0ShdwAJKFYYj9XeyJpD/3a3qxe0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErB88FhcvEmJQKZksDPdVnsV7Kf1WClKp6axcoH8kLNYGEmBeOe/nCmLVVXh1oHui23f3/d8gQwqX1Z8mVyiuS4ptxCL3R8cEZqP8wWfqN4QOLFHSK/HUReBQPmH2vb3qFoDnaYx3fEi0/A4MdNeG9MdsQQ8Z2zvai8BcZycYXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F42160007;
	Fri, 10 May 2024 12:13:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 00/20] Fix a number of static analysis issues
Date: Fri, 10 May 2024 14:10:10 +0200
Message-ID: <20240510121355.3241456-1-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Changes since v1:
- added 6 patches
- Fix syntax error in "client/gatt: Check write_value() retval"

Bastien Nocera (20):
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
  isotest: Fix fd leak
  iso-tester: Fix fd leak
  sdp: Fix use of uninitialised memory
  monitor: Work-around memory leak warning
  avrcp: Fix uninitialised memory usage
  main: Simplify variable assignment

 attrib/gatt.c          |  8 ++++---
 client/gatt.c          | 21 +++++++++++++++----
 client/main.c          |  7 ++++++-
 client/player.c        |  2 +-
 lib/sdp.c              |  2 +-
 monitor/att.c          | 19 +++++++++++++++++
 monitor/jlink.c        |  3 ++-
 profiles/audio/avrcp.c | 10 ++++-----
 profiles/audio/bap.c   | 47 +++++++++++++++++++++++++++++-------------
 profiles/audio/media.c |  1 +
 src/adapter.c          |  2 +-
 src/main.c             | 16 +++++++-------
 src/shared/vcp.c       |  2 +-
 tools/iso-tester.c     |  1 +
 tools/isotest.c        |  6 ++++--
 15 files changed, 104 insertions(+), 43 deletions(-)

-- 
2.44.0

