Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3EA6FB6
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iQQxCFrQ"
Received: from github.com (hubbernetes-node-e7db897.ash1-iad.github.net [10.56.157.37])
	by smtp.github.com (Postfix) with ESMTPA id CB10560075E
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 13:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1702935387;
	bh=CzxbAMlVMAuYj+dlD+xBRD80U0ZMZu5kfJroPRvtWhY=;
	h=Date:From:To:Subject:From;
	b=iQQxCFrQ41F6h117QvGAPkpFxv/2ibHK+S1Zrn2vnpghKbjy6G9DAsHbedm49Yvj+
	 iC6+z7wGmyWISsKJBaOKO0DWqCnSYF50I0WnwH8Swe0L1uBFQ2nWJoSJe3ggHExl+q
	 IWR6pFP5VsqrM/69GmFYo+D0ptfVLeLqhdPw/lUU=
Date: Mon, 18 Dec 2023 13:36:27 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/eb07ec-c623de@github.com>
Subject: [bluez/bluez] c623de: client: Add initial manpage of bluetoothctl
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
  Commit: c623de844c88a4058df2e027346f82ff38dca0fc
      https://github.com/bluez/bluez/commit/c623de844c88a4058df2e027346f82ff38dca0fc
  Author: Paul Otto <potto@vt.edu>
  Date:   2023-12-18 (Mon, 18 Dec 2023)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl.rst

  Log Message:
  -----------
  client: Add initial manpage of bluetoothctl

This page was accidently not added in the recent documentation update.


