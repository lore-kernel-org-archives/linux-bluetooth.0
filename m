Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE1402B8D
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 17:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817150; cv=none; b=eoD/S5Xzvhm8iDebPTdTMmJf4r21OP9n8vKQXGrLZQmNvhJG87fwhfee1f2VSBpaHxvexcC04LrOA7fNIAtjM5wrUnkacGOX+q1LHgAHZ52xTiaQM5uFJzZMo/OhDc+reFw64HN13BnWkCbWbsVevoQxV7zIlNYhLhJBLPwP3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817150; c=relaxed/simple;
	bh=Uuhzb3StbAPHmAYDWPerwxkJH3poLLiNnlotjxwVL/4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eQq1wbPk9ZiVX9EdqcF4SDeCQIbLdGQHA7dnSXKX9BQi1dKLwGZt4QJRW+QYoMM1mMVaKRDm4TBH8Px4E8rHYAHvA0hyqBQ+Huv+7Gw5Ovy6XmOkmKxE+jC5yOZWKXkB49boxBe35sf3jC+znH5TdJmOR/aR+jksyt00DmVNNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DlaKE086; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DlaKE086"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779817147;
	bh=lNXwVIsDWTwNA62wYvRfIVO24scT8kmfoQqC8Ii3y/Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DlaKE086AuheQpcSRhg2/chVTaVOLWPONLWTYvR/UXDz09hV6G7wLn1gcDdSk3LCi
	 Gm9UJmxO4fLhRzilpRLpg97VnVadzXz1/k+b/m1mJxpaJqDp8mh05Sa0MbiVChPiXX
	 lCVeInm7lgSFBuaTUwmqwzxkUe8HdpwJ1UUb7sbc=
Received: from github.com (hubbernetes-node-76a8112.ac4-iad.github.net [10.52.130.39])
	by smtp.github.com (Postfix) with ESMTPA id 77A91941130
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 May 2026 10:39:07 -0700 (PDT)
Date: Tue, 26 May 2026 10:39:07 -0700
From: apusaka <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f818e9-b49316@github.com>
Subject: [bluez/bluez] b8d42b: test-mesh-crypto: Don't attempt to run test if
 AF_...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: b8d42b282b3c17f1f4838039fa23ba24f07db723
      https://github.com/bluez/bluez/commit/b8d42b282b3c17f1f4838039fa23ba24f07db723
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-22 (Fri, 22 May 2026)

  Changed paths:
    M unit/test-mesh-crypto.c

  Log Message:
  -----------
  test-mesh-crypto: Don't attempt to run test if AF_ALG is not available

This make use of mesh_crypto_check_avail to check if AF_ALG is available
and if not just bail out which is similar to how test-crypto handles
when bt_crypto_new returns NULL.


  Commit: b493164ffbff277bdb540f6d779ba4b4645b3679
      https://github.com/bluez/bluez/commit/b493164ffbff277bdb540f6d779ba4b4645b3679
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2026-05-26 (Tue, 26 May 2026)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for HCI Event Encryption Change v2

> HCI Event: Encryption Change v2 (0x59) plen 5
        Status: Success (0x00)
        Handle: 256 (BR-ACL) Address: 00:11:22:34:56:78
        Encryption: Enabled with E0 (0x01)
        Key size: 16


Compare: https://github.com/bluez/bluez/compare/f818e9d0c9df...b493164ffbff

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
