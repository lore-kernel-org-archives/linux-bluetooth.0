Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BD13A41F
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781474; cv=none; b=R0affE7tZ4bP09LQvdozV7Bt9g0uZSm/LcEZxOrc2EIENIlzNEnNK7jdzW7wWBj8veqaZwG7WkoN0V/2Bn36hjMyArTtrLXTf5UliiScKU7NSHW4lHVeWimp5D9yRl3s3hY+PAZngt0cB8uBwYM6yeJwKpQydnWoTa5LKZ3Y7mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781474; c=relaxed/simple;
	bh=Fg4elSG0+0G8/XXmj3cDgLlbV9Rq7XvLWjm9VMHsuMs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UkE4h7Gcp10tO0FDy0djMDMxtG6pOwKKFRRjBWc9teT0Ln0qbPLkSK3Na65fRuoQFx63PX2O6QZ9ZZFwtay3GFX/6d0o1nYzuBzjXt9pkNjhrJb/nNmJ6cz8EBlHeRMB9hfgJ2o/kYdSAPDtbfHQfNNy49jGRO11O9ZTXHDnj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HcQ7vKRh; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HcQ7vKRh"
Received: from github.com (hubbernetes-node-00720a3.ash1-iad.github.net [10.56.191.29])
	by smtp.github.com (Postfix) with ESMTPA id 5F3399211C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755781472;
	bh=mu2/I/IQxpgTxGtx+tzfL1+f+VPZvLe/d+2sLIRDaRk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HcQ7vKRhDIZfWZj9+X/bcDlu+4EHWX2yIGqopm/5hTnJrcp0iwc8YHZlt2WmcIVbA
	 sbNaLdgzjyJ1I8VjNge9Vwj0Y19ELGkf+OwRbFKH0I47cfXd8bCnv78lB7jHNmWvLP
	 TY7yKVqJwPzpdWp11Im695vdg3vZni2lM/0C29C4=
Date: Thu, 21 Aug 2025 06:04:32 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994029/000000-2b5b44@github.com>
Subject: [bluez/bluez] 83fd24: sixaxis: Fix official DualShock 4 controllers
 not ...
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

  Branch: refs/heads/994029
  Home:   https://github.com/bluez/bluez
  Commit: 83fd243a298a80158dfd28fd69a90b3bb7851f24
      https://github.com/bluez/bluez/commit/83fd243a298a80158dfd28fd69a90b3bb7851f24
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M profiles/input/sixaxis.h

  Log Message:
  -----------
  sixaxis: Fix official DualShock 4 controllers not being handled

The devices changed names, and those do not match the expected name in
our list. Ignore the "Vendor" portion of the device name before matching
it.

This is most likely the result of official DS4 controllers now being
handled by the hid-playstation driver rather than the
community-supported hid-sony.

This fixes DS4 controllers not initiating cable pairing when turned on.


  Commit: 2b5b44966443174951112e208fcdae5880e6547d
      https://github.com/bluez/bluez/commit/2b5b44966443174951112e208fcdae5880e6547d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-08-21 (Thu, 21 Aug 2025)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: Initiate pairing for all cable pairing devices

Fix the cable pairing not being triggered on DualShock 4 controllers.

Note that this still requires an authorisation when connecting through
Bluetooth the first time as we're not exchanging linkkeys. Sixaxis/PS3
controllers aren't paired, so don't have that problem.


Compare: https://github.com/bluez/bluez/compare/83fd243a298a%5E...2b5b44966443

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
