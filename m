Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0829AAFD
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360400; cv=none; b=aQsj2/5padmgDA3qcul0JO8pmN5U0V99joEbxXliDFyu7S5U5wMLJYBcetYH3BsIqdiP7p4kOTEkOI6uU7jXuxuDzomlnPPfFkQXy4HhRoj6u4LCKoipA/mjA+bxPSnhLgA8CRddlJ3JmAFMqWhgcwhaPXZyt3614dGu9vLWRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360400; c=relaxed/simple;
	bh=xJHPFRQTsz1u5mh9NO9AtjlIa72X/gzgE31geA4tnIQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lhEc1OAFzuLmUW+Nriq3icC7MMYB5pnSC9oHVjt31K5J9if0vpl6y2QJ9pyXw0DHM4l9Htn0//dX0P2BHVl3DDCRLoAgkK921x4XQ1vI6NPL1npN9jBEGkxFY2LG9FLpEasF7Pm72/LNWPLUu4u/KHuYkHnJRZzHL0p6Dxwx6n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dLPuun4Y; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dLPuun4Y"
Received: from github.com (hubbernetes-node-eb34e4d.ac4-iad.github.net [10.52.170.40])
	by smtp.github.com (Postfix) with ESMTPA id 1450E203FB
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758360398;
	bh=rl6emzYljV9VVOC+O7Ff8UXObUonoG0zaWgm37cH02U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dLPuun4YcQAFQqapCCnj6swttnybiZg0kAmToOTaZ08OX0p8Ssrb/qNjKyB7M2ig0
	 7or3nOAf7JuIP5ojjMIxlB3NQdUq02fwZFRZQ2d3CGDGZF4Zk01w0UHbYjWQMKJWDz
	 ja/pV6wq41JtGhIChu9cxaJBo+zRrtEK4a1pJ5Yw=
Date: Sat, 20 Sep 2025 02:26:38 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1004473/000000-deb76e@github.com>
Subject: [bluez/bluez] deb76e: doc: iso: add BT_PKT_SEQNUM documentation
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

  Branch: refs/heads/1004473
  Home:   https://github.com/bluez/bluez
  Commit: deb76e3ebea82fa1b070bd15e00854f2a4087d7c
      https://github.com/bluez/bluez/commit/deb76e3ebea82fa1b070bd15e00854f2a4087d7c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-09-20 (Sat, 20 Sep 2025)

  Changed paths:
    M doc/iso.rst

  Log Message:
  -----------
  doc: iso: add BT_PKT_SEQNUM documentation



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
