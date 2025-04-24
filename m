Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551D827F720
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509534; cv=none; b=rMXapKNsfH4vDsDRJx9wsK07KLNbdtm9MCJzmZApeu4SdgEbCb1ZvnVOk3nqHNQZTXq7eKsKgqeL2pflS98W+qLj14SMoJp+2DHxkRigoTKZAe/tLjL6bApTXPriLbwTN+4z40LPAGEAbbqrhlGO8ZTj0s//yGzVSXN+u/3yCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509534; c=relaxed/simple;
	bh=+4NfP4vePkMDrok5vltS+WtT7k0LcMa6beNH/3/JYxY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cS5/gIgMB9TKobFQYi1yFtkjRAvcOyElkdqUHjy4Bz0Zr9xutF3pe0GnCiyMuFQBSYyrid4LRUJe/ZqvDebQxFMa6GGwYtWnZXx7Ee00C19Ed6hK04pc0kWn+zmmueZVzLoMDqQQ3eQpjxPcnrMzibz5ZvFIei7DhZID1cO1bXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LxuyjmCP; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LxuyjmCP"
Received: from github.com (hubbernetes-node-6261fd4.va3-iad.github.net [10.48.210.87])
	by smtp.github.com (Postfix) with ESMTPA id 407AC4E0FF9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509526;
	bh=DjNooWEW8VvwpvozhQyqeEVD1+EP/jPTqbfdEDKhOBk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LxuyjmCPHFhRggHCaOfwamRpqQmwPYraWCOHgFYOobYXBoHpmFMsScq37wBXr25Ih
	 CAX5ocR3PJwDeNEGbiPYKpwy7At6ppLdvtMpOxDXj2rfm/QI2GNIK7sx73BmYz0jVK
	 Hd3VvNYuZ0sB7ZcvbokDe5oKFaCpV+Y9mltJbHik=
Date: Thu, 24 Apr 2025 08:45:26 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/955480/000000-42d3e7@github.com>
Subject: [bluez/bluez] 42d3e7: tools: add tests for SIOCETHTOOL
 ETHTOOL_GET_TS_INFO
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

  Branch: refs/heads/955480
  Home:   https://github.com/bluez/bluez
  Commit: 42d3e71781425289efbe8757c78cc1bece1c35bf
      https://github.com/bluez/bluez/commit/42d3e71781425289efbe8757c78cc1bece1c35bf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/sco-tester.c
    M tools/tester.h

  Log Message:
  -----------
  tools: add tests for SIOCETHTOOL ETHTOOL_GET_TS_INFO

Add tests for obtaining timestamping capabilities via ethtool ioctl:

L2CAP BR/EDR Ethtool Get Ts Info - Success
L2CAP LE Ethtool Get Ts Info - Success
SCO Ethtool Get Ts Info - Success
SCO Ethtool Get Ts Info No Flowctl - Success
ISO Ethtool Get Ts Info - Success



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
