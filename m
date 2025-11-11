Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7725D917
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853582; cv=none; b=eEGAjnD7uv51uEE9dX1raUTL0Bokp+mN6DxkkctRmduT8FFF9Q+FK8DZNNF4jmndbScaVOFGVxF6h2Yfr/BVl2we67BdsXtVGDXqAr6HCqLubKEYc7WNpyns1btTCGgQmkeKpa3pFN9qNxpoUQELOEPJp+6EDyzcQL1D19IAr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853582; c=relaxed/simple;
	bh=pmmWgaDU6cv3kdNq15WhvOOecW/x7/OrgYtBl2tZffs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T19cSBiCNjLMpxiYP/aZU29hB0r7QOcfUU6U86ebmrBO5dDWNzdNMXF++5GleNgCbWUuzAEanMRHecsQlBBNgcv80OfHiafF92yaIbjSD1xPUf3bfq0JnjJPs96dM3jhsiiqsFhlorPpAZl9ikDoaZRfjffILkfxA5nJtVhbytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Lwv89fiX; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Lwv89fiX"
Received: from github.com (hubbernetes-node-e2a6b08.ash1-iad.github.net [10.56.201.108])
	by smtp.github.com (Postfix) with ESMTPA id 7810C921198
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 01:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762853580;
	bh=zKs4IhSsILAka2s22ge7lsCNFoKwhONi+DWaPHVXkD0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Lwv89fiXZBaq6oY4lRPzD8NUlASeUU7HcbyMqu4RghHx6dPjInl0ejT5iULvRKvOM
	 Q4Rk59MTabs7OLxBeWNgrH9bo9lexeLSNGc2nU5/4Q38OH7WJQh7woRl8u2cqjAk86
	 2Z6n7r+20cqUB4fi5toGq+l5UwAA+VV5P93jpvGo=
Date: Tue, 11 Nov 2025 01:33:00 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021957/000000-f1c880@github.com>
Subject: [bluez/bluez] f1c880: bearer: Implement Connect/Disconnect methods
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

  Branch: refs/heads/1021957
  Home:   https://github.com/bluez/bluez
  Commit: f1c8808087ce1aecea17e91d795f03f44772ff9f
      https://github.com/bluez/bluez/commit/f1c8808087ce1aecea17e91d795f03f44772ff9f
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-11 (Tue, 11 Nov 2025)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Implement Connect/Disconnect methods

This patch provides implementations for the Connect and Disconnect
methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
interfaces.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
