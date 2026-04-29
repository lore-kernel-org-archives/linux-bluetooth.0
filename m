Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21B2848BA
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470706; cv=none; b=YAuAI5OCH/DpWnu0yo69IdX3ykfjVNYEv6AYGfknxtiAZ4I2S/O9HjaNXY0Nb4fb1I4EDmg5+5PIcCt26WZ53gkwnHqphK0Eq1H69FAfk7QT5UUg/oHv47eFvCCk6Xli3cSe8VCXWxix5m0PRzobsgj8P6yNtXCHchZ2Rm0c4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470706; c=relaxed/simple;
	bh=40MRBFWxF5P4KJg/3K+fDWcSHpIIgF3laWKPiJk0f5k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=S8O9avpvvpOwb0GNXqI12gKpJfBF+e6udK0lNuUKtcdzGG1e7VAtICZy4SAxofr0o0eyubNLEW/Q+FFXmqOCaidWW0sSBqnIoVjLgDWRtsTDepZGzci1ybkVc15xm48XCXNjV9ycC82AGk0olAR4dV4wDfg9VDmmj+nURaMSZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SHQTKU9j; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SHQTKU9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777470703;
	bh=04lDm/gv/KODeN0Dk5mZrbKtP+RGj2zibNsDpxD0HFI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SHQTKU9jlYbVuFOg2Mqrajsjyd6wpqUc6yjB4eC+uql13GWi0MN4BkRfn9WgAsXqw
	 CFQGIW/9cONQ8HEHdSGtv21myiBdADPgw9UuTOXbnA8AIoe4q2ACtwBohn7J4Hq5VL
	 4omZHsW7qT/Rmhkr7deLljDHw/203WWE8Z6rNjUg=
Received: from github.com (hubbernetes-node-c1cdbc0.ash1-iad.github.net [10.56.166.30])
	by smtp.github.com (Postfix) with ESMTPA id 256A0361199
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 06:51:43 -0700 (PDT)
Date: Wed, 29 Apr 2026 06:51:43 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b3729e-278f34@github.com>
Subject: [bluez/bluez] 3171f7: monitor: Add decoding support for Public
 Broadcast...
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
  Commit: 3171f7fd3685874a429556d23ef49f8504fa8c3c
      https://github.com/bluez/bluez/commit/3171f7fd3685874a429556d23ef49f8504fa8c3c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-28 (Tue, 28 Apr 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding support for Public Broadcast Announcements

This adds support for decoding Public Broadcast Announcements (PBP).


  Commit: 5dc2d7e3334e4564f192f1b8c76217e114013066
      https://github.com/bluez/bluez/commit/5dc2d7e3334e4564f192f1b8c76217e114013066
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client: add public-broadcast advertising command


  Commit: 278f3439c45ffcb1309f9fe961be1b120bdde459
      https://github.com/bluez/bluez/commit/278f3439c45ffcb1309f9fe961be1b120bdde459
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M client/advertising.c

  Log Message:
  -----------
  client: make advertise.name use public broadcast name


Compare: https://github.com/bluez/bluez/compare/b3729e26cc42...278f3439c45f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
