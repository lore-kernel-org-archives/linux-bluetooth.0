Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA67F
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141249; cv=none; b=LLktDOiO9nK6eKHg71wZaHLsNzYfm7BSttG+cFa7H7gmmwInJat/j0ctlZLHjjZFpiAweTbgA5o69+RwfTD344u/9DOoNQn+rTl/p7tpASjRjQtaAckgykZ5/DTyOuuFBBIF6Jlv2m8E+17oT+bSzieAEUAkxkQlWg/S3/URlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141249; c=relaxed/simple;
	bh=YPAuJR/p/8YBl67ki2/Jzj4r23FKOVbW0WP58ypVgAA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NDxjo4KamwXaMWWWKI8wRtorA+B2RTbw6MyUJLiAo5T3TiFxgdYUN4pdk7YggXIPhagqEWv1ReT4xQMLP1RDpVRMfPfI9jn8dtvIO3Pu8IOeoThj0lezm84qpLDR3cWSgdFSrCIx1rjc0WTQUykAj6ithC8GoXPBF1xJFzdgnDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLLTgQsS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLLTgQsS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1854BC433F1;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706141249;
	bh=YPAuJR/p/8YBl67ki2/Jzj4r23FKOVbW0WP58ypVgAA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=eLLTgQsSz9MlJHAxAb9WmyDvo0AqFvsgXNyq5z+L+b7DpddDNagQWZ43h5DSiqmi+
	 4/7IrNXMdhlDkUUxiTwlzGd67jWUsQPt3WlZGCk0qFqhFR5W2PLZUWOoMbiyiFrOwT
	 nEP+a0wcnfRjH1+cge944VCjuUWHfQO7Fy47gn1EA0ooGi0YqBuUCPs7bwOgRzLgIG
	 PgTFSO3WofEUE1tWLATqmYgLdhyncxgyCsFhLAZlDNsyRztagv6Yg4wX1DRS6AXOMK
	 71+wQI4d6oDTZ/PSNwOGTL6eFYqqRR7p58pp7RDF09LgnLmE6OUVFvh30lA7SNRQYP
	 WAtULiiQptBdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CDAC46CD2;
	Thu, 25 Jan 2024 00:07:29 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ v3 0/8] Remove support for external plugins
Date: Thu, 25 Jan 2024 00:07:25 +0000
Message-Id: <20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD2msWUC/3XMSw6CMBSF4a2Qjq25XEq1jtyHcdBiCzfhlRYbD
 GHvFkYkxuE5yfcvLFhPNrBbtjBvIwUa+jSKU8aqRve15fRKmyGggDyX3HfczhMf23dNfeBGg7m
 WqIVCwxIavXU078HHM+2GwjT4z96P+fb+TcWcA5eoFDgDl0Kqe91pas/V0LEtFfHAUfxwTLxEI
 RRIB6VzR76u6xfgaueE6wAAAA==
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706141247; l=1630;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=YPAuJR/p/8YBl67ki2/Jzj4r23FKOVbW0WP58ypVgAA=;
 b=HNArrLqxiC3iZPqkNKtXD9jGm1G0gvmackOIqOhzPqx/Jh3BHX0d+th3YagonYzGTfx8PSuGC
 K1hCQIhfwJNCt8+4x0bUabDVqb2hGvAx7JNaJ9ljYlqYh47vbFhkMiQ
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello everyone,

Here's v3 fixing a small bug with the previous patches, which was
tripping the CI.

Link to the previous revision can be found below.

Thanks
Emil

- Link to v2: https://lore.kernel.org/r/20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com

---
Emil Velikov (8):
      configure, README: introduce --enable-external-plugins
      obexd: factor out external plugin support
      bluetoothd: remove external-dummy plugin
      bluetoothd: convert external sixaxis plugin to builtin
      bluetoothd: factor out external plugin support
      bluetoothd: don't export internal API
      bluetoothd: change plugin loading alike obexd
      android: export only (android) entrypoint from the modules

 Makefile.am              |  17 ++----
 Makefile.obexd           |   2 +
 Makefile.plugins         |   8 +--
 README                   |  13 +++++
 android/Makefile.am      |   3 +
 android/hal-audio.c      |   1 +
 android/hal-bluetooth.c  |   1 +
 android/hal-sco.c        |   1 +
 configure.ac             |  10 ++++
 obexd/src/obexd.h        |   2 +-
 obexd/src/plugin.c       |  93 +++++++++++++++++++++----------
 obexd/src/plugin.h       |   4 ++
 plugins/external-dummy.c |  28 ----------
 src/btd.h                |   2 +-
 src/plugin.c             | 140 +++++++++++++++++++++++++++++------------------
 src/plugin.h             |  16 ++++++
 16 files changed, 209 insertions(+), 132 deletions(-)
---
base-commit: a9d1f6f6a625607de6c3f5b7a40a3aac5f36c02b
change-id: 20240116-rm-ext-plugins-ba0b852a492b

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

