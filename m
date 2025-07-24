Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBC275B15
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753389670; cv=none; b=YTOAf3ZGB8lrnKDPWPFJh0LGnza52sPqOqU+fLhqlf0qg/P4t6Kwr/Vpb8tQqQvq0CwtMUr30bhts4a7mneeJ1rtytlXNU3teJur7icAPdeJuGRn0wYlHLnKoSZs+mv4KekWtocG5ZJpEjdtOjGDWebMb1sxBFSjn83t8S2AtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753389670; c=relaxed/simple;
	bh=IoZf8OLFILez/1/L/4xOrFUDmU+gvUDYfobhMTUUZ8c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OIMiha6a85K28XEy+x8BHoqLVoTJNuXoZfi3lYoAb2O07X6wSzkFGZiC2DDv/owKFOpZZlkWmP5YHirjT6RbdhXYUp3/ZFLg7KUdjEwKizo5iS+zvFyWgsNy8Q2bZPlLDhyTvjL4QTliTkAkqP/+zrYvQhzlCFopmjtGBnqM/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WuBCIpwe; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WuBCIpwe"
Received: from github.com (hubbernetes-node-8958b40.va3-iad.github.net [10.48.12.92])
	by smtp.github.com (Postfix) with ESMTPA id 7EB008C08D7
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Jul 2025 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753389668;
	bh=PWk4qd4ixKHzm1LRBC9Lr6TdH1hlRvfohZdmwE/dRm4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WuBCIpweN0LrbDMnCAmkBs1+JbB8df4DNsXQBV8ofGs0F9k48yfwppdZIRgE8X7N3
	 fNfDkMR34kGfTUyljqjdrHmgAN3szNpOgZF/K0rmJGSfzLivVa3Zn1lzLHWPeYkIkO
	 AH/tXIff8vQZXWdxktgLvMrJpzTcWrCLyArSUJVQ=
Date: Thu, 24 Jul 2025 13:41:08 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/985699/000000-03b766@github.com>
Subject: [bluez/bluez] 33b973: btdev: Add le_big on BT_HCI_CMD_LE_CREATE_BIG
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

  Branch: refs/heads/985699
  Home:   https://github.com/bluez/bluez
  Commit: 33b97357d8bfbdbd982ad3cc90e71f01dbcac19d
      https://github.com/bluez/bluez/commit/33b97357d8bfbdbd982ad3cc90e71f01dbcac19d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-24 (Thu, 24 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Add le_big on BT_HCI_CMD_LE_CREATE_BIG

When handling BT_HCI_CMD_LE_CREATE_BIG create a struct le_big to
represent it otherwise the likes of BT_HCI_CMD_LE_TERM_BIG will not be
able to detect a BIG was created.


  Commit: b938a26daea5ae7bc03de66d25a2ad9779b14505
      https://github.com/bluez/bluez/commit/b938a26daea5ae7bc03de66d25a2ad9779b14505
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-24 (Thu, 24 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix handling of BT_HCI_CMD_LE_TERM_BIG

BT_HCI_CMD_LE_TERM_BIG shall cleanup the BIS connections and if there
are remote connected then they shall be notified with
BT_HCI_EVT_LE_BIG_SYNC_LOST so they can proceed to cleanup as well.


  Commit: 03b7663083baf65588577e7cfa8e11807e1824c4
      https://github.com/bluez/bluez/commit/03b7663083baf65588577e7cfa8e11807e1824c4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-24 (Thu, 24 Jul 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix handling of getpeername

getpeername can either return an error set in the errno or the
returned size can be invalid but in that case errno is not set so
printing it would generate bogus message.


Compare: https://github.com/bluez/bluez/compare/33b97357d8bf%5E...03b7663083ba

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
