Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253B22E415
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539457; cv=none; b=Do0IQxRnRL/KbGedu85SDl7TpLQ7ZQGqUAXgDllJcHxa/d3RspkxhcZvRgEOTcNDxN67XwfnHRs3M2V4ZKj1R0NeGFw+dNlAvrbAulO+T14ZmlemSf4aXdvQKdltEdOn87yRzwcBOkcLybsfU8AcA+s6GJmlAeDkTm6KUK/aPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539457; c=relaxed/simple;
	bh=yeoFlTl9a/bqgLVxGb60Ke+4mr2ZgTSxsYBZYPeh9ZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cuhhTLWqmPwVz3uW00fpkz05Ss/ldxKUBX41X9ZYO5OHFM+yfeJXVtB+JortehP8ajN6RSljxmwh7qJic9YGS6OmcSjWf0Jtz1/YfgUPLV5MA1KnpFYLi/ErUV+2ZAoWT6jEvGejiKvw5gAStcZdRWV6oJCP2iGvEwwRVSswDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4XF/KvH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4XF/KvH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFEF5C433F1;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706539456;
	bh=yeoFlTl9a/bqgLVxGb60Ke+4mr2ZgTSxsYBZYPeh9ZQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=G4XF/KvHG7CrczCQ6KFmSgTTcyVH7xakoqoRrWV7M6nWl1sblNJJc+meErE862dbG
	 k2mx+QC/mmndPFfCALrRXM0ovongQkf+iPaWg/R896jsqgTk+CdY1eHGVf+VRaOUiN
	 WVtfkckSTO/S15Vb0K2ernNE1fWH/r0z3Tmu7ucuOSdXONtaUTef8H+9jpWndzHWnZ
	 Mu0krHPDlu4Da67kmWqUWoYx7V+hlWYC2RH0tJKXaYFBAYrTmrVdnNlHZiv7B8hfWy
	 PvdTfz0+V6N9lJ7FKkOVGa6X9BNbdFaOR1XVqH0EaOv5uob7Z53SvncMPHzUtciJDc
	 k6VIGW8KdC9RQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8615C47DDB;
	Mon, 29 Jan 2024 14:44:16 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ v4 0/8] Remove support for external plugins
Date: Mon, 29 Jan 2024 14:44:14 +0000
Message-Id: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL65t2UC/3XMSw6DIBSF4a0YxqW5XAFLR91H04EoKImvgDU2x
 r0XHZmaDs9Jvn8hwXhnArknC/FmcsH1XRz8kpCizrvKUFfGTRCQA2OS+paaeaRD865cF6jOQd8
 E5lyhJhEN3lg378HnK+7ahbH3n70/se39m5oYBSpRKbAaslSqR9XmrrkWfUu21IQHjvzEMXKBn
 CuQFoS1vzw9cnHiaeQl48xmtwy0lke+rusXo3zlNCoBAAA=
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706539455; l=1855;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=yeoFlTl9a/bqgLVxGb60Ke+4mr2ZgTSxsYBZYPeh9ZQ=;
 b=sPY/5c0BPa6VBrBUEtPGbDN87T622o2uippFPQTBrX4qFE2GvRhFWK1VMpoY1hJLwFoWrYR16
 +d6kX37R/sSDj1U/rNHpPEcPfnH2RCiGkKExQnrOTkkV2CTa7XOUpae
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello everyone,

With v4 we have moved from pre-processor to compilation checking for the
external plugins support.

Namely, as we build without one the dead-code elimination will discard
all the relevant code. Ultimately this means we compile check both paths
in order to catch mistakes. Thanks to Luiz for the suggestion.

Link to the previous revision can be found below.

Thanks
Emil

- Link to v3: https://lore.kernel.org/r/20240125-rm-ext-plugins-v3-0-d141f7870bb6@gmail.com

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
 Makefile.plugins         |   8 ++-
 README                   |  13 +++++
 android/Makefile.am      |   3 ++
 android/hal-audio.c      |   1 +
 android/hal-bluetooth.c  |   1 +
 android/hal-sco.c        |   1 +
 configure.ac             |  10 ++++
 obexd/src/obexd.h        |   2 +-
 obexd/src/plugin.c       |  89 ++++++++++++++++++++-----------
 obexd/src/plugin.h       |   4 ++
 plugins/external-dummy.c |  28 ----------
 src/btd.h                |   2 +-
 src/plugin.c             | 135 ++++++++++++++++++++++++++++-------------------
 src/plugin.h             |   4 ++
 16 files changed, 188 insertions(+), 132 deletions(-)
---
base-commit: 0de32f67f685b95c35a5c2f1206081af89bd88b6
change-id: 20240116-rm-ext-plugins-ba0b852a492b

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

