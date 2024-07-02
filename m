Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91651422B6
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910151; cv=none; b=f8iX8eKrAH2z/MKh0L4gYflgjpGzideXBB4VeZFuwz35TREN+Le2Uk+9MSy1RoASIvTeeW44KaYh0HKnBEYjmPapYY5DFICpXRGGFWVbNwK/BviXtcqfFoNPwvbnTuwynctAXDt5AJVznMKq4sQIvVoaNluESWZZKGlBVbidI84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910151; c=relaxed/simple;
	bh=+qPjmmn8NcK+7xfblQeghMNUTzsvNZ8xaNT6WpjPUX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWHA8KH2p63J7QZEONDQ7VpBYKkgvFydO5Y34BTJAtPaXzIEwDklnwo+vAB3shpBNE+kkFvIJYg+dcGlTYwJ2T3WUWS0sgJIAgle8Tu5QMoAaMMYKFVwzjvdkE9IeGkiqUZN7vm5dktvHupBK7Ocv4BR0XaNPoend/EEzAOkSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id D41C5E0003;
	Tue,  2 Jul 2024 08:49:00 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 0/9] Fix a number of static analysis issues #4
Date: Tue,  2 Jul 2024 10:47:15 +0200
Message-ID: <20240702084900.773620-1-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

"main: Simplify parse_config_string()" is a repeat. If you don't want
the patch, please let me know and I'll carry it downstream.

More fixes incoming, please review carefully, thanks!

Bastien Nocera (9):
  main: Simplify parse_config_string()
  avdtp: Fix manipulating struct as an array
  mesh: Avoid accessing array out-of-bounds
  obexd: Fix possible memleak
  obexd: Fix memory leak in entry struct
  obexd: Fix leak in backup_object struct
  health/mcap: Fix memory leak in mcl struct
  sdp: Fix memory leak in sdp_data_alloc*()
  sdp: Check memory allocation in sdp_copy_seq()

 lib/sdp.c                      | 13 ++++++++--
 mesh/prov-initiator.c          |  9 +++++--
 obexd/plugins/messages-dummy.c | 12 ++++++++-
 obexd/plugins/pcsuite.c        |  1 +
 profiles/audio/avdtp.c         | 45 +++++++++++++++++-----------------
 profiles/health/mcap.c         |  1 +
 src/main.c                     | 19 +++++++-------
 7 files changed, 64 insertions(+), 36 deletions(-)

-- 
2.45.2

