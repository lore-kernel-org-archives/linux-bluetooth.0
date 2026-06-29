Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1437F75B
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751739; cv=none; b=o64fjqbyW9mITND1tY04FyXczUno/ItB8euSGTBpY9cBupIGtHBXq9Rv6i9FBSdiIlIOftukxiBjGF0mclHsJ3r+uuGEC83HzP1OgUzMOGbYxGiJivrI/tS+gW1p4eIYkF5tVHmeODdAiUkZidGJhj1RdpemZ+gTnegcme5LAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751739; c=relaxed/simple;
	bh=w8xoyz0zN7WGcpqIKu2rmscyGs70EkSLiH2wOVlBf4o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SmlC8ggaRCtItODYr8M82dRT3PeCNQPpKHTqQFai0d8kMyfMeDOEcK/UGoBfWJ/lhjfbp/gnp6sz8E2Y4MWxyrvmSwkXOYzKQyCsTg24r8YyvophqkDiv34I5k+kJEUbdYS5mWVvPWsmQdaWa96Gps+VhGDA78AujGqm7UMnEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ohb4jM7D; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ohb4jM7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782751737;
	bh=ud7+LIdlaKQ7KymGFYuPdTyLYf1Wn8lKE5/CrUwssPU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ohb4jM7DXtsAZtoS9V6JEE0423k+GRellnOMzHhO2EOKdEoTXwt0IbjwuBKJOUSra
	 GtadZzpcOyVfcq8trILvU8ZtbHw3uSkDyAo4VxRLbHFkpFcjo9Z9T49dhH0sTg76xW
	 FAU7F7qo1ac6uD678jhfLhLyNYXZylACfMNkEEHE=
Received: from github.com (hubbernetes-node-2a9f5a6.ash1-iad.github.net [10.56.149.43])
	by smtp.github.com (Postfix) with ESMTPA id D510E60074A
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 09:48:57 -0700 (PDT)
Date: Mon, 29 Jun 2026 09:48:57 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1118322/000000-dc5f00@github.com>
Subject: [bluez/bluez] 4bb428: bass: Fix possible crash on
 bass_update_bis_sync
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1118322
  Home:   https://github.com/bluez/bluez
  Commit: 4bb4281e3b7b51c2b322f4ba1882826c139ef52a
      https://github.com/bluez/bluez/commit/4bb4281e3b7b51c2b322f4ba1882826c139ef52a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix possible crash on bass_update_bis_sync

bass_update_bis_sync does use bass_remove_bis which may end up
removing the current entry causing a crash on entry->next, to avoid
that prefetch the next entry.


  Commit: 7a4396677522a537c751327defe8d66ca26ad3cd
      https://github.com/bluez/bluez/commit/7a4396677522a537c751327defe8d66ca26ad3cd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Check if stream is valid before attempting to release

bt_bap_stream_release shall check if the stream is still valid before
attempting to release it just as done with other operations.


  Commit: 6214233de73d8e101322487f79bf8a89b8ccdb7a
      https://github.com/bluez/bluez/commit/6214233de73d8e101322487f79bf8a89b8ccdb7a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Don't transition to IDLE inside bap_bcast_set_state

Remove the recursive stream_set_state(IDLE) call from the RELEASING
case in bap_bcast_set_state. This call re-entered bap_bcast_set_state
while the state_cbs queue was still being iterated, causing a
use-after-free if a callback unregistered itself during notification.


  Commit: cb4ff884ae40b2bad3ba63191b4f9848c8d892b1
      https://github.com/bluez/bluez/commit/cb4ff884ae40b2bad3ba63191b4f9848c8d892b1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Use queue_foreach to notify state changes

Use queue_foreach to notify state changes since that is considered
safer as it does attempt to detect list modification while traversing
the list.


  Commit: dc5f004af4bbc56381a74f2dd11b113608941ded
      https://github.com/bluez/bluez/commit/dc5f004af4bbc56381a74f2dd11b113608941ded
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-29 (Mon, 29 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Protect bap_stream_notify_connecting

bap_stream_notify_connecting may encounter callbacks that remove itself
while traversing the state_cbs, so this attempts to prevent to cause a
crash by prefetching the next entry.


Compare: https://github.com/bluez/bluez/compare/4bb4281e3b7b%5E...dc5f004af4bb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
