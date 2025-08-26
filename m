Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2478734A306
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215938; cv=none; b=dVdFTRs8CDLnZmUtKf3yPBdSVxYnuvK926wiBrPdGIkMPnTlsnE6Yx1U0JnCy9iJ5zr2D5o2W0fevoDtT7AJ3FD7bQluKuwv//OU9nE1VIm6RlwMoGnTEH9IE7MXbeoGHrZsVPwp+weysROUS+n7b+LFLCmSE7t/cxoH+6i8huU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215938; c=relaxed/simple;
	bh=FouFxWI2AG1G7Bsb+j51w5EVnpbtiK1pfDdFGle6fXg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Mk/puqvAXwicONqBtuXVxSiDIcZ60YLY+iXtFYBOqz6gQglMtp1PvytWnYQexiUO9FDZfG/xQ2cZgEZ0mRonhntSU+Ksg41ipAlwZU793rvGwxB+l6woFN1Y9NinxWWEYdMCSdY0spbwHsNWpcGdlDe4yqAP8CwyDHENtH5jhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lSeN648c; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lSeN648c"
Received: from github.com (hubbernetes-node-3d6483a.va3-iad.github.net [10.48.160.23])
	by smtp.github.com (Postfix) with ESMTPA id 61CF54E0873
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756215936;
	bh=GNimOH5WbbOAaJXRICeun6k5DLqr18flMh+ZTxCN5cM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lSeN648cK5G09Eb0Y1VIUPVDgxxSdFEwJRXjBXjnIeJmPQdI4NhBEJVxnbBYyf1I4
	 Ebo91pD37HZ5kX1c8WASiJlXKogFRtG0DCRZ5NgeuuAb6tHQLqSwyeF2OA3bXVurEv
	 6nAxdD8Jc56987mKEOR2ups2Y+/xVoXWeYOteXXY=
Date: Tue, 26 Aug 2025 06:45:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995586/50da77-000000@github.com>
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

  Branch: refs/heads/995586
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
