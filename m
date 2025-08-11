Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B205299AB3
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754942341; cv=none; b=UC+AOoXwTI2JGadVdoP2cjdGbw4HzxS7cWLJ1wA8sUd4PldY51xqlnasdfMGaWLu/MYxb5vC5lViWKRKPzir9EypMVsd2Xur5SvlP17EtBtttKPGR/2tW7aqcXfbmErUPPYQG8Vk/c+41QqLC+wOh1mKO1AAQWy4FbwmON5diYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754942341; c=relaxed/simple;
	bh=4R6ZNM4jrye2YNhGLN0owK83Viv709IfEMgFd3NpQBs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jLOwV/oEnCl2AS8UPtLOnW3EY4Sr1ddZWSZke4j98gU7sP6YMcWZUjwP3onkeFmS/ZlxtdFOwWj80rLH9sbfBKcwVFCIMJEiQGVscz1DkajrdfwGnIupJecc3Tf0Qd4swBPi/gCFsQdZ8dXLnsXBVqHV1C/5QBQ+9AZpPLfmPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2918A1F47E
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 19:58:55 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/8] build: Add meson build system
Date: Mon, 11 Aug 2025 21:53:41 +0200
Message-ID: <20250811195850.1775759-1-hadess@hadess.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeeffeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepfefggfffvefgveffuefghedufeehleefhfegfeeiueekhfegteetueehgfefvefgnecuffhomhgrihhnpehsvghrvhhitggvrdhinhenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmeejudgurgemfegsugemvddtrgelmedufeefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

A couple of important notes:
- the ell meson build changes still aren't upstream, so we're currently
  relying on a fork, but that fork only impacts builds with vendored
  ell, and meson
- I can make similar change for autotools for the last 4 patches in
  this patchset, just let me know whether you want them in the same
  commit as the meson one, or separate ones. If they're not accepted,
  I'll use them in the Fedora/RHEL packages, as those tools were
  installed manually up until now.

Bastien Nocera (8):
  build: Add ell subproject
  build: Add meson build system
  build: Make more use of 'feature' options
  build: Separate systemd and libsystemd dependencies
  tools: Install gatttool if deprecated tools are enabled
  tools: Install avinfo tool by default
  tools: Install btmgmt along with other tools
  emulator: Install the emulator if built

 .gitignore                   |   1 -
 .gitmodules                  |   3 +
 attrib/meson.build           |  17 ++
 btio/meson.build             |   1 +
 client/meson.build           |  54 ++++++
 completion/meson.build       |   3 +
 doc/meson.build              |  41 +++++
 emulator/meson.build         |  36 ++++
 gdbus/meson.build            |  19 ++
 gobex/meson.build            |   8 +
 lib/meson.build              |  55 ++++++
 mesh/meson.build             |  75 ++++++++
 meson.build                  | 280 ++++++++++++++++++++++++++++
 meson_options.txt            |  52 ++++++
 monitor/meson.build          |  47 +++++
 obexd/meson.build            | 121 +++++++++++++
 peripheral/meson.build       |  13 ++
 plugins/meson.build          |  29 +++
 profiles/meson.build         | 170 +++++++++++++++++
 src/meson.build              | 102 +++++++++++
 src/shared/meson.build       |  80 ++++++++
 subprojects/ell              |   1 +
 test/meson.build             |  41 +++++
 tools/mesh/meson.build       |  16 ++
 tools/meson.build            | 341 +++++++++++++++++++++++++++++++++++
 tools/mpris-proxy.service.in |   2 +-
 unit/meson.build             | 111 ++++++++++++
 27 files changed, 1717 insertions(+), 2 deletions(-)
 create mode 100644 .gitmodules
 create mode 100644 attrib/meson.build
 create mode 100644 btio/meson.build
 create mode 100644 client/meson.build
 create mode 100644 completion/meson.build
 create mode 100644 doc/meson.build
 create mode 100644 emulator/meson.build
 create mode 100644 gdbus/meson.build
 create mode 100644 gobex/meson.build
 create mode 100644 lib/meson.build
 create mode 100644 mesh/meson.build
 create mode 100644 meson.build
 create mode 100644 meson_options.txt
 create mode 100644 monitor/meson.build
 create mode 100644 obexd/meson.build
 create mode 100644 peripheral/meson.build
 create mode 100644 plugins/meson.build
 create mode 100644 profiles/meson.build
 create mode 100644 src/meson.build
 create mode 100644 src/shared/meson.build
 create mode 160000 subprojects/ell
 create mode 100644 test/meson.build
 create mode 100644 tools/mesh/meson.build
 create mode 100644 tools/meson.build
 create mode 100644 unit/meson.build

-- 
2.50.0

