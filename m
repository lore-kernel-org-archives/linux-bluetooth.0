Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64580197A81
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598461; cv=none; b=At3XLC+fk2OxVB5b+2q2fmhSjXjMH4P5yOspOLog5wf2SGWnIiHydpkOX2RidnMSfL3NNGMy745/pW726YtM1OL8DIVTq7KAJG9fJl7vtDCqM/vM7YpvAIxdxY3rZiLYiqY9laq+5NlapTV22+QBnMIswWvmBiR3pnTBCGnstuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598461; c=relaxed/simple;
	bh=x99X1GJwq0ouMT67e7vEJPRaAGNClLb1vABALUa7mtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXzd30Uf91PqYLxV/oS0XKLnzv0dZDqGmiOd50Xj+8nfRIgVlxOAWYuICt8xzNHoxgwRlewZJRmjwDVzPzvpHJ6uFDNRqB9QIiBAiEqtuYjAec05TQDrwlSQ9ZaYWD0qComhKaFGqsGAKuAQ60gRZnQsiWlMQ71K6vYCVc9yn/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B98E01C0017;
	Tue, 22 Oct 2024 12:00:51 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 0/7] Fix bluetoothctl --help hanging if daemon isn't running
Date: Tue, 22 Oct 2024 13:58:30 +0200
Message-ID: <20241022120051.123888-1-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

v2, this one can print all the submenus without requiring bluetoothd
to be running.

Bastien Nocera (7):
  configure.ac: Update requirement to glib 2.34
  client: Use g_clear_pointer() to clean up menus
  client: Split installing submenu and doing I/O
  client: Install submenus before contacting bluez daemon
  shell: Document "mode" variable
  shared/shell: Add function to handle early help calls
  client: Fix --help hanging if bluetoothd is not running

 acinclude.m4       |  4 ++--
 client/admin.c     |  8 +++++---
 client/admin.h     |  1 +
 client/assistant.c |  8 +++++---
 client/assistant.h |  1 +
 client/main.c      | 14 ++++++++++----
 client/mgmt.c      | 11 +++++++----
 client/mgmt.h      |  3 ++-
 client/player.c    |  7 +++++--
 client/player.h    |  1 +
 configure.ac       |  2 +-
 src/shared/shell.c | 12 +++++++++++-
 src/shared/shell.h |  2 ++
 tools/btmgmt.c     |  3 ++-
 14 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.47.0

