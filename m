Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688BD3A875E;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497450; cv=none; b=hHccn85Ztye38HjPSpqUjdSX6XdDrH18pdrS3E4lDRx6WjasQMDCi6VP9imjiFKCvrLPtY/miTvB6kn3vohoq332gJIRenrqzSfUprVi/2ak0IqZxx/Fyq3/sHBGYhQNUnkEOYVHJWpKF7TYBOhAq9ars6d1U0spNpRRgKVjX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497450; c=relaxed/simple;
	bh=vOG1j+RBZzZDmPRW4Ip7Ohh/+zr4eA1sH7Jzdx+DBdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQ3aO/pcI2no80lpbDbt7YpmlHlL3AidtRAn5isMxO4iWcJXFcuG7+nVezT4Bdjbnz/h8R+mVFV3HkHhLd/3PpovTcQ/z00TJUbWBVtDpz1Lud/ES6Y612+L4La9f8ErED7GQgmYD/io0BIb83Gn3B6ehLayFZXj4cpFHKw80AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYrgsKzz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYrgsKzz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E901F00898;
	Wed,  3 Jun 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497449;
	bh=FAnKXQD3bvCVFIfyYorBgm/CkR5JT97inhbW0TVjPEw=;
	h=From:To:Cc:Subject:Date;
	b=OYrgsKzzt1H6DxRRT1DJUd98M04qK4+QCkDkXmtfMM8WZzqjtuSTNdng7BESnaUfY
	 W21rlFjVDjPQolQiDLsK/ZeYQyMtHTQoIO7sBRimDDQPWy2F6mvhSyBukqtUzOPGCp
	 gpcTZqsTnb5FgrUAYXlPp5G4gULHaZmI/ouCrM6I6C6RVxE1nPWwoJ9+VrMVivo8lT
	 ecHpmoAy6Gr15v7cWXY4ty8DFvbkgfwIsa6PeNgAtpyxHS58P3u1jQ/O78+G0s7Nj/
	 vCeoVCNvdDo4bOtHL4FiLqxoUY6X0hPAVeD4fMVH/ZOBa3v+/xCbq4RnvPzOGr8Khb
	 5n7HH9k2By1PA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wUmik-0000000AYAw-2y0R;
	Wed, 03 Jun 2026 16:37:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 RESEND 0/5] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Wed,  3 Jun 2026 16:36:38 +0200
Message-ID: <20260603143643.2514595-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ This one was posted two months ago and appears to have been archived
  in patchwork so resending (with Paul's RB added to patch 1/5). ]

This series fixes a couple of use-after-free issues and a wakeup source
leak on probe failure and a (currently benign) OOB wakeup interrupt
devres lifetime issue.

Included is also a related cleanup.

Johan


Changes in v3:
 - fix use-after-free on registration failure (new patch)
 - fix use-after-free on marvell probe failure (new patch)

Changes in v2:
 - fix wakeup source leak (new patch)
 - fix disconnect-while-suspended issue by making interrupt non-managed
 - amend devres lifetime fix commit message with a reference to changed
   devres behaviour
 - clean up error handling (new patch)


Johan Hovold (5):
  Bluetooth: btusb: fix use-after-free on registration failure
  Bluetooth: btusb: fix use-after-free on marvell probe failure
  Bluetooth: btusb: fix wakeup source leak on probe failure
  Bluetooth: btusb: fix wakeup irq devres lifetime
  Bluetooth: btusb: clean up probe error handling

 drivers/bluetooth/btusb.c | 61 +++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 18 deletions(-)

-- 
2.53.0

