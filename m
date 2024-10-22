Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C176119E96A
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606284; cv=none; b=ekyyTRzUB4EtIwhmuHm4RqmzMjOxc64F5zp5I/J8tuYFvR8Ga1SA4hQl9rjALV1GNmFJc/mXOurz51hn91zO0kGXbddALeCjPbuY34NE4e5r3kx1jrH5qoimLmh9qZsFnubZlKNzbGF8GT5C9dz1JFCImT5uW5VJqafOjOVRc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606284; c=relaxed/simple;
	bh=iiENksnMjE/ZH+Ad9ApiUkPgroJpulk47djEin3noR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rh7PVAzV/+GFD2MJ8JWTi5Sph0lTuXtu/TllE2i5Dq8ZNbbR1ZhL2zT9Euni0BXvwgIRpMNBraE7JAb2Lh5wpAU/gt2gI3DGiz7HuHmyTr9Y/n3qhGye9NECsUNltBqpJ54FVOxhnj9oEC1jBHEKkI1AtQY0l4bylvxyABrjLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A9FFE24000E;
	Tue, 22 Oct 2024 14:11:18 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v3 0/7] Fix bluetoothctl --help hanging if daemon isn't running
Date: Tue, 22 Oct 2024 16:10:31 +0200
Message-ID: <20241022141118.150143-1-hadess@hadess.net>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Changes from v2:
- rebased against latest upstream

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

