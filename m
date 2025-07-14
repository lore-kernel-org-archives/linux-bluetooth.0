Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FA66ADD
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515353; cv=none; b=uufmh1IdUO5Y2hU+SAU/kq6bsFpE/nhA0KApb3eCzwmtwotbBbs1IptusWRKYbajwMPziRnHUVDNcRptt0sAOxG/4gn7lvdWEE3gCPMg7NcBKjDgd2b4m7K7EoDMPOJBJGMB4KOulzIpSaeBThvDf3aWlH/+prumnxJ8qFDeock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515353; c=relaxed/simple;
	bh=MEuG1p36tM0weepqlaP00pSdwRcOGyFB0OliSY4Hd0A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EoQceJbYmYqhmNJlUJ82XUlBb5P/3gvf1wBm+RyORQudUAZt/eIq8HKcNUn/AzEq7PSN7bD5vtvHd7yvMZnwU+EY4XMGyG7mXQoCRTyyyqH2lwFbibi5guD+F60K6bGk/yc+HUuef0FyUaMRzyuDKOjgNOvPQyaJqe6I6DQrEY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FYeeXpEA; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FYeeXpEA"
Received: from github.com (hubbernetes-node-a9ec292.ash1-iad.github.net [10.56.173.19])
	by smtp.github.com (Postfix) with ESMTPA id A74BA140728
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752515351;
	bh=HcU5+JW8hQeIdsoDqALavIgm719idtCpUXtbj0A1u38=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FYeeXpEAxqMTDf+2xkT46cJDYNHxpgGWZfgMKGGJJVpJV/2ywA+BtYHhhlvf1HjRV
	 hMehIsPE6BzK/wliM8PKuO5HQOggcDyBV3z0zk2fknjYNR4Zc/pcOSFnbJAliqLiY1
	 WLrnnlm+qFNRFSCIXbGJek1nPJp7MSOg2zuM9R+w=
Date: Mon, 14 Jul 2025 10:49:11 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982181/000000-33ec72@github.com>
Subject: [bluez/bluez] 33ec72: doc: explain SCO and L2CAP timestamping related
 so...
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

  Branch: refs/heads/982181
  Home:   https://github.com/bluez/bluez
  Commit: 33ec72a52c37af7c3363b71745d1758a51b535bd
      https://github.com/bluez/bluez/commit/33ec72a52c37af7c3363b71745d1758a51b535bd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M doc/l2cap.rst
    M doc/sco.rst

  Log Message:
  -----------
  doc: explain SCO and L2CAP timestamping related socket features

Add explanations and examples for SCO and L2CAP timestamping-related
features.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
