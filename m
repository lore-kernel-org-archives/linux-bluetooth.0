Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B52192E4
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 17:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755192717; cv=none; b=aiSYns58+KCwcE5cau1+mPNoMUBBaIXGkDjXAPWxZj2l/uaWKrYj4BY/stTy7vvpDD4iIhnFs5CinY7g32BAG4lCr9pn0+MlFS1H3d6l5/kjVxDMa5Hk1UeK7bK2ulj4ZM2TPsdI1ScM1NLQRH0JZQ4YqGJTVZJSUzuDOmrCKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755192717; c=relaxed/simple;
	bh=Lsf/MShHJN30V0suu3jKaW6fSUGSrvb2GRp6n2ENTLo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=J/q2nWQxxGNHIGJzlXxlWiq33joOHnGt83xRaJRw4zmqmeuWZUDzr2L6ZZc/1RPN4qHGGZ5UK8JT/N9rOEyxP7mB6T8ZMsmximXTkgWMaOhWHY3WG+aJQD10KPPCWNzxUYvyCHvlCgkWglC+j6OZ2X1X+Wtq78uqETZij3NFawA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X9BrIw0/; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X9BrIw0/"
Received: from github.com (hubbernetes-node-4448617.ash1-iad.github.net [10.56.164.49])
	by smtp.github.com (Postfix) with ESMTPA id 9319B140D5D
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 10:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755192715;
	bh=ZbazyY0Qlg5tCEXuUNVFSt/sVMq1UcEZmvLIGRO7yoM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X9BrIw0/QFj5pA292g1BGkOjFov6tldOCa2IAZUXltrLvqEsm6XoLaN2gbsPloTNq
	 cluc7+20TgWsWZbUesdTeBTiFY/H/+y6ycZ9KvhGvRZaAVfmoscp8cz3wb1mVSDO4A
	 IzHtkivMmxg1YxKjATkle+9SFb2/CkdC8B8BRmXU=
Date: Thu, 14 Aug 2025 10:31:55 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c8a82f-ce8216@github.com>
Subject: [bluez/bluez] ce8216: monitor: Print unacked frame when releasing
 them
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
  Commit: ce82168f9f708a61efaa2bac734997db01c9ffdb
      https://github.com/bluez/bluez/commit/ce82168f9f708a61efaa2bac734997db01c9ffdb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-14 (Thu, 14 Aug 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print unacked frame when releasing them

This attempts to print the frame number of frames considered unacked
(missing NOCP):

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 2304 Address: XX:XX:XX:XX:XX:XX
        Reason: Connection Terminated By Local Host (0x16)
        [0]#102132 unacked
        [1]#102137 unacked
        [2]#102139 unacked
        [3]#102141 unacked
        [4]#102143 unacked
        [5]#102145 unacked
        [6]#102147 unacked
        [7]#102150 unacked



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
