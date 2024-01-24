Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AE27CF05
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112484; cv=none; b=fG9VYmQtiTsMd3m11FADqPfS2u1yY16IBr9gvhHgv+B46/SwUWYkU/sCZX9Oa7RCWJEQhWmMMxX8UbjxFwtThu1113cPjRw6o16uY8flTxGry4s6FN0sOVuLoxwjinjMK/j6L7wKDxNUD5zSYwry1AkxvlYg5AYZe3ygNjGJugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112484; c=relaxed/simple;
	bh=R3HFcVBoJszTJuASrnzBJqv6UFv6WlatH6rNlebl+0Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ec7bSaltDnD+NAHqy9oP88CdA6BiXctrpyxkyd1bIE+MkdAAvqm6Wc+ANdRP2PK04vl7gsJHgTwbHZT6X0ZvRkdg76PRrVW/dvVgm1kGTdUI6jS0nMGFrzixv8KTlTC4yMDB7cCEynZIfyJqb1P1sSJMXWwuEcC8H3Ofv0/I1do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfNCeV7i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfNCeV7i"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 231BBC43394;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706112484;
	bh=R3HFcVBoJszTJuASrnzBJqv6UFv6WlatH6rNlebl+0Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SfNCeV7ikjVnI68nbXUDD5BlfIbkfLyi5ey2QFvInrbNYshKX/dDlGC5EYlf6PJRd
	 vx1ILu9Yp9phm6k/frAVi7EGyKAGqqcbfPNFdsAg+1qoG95YbenYLeDofsDc/qYmxr
	 NFTx/DZItJGS9Wo5dd+kbK7J7eJMF6nkBtxahoosO6XVAFm6dT3gJwv6e52AcYElpe
	 TWlO83vVP4Qdn8KK5/UDAwigknDJbadin6ibDixI/VQdqE9TgVT5HNG/jujipZvCaj
	 SSwK4VY90ONO/QfFXc0zVaZIjFlY4eOhcouPXWAlfdlzgRYV2asrwFs3Z+R28l2i8S
	 CKcq6umPade5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E10AC47DDC;
	Wed, 24 Jan 2024 16:08:04 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ v2 0/8] Remove support for external plugins
Date: Wed, 24 Jan 2024 16:07:56 +0000
Message-Id: <20240124-rm-ext-plugins-v2-0-5244906f05ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANw1sWUC/3XMQQ6CMBCF4auQWTumHREtK+9hWLRYYBKgpMUGQ
 3p3K3uX/0vet0Ownm2AutjB28iB3ZyDTgW0g557i/zKDSSoFFJW6Ce024rL+O55Dmi0MPcr6VK
 RgXxavO14O8Bnk3vgsDr/Ofwof+tfKkoUWJFSojPidqnUo580j+fWTdCklL6bZ16lrAAAAA==
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706112482; l=1947;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=R3HFcVBoJszTJuASrnzBJqv6UFv6WlatH6rNlebl+0Y=;
 b=+sNzy8QaySNon+vpbiLaXjePBK3GYevtafRdkPxnZ6ZklOjHpWz3++HIfJ7dDv4Ca4wWwwKpc
 BJHZTBqI6wWDTh+4e53BB5TTaMwlzUIYWPK390ZWMVidwIFP6VtF3GF
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Greetings one and all,

This is v2 of my earlier series.

In v1 support for external plugins was completely removed, while now it
is preserved but compiled out by default.

An extra --enable-external-plugins is introduced alongside a note in the
README and a one-off runtime warning. The latter two pointing people
towards integrating their plugin into the upstream BlueZ repo.

For more details, see the link below to the original v1 cover letter and
patches.

Thanks
Emil

- Link to v1: https://lore.kernel.org/r/20240116-rm-ext-plugins-v1-0-62990fb07369@gmail.com

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
 src/plugin.c             | 139 +++++++++++++++++++++++++++++------------------
 src/plugin.h             |  16 ++++++
 16 files changed, 208 insertions(+), 132 deletions(-)
---
base-commit: a9d1f6f6a625607de6c3f5b7a40a3aac5f36c02b
change-id: 20240116-rm-ext-plugins-ba0b852a492b

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

