Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0FB23ABB3
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 20:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129011; cv=none; b=YvAaluel33w3t6tBJCQqkjGepWo2BQoPpWafxbvaB/c5Sd96h2kcKPEFwD4CylfbbsAnRrVhmOv1MYtyNLU0mmAptoem+HZFQiuB5AKeA8qKy6BuxsXRnmOPHv9ZMNQf1gOBbtVuCqdq80mBAimlCrjmZTHD+EBK2Oba2QtLsQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129011; c=relaxed/simple;
	bh=z6SWo/OtzWeQjBHYR3yRLwNt7XyUh7lIBw4WCGy5XIg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=F0solSKGTnlb/j8OWlSsXj+7kHmZbjWA76nRnAdP6KZ48GBGzARlH2mVStJAXfPtEagF5MAbDi8KdllWI+mfMykbfjwmKNK+M0o/R45wBf3bCQRBuqyrW2g4R8LNVEEkmgzTyjaBeiFp1UCaZaBpuOwtpN5cLaqjXGy9FwBSUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X2iTJQt6; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X2iTJQt6"
Received: from github.com (hubbernetes-node-deea9a8.va3-iad.github.net [10.48.167.51])
	by smtp.github.com (Postfix) with ESMTPA id 819358C0B8E
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 13:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753129009;
	bh=It8aFe03RK3l2yBtdo63BATKSUViJ3CjGFq4rm+ySLI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X2iTJQt6Rh3gZOs7v5QJBskrIFnF09TDDNiTv1qrX5Ue3aROiexOkJn5b2kmczVcv
	 YwlKH0PGdyf5QiotQvts7x5umFDX5/QjKd52oj/0ihimuccDJml59+Q2LTZLoy0NWX
	 vYgI3kqi1MyTg2FE5IihelXpfMPtT33aGitPLZzY=
Date: Mon, 21 Jul 2025 13:16:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/984445/000000-a69ae4@github.com>
Subject: [bluez/bluez] a69ae4: client: Fix gatt.{read, write} not working on
 scripts
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

  Branch: refs/heads/984445
  Home:   https://github.com/bluez/bluez
  Commit: a69ae4d1fc3ec3b60e7649977340a0966c7b1efa
      https://github.com/bluez/bluez/commit/a69ae4d1fc3ec3b60e7649977340a0966c7b1efa
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-21 (Mon, 21 Jul 2025)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client: Fix gatt.{read, write} not working on scripts

If gatt.{read, write} are called within a script they don't indicate
completion so they block commands to be run after them.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
