Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A230FF36
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295159; cv=none; b=NLn8Bo89L0ANeSt8P51xvz2EDaVUeRsslenYq1SbOhVpLXAeXaBq4N11SvJjIBAenJ6bWmE4IzyZbBQmDm/GZH1IyVnSUY/qCK17PbUlEJvrRE4elY5LNIePoY0BUnFl6idPHbapLsscXFetKFpXfNp0vU4yzXV6AyiMYm0/VD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295159; c=relaxed/simple;
	bh=ocqMUSSrdjJSdxLHL1Q+mvreEXt+EXRov2QJLub/fk8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UetB6lVoTnWj7DU2uznvUl8IeHV1j7fKRf3HYsjWrAy7erJgWPOfyJjelRID5GeEALbXgsRu9qf8PSZW8STVvrn2pArQlTFTH98CSbUip+APh0GNM0g8g+uNNNP3le/EfHcaPF2uQaXTSW8X9wwe7bX+dqR2q+02mNXw0x6Ev/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h5/jZw0g; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h5/jZw0g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786295157;
	bh=tXrbiNowB9zpHDkyHAXZPQcOWx3JfCDXmnNk7HN7moQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h5/jZw0gOIXIIZh4SargHvVhWxvB8+ovFgtlhl9mUrz1sdS4aTdUdmmW2NLvz1ia/
	 4KTiHl2rZ2GzaEXAjRF9ARr/FDrq1tK7MXV/bvU0mhT/ZDeei0IZHURWpJs+yKfQaj
	 J4JW0Toxr1tT8L6vNEb5KKvErckhyfock49mLNok=
Received: from github.com (hubbernetes-node-d498343.ac4-iad.github.net [10.52.146.37])
	by smtp.github.com (Postfix) with ESMTPA id 19364940C2E
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 10:05:57 -0700 (PDT)
Date: Sun, 09 Aug 2026 10:05:57 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142951/000000-91f1be@github.com>
Subject: [bluez/bluez] 91f1be: tools/l2cap-tester: add tests changing
 BT_SECURITY...
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

  Branch: refs/heads/1142951
  Home:   https://github.com/bluez/bluez
  Commit: 91f1bede78c284171d7d383b357f13599ceb6d80
      https://github.com/bluez/bluez/commit/91f1bede78c284171d7d383b357f13599ceb6d80
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-09 (Sun, 09 Aug 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: add tests changing BT_SECURITY after connecting

Add tests that change BT_SECURITY value after connection established:

L2CAP BR/EDR Client PIN Code Change Sec - Success
L2CAP LE Client Change Sec - Success
L2CAP LE ATT Client Change Sec  - Success
L2CAP LE EATT Client Change Sec - Success



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
