Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BF382F23
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577428; cv=none; b=HMmyfTsBF7sAO3Nh0wS6f8/6K5qBTtOewHa9OK2EXpz9DkVoZ9WH/SyWM2eVXIicy3qH0DMJX4uYfx/XqrPiTGN4NaKtiqQc3MORHbeCDpIfEZCOLPZkXAoijgtG+tJzbrhpQx3qiBhFPp7jGlQO6teSddIMFBtqz/zpO544SJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577428; c=relaxed/simple;
	bh=Xs7Vg2TJOtIYoesiMT3TI0q9DH6pnOuD2KrPB9V3OR8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fouFwJlpPp+xE8F4Hl7uTWIHa0ekvPPwmGqaMmwVsGIrYxzjyJs+RtNixS78B40qyLqWGtQCMcskuebcpc0PHDEc4pY2hQNs+oNYRWJzLKOtdU729W/1r4AECzAo422PrZWoBUWG1I0K+qs/ayRcqef9tVAtOp2HFmVxmFnM17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WOz0A7wh; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WOz0A7wh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784577426;
	bh=/2T1k6RA3qxhPweXmReEivv/PACCLk+p8/WOLpED59k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WOz0A7whDeXd/FoUPgJWWe05RY+aLNK4xkRxSSNGAZDx93iDiTZVtn8+9CzviyuIE
	 dJ36VqldUqfCSzNufhxtYcsDUkEGKPEdibvFtd9wB7scja2432kJm82Cj5DZ1pQ8WA
	 SbndAvGb/KNMULteSu7srMGrKkqyz8OcGvEGA5IM=
Received: from github.com (hubbernetes-node-20636c1.ac4-iad.github.net [10.52.220.72])
	by smtp.github.com (Postfix) with ESMTPA id 1ED3D9411D4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:57:06 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:57:06 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1131086/000000-75f75e@github.com>
Subject: [bluez/bluez] 75f75e: tools/iso-tester: fix GIOChannel refcounting
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

  Branch: refs/heads/1131086
  Home:   https://github.com/bluez/bluez
  Commit: 75f75eed2d13f5f981d0c24cffaf11fa494c2f3c
      https://github.com/bluez/bluez/commit/75f75eed2d13f5f981d0c24cffaf11fa494c2f3c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  tools/iso-tester: fix GIOChannel refcounting

iso_defer_accept_* consume the reference passed in.  g_io_add_watch gets
a reference.

Fix the refcounting accordingly. Also clear data->io_queue immediately
after the test, so the sockets get closed.

Not leaking references makes "ISO Connect Close - Success" to work
correctly again, exposing a KASAN crash in current kernel.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
