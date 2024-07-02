Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA986AFA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930287; cv=none; b=GlfJ5xrZwiA8ESEEloivRhnHQ7IWWqkGxV5qenk3m0762Q8gGGSnZdo1KL5tkgTAIBd3Y/0teljflHydrcGDILJ8bDb/o86Xm1qfE5WuVux39Gy0YxVJdcAWLVp1h4117PPYyPbPQ72od5APWYFkVizeV8LCbu0nF9lJnHcEF00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930287; c=relaxed/simple;
	bh=pY7IJnJvVtfhOHUjSuNMaMdEr0cl9pK5yH1g0maw10k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0Pkyexp/v3EZe+46BmMkN1LhQP7Ig87JBdl6YTjBw/119K+TeEls0s7RxXd9JvXz/8h1uEB2D51m3IpwEo7p3M6tlju72vqHCvLQCrdJzMTpTZLAaKJF7B1AVCrcU6luSxg+ANnHsG/H53H8+5PQ452ACwFXoubqKScpdsNqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A34124000A;
	Tue,  2 Jul 2024 14:24:37 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ resend 0/9] Fix a number of static analysis issues #4
Date: Tue,  2 Jul 2024 16:23:32 +0200
Message-ID: <20240702142436.833138-1-hadess@hadess.net>
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

Re-sent with the correct prefix

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

