Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC8368D41
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787482548; cv=none; b=aSjskzx8k2GpK+51Is8Tg+WLIhHt2gWOaRy51P0NHHdcEjKuYM/vfapO4DgDhlSVJZwcH5ek96NP7MyA8RKGyW16V72W7WfecwWzZ/GSW34WI+xZtrkSrCOQ0FuF+YygSsjNF6Rs6zt6acNt44JnCmZ5HfcOmOog7za/VXvoHdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787482548; c=relaxed/simple;
	bh=iZy4gkFbCnzaPl69FutQoCV1/QpGc+KQ0aF3pV+a7Y8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G/kyto/abaPFfi2NaP3HHRic29nTwdnVFNv54aO+FRd7uGaQMiiKYuToYs2dhv7xNW2vynSS7pFsninAGT39qBsc3MyB4p58OGC/tZBeexa5REkdKOCSb2JkSPfY+C/OXURNCHcVZoJFsFreWirA7L0tF3SWtCEv1+Xh/zoruiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kyVCDebK; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kyVCDebK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787482546;
	bh=c1B2Y8RaJuHlM7cj+CXVWZE0Ng7LTGrCpOLcZWDOf/Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kyVCDebK0vRPOaVkhuwz03wqDisuEIe9Ij23WxSeUX4w0gAcCs6BMQZzr68sHREFH
	 Xoi2HxSaYSXtPeHzCRX2JwvXtlO+XiIUfwKYXZYXmdRad+g3jceE1avPg3mYn6iVdj
	 kgyOCqok9zqJ7YXWqXiUkKAtdCfdwDQ0PXPCYH24=
Received: from github.com (hubbernetes-node-6773839.va3-iad.github.net [10.48.68.61])
	by smtp.github.com (Postfix) with ESMTPA id B4B0428108B
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 03:55:46 -0700 (PDT)
Date: Sun, 23 Aug 2026 03:55:46 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1150371/000000-eaf6e8@github.com>
Subject: [bluez/bluez] eaf6e8: tools/iso-tester: fix GIOChannel refcounting
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

  Branch: refs/heads/1150371
  Home:   https://github.com/bluez/bluez
  Commit: eaf6e80eec2855302412b9a069350c61add50b1a
      https://github.com/bluez/bluez/commit/eaf6e80eec2855302412b9a069350c61add50b1a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-23 (Sun, 23 Aug 2026)

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
correctly again.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
