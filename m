Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334E2F50B2
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477570; cv=none; b=oPdSlW7H7aD5qmCEfgWaa7wyjGfB/he5/6QKoNebckUIwwIl+qbey494TnG3uiIXq+XVgXCoNszSmFl1SsS1vAhTYiEIWlR3ZhbHINXoaiUYWxMOeSeW2ixRz8YHkPFlYuDVlQIOyjJhmw1EBFGhp2a5zNsUjjI5JFsCifwoQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477570; c=relaxed/simple;
	bh=xX+5skLSCXI9D7+oacXhsc5Erv7fAUId07G1tp9chqI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YMP1ngV6/lEu46MEq2xi64Ybdy2Ihmmypg7qLrJbmCHanG3qEzd7H9SC9FuaBcuyfVesBPU/g788K4evboAEir029bP9oNj9AqrjyXJETsuCzNZIQz/BGra1bCHAMC9j0SnRuHZTYJ27qIFMYUcYPzFgJ4Hnj5Rua8rjL1o41pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DzY0zKzw; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DzY0zKzw"
Received: from github.com (hubbernetes-node-02ad76b.va3-iad.github.net [10.48.174.52])
	by smtp.github.com (Postfix) with ESMTPA id 810D74E0401
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751477568;
	bh=Y5F12PHgya3tbDECJoXuIVsp/rdR8ow26gKHkw0J5/k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DzY0zKzwhknw0bCQ5cPB9urrqVQ/MlvUD0noDAcIG8/U57h4dctSKo05N3VhNVDbU
	 9LoBcUnZummVJ4jegdCNjKDjw6j6zegkY6G0kdjiBhqoVqDay/4+EOl/+1/thi5X9D
	 irXymqESewst6C1Pf1txUmheB1QEAfGQvrdrAIQg=
Date: Wed, 02 Jul 2025 10:32:48 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/248a67-50fb90@github.com>
Subject: [bluez/bluez] 90e229: advertising: client_remove: use concrete type
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
  Commit: 90e2296ee45959d286c7520f51d163360fb7c387
      https://github.com/bluez/bluez/commit/90e2296ee45959d286c7520f51d163360fb7c387
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-02 (Wed, 02 Jul 2025)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: client_remove: use concrete type

No need for using a void pointer here.


  Commit: 50fb9042e1ad471115e21ed83daebae278594aa7
      https://github.com/bluez/bluez/commit/50fb9042e1ad471115e21ed83daebae278594aa7
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-02 (Wed, 02 Jul 2025)

  Changed paths:
    M mesh/node.h

  Log Message:
  -----------
  mesh: node: remove dead function declaration

node_attach_io() has been removed in 7cdc215ff5a1 ("mesh: Add
finalization of a newly created node")


Compare: https://github.com/bluez/bluez/compare/248a671e5185...50fb9042e1ad

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
