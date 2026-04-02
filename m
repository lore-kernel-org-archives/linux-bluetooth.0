Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1D392C28;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122053; cv=none; b=NN/0QOGbWz7QrGZtjh5KqwNaS+utgAHt8M0LdxnEv6/Unt6XU0a/TddMaxC1sMGhpAz8HCe14weXN7sC6Y9DbaXKUhw+1Xw3BwwESIpHeTISBoIKlMpdBL9+UXprfX1zvU+U4vRkFwus0dc5UKZa2kfzN1Qj2Ua1VkKKOLkoXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122053; c=relaxed/simple;
	bh=1W1HDtzn9n+1yQmy7ovsK5sF11Ps6q3Yby16jMugPvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pykbfhktu2Q31WL8cw2hlQFDo+NGn0rIPHfzldoFXTacAw+gxoeonsPpEGJ24EbkIaqFs15ey5/q8WVpwB+LwU7OvSlAf5I5PtJ+SwD1gzdjv4OVe01JKXMsILX+ILC+dstB/tEENBDb4ZvxDexbQUc/rOPv6kuq7Mxm1IcScgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VleFYkYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VleFYkYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6175CC4AF09;
	Thu,  2 Apr 2026 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775122052;
	bh=1W1HDtzn9n+1yQmy7ovsK5sF11Ps6q3Yby16jMugPvs=;
	h=From:To:Cc:Subject:Date:From;
	b=VleFYkYS7okiD6adeGXReAZWN1iAE+Eua0AMrxcMdBAmZsuIGQ+ShzVPKB9KGzCak
	 5UYyOKdjfiN3KneAVEUWWQJ4H7W8MhNz20un+i6AsCLy3Fng/gs8OP3i5m7ADhls4T
	 DSjHwVoBWxTM6Yc9UCNoJV7T2bfDfVELJXpy14yNlKBTjY/s1pDf5um7owFXML/adB
	 nzd+mDoJx9sdYpbuAZ4ZLVYuCpo/8MwqL+fKZvUlvk3Org/V3qU0NH2P/qAh7SMrtM
	 nXTwp8Ne687jgnAhvZfrITIdocxeZsdwgcj8jWLwUzQPYWW/KxFxFJl9BWS6lpIpr0
	 PIAYZeI53hSHw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8EKo-00000009qUl-09eP;
	Thu, 02 Apr 2026 11:27:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/3] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Thu,  2 Apr 2026 11:27:01 +0200
Message-ID: <20260402092704.2346710-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a wakeup source leak and a (currently benign) OOB
wakeup interrupt devres lifetime issue.

Included is also a related cleanup.

Note that these are intended for 7.1 (e.g. as the fixes are not
critical) and apply on top of linux-next which has commit 2db5a8b68e31
("Bluetooth: btusb: refactor endpoint lookup").

Johan


Changes in v2:
 - fix wakeup source leak (new patch)
 - fix disconnect-while-suspended issue by making interrupt non-managed
 - amend devres lifetime fix commit message with a reference to changed
   devres behaviour
 - clean up error handling (new patch)


Johan Hovold (3):
  Bluetooth: btusb: fix wakeup source leak on probe failure
  Bluetooth: btusb: fix wakeup irq devres lifetime
  Bluetooth: btusb: clean up probe error handling

 drivers/bluetooth/btusb.c | 50 +++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 18 deletions(-)

-- 
2.52.0

