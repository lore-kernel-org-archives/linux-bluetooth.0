Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D971B373C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947800; cv=none; b=sW8z7Lk1KeYV1fX/HaG0IUlwW7syTd+aqrSfh8rNypCFgPuV4mT5w+SoIScyhyvuIyo0oDrtio1tB2VbbVp0gQ7pHveK6HG8IndZ6wo843OgUXJzcUlmWAfVzkPN+qdjRuzhdjbrnEfwq6keVZbgTSaiuTMCwHfqO5bbVeEbcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947800; c=relaxed/simple;
	bh=d+rrm5Y1bQQmuSEhP7B9IO5oC3qlL9f7S899iofuwvU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lY2XOMWx15hzY8pO9mRlhzWEH7wSnNl6kMARaW1KnVAuP53bH6WmFzaeFHAQz1ZISPIb1HMwdzpl2hva+jqJVAZudHQRNqS66tr9FFMG4ie2XfctTUR2KxgzO2MUwxwmFUEECztUDm/wFXK3M+RQpShtvBHBSbB7ZoosMcuMch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bbt3eoV3; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bbt3eoV3"
Received: from github.com (hubbernetes-node-58bed60.va3-iad.github.net [10.48.145.31])
	by smtp.github.com (Postfix) with ESMTPA id 04F9BE0A72
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1724947798;
	bh=yLNEWrDo9OEDtamcXdwXgmF1r4B9rWcWGpXKrASGCT8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bbt3eoV3ltlMwQd9c4qSKjsBhwPoyTumt5oFxx9dsCUpged8h/tbRsVPEv65VCJwt
	 sZBUikicdvJfbcF/S/R2ucPeth/wFmfvcel1fTPakfRs0HxyGAbmIO+tWAgUZGLXe7
	 DW7VfV0cbi+8jGUZUKvvrzlnJzodv7BZyyHDNdI8=
Date: Thu, 29 Aug 2024 09:09:58 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/32a081-2dadde@github.com>
Subject: [bluez/bluez] 2dadde: shared/uhid: Fix unregistering UHID_START on
 bt_uh...
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
  Commit: 2daddeada069d38c6e98e4d28a7ecd6709909c21
      https://github.com/bluez/bluez/commit/2daddeada069d38c6e98e4d28a7ecd6709909c21
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-28 (Wed, 28 Aug 2024)

  Changed paths:
    M src/shared/uhid.c

  Log Message:
  -----------
  shared/uhid: Fix unregistering UHID_START on bt_uhid_unregister_all

uhid->start_id shall not be unregistered in case of
bt_uhid_unregister_all as that is considerer a internal notification
not under controller of the users.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
