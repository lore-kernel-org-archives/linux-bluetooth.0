Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58F2701B6
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364933; cv=none; b=mfXRBSsgiAVkNoay/70HkJ/1HpSkVUuVK/xvWOvqAs73uLnTupdbRGWqvqV6qv86ZQewXlNAc/8bR6PqFL9vo3yKUw53DWseOUCk6puVBtV8MHL0uexeKrhF10YAdA5nN4+HvJDitUlWnxiEcEQ7p0lmgrj/ndFYlzmfashitbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364933; c=relaxed/simple;
	bh=VuOOktw2UHQTrbLxaU9oqlgAgNuujr2+2liXJULxt9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fs+srgLPraQpOqC7U945VmLenyxTQ0DvGg9ydQQW7euLpZhSfvttZq5XGH/Zi55+s12BX2HMgF0MNy13IdhSqucZuLPUl59uuSWfqnXdRHjZpGuZiVGbTZe047HDhEmIF0syf+LzOMeCqpQYyJ2I/R0WibHWTep1LFtceShJ4fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 61182438D1;
	Tue,  1 Jul 2025 10:15:29 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH BlueZ v4 0/8] Better connect debug and error reporting
Date: Tue,  1 Jul 2025 12:14:21 +0200
Message-ID: <20250701101520.459452-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpefhlefhkefhtdethedukeegvdehieeviedvledtueetjefggefhuedtveevlefffeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth

Completely redone from v3, following discussion on the mailing-list:
https://patchwork.kernel.org/project/bluetooth/list/?series=964591&archive=both

Bastien Nocera (8):
  error: Rename device error helper to match retval
  error: Add helper to return DbusMessage errors from errno
  device: Use new DbusMessage error helper
  error: Make errno to string helpers private
  device: Better error when no BR/EDR profiles can be connected to
  device: Better "Connect" debug
  device: Better error when the link key is missing
  device: Better error when the adapter is not powered

 doc/org.bluez.Device.rst |  5 +++
 src/device.c             | 79 +++++++++++++++++++++++++---------------
 src/error.c              | 71 ++++++++++++++++++++++++++++++------
 src/error.h              | 12 +++---
 4 files changed, 118 insertions(+), 49 deletions(-)

-- 
2.50.0

