Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05F17726
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ORwLJP1e"
Received: from github.com (hubbernetes-node-17193bc.ash1-iad.github.net [10.56.161.23])
	by smtp.github.com (Postfix) with ESMTPA id C09F86006AB
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705097604;
	bh=+/6C9pIU3qL0aUu3oFT1Ar83sAZXZnrO+0ocsgnaz+k=;
	h=Date:From:To:Subject:From;
	b=ORwLJP1eWiBMfvSptE5VFGsvLwTh9+9atIgg7BzyEl+O3KBwLXA4zrAp9goWnc4+I
	 jJVasSZzLu5ZWTxdaENGtrbR35py3Xil3fffr/rul7j70vA11ivPD/IXGpSDi/onWb
	 iSjDLcnw/xt+NMgUgIRR247vKLPX9Q/pAzXFIz14=
Date: Fri, 12 Jan 2024 14:13:24 -0800
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1f9ff8-770ad5@github.com>
Subject: [bluez/bluez] dc0cbf: build: Update library version
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
  Commit: dc0cbf0f5dad5f83ae5a07215ed7e7bdb68589cd
      https://github.com/bluez/bluez/commit/dc0cbf0f5dad5f83ae5a07215ed7e7bdb68589cd
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-01-12 (Fri, 12 Jan 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Update library version


  Commit: 770ad5614e7e8074133e6f563495ce4822f63fe4
      https://github.com/bluez/bluez/commit/770ad5614e7e8074133e6f563495ce4822f63fe4
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-01-12 (Fri, 12 Jan 2024)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.72


Compare: https://github.com/bluez/bluez/compare/1f9ff8fb4048...770ad5614e7e
