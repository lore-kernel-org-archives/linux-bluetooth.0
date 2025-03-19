Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00821D47C3
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404424; cv=none; b=Kw3Nw5keIMKrv01j653PD796blu1NOBCh7GLsuYC7KwT5WJv23HQGxxZI0ZXjmgG8tXd58npq+g2rD3jcAjuxqk+NSt1VBven3zzA8iGeZszlfLjsUokdB4f+IzFumNImDXldTWFFrdTH4CfFNeDuS0AXrIObcz32thV++bAPnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404424; c=relaxed/simple;
	bh=f2EkjPfP3vDnIHNBP9400XPkVd+b+40WJfxyo0Ah7Gg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bigKDnrnlngvynaSvYQzEcewQ+oTMEG/hZtLkzsr4hxKJwDQfEMyR7+7O1a0RkJjMEB+7FBCqfk5ddPbKbHynPTWbxZSIV7vsVKMCzmLYL5sTs03NfCAaf61SIpVhhe4F5IkGX1twon+WFOdXX3n8+VIgc0Z8SSclVINc2Jr3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aBnvRwEI; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aBnvRwEI"
Received: from github.com (hubbernetes-node-05ce5d7.ash1-iad.github.net [10.56.174.20])
	by smtp.github.com (Postfix) with ESMTPA id DEC8060130E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1742404421;
	bh=wqkCVjIsSiR8XvBxzLW/IQPczWqwnY07vZS/+N1MAAo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aBnvRwEIL4A/HIQo2abKU9F+tUoWarR/TFu5SXXSYv5TEKDgf1j06+5KjC6/4evpv
	 mlbD/iwBt85PujsIkpa0tSl1BCUZ9as7EDrFRPHJNhC6JWwdDOSuc4LGINX/NEkBdM
	 IS6PY8nQJrEv4FeMOoHsS0GVKCJRIl5/eIFKwk/4=
Date: Wed, 19 Mar 2025 10:13:41 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f4b6a6-775243@github.com>
Subject: [bluez/bluez] 775243: l2cap-tester: ensure SO_SNDBUF is large enough
 for...
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
  Commit: 77524358658a11199b9e5a48383c56730e17e215
      https://github.com/bluez/bluez/commit/77524358658a11199b9e5a48383c56730e17e215
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-19 (Wed, 19 Mar 2025)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: ensure SO_SNDBUF is large enough for the writes

Since btdev runs from same thread and won't flush, SO_SNDBUF needs to
hold all data we are going to write.  Fix spurious test failure
in "L2CAP LE Client - Write 32k Success".



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
