Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3462749ED
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775903; cv=none; b=W1ckPd/t3pBIhs8PVFLPN6DZG7IjW1z5ILKKRVGmg1TSo0U08PYDihCWXGKPbpggBFJvem78Vvv20Xed6U6Jw9z6e8HjCc+5d7e5SEZviV7t8/KiXRnl10oCOeE4x42UfmAvLHu5BhtKAbyzmQ7SM0PK5jbF+ZYty2iZldz/pzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775903; c=relaxed/simple;
	bh=BB6Zo9Ch6b6qrvLJcbZ84/9go69rlEbnAxDnI8Luqhw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SK0evo/CwQX6Y8qUDd3nb5SmYrAVTeCDDghmgED8pniSpHFiIOoK9s5vwUEG5L9XLp0V7v308YRoEhDdmU+zhhN2rDG1S2OD9JXL/dKAgpfmATsxJtKhcG/zj8yqubKcy9K7HdSCBCrABaXSkmxrVC42qrz2IcpoRsLMbXjwKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqtI6oNT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqtI6oNT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A613DC4CEF7;
	Wed,  7 Jan 2026 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767775902;
	bh=BB6Zo9Ch6b6qrvLJcbZ84/9go69rlEbnAxDnI8Luqhw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DqtI6oNTDRi/48qcf+B2dWEvvdPB6qRfpjd2QF3TCjxNMCTVhvmFnhQPA5i6BZGAU
	 lH3mv0pdiVBCRkL5nf6HNJgdqWN6DJluXt+stTY2ebuhUFew2UW/xNiJyYHdHcUinm
	 Sqsa7qeZo6R0138gQ9xdhh8UZRHhvWqFWfkb/SkDcduIboP9z6FoVuWp0yoa2mIhHw
	 ECm4+b1nDwKWl92fiFqTlX6sff0SxfV/uliAbVvEhwLKPVNtzZUJbwQD+Yf7pTuTgm
	 Ar3kFNGvc5G3I9X7TKOYvuGITzRl/gy4bS12LSC1TlCwEKZ+RoMgFNIhG5ygiIWQ/r
	 MrTSoWBIqNPBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9467ECF6C0F;
	Wed,  7 Jan 2026 08:51:42 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Subject: [PATCH BlueZ bluez 0/2] Optimize the PA sync flow
Date: Wed, 07 Jan 2026 16:51:35 +0800
Message-Id: <20260107-mgmt_ext_adv_sid-v1-0-6832b40813fd@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJceXmkC/x2MywqAIBAAfyX2nGAe7PErEWK51UIv1CSK/r2lw
 xzmMPNAQE8YoMke8Jgo0L6xFHkGw2y3CQU5dlBSaVnIUqzTGg1e0ViXTCAntLajsrJmKuDs8Dj
 S9S9b6JcTb+je9wMZ+sigaQAAAA==
To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767775901; l=665;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=BB6Zo9Ch6b6qrvLJcbZ84/9go69rlEbnAxDnI8Luqhw=;
 b=/yyOb0GJXmRIAuYi5KOedfouW/u2aWtGWSXZ6YUA7mFX87U46dVMeLnENWR8PZ2D2TMBgPaZL
 9PmvEWftCioB+l8rPqLzVFV5yu20zM/k5221DOq7FITT0MYzuODCcfK
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
Yang Li (2):
      adapter: add MGMT_EV_EXT_ADV_SID_CHANGED mgmt event
      bap: add timer to wait for SID update before PA sync

 lib/bluetooth/mgmt.h |  7 +++++++
 profiles/audio/bap.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/adapter.c        | 39 +++++++++++++++++++++++++++++++++++++--
 src/device.c         | 22 ++++++++++++++++++++++
 src/device.h         |  2 ++
 5 files changed, 114 insertions(+), 3 deletions(-)
---
base-commit: b35b6befb12c91c1802d09208ea5a00f0b0bc614
change-id: 20260107-mgmt_ext_adv_sid-66af2a092a08

Best regards,
-- 
Yang Li <yang.li@amlogic.com>


