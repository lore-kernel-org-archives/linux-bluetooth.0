Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEF3C3797;
	Thu,  4 Jun 2026 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555147; cv=none; b=IVF0h4uTiJ5tfdZZy5Os9qX4Ht++v/vWUO2Oh10q3RG3I79yHvIwlFl1+Xhsbu3xnBWtXrkLyz5kT1bFVAS8/ObubFEC9x6iUscUL3XkgPe1xdZppnna+Bfnr2a2YenRR5k8/4qFm7D8PWRmUNcjW/eFXv56eRBRpRYgXtA+Mbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555147; c=relaxed/simple;
	bh=fmemyI1Qtwu08am2gPaqIGBWwkgC8uPWi2cpYsvFPqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaIBMc5Auyi30CrhUeZEJR5do0EWjXeKqUWPpuGRZ0nqGEVGd8CxfIfy0F9KFqnihzKY2LDSCWmTOwZ2GU/C4tTlfAqAmiN/VyZSFV1Ba/PkiQFwmjoteZQ8M5NDjVCt+w28PU+MxgDVOVC6x6DaH9i20TaH8GIV8xaKjgYaY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUSdBQ0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUSdBQ0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80C41F00899;
	Thu,  4 Jun 2026 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780555146;
	bh=0auGndFS8FxKBn4TiyDtKuXIx2bjLsvNPram7BE3J6Q=;
	h=From:To:Cc:Subject:Date;
	b=IUSdBQ0HD2Jo4wKQlqP4+upX1TkrbNMF6Oa3mw3hoggr7rJA9Pzsd0dy/XXX7ttaf
	 3wSceDKAn0bwvuU6jAjOJpu/YjI+lU/AW/CIYhjPZ4tiNUXKnm0MGquSWnHJbCopbm
	 SlnaYfsSWzOTMNY3gGA8fMe+XW1zYGmlpBslLsJLGYGmfNSNXGZnSLm7qT+xNEDm55
	 vz6V/PQmFz9jhO2lUR4By04OFmrdt0wEFMQE7ve0/H3JyYJoSaA0Y/ZG9GXBzhz9/o
	 jv3nCzEWfgFw0aofz17CfFpRHF2mUwJC56ssI6FEjhdJmTluCXv+ExSmwzzck13NGa
	 ob70EHUy+sdjw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wV1jL-0000000AtAl-2qjP;
	Thu, 04 Jun 2026 08:39:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v4 0/5] Bluetooth: btusb: fix wakeup irq devres lifetime
Date: Thu,  4 Jun 2026 08:37:35 +0200
Message-ID: <20260604063740.2595260-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Johan


Changes in v4:
 - fix unused label warning with !CONFIG_PM

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

 drivers/bluetooth/btusb.c | 74 ++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 20 deletions(-)

-- 
2.53.0

