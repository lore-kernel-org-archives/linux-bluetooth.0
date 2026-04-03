Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CD2248B9
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 23:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775260358; cv=none; b=jtr4upVB8uTL1Gy2szDuJtXELshgdnY6lfG5rzkgirumfn4e3VQfdWFWgR1TWumyF1HSNoqD+zuIB5y3RtmA3DcHvyNfwqitxZGMMSM0ATMiFjxhEs0IpC+2t6lc8Aia/Hpw29Wz2oeTcMb9oKg97hDgMo48YDit4EO+pj0+Bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775260358; c=relaxed/simple;
	bh=Cx9ZsElXWoVYqRP6k4qJ12ABrGvn/TRCTcChv1TEl00=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Qk53pk0bbY0GiFBPKdFFObEBs02wL0RtnV34gHXyeDqIVRhIQZr554IvxDyjWd8sQsEZmKTSX5ObigdOFLCQNjzfKxAniNxqIhe4bO5v7xRByjMGV84TMqjf/6SNfImmQ1+RIqoOjufpkEncdtbM2ckMqSswZAA+S46iMl+GUI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JyLO3pEA; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JyLO3pEA"
Received: from github.com (hubbernetes-node-5de8ee5.ash1-iad.github.net [10.56.224.92])
	by smtp.github.com (Postfix) with ESMTPA id 5A2BB6C079D
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 16:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775260356;
	bh=yvkcDncR1v2LiacJ2BwCLh2iHJgKfvYUXwpGqVpH3yQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JyLO3pEAo5HtPdr0VOijI22VWIni5tVQjHivTcSqDJ8GwFfGraTd9XdqxKJl3Rp2O
	 Jz2wUR+ib1ilO4EIKFEuhSGL3oPrm9jnMz996cXVk6oG0cl6LaI3b0JZOGXUuAVENj
	 qf15MS7vGqbegymNjfZt0A8ccd+GHuOGOlBVj1zo=
Date: Fri, 03 Apr 2026 16:52:36 -0700
From: Harsh Sahu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077174/000000-bd528c@github.com>
Subject: [bluez/bluez] bd528c: device: warn on BR/EDR connection key mismatch
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

  Branch: refs/heads/1077174
  Home:   https://github.com/bluez/bluez
  Commit: bd528ce7c8274799b6f3cd012269bd3eaaa6c373
      https://github.com/bluez/bluez/commit/bd528ce7c8274799b6f3cd012269bd3eaaa6c373
  Author: lazy-pir8 <harshsahuxlr9@gmail.com>
  Date:   2026-04-03 (Fri, 03 Apr 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: warn on BR/EDR connection key mismatch

Log a clear message when a device fails to connect due to
Bluetooth BR/EDR keys changing (e.g., after pairing from
another system). Advises user to remove and re-pair the device.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
