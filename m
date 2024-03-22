Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF5556B8F
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123783; cv=none; b=NlmIM1AIvWxfqGFMRgd5QrvmWwwgF9boKTSWCpPey7g5L2F2vkgMeOnUDs6YDc8eTRNxcZTNg2FCaN66oV0Aarlh4IGE9GG5wb8pyOWuzQQYMSpSX+6vMExvNGhSj+m5ScbrsV1qevQWpbfKN+lfxpKrdkJIxXuIAXHIDwt+DuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123783; c=relaxed/simple;
	bh=BV8ewJPjTxMnbh3DCQe18kb1NW++4HQ9fd7Cxm8gmWQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LYVk2ycqE9/TrTUfF6BlSavRkkypLW9oA1Dzn5m0zfs5zp+jA1ghG4MfPGHG8duDhMYlZMjMQTR1KitjDo3BplB/3hT7zLWunv026JFXL4GZHV+607p9d5ob9iUlX2Lk63xqVa9KwWf64+i7MYgA6NHfjlRUHNHKI10cHb32ptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fa7AMoeT; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fa7AMoeT"
Received: from github.com (hubbernetes-node-410ec37.ac4-iad.github.net [10.52.146.34])
	by smtp.github.com (Postfix) with ESMTPA id F2B1670140B
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Mar 2024 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1711123780;
	bh=6HEK9UWmbg23McZc9pEIYSkkpF+AYIZjULaHsCHWOqk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fa7AMoeTwJ6N9AMGsbw9OmCb5LdZzkTLAmW+Me3/3dkdRtaEDYY2d1uj8gV/GVibE
	 qs/P0gnHb9Eo2rMiI7YxxKXcBZeb43NQUJNRF8qOmVEfGCEXAi3gM0M7VBMZpD0htE
	 P21dD4pmBtm8V7sl63lOjrSFmg1+gDslVF+XwiGM=
Date: Fri, 22 Mar 2024 09:09:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/925092-87cabb@github.com>
Subject: [bluez/bluez] 87cabb: bap: Fix not setting adapter address type
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
  Commit: 87cabb26793554ad9f67f0b23ecf19869b20dd17
      https://github.com/bluez/bluez/commit/87cabb26793554ad9f67f0b23ecf19869b20dd17
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-22 (Fri, 22 Mar 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not setting adapter address type

This fixes not setting adapter address type when listening/connecting
ISO sockets which prevents them working when adapter comes unconfigured
which then gets assigned a random address.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
