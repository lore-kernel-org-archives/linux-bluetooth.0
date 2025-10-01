Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020B258EDF
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346641; cv=none; b=rlMJULLqryUTKsa2H2b0IN1gHd4ddL1nTEQiIbkgx1oNZXTGMQL170mJotu8qfdXNNhLuboO76S7KGwhz3xoQ/gMHUWcHLRZAU4y/GmO0NyQrPZa4AFy4hX0JmqgrvoqB+H3YB5KiGqVz94wZoqv4Qh9ueF0+OvawEajnkh73Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346641; c=relaxed/simple;
	bh=zDlXcK6DqqvOMVSECg7jPS0NjAf3Smgd2H9j8yssHUU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RKQhMFyu3joB4m4HmZjFq9WZIC/FnqQwJUOa/QBEho0e1NXXGYk9Qegy6EHgeyF9LNDgA40Hcv+werI1QrzSoVD9ymfL3zX061pYI0iNy9f6O/deA8alJQyJ4/M72pzfk0Q7n9eCovreAm/1x0HWfxrb32yL6FLqCjshR0/kGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Kh3+XXqm; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Kh3+XXqm"
Received: from github.com (hubbernetes-node-407bfdf.ash1-iad.github.net [10.56.225.23])
	by smtp.github.com (Postfix) with ESMTPA id AAD8092106D
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 12:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759346639;
	bh=XqUGl1IrTcE0EZGsDx2K33JkW0OtPx/nzyIwMQ6fqLU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Kh3+XXqmoW1h/QlhyfhTPjbzw4RLwCdWBRDOoolZNgz5qBgzpJQlcPsI+MtjMyGVH
	 YqBbHOW3CqzYtd/2E7NXSsWe/RWY0AuQBis3XFbnOR2saflyOTkQmcmugoOje7LQos
	 2mEd0l7OomaPl2ld+DWSZlh7iC3emaUY1TBBBz5w=
Date: Wed, 01 Oct 2025 12:23:59 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007799/000000-a9f981@github.com>
Subject: [bluez/bluez] 93fb4c: shared/bass: Fix permissions not requiring
 encryption
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

  Branch: refs/heads/1007799
  Home:   https://github.com/bluez/bluez
  Commit: 93fb4c0f7e7617d0a6081d25accc935c54f9faea
      https://github.com/bluez/bluez/commit/93fb4c0f7e7617d0a6081d25accc935c54f9faea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Fix permissions not requiring encryption

Both Broadcast Audio Scan Control Point and Broadcast Receive State do
require encryption:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/24670-BASS-html5/out/en/index-en.html#UUID-dd95da9a-6ac0-3f45-7e34-13fa9e04d41c


  Commit: a9f981ae30d04a0395eb650e0571339d92d0b0cd
      https://github.com/bluez/bluez/commit/a9f981ae30d04a0395eb650e0571339d92d0b0cd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-01 (Wed, 01 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Set QoS.Encryption if QoS.BCode is set

QoS.Encryption must be set in order for the daemon to interpret the
QoS.BCode as valid.


Compare: https://github.com/bluez/bluez/compare/93fb4c0f7e76%5E...a9f981ae30d0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
