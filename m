Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E81C174B
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724445143; cv=none; b=Ol9ZF6OMbqWy3Rb1be7DbygryuhycVeXDlozRNCo0rNZ5jAZSUSwcP3HiwRACrAULYWNjjyAg3rs/KG1U7E9u/1JhAkFCZWP7Y+6PCC5/YcESHKaY2Isf5/lNNUzAESPB4xaSEimJsY7HK6F0YiYBrhmCErK4DBhy47XK+ALYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724445143; c=relaxed/simple;
	bh=QiP+WYNn2fB8a8vB7rT0ndUWxVOuszsp2XAcYOHaksA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fBYuBOCcBrL9mb0eFriuzHOKYr3bKusRkRK1s/Ut/pPZnriEBDdm7Mxp0PuJecCXFwQS+PZR/3poCZV55aCCJIBXRMRNLusOHzaRA3IkWGoIShRVh/fn8aN/y4DxjhLvDI1rISIDfEDyRUs9VEmebb0ZpBjnjXIkS1QE/1RHpk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DhXvn1x1; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DhXvn1x1"
Received: from github.com (hubbernetes-node-ee2c532.va3-iad.github.net [10.48.206.59])
	by smtp.github.com (Postfix) with ESMTPA id 325094E0B41
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1724445141;
	bh=MrvDMP+iM68+2qKa5gVHeqHB2qaWP6Nsi5uO2ycfIrQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DhXvn1x1Aq/y+1rzZu0GvgQ9XoVnpBZEN5osRbODAUjOV/O2Yg9lHm4Jf1hjS4uDw
	 yrHhLbl5Oij8Etww4Mt1ak3gTYlOzaKYlHUcWqmXcqpEJVyJt0rzCY7syM+EpMCNVl
	 jWMsIq89JUi3Mq4du/POWJvlOMdTjEsBVXq0wEqs=
Date: Fri, 23 Aug 2024 13:32:21 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a6ac17-4ed706@github.com>
Subject: [bluez/bluez] 4ed706: test-uhid: Fix attempting to run when bt_uhid
 is NULL
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
  Commit: 4ed7060ca9dfcc89c55801f818b0b43db6f5acdd
      https://github.com/bluez/bluez/commit/4ed7060ca9dfcc89c55801f818b0b43db6f5acdd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-23 (Fri, 23 Aug 2024)

  Changed paths:
    M unit/test-uhid.c

  Log Message:
  -----------
  test-uhid: Fix attempting to run when bt_uhid is NULL

When running under root there is a possibility the bt_uhid_new_default
doesn't work (e.g. fakeroot) in which case the test shall be aborted
since it is likely a device specific test case which would require
proper permissions to run.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
