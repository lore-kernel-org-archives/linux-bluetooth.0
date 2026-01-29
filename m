Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAE374743
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769728405; cv=none; b=AvhjIdAaqBI/NPny8+v35Q7opf+YMv8LLKscLTQEvpZWZL+aWus/CwhKfG0CTM2ZAB69IVSW7SMQi8ulJ4UkULHpvlVtVVvM5TRzguEMgFr/XbqzwaBcrMgM2WszO9B3yB77zNlV5mc4BCJE2Xbs1Uen6To1vO7avjCiWq5/aNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769728405; c=relaxed/simple;
	bh=kQadUWDM7dTnM9z/Zc3WgYMtjj4lbXhsUBUtHQp3G3A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bwfmpbQFobAmVwPYaej2cbw6cklbvH0j+6vkh+kCTrjcG9it26vMWYpI0tvSlB6oWaNQBRy923eE8hdZifJquINPYSiugM1+ciN0fR7Fv6XY9kQBZoTh+xJ8lhg8jJD1llQLz1k/Q8PBZUkxHJbEnjjeMZVkDR8ty83JD/uUglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FN4pLSUk; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FN4pLSUk"
Received: from github.com (hubbernetes-node-ba83afb.ash1-iad.github.net [10.56.130.38])
	by smtp.github.com (Postfix) with ESMTPA id C91526005D3
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769728403;
	bh=DCg5WMNiqmLbiJF5KevwffqtKHyGsySjbR/CHSAqZdY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FN4pLSUkxp4GblMDaH8C/tAQwnV9s4VCi0GP66YMdjdQMzn2zZYoR4BAB8tPi/fox
	 urKLDgubEOOKIkh3Oz7Tsi1jPkP42GTPdO+/zP/30tDJ5rxlG5lMrl+h4dBmQ+x+Fr
	 9OQg3oGPGPOSzTnA4X0srb2nFho0CQ4C3GIRbLF0=
Date: Thu, 29 Jan 2026 15:13:23 -0800
From: Paul Otto <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ebb331-358ab8@github.com>
Subject: [bluez/bluez] 358ab8: client: Expand GATT submenu documentation
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
  Commit: 358ab8994207ddbe601631dcf0725a939030463e
      https://github.com/bluez/bluez/commit/358ab8994207ddbe601631dcf0725a939030463e
  Author: Paul Otto <potto@ieee.org>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-gatt.rst

  Log Message:
  -----------
  client: Expand GATT submenu documentation

From:
https://github.com/potto216/bluez/blob/master/client/bluetoothctl-gatt.rst

Closes: https://github.com/bluez/bluez/issues/747



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
