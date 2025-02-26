Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D0275600
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740602269; cv=none; b=mtCGQEGhdICGZ7nEsy++LSZtk+2EWYPdGgBaImB74kwgkKCuy0BZ02jW6fxl63Q9RTNf1x55JHqWo7e+q8gmvph4KxpIncawgkC0hQ1odm+TqPVjHCiH13Zw9PKY77rDVpNDZPCDr+cgE8fF+YNqV51FRC+ftyZEd4T0S+Q3CkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740602269; c=relaxed/simple;
	bh=C4niATZTP/O9JFwmYZy+MFt4zrzgec5STGP6Gk09zEk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b+XeIprHapkmzgI7abMd8qNyp9ywk8tQLEoU3FEs+4EU4yBdP8Q9FdXhTVJ0/AQse8WkMpQIlHj92cNJUztE8CLzBs4jgxjNLnPMjLQeOt1SNJYW7f8UHW3zlFofuUWXEeLqJREMPl15NWgPyHmN9RllyMtvHSQGfavunOFOnVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LmlwjFRA; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LmlwjFRA"
Received: from github.com (hubbernetes-node-f35bf9b.va3-iad.github.net [10.48.156.33])
	by smtp.github.com (Postfix) with ESMTPA id 746F78C0129
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 12:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740602267;
	bh=j4bdSQLYi60yerhcJMZ5RgFv3X0Mzd/UIMz/ztiW+2o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LmlwjFRAKOvTTl8xvXm+zne47gpV/14y+DwNB0J2NSMyFMrvrK4LsrPesGMo2vfMi
	 eSjatSpM9LsSzbqgTdOz21jp3zNQUOWSEHf7/wkt7nGy1LNFcmx8BjZ74yfgMbQHzz
	 4Pb25VcxPBa63Zt6mIv+3VNugIZYvghGWWRqvQII=
Date: Wed, 26 Feb 2025 12:37:47 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/173045-f4617c@github.com>
Subject: [bluez/bluez] f4617c: adapter: Prepend the new added device to the
 adapt...
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
  Commit: f4617c531abe2cd263ce3b9ba7ba77dc5859215c
      https://github.com/bluez/bluez/commit/f4617c531abe2cd263ce3b9ba7ba77dc5859215c
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-02-26 (Wed, 26 Feb 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Prepend the new added device to the adapter devices list

When the DUT is paired with a mobile phone using RPA multiple times,
multiple device contexts with the same bdaddr will be cached.
When we query the device context through bdaddr, we always get the
context at the head of adapter->devices, but its status is inactive.

Fixes: https://github.com/bluez/bluez/issues/1095



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
