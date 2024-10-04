Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3297E2178E8
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052854; cv=none; b=r75BmKs4bTx8KS9jIjrk2VRO6tbsos6K3YEUfsg0ysIcPJ5Hz9ovUVuoHq9Vngu/ifGyCMiyouLm5LDmTbSU8MiIBkZcZl1my9RE3Gx1sAn7QrN0K8xz0tEyDGa9bzfET1gJEmoxYxYtr1LYS3/2m8eY5l3Ni7p48U2EjBruqSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052854; c=relaxed/simple;
	bh=+uIw3+D7cf8opKOu8qmeAOOPO4GY39AZpM9finbUki0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=BYtrRCAUkc1fpZFpn+gRlQ5Y9lSctyxnb08eb2ou6gIK9aDOVP5TmKOLdXY/D1wneH9aadvcmQAnr8UeBoWK01RBFib08/KjLRQ1iPW6UNjipWFNsOR1CSQYkGWGUcR3UzqVl5dOcVk7g/F/1tl4p61KbeUlwlT5HLJUNmNNszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PgF9zb4S; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PgF9zb4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728052850;
	bh=+uIw3+D7cf8opKOu8qmeAOOPO4GY39AZpM9finbUki0=;
	h=From:To:Subject:Date:From;
	b=PgF9zb4SFVa4DvzdJNwj6nXfJoKjDnr++mbdecvVYDYOnaQbDB2Y/x9A/kDOHqqeS
	 sdzzL1UnajhGKA5T5j0ZITNQ6zLc/BOpSdSTKUHWMccKAfKKrmwombIlPY9Uux15tD
	 mAMTQqppEoGwTS7GEHcWD4YYDvihk0bxxAu8rTel9kRwBMPKxSGsfwZxa8bb+Jvedz
	 jvuFq/PZBw/2HpsopUtLB04t4Vg4StMhv1+p51dvrlJ5qdxqGSQpIDmt6NmysJcUrP
	 C3oB8+T2OVjOtjE0PvEQj0NeA6l004eEWttbb2hB7DWcvkly3Oo0Gbgu+NJMLO5z0Q
	 +yDrZ+6+HU22w==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B17617E35F9
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 16:40:50 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/3] Fix now playing list on playlist change
Date: Fri,  4 Oct 2024 16:40:40 +0200
Message-Id: <20241004144043.419832-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some devices reuse the item ids for the Now Playing list on playlist
change, e.g. using the Samsung Music on Samsung S23. These changes
allows to clear the list and prevent to keep the previous tracks
information.
This also extend the ListItems method to get the Artist, Album,
Track number, Duration and Cover art handle.

This has been tested with Samsung S23 and iPhone 14.

Frédéric Danis (3):
  audio/player: Fix media_player_set_metadata item destination
  audio/player: Clear playlist on Now Playing Changed AVRCP event
  audio/avrcp: Extend ListItems to get more metadata

 profiles/audio/avrcp.c  | 65 ++++++++++++++++++++++++++++++++---------
 profiles/audio/avrcp.h  |  1 +
 profiles/audio/player.c | 16 ++++++++--
 profiles/audio/player.h |  1 +
 4 files changed, 67 insertions(+), 16 deletions(-)

-- 
2.34.1

