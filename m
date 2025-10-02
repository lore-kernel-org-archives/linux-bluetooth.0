Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109AF24DD11
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421820; cv=none; b=j6azFMY8DZUJ++fonKHDLGmFj3WxBmkrZ1hxC2Cd46HpmPvfuKVGh2oImqlWdMg1Bfc/OdBsu45n9ClX0gMbTisq+ZHwZiY9rWi0BOgUSxLJ+f/0TS/XOe9vDb6Z4ocTvAkBgWpQXAv6aSEhh3P7pQMyYd6yyuKGxi8N+xulIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421820; c=relaxed/simple;
	bh=eL3xzYZaj017pQyrNVq784v7CYR63ZOeNEY6XmFtSXU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=h4t9aDaPkOuyUW+tqz+2ixO8hiczR5vBGifOmmz+3IZOoQz3j6370p0GamRtPzOnVACDwlsLHc1evhSyx84tOYQOHthnjjgUFudOlkFCDl5xzCu0kzSn/vUMidqWaL8APrcrSjwqLPpj5Lu3YjqN5eULArt/TbuG/qAT8Hibyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ENSbl4fD; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ENSbl4fD"
Received: from github.com (hubbernetes-node-516eb8c.ash1-iad.github.net [10.56.174.24])
	by smtp.github.com (Postfix) with ESMTPA id 2DFDB600300
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Oct 2025 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759421818;
	bh=Ek8jWJC74ndDKEUkz2AECL7V0pHNMCmEvKpAaAxsp1k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ENSbl4fDgbtuG07B1Vlp06KPA4ullaJEe48p8JDLN2sjVL5d05BAejzegFPWhYZ+C
	 I6z/PdJXU10xW4y6Pab1wQetTH9zgKCY4NL/iOLT9F97E8+m1nx245hxL0FCyZJa+y
	 3S8XSSAgZAXg27JXcDZlvbcd/ZHkMEb4MW7FXf0k=
Date: Thu, 02 Oct 2025 09:16:58 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1008056/000000-f272cc@github.com>
Subject: [bluez/bluez] 079973: shared/bass: Fix permissions not requiring
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

  Branch: refs/heads/1008056
  Home:   https://github.com/bluez/bluez
  Commit: 0799730e63f64dd806ac483be87271145eb85dfd
      https://github.com/bluez/bluez/commit/0799730e63f64dd806ac483be87271145eb85dfd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-02 (Thu, 02 Oct 2025)

  Changed paths:
    M src/shared/bass.c
    M unit/test-bass.c

  Log Message:
  -----------
  shared/bass: Fix permissions not requiring encryption

Both Broadcast Audio Scan Control Point and Broadcast Receive State do
require encryption:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/24670-BASS-html5/out/en/index-en.html#UUID-dd95da9a-6ac0-3f45-7e34-13fa9e04d41c


  Commit: f272ccf09b8fded83dad440f29ea55a4fc40ba9f
      https://github.com/bluez/bluez/commit/f272ccf09b8fded83dad440f29ea55a4fc40ba9f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-02 (Thu, 02 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Set QoS.Encryption if QoS.BCode is set

QoS.Encryption must be set in order for the daemon to interpret the
QoS.BCode as valid.


Compare: https://github.com/bluez/bluez/compare/0799730e63f6%5E...f272ccf09b8f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
