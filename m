Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99424137905
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259639; cv=none; b=DtGvS2xE0VhhruA5qWzbc6d7DnA4F2nYqyRjNdirWJlzEv7Exz7Rjsz/AJkpq1mgRgBS98NKNjRObOujBUa/GswJ/WWl5Bse/Xvda07b8fgf9mnr6NwJtz75cZ+uasnEZWhKnkYYNChoczaXl689qpVzfobCieDs5W/1Vk5em5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259639; c=relaxed/simple;
	bh=+9AowS9Qq656ky+MUdsI+jJxRdDimYPYyuNNFt41XLQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rGTe5QfdKpX9Ohl/uErtEiIGO8z0Li9XEj7z+M9rxAsyGiPoTah2M6z7Vc6i3KTvYFDjyhPmLBXTwk3ChJ+mpdZVZ/Zkt2UwbqRggDjYTVRH24b9wlWYEJtOQakP0Z7AKkSUfzR0SqsLAEc9sfr2IpGbYKGAugrf5jbtDf+WL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LpP/BTg7; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LpP/BTg7"
Received: from github.com (hubbernetes-node-71f5be9.va3-iad.github.net [10.48.139.18])
	by smtp.github.com (Postfix) with ESMTPA id A67194E105C
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2024 13:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1726259637;
	bh=wc21IgjjFL+UY+HcZ5zImm3cgLzmRsn25MffmgXCyfc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LpP/BTg7OZc/8z3IxJAPYiloZTjIGeHNmXIAEWTX2wg1XuEm15eq6Qcy2R0A1GBvY
	 JEyYbibhl5mMD8CI5HURL755Jb9mgsUv3KjGXVyMRABXm5dySVk9M/39eOufrtV1/Y
	 AT070FeUyrpuP/rdgCsYY/lu7Aup1Tb4AJvTgdlg=
Date: Fri, 13 Sep 2024 13:33:57 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d8a4b1-41f943@github.com>
Subject: [bluez/bluez] 41f943: client: Print a warning when setting
 discoverable ...
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
  Commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
      https://github.com/bluez/bluez/commit/41f943630d9a03c40e95057b2ac3d96470b9c71e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-12 (Thu, 12 Sep 2024)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print a warning when setting discoverable without a timeout

This makes command discoverable to print a warning if
discoverable-timeout is not set(0):

[bluetooth]# discoverable-timeout 0
[bluetooth]# Changing discoverable-timeout 0 succeeded
[bluetooth]# [CHG] Controller 4C:49:6C:44:F5:E7 DiscoverableTimeout: 0x00000000 (0)
[bluetooth]# discoverable on
Warning: setting discoverable while discoverable-timeout not set(0) is not recommended



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
