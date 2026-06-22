Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FF233943
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111837; cv=none; b=pYYFCn+Z+jHCNW4ligQBsfsWg53N7vePwCCP5tYgrQKGQb8mUihP9Hb5Q/gARoPx0B9pZJSq4XeRKT4DocqCN2sOofwHbWfMlFZnulwa6CpzJ68yEanfHngGq+a9QfqOsUaC21UqoVI2VP5wfU7Lt8FdjAjHBR0v9+9xPw/S4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111837; c=relaxed/simple;
	bh=Kw2Bjg2yvi//9pNxpq8mkC5KWhO7bTq7XNVPD1LvPlk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=N39eRhShI/SSqJiDophmaC+zGMb00Q7eM99dh1uZy/Z6DTPunAs6O6BJ0MqSJsB74mABLy0wPGgrJ4X5LORuGzVXPJhC2iZqwR1mkfMlC/cr+qTNFo6pSjnRBUjolBJm/Fscrr0U1CmQA8th01/7kFJoruVw/arnbfevL4+nFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XkmOUVHH; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XkmOUVHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782111835;
	bh=ZKsuhICK1ync4sgTr0XLNFX8gJ4j/zBeUcd/nQEzpTM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XkmOUVHHXwUn8oAJwvv64KcDLYSZK415ESC82cvJb6l3xOwqtmsK0Jvuv8KGceN8q
	 SEXrIdISvX1moHzxPqQG/bdsRWSlUqtzWPPVxhufj6cngRwcbojbbx9Wirz26B1tx2
	 OxAgBx2gLve+AKNehnWUGpvE1VzqVbtvGbTFKsG4=
Received: from github.com (hubbernetes-node-5b3ec41.ac4-iad.github.net [10.52.138.38])
	by smtp.github.com (Postfix) with ESMTPA id 535E3A0359
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 00:03:55 -0700 (PDT)
Date: Mon, 22 Jun 2026 00:03:55 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114528/000000-f46211@github.com>
Subject: [bluez/bluez] f46211: shared: rap: Defer CS Event registration until
 con...
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

  Branch: refs/heads/1114528
  Home:   https://github.com/bluez/bluez
  Commit: f462115223abcf275bb6109f19647b902c6fed06
      https://github.com/bluez/bluez/commit/f462115223abcf275bb6109f19647b902c6fed06
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-22 (Mon, 22 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  shared: rap: Defer CS Event registration until connection setup

Move LE CS event registration from rap_probe()
to rap_accept(). rap_probe() runs during service discovery
while no ACL connection or connection handle exists,
so connection-scoped CS events cannot be delivered or
associated with a device. rap_accept() is called
after the ACL link is established, when a valid
connection handle is available and the HCI layer
can route events correctly.
Registering events at this point ensures
proper handling of CS events.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
