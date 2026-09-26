Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642FE283CB5
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790383122; cv=none; b=lJ6PtpDQsJuEN+lGD7vHxnWNPuAPjsqzzaGL2b86h8wP59FXcSFWU+B3+2V0SFoNpo5XVCocOfwx8GaegxK5IpRc5Ww3Hk4grLAAK9YnHmIg7ZYXr6jcZqEOssR1bTJomm9+roj9gvFRRo69ln+eCfSqKXm7i/WuQ/lFQ8BwlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790383122; c=relaxed/simple;
	bh=CdeMfPk/HJZIS91M/9EsdipNJlW0cuLP61Z+Hm0HGWs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VlrW3jVmOJaYrUyvbVNW+81RKxzdQQQqfGt4JvOIiU6BR4aL6UBkNenlpfKwWJviw2mSlmgUbQ0yRbE1ItmMtF6VwM/pDqQOkLuR9ZBFgtROmZRGcyEaOtvapbTwc3ctude2ubzm7dlQSJPJmg6HRWrb12oNoihiJsw/9u86Kew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jyM/uE3o; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jyM/uE3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790383120;
	bh=dDTPIPYksuYkVk+fFHzV9265nbarqWiiVcoaeNAEfG8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jyM/uE3oF+zea9ld6qKjy2WSABFNHrxDR9csRzqquljnr3Y10mJXaBEtIja6/KuYh
	 cl9nhAHxLemEXGG6mkO4WuBcE49rgdLV1WMANA+sIqf5EJP87R/nvVTpl4SC1y5njn
	 M2GBqGUT9/dph0Rev+ihAo3UmW+2HUkD6tDFJkt4=
Received: from github.com (hubbernetes-node-07b3504.ac4-iad.github.net [10.52.166.13])
	by smtp.github.com (Postfix) with ESMTPA id 517399407BB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 17:38:40 -0700 (PDT)
Date: Fri, 25 Sep 2026 17:38:40 -0700
From: "ooonea.eth" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1174116/000000-269053@github.com>
Subject: [bluez/bluez] 269053: unit: Test HoG report map reads after reconnect
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

  Branch: refs/heads/1174116
  Home:   https://github.com/bluez/bluez
  Commit: 269053fbdfa96b589a087c2a0455c1cbdb66448d
      https://github.com/bluez/bluez/commit/269053fbdfa96b589a087c2a0455c1cbdb66448d
  Author: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>
  Date:   2026-09-26 (Sat, 26 Sep 2026)

  Changed paths:
    M Makefile.am
    M unit/test-hog.c

  Log Message:
  -----------
  unit: Test HoG report map reads after reconnect

Exercise reconnect after an ATT error and after cancelling a pending
Report Map read. Require a fresh read and validate the resulting
UHID_CREATE2 descriptor on a simulated transport.

Stub Bluetooth address lookup for the Unix socketpair fixture. Both
cases fail without resetting report_map_id on detach.

Assisted-by: OpenAI Codex:gpt-6



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
