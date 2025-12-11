Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAFD30F948
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476898; cv=none; b=ZA3q+1Xv9e7vVws3dIEWkHC03vmHuPJR4AmkJ3Bl2kTN1WJxdV53P4LiOaMHbC9080+1due51btVFbUiRviEjVYtPHmoKA9OpBiGyAlRtdGFDj0Luwn3FYKwYkfaD640eqXjdt2lnEZYnDO6vN2reFw/qW5kUt+Z9TuSwtBJkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476898; c=relaxed/simple;
	bh=F7dQ5EPVCiDb0uS40vJYdC1avhfy+Wez9MbP6rPc+lk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=seUiH9q0KTb2gCa+PN+Xs1XUgQG8lIKpRnvz1JJkW7UZmOnxaB3u52JcViYDBW5RTLXqf/gc1GjBSHj1fzlF83o3eTdmtLXtXR1V8UCBK2L8f48Jx/Rf/0NbHwAdvZMQyyLnDB7uUbWysypgztT9GRk5dGivbQUik1avFtypRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XPILJWS9; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XPILJWS9"
Received: from github.com (hubbernetes-node-25de501.ash1-iad.github.net [10.56.201.111])
	by smtp.github.com (Postfix) with ESMTPA id F020292134F
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765476896;
	bh=5DBMFau6NB5uRL0sFTwmXPSKvjtI6nNNM9VuNjJYxog=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XPILJWS94gvJCbt4GFvTRaJOinOkX1gro52YBeZZ7iOVDlHfXL+m2XMWC7w19g2w9
	 UpOBJh8eUcDYh1Zw3SjjYrxVLGtZK8lhrwEUnJO2zyC08bAHATHlvQ+M/p6ojLH99L
	 K3Wv77fad+fw+gXId52yZRQN6+fell+KxR6F/34o=
Date: Thu, 11 Dec 2025 10:14:55 -0800
From: michael kong <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e83c6c-72757c@github.com>
Subject: [bluez/bluez] 72757c: shared/lc3: Fix frame len in set 44_1
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
  Commit: 72757cd096f78a9fa2a6f5aa610f83c02a04ce05
      https://github.com/bluez/bluez/commit/72757cd096f78a9fa2a6f5aa610f83c02a04ce05
  Author: michael_kong <kx960506@163.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M src/shared/lc3.h
    M unit/test-bap.c

  Log Message:
  -----------
  shared/lc3: Fix frame len in set 44_1

The frame len in set 44_1 shoule be 97 not 98.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
