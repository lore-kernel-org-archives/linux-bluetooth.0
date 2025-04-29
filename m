Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFC21ABAC
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938764; cv=none; b=YhrW7c0QrbGIATKhJY1qYp1nn9HC3RuIb0Fxu39m4VTmuCDwKheSqrnyvBTrXFVgcd2URvkwyHiTkW1+jVjsTESSSa2TsCK8kyv8l+WMNwto8gqOxZL7w5cv08GhkRlUA5WG5h+prlekXVxJMFtJ1V5KQ6/n888vHWpRWJFGgy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938764; c=relaxed/simple;
	bh=3qjXSomZ9etBRbdupQyjUVj8eu0OOBQDmyd5se6/wJ4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=APoEBsANkIcpiRLwv0oSHHxbEYXNoIcvexSYxCXEMYCgCgPO5oEopkmSX9e4KxfbbCyyhTtH2zoZ439MkVX2apDMPp4GaVZ2unOhOMhT+ZrPBfROo9lHpc7QcjCTSIqjPNdD7xpJNAtet3oxhtpQCFmI1ksHbz0JnpXRoSrpNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VOwTGhmT; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VOwTGhmT"
Received: from github.com (hubbernetes-node-27619b5.ac4-iad.github.net [10.52.162.15])
	by smtp.github.com (Postfix) with ESMTPA id F31D120C63
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745938762;
	bh=kmfaQQ0nb0f6bhEFU/kbIO34Dvxvmh4WKHOnC8Tefu4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VOwTGhmTUhbrLESTdftih3qU+VX4UsctZ+O2c537lRf3hvy/6Z7VMU49lM6Lcq2Cw
	 OzP8ig2kAlFdqU7nvBzl3otN436OiCk1TYlYGe2pXGl3Dpn1Aw0nstWeUW51CSXj0s
	 lK3twOF9BxYE9v5p9gAJ4Bp5/F5Z9vF9COlQcrnQ=
Date: Tue, 29 Apr 2025 07:59:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957730/9a58a1-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/957730
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
