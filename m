Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9332E7BB7
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073923; cv=none; b=aTCC1HtBUIR8PAj9jACjTz0TLOIzbSPsJtW2SaF/UdUhZzi/RMb/lzQUWjVH8z41/fjFgEvdnrJoCCuOt4HOQcqdLcFESC+BuPe+EHMXrZln/GxUGHO1/5qWvkMrdMHL/n5BLEqtxiIKOxv/nZHfW22KURUqfjPp0vFDyfPWbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073923; c=relaxed/simple;
	bh=LWjIYNLOhtHZ/z7pk52iwYvB360AsWaomJ4FE8683Pc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aLgd7uMvGDRZAm1Nc2LklXRuHYXhVGrsSU+v/uyQjF9070x+QdHFg1Hs/88j9PBH/SwYexFMj93ltK4cYvi1g8l7/GglDmQv1rj4PEs7JoR0+K4FM3e7cMKkKD7/5pXZNIrVbe2BTsMA7ylk2pMKcc2qq3g5soRSKkbaKNymQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YmXqk5iH; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YmXqk5iH"
Received: from github.com (hubbernetes-node-eaf1902.va3-iad.github.net [10.48.169.31])
	by smtp.github.com (Postfix) with ESMTPA id 75417E1587
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752073921;
	bh=s9F9cJ9D8tBjzwAN4JHgaHOKkINejzcPCbzCR0M0pw4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YmXqk5iHDikuLYqqbZYxNgDPcl6tQTXzKb235FCEJ1VN6hgM71vg2gF+H1AA9+ndq
	 kCbUW8cWL8Lt+Io6fU4HP7R9WkXrnI0az+97LQJSUnLRDCAEEZRYnaSX6LBGRAXArk
	 FBFktwxcmzjRZDd8cSOqdh82hCaWpx3OkeN7kdBA=
Date: Wed, 09 Jul 2025 08:12:01 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/09212f-24a327@github.com>
Subject: [bluez/bluez] 24a327: shared/util: Introduce strnlenutf8
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
  Commit: 24a327427d7e7a1ef5c69a0f90bc6297ab17a9ab
      https://github.com/bluez/bluez/commit/24a327427d7e7a1ef5c69a0f90bc6297ab17a9ab
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Introduce strnlenutf8

This introduces strnlenutf8 which works similarly to strnlen but return
only the number of valid bytes of UTF-8 encoded string then replace the
other copies of similar code.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
