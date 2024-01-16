Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812B1BDEE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FISa6OOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70372C43141;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413118;
	bh=qMVrXkmg4Fgyp38JOJtFMNb6rJOsPj4pytAyiNylZ1o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=FISa6OOQQo7MVPehFsZ6teK+Vw7iKrZra+/ztq52QvzNtrsqVk0zbW9cUBdRDJsRa
	 YFDgUnMQB6nTAJHJk27y1pCZ1QCWQXY0xgSJJhy6aS5c4hituWrXybDCQzuoUeuGF/
	 0BJCxvAaj43OmbZKRRYuPQC8rZkWYxO0oXdRAulKvqC4Xa9Eg7/SjskdFeSbGI1vDM
	 ae8LAr1+AUa3wLjUu/Y7DCcMtbwBcxD9yf0zv70jInbHc6O8iX14MYbcujw9KcBPYf
	 9weY8u7XkTBuMmeDG3pdwojZoc7Oh8fBIv+1sb8w62nYN+sWJ88l53AqhVW369jtCM
	 s2JO53boTyLcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56039C47077;
	Tue, 16 Jan 2024 13:51:58 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ 00/10] Autotools papercuts, linker GC, symlink
 dbus-org.bluez.obex.service
Date: Tue, 16 Jan 2024 13:51:54 +0000
Message-Id: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPqJpmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Mz3cTSkvy0/HzdlCSjtFSjZHMDS1NDJaDqgqLUtMwKsEnRsbW1AOo
 5nHxZAAAA
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413116; l=2083;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=qMVrXkmg4Fgyp38JOJtFMNb6rJOsPj4pytAyiNylZ1o=;
 b=aPKfZIFRlWYuJQ804uFLlrxAfw6vtk+x4XgsaCJpxgCpJSlGb+6hrynUdQRU5ebgKvqj9f077
 MOcg01vDz7ODWjwOKYgjEkahKYylR2XZBx6nH+b4gKxlF3mE8zJCtsK
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello everyone,

While looking at our bluez package for the SteamDeck a handful of
paper cuts stood out. Here we tackle the build related ones - a couple
more series will be incoming shortly.

In a gist we have the following:
 - remove manual tracking of .services.in, DEPENDENCIES
 - remove unused variables
 - polish PKG_CHECK_MODULES handling
 - enable linker garbage collection
 - create a symlink to dbus-org.bluez.obex.service

The last change is slightly out of topic here, although since there's
a high chance of merge conflicts, I've added it here. Let me know if
you'd like it send out as separate series.

This is my first time diving into bluez, so any comments and input is
greatly appreciated.

Thanks
Emil

---
Emil Velikov (10):
      build: remove unused AM_CONDITIONAL
      build: tweak PKG_CHECK_MODULES calls
      build: require libudev 196, circa 2012
      build: remove dummy {conf,state}{dir,_DATA}
      build: remove unused variable builtin_nodist
      build: remove .service files from DEPENDENCIES lists
      build: remove explicit DEPENDENCIES handling
      build: manage .service.in files via configure.ac
      build: enable gc/dead code removal
      build: install dbus-org.bluez.obex.service symlink

 Makefile.am                       | 31 ++--------------
 Makefile.mesh                     |  7 +---
 Makefile.obexd                    | 10 ++++--
 Makefile.tools                    |  6 ----
 acinclude.m4                      |  2 ++
 configure.ac                      | 75 ++++++++++++---------------------------
 mesh/bluetooth-mesh.service.in    |  2 +-
 monitor/hwdb.c                    |  2 +-
 obexd/src/obex.service.in         |  2 +-
 src/bluetooth.service.in          |  2 +-
 src/oui.c                         |  2 +-
 tools/bluetooth-logger.service.in |  2 +-
 12 files changed, 43 insertions(+), 100 deletions(-)
---
base-commit: 770ad5614e7e8074133e6f563495ce4822f63fe4
change-id: 20240116-autofoo-db2fe2c70951

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

