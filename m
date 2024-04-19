Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9AA10A03
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713557258; cv=none; b=F2bCmobg/80yS0gUPuFqeM21jZKsZUqG91jaFIH24jhJ3F1Is6jcZJf0/ziac1AmmVAAaYajx4aW7d7r9fD0pLbr32Fwg/v2/PN7vB6RidC+t3Um/fhbaDgv8GLEcYPLh3RO/lB8XGB4XaPYjPAe22T+ZpZt+doL/1PdApHnqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713557258; c=relaxed/simple;
	bh=xzs/DdOYm0zuw3lKSWIYWoopCbDluCQPUKdwSy0I+rY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cVSseqYku5oneSlI9ueMqr/MMB1iqMYqMeF1QheExAvLBhkiZUwYNAhKmnHXSnqeGTCnKaQA6ZuQXz8vOUDD7p4baaDKN/B63ukvEI8uGARmL99zTElBcqwCAmWxG9osOJOZvVSXMeC17nJrhHteI9ArrQjagEmi0d41HHwQgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gdv6dkk6; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gdv6dkk6"
Received: from github.com (hubbernetes-node-7c42e0d.ash1-iad.github.net [10.56.200.81])
	by smtp.github.com (Postfix) with ESMTPA id BFFB0340416
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 13:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713557255;
	bh=IVdpubNAYJyqgb4bxUQsf+DnTCSJr8VvMoHYIMEuzJg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gdv6dkk6jT3fURGEM/YODQf+k2L25xbMK3lhRaLjWlMQqTYe5Hg7W/C2Q6Gm29k+8
	 60h7gH4JW2EOkiIQdskFhFIBOX2eBxWzOV5xsPHPgsITGn3/oLN1Rvmbbku8dxovqz
	 S5UnifOiN98V8oAITQ6/xK/eLz6G5axpHTEfSfB0=
Date: Fri, 19 Apr 2024 13:07:35 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/89cb88-4dea3f@github.com>
Subject: [bluez/bluez] 4dea3f: client/advertising: Add flag to mark if data is
 valid
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
  Commit: 4dea3fb932f815b0b1be470cc0aaa213d82bf213
      https://github.com/bluez/bluez/commit/4dea3fb932f815b0b1be470cc0aaa213d82bf213
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-19 (Fri, 19 Apr 2024)

  Changed paths:
    M client/advertising.c

  Log Message:
  -----------
  client/advertising: Add flag to mark if data is valid

This allows the use of type 0x00 which otherwise could not be selected
since the property would not be exposed even though the data could be
set.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
