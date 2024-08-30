Received: from o7.sgmail.github.com (o7.sgmail.github.com [167.89.101.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD02199FB7
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725034194; cv=none; b=rXEHYOUrN3x1CHofErwaF6fKp5ZFT+4Gfy+zsNYcXksfZPpHWBBK8Qs+Q5MflcsOpJ7S72sMX3Lp5zMvqmBu7SyuUc+m7JCL4I0UaWRZpRvRBEQY80IPus6C2Ae4RY4oqe5Tjz//LcmlJJ21Ci+ub9M4VhiXNNjzsQ5Qf/0cDss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725034194; c=relaxed/simple;
	bh=xrGlaQavIT8RtGSfrXITq95H1RKyUmuocQ75Pzw6VCA=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=AvS97R4sMV1VENYIKr3qsXpEcIcsVAYW2whDDmu8+6UZat2Jt3ZTB9xciggZsyrEXfvP87171dCY5t1HzixENBMjrZ/fqcPDoiWdp1jY7V+HkPt5zhEWkZtRsYd3MS+OI+87MuNInS0+9PNuz5rkP/ogtfOkTdx3/qQmwr9+BYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=qmIswlJ7; arc=none smtp.client-ip=167.89.101.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="qmIswlJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:from:subject:to;
	s=smtpapi; bh=CVYLeA3B2aZ0qw784rft4HzIuzIRbN5obiuZZ+iJvAQ=;
	b=qmIswlJ7/pGQj3JlInFE6n4BK+XO3WRLaYkKwUcq6hUyk/g7es/WzzV8YqmNJPySTPBV
	ubKTDzHXamM8hyZVX09SG2mbQQDIoObZ0y7CKSWn63giY4UiB6V8/jZlr09H5+SlLEcWmK
	gg1NEAAbL2kyHCt71jd+oIxM8oqdU1z3E=
Received: by recvd-canary-5b6884b69d-vpgnq with SMTP id recvd-canary-5b6884b69d-vpgnq-1-66D1EECE-A4
	2024-08-30 16:09:50.998670527 +0000 UTC m=+755061.284401400
Received: from out-25.smtp.github.com (unknown)
	by geopod-ismtpd-28 (SG)
	with ESMTP id Rg7X273sTq2NOWaOHPoDag
	for <linux-bluetooth@vger.kernel.org>;
	Fri, 30 Aug 2024 16:09:50.954 +0000 (UTC)
Received: from github.com (hubbernetes-node-1227519.ash1-iad.github.net [10.56.212.78])
	by smtp.github.com (Postfix) with ESMTPA id 47B851411A6
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2024 09:09:44 -0700 (PDT)
Date: Fri, 30 Aug 2024 16:09:51 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/2dadde-394675@github.com>
Subject: [bluez/bluez] 394675: device: Fix Pair method not setting
 auto_connect
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIArP3mazTo04A?=
 =?us-ascii?Q?6lKN0d6dizJr2=2FHOOzeTV8njri4L7Rxczmyc3N+?=
 =?us-ascii?Q?uKzhd6Ujd12gyE24WK=2FEvqKPedeCKa2HyfKlW5c?=
 =?us-ascii?Q?QDh5JrxypzP9T6e=2FkYLKid4PROzaq3jqyDnbNjB?=
 =?us-ascii?Q?Qnw16OhZ2QePqN4O+yKapJHcdcOqMUHV=2Fl1FnNT?=
 =?us-ascii?Q?CoKwmcIJ+jBnRWlRJC8I=2F2Ne=2FQ=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 39467578207889fd015775cbe81a3db9dd26abea
      https://github.com/bluez/bluez/commit/39467578207889fd015775cbe81a3db9dd26abea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-29 (Thu, 29 Aug 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix Pair method not setting auto_connect

Due to commit 507ba12483c3 ("profile: Remove probe_on_discover")
disable_auto_connect may be set when a service is probed but the device
is still temporary which is normally the result of service being
discovered over advertisement rather than connection.

To fix this the Device.Pair method needs to check if the
disable_auto_connect flag has been set and then reset it set auto_connect
which is similar to how Device.Connect works.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
