Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9217CF22
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113209; cv=none; b=XuxwGCKrrV1tGHg/yav7xEjjegzMiu1gc93ib+2cP8NiDiDgfu4w5xxNtLxBaKyfHD5ociLmJ2Pzixy3l2C2kyHh5rqa0eC2RPzyjrp9tR/csojjXCc3JwLKQ1Fh0TBiGh26oQIWvYlagtAboERSCPVXwqKRw6Gkx7lcmFUsGRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113209; c=relaxed/simple;
	bh=5WUSuXRnSfJ9iHmo+afEdRZ3dZUoO2iqL708lpDPlpw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qfoMzLIlx4fTQu2psYyxlQVO/N3EJwEFVmmId516HdKj9sJvhHypYFUCneN2Y88h8lL16BhTMzRW99DGZ/XD72/D0AZRVx6AbAfSc1f50NVU8RJydwpokctqZpLvSVue374Pr7dimfD9KI2N6yxsyfot5ANROYkplC/Dbnz+ZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/DAL+AN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/DAL+AN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60A95C433C7;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113209;
	bh=5WUSuXRnSfJ9iHmo+afEdRZ3dZUoO2iqL708lpDPlpw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=D/DAL+ANbUaHa7+Kiko5auEa5UsdB74K+LFhqEby8yzlCiPfMide7lkefRUpPoz46
	 kSGMWmEVQp/hpqH1E/mJ+zz4UkFwsXBeBQxrGyD28B+2WfhNeJ3J6L9fYLH487/JVG
	 f33o5Ae3tpeWx9rLOST7xNcB+qwbEQeDtYQ3Q7mukm15yheIP9vNtj7rgCaoN5Oump
	 f/eIMyHdEkNTDayE3raYXBw0FDo5bZM7ZyHrCnpjpMcObHq/OFBezj+TANEilgXfH0
	 U+brkH8T8k3HAmco1OCmNlgmbtRk8K+p0UyyPbBCiU44/1qM+ZmruT9iif236/ho/o
	 ZDcpmPSm6maPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8DAC47DDC;
	Wed, 24 Jan 2024 16:20:09 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ v2 0/6] Autotools papercuts, linker GC, symlink
 dbus-org.bluez.obex.service
Date: Wed, 24 Jan 2024 16:20:05 +0000
Message-Id: <20240124-autofoo-v2-0-a210f20aa2f7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALU4sWUC/2XMyw6CMBCF4Vchs7amnUCNrnwPwqJXmEQY0yLRk
 L67la3L/+Tk2yGHRCHDrdkhhY0y8VIDTw24ySxjEORrA0pspVJamNfKkVl4izGgu8hrp6C+nyl
 Eeh9SP9SeKK+cPge8qd/6b2xKSKFRR2271nqp7+Ns6HF2PMNQSvkCsebg6Z4AAAA=
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706113208; l=1641;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=5WUSuXRnSfJ9iHmo+afEdRZ3dZUoO2iqL708lpDPlpw=;
 b=EfFd90IVDc5vXag36Q3nz+MwbvB0XUBlQyWExPaI3ICA3bl3PDMESgWueFhHPvvGxhuQeMLSM
 rtcGVj477biC2pBtSNr0vjkpsm8HBTJmYZIMj40iRdpF8yGJofoAu8p
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello everyone,

Here is v2 of the autotoo papercuts.

Changes in this revision:
 - dropped already merged patches - thanks o/
 - drop "build: remove dummy {conf,state}{dir,_DATA}" patch

The latter patch was causing some unexpected and unrelated issues with
the CI. At a glance I couldn't quite track down why, it removes some
dead code and reproducing the CI is a time sink ... So I caved in :-P

Link to the original v1 cover letter and patches can be found below.

Thanks
Emil

- Link to v1: https://lore.kernel.org/r/20240116-autofoo-v1-0-626f6b54bd06@gmail.com

---
Emil Velikov (6):
      build: remove unused variable builtin_nodist
      build: remove .service files from DEPENDENCIES lists
      build: remove explicit DEPENDENCIES handling
      build: manage .service.in files via configure.ac
      build: enable gc/dead code removal
      build: install dbus-org.bluez.obex.service symlink

 Makefile.am                       | 25 +++----------------------
 Makefile.mesh                     |  7 +------
 Makefile.obexd                    | 10 ++++++++--
 Makefile.tools                    |  6 ------
 acinclude.m4                      |  2 ++
 configure.ac                      | 11 ++++++++++-
 mesh/bluetooth-mesh.service.in    |  2 +-
 obexd/src/obex.service.in         |  2 +-
 src/bluetooth.service.in          |  2 +-
 tools/bluetooth-logger.service.in |  2 +-
 10 files changed, 28 insertions(+), 41 deletions(-)
---
base-commit: a9d1f6f6a625607de6c3f5b7a40a3aac5f36c02b
change-id: 20240116-autofoo-db2fe2c70951

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

