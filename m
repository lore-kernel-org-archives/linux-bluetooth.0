Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1586A3BED22;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144989; cv=none; b=jQc+M9dSx41sDuV1MjLZpmnqNMYiVpwM2exj2YG8SEtxaJilUTLL70U+b2sD+IOIeHu3QOvkml95ql+eikopmmSneuxbVMRCzs1Wn/55/phOPMb8UERN+bweHFA7Rps6L6cd/4uJ/23MUO5q/9IXIxvD6r8WlzVqifdB+lJDUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144989; c=relaxed/simple;
	bh=zRrCddcNzJLAf8VfrxR8aHlkgemGvAyPe/EF8k2Iqi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f4lU+70q6Xnyc0JjcEGQIGyeO0l/SsMLEZrV0ZdwJR/9ZQwkDgPJu33jURbvlYyrnAWkg9G9N7wjDomAowJYPo9eLulxe6MT2qtw8CGQQeZvSVREn32OMSUoc5uOCM1TMnWodx8qbaIvYHmH1fDwLyF5Ga9RBoa7WIlC8UNABG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB8vPspe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB8vPspe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C4DC19424;
	Thu,  2 Apr 2026 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775144988;
	bh=zRrCddcNzJLAf8VfrxR8aHlkgemGvAyPe/EF8k2Iqi4=;
	h=From:To:Cc:Subject:Date:From;
	b=dB8vPspejcFIF0t/3i3Wm1OA7aF/HrV2j0BjJQn1tYCTqLg9OUcLJcEPgXJFcoxH+
	 IHIadGAo1aZTy94oEcNJNx5KAwz0JDVgzy4ZWzoz9UV8OkAEjR06uREC5sxloy45Wl
	 /B8MFfBUFycPavFZ/5IYDmeJ+P25gIwWwcNZrOJ+aWdHjlGFABIyqGbWs9UrISARGZ
	 hanexFjRJgNCj8NMbyrUmS58LvvkAEbvyKoHCh4FsZp8S7QWZG44w1nGjP88OCtM5a
	 PNqxb4nZ5AWrSLeOOUY2TXRDFNnqZGUVEQbkyiJ+5EN/mcvQZhUMadmoHhVxMLRwgo
	 soPGQq1T15EGQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8KIk-0000000ALvM-1zQj;
	Thu, 02 Apr 2026 17:49:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 0/5] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Thu,  2 Apr 2026 17:48:05 +0200
Message-ID: <20260402154810.2467291-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a couple of use-after-free issues and a wakeup source
leak on probe failure and a (currently benign) OOB wakeup interrupt
devres lifetime issue.

Included is also a related cleanup.

Note that these are intended for 7.1 (e.g. as the fixes are not
critical) and apply on top of linux-next which has commit 2db5a8b68e31
("Bluetooth: btusb: refactor endpoint lookup").

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
2.52.0

