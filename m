Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40E2FFFB8
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373947; cv=none; b=TEu3c/Wj4YSHUeSv03qENdDt/Yc9d4nWNRC0EWcBjigwoSgNSHHWUZcYfX0ivBwp4ApnG+Iiw5SuSUYh2LLiKsFItTHGFavbKnjEtjkZ1Xe9NvuhBENIEcLwwdRir7TZhSVr2CEptMYgILziOxLT1Cmmp4gTunvuNHrBlOZEoyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373947; c=relaxed/simple;
	bh=PcQU/5MbxETsP0UkMPB/W+MhKhPfyT2i+aAa1EWZPlI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JT1AQ4+3PVEuFnyO+Y+kwJTEIQ8KCM0Ehzf6i9Q6HakRC855m0jce5AVj31l7J2GaQijkOfsIya0jq2DwOrfkO1NwTFjmoPsCQo+2F1EkF/mfdgUG6TKmrwzc933PX7d1IfU3xhWAvQwOuFFObKpg/c4BDh8Wa/FsGHVLoNvE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cIxRePJA; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cIxRePJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779373945;
	bh=9TMZwK8T0ykFxGBHNUe5rTZmTS8CpdXTMV1I8oPwzzk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cIxRePJA90oZyny313UfGp5GEjbHubRk/ccAd1Gg+iFrih+0ybk2Sllcz9avqWXQp
	 rRmpAeuVmbyXNGVzZD2+A59psr+h3r4GLAlEokYKkoB+8kYj9GqBRJwVaDc69bHJBD
	 2D+67a/pcC0UeEMOIugSryERlwPR4JnuNR9Lc30A=
Received: from github.com (hubbernetes-node-0de1117.ash1-iad.github.net [10.56.188.30])
	by smtp.github.com (Postfix) with ESMTPA id 252AD8432C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:32:25 -0700 (PDT)
Date: Thu, 21 May 2026 07:32:25 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098468/b65a3a-000000@github.com>
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

  Branch: refs/heads/1098468
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
