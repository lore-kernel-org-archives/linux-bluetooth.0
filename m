Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF841F0E32
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129159; cv=none; b=fewI93OFYikemioYhfhIbh+61/OrzJ5Uy70e6b2UhIdWu75nCcWnEKDSquxQe6w9KJ7TJiil2Qz9xD0BsWPDMlwZc+l1Xzk9qr+yw+CPYUbAse7RXZS4GbFRnH1rMvxKdH/bz+RLEq4lPxbTuQwcToI8oHre8pfQytwVho+7ra4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129159; c=relaxed/simple;
	bh=WAb5/3EteQIuKyQR7BOl+RPye9wSt1Ml1ncK197CPM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCOjlbrEjaabMGOBpq9DE/VNv/syIEW4Ee9UGCmc1+Onsf1kkxWIeSH4mlnNZYOKtd6aoK0Ggg+00UtN1qYTv6xX+gW6cOBkHOoz59FXhAfiAZZXs/rNoUExLibzVjPWklzAGke2/ENBAgZtMQqA5/6uwX217bIa5azDQCU/JzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 536A1439EB;
	Tue, 13 May 2025 09:39:14 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v4 0/9] Fix bluetoothctl --help hanging if daemon isn't running
Date: Tue, 13 May 2025 11:38:10 +0200
Message-ID: <20250513093913.396876-1-hadess@hadess.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepffetkedtjeduvdfhtdeftddvteegieeltefhtefgtdehkeevgfeuieffhfevhfefnecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeholhhimhhpihgtrddrpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepvddprhgtphhtthhopehlihhnuhigqdgslhhuvghtohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgruggvshhssehhrgguvghsshdrnhgvth
X-GND-Sasl: hadess@hadess.net

The changes are still made in a way that there's never a commit where
something is broken that wasn't before, hence the function split
happening first, before we enable and use pre_run.

Let me know if you want me to rejig this, I think that the end result is
fine, but you might have a different opinion about the way we get to
that result.

Cheers

Changes from v3:
- dropped glib upgrade
- use pre_run menu hook to setup dbus if needed

Changes from v2:
- rebased against latest upstream

Bastien Nocera (9):
  client: Split installing submenu and doing I/O
  client: Install submenus before contacting bluez daemon
  shared/shell: Add function to handle early help calls
  client: Fix --help hanging if bluetoothd is not running
  shared/shell: Add pre_run menu callback
  client: Port "admin" menu to pre_run
  client: Port "player" menu to pre_run
  client: Port "mgmt" menu to pre_run
  client: Port "assistant" menu to pre_run

 client/admin.c     | 13 +++++++++++++
 client/assistant.c | 12 +++++++++++-
 client/main.c      | 13 +++++++------
 client/mgmt.c      | 23 +++++++++++++++++------
 client/mgmt.h      |  2 +-
 client/player.c    | 11 ++++++++++-
 src/shared/shell.c | 19 +++++++++++++++++++
 src/shared/shell.h |  4 ++++
 tools/btmgmt.c     |  6 +-----
 9 files changed, 83 insertions(+), 20 deletions(-)

-- 
2.49.0

