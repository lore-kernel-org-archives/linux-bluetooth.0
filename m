Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCD421CFF6
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771010938; cv=none; b=OhztdJoYwYHf8rymcqZu0MtIkes+Yd85vnMVprzOmczjDCG7CN4s5aRBNCa5vpMVb1NMXKeY6Vo+cvUCvShiuA5UNcYx/nqRLSdh5QIVpMXxQ3G2SOLdedUVNRsKT+ILGkWKh8mkSGyf1N2Z05jw37YUK9MTzsBjLvUhOupMf2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771010938; c=relaxed/simple;
	bh=CYoU4CRspByFuhV55FZaRHsiISuia8SSmJqqHOz18B4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EDv8uj+1M1oh6cVQs47eObI+SkIfGfxoDD/JZdAbnPajycpRn536gyswE9KZnVVGoszsNQKfh8yo0mScqspCM40DEe4OFk6i4BWNirmNgnYYgbLVVjO/ClfUpYODMYzkqHTtcty9qgRZXLpt0npqIZM6Pf4ILjKzwpc4HEY0GgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ILct8iAB; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ILct8iAB"
Received: from github.com (hubbernetes-node-c8a482f.ash1-iad.github.net [10.56.154.23])
	by smtp.github.com (Postfix) with ESMTPA id 18FE61402CE
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 11:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771010936;
	bh=tReNatImvdyTxsFxtSd0XwN3yg9xnTLb+XvjkiLzmX8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ILct8iABlF6bT9HofoVfkndsDSs2LBXk5Zx66abxBwk3EEEP174oBWf38IxZwE48D
	 Qn1u+EpKPWLWXdI71N5O/qnyyfYVaU2XkHEZILN74BJEmXkN/wIUFT8vkjc9/6f8jt
	 WO/+D5qVDIAi/9LinBB7zrz2O25AMXKbPLYsK00w=
Date: Fri, 13 Feb 2026 11:28:56 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-dualshock4-random-inputs/066e59-81adcd@github.com>
Subject: [bluez/bluez] 81adcd: input: Fix trailing whitespace in continuation
 fra...
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

  Branch: refs/heads/copilot/fix-dualshock4-random-inputs
  Home:   https://github.com/bluez/bluez
  Commit: 81adcdbd44a94a00807e6f8e5d9ffce0a8884e16
      https://github.com/bluez/bluez/commit/81adcdbd44a94a00807e6f8e5d9ffce0a8884e16
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Fix trailing whitespace in continuation frame handling

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
