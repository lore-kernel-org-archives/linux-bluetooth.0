Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1A24AA41B
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369431; cv=none; b=Grh0Ph0zcU3nxUqztE1SjWpO0laq4gNT2HlJmKXT+xLmGM79K7H5YISb1sA0WJH3eVL8poWl9lCu22Lec0ICUkKbVLFYUNKD96EAp1K251PAqf1lmnJdP3HR6egQucabbXTmNVdD6nCKElsGpetNz+oENaptY2mKg5gAF9c4oCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369431; c=relaxed/simple;
	bh=MB6acAKdmNIq6J0pifQL8b8GXlIfhoVniShM7owAwBg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BY0Vwd5LgTSQ4GbgDK1Dt9eImLFLZeGCYaRkAgou9gh31LYG5fsWVN5A5Zm7fwEJ7nwu+CedKSzsrkzmPjRR1D3DtRTu2Ea75BAxadRgQXsIAYxaWjy4X1/ku896bsK4ZWyjRvoi4ccegb/fNnX+CKYbHcD1hpHHTTc1EdDEaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Vj1HBx3x; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Vj1HBx3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788369429;
	bh=SL8LaFvsmtQ/TpS6uPXwxvGbQbYcPhxskhQly3bkwJQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Vj1HBx3xcnmN2363mE9NGbR/G5O7YRef1P4IKGSo4V+rFklv0ceVr3AWLRwhFMxvm
	 jIjRHWv3D2jDA2kJv8pw9F5+lOBh+3/n5LHyuMk0+Wt1Cf0qiVpSDpD3TdBHZN0pGO
	 XXslASWOMn2/ahnjhxWsWeNhmLtHtj8SHobDp01g=
Received: from github.com (hubbernetes-node-f2fb6c0.ash1-iad.github.net [10.56.180.16])
	by smtp.github.com (Postfix) with ESMTPA id 6484A521597
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 10:17:09 -0700 (PDT)
Date: Wed, 02 Sep 2026 10:17:09 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1156272/000000-bff1d0@github.com>
Subject: [bluez/bluez] e75266: monitor: Check valid range of CE Length
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

  Branch: refs/heads/1156272
  Home:   https://github.com/bluez/bluez
  Commit: e7526660e2f1c79dadf765029fc1f89791929911
      https://github.com/bluez/bluez/commit/e7526660e2f1c79dadf765029fc1f89791929911
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Check valid range of CE Length

The connection event length recommended in requests by a Peripheral has
a valid range of 0x0001 to 0x7CFF (Time = N * 125 us, Time Range:
0.125 ms to 3.999875 s), so print values outside of it as reserved
instead of decoding them as a time.


  Commit: bff1d0b0312a7d946e316f1be69b5f62dd0312e1
      https://github.com/bluez/bluez/commit/bff1d0b0312a7d946e316f1be69b5f62dd0312e1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-02 (Wed, 02 Sep 2026)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator/btdev: Check valid range of CE Length

The connection event length recommended in requests by a Peripheral has
a valid range of 0x0001 to 0x7CFF (Time = N * 125 us, Time Range:
0.125 ms to 3.999875 s), so reject LE Connection Rate Request and LE Set
Default Rate Parameters with values outside of it.


Compare: https://github.com/bluez/bluez/compare/e7526660e2f1%5E...bff1d0b0312a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
