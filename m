Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC453B8D48
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765486105; cv=none; b=ZhX8f1vPf2tW7wY4RPoyg+IRZFSgfh+79kqgc4TOT+7ufBh2LcX+QNfHnpmYDriXslztFeXBkZ03k5q+0zJt7yge1d8tv2otpM4UYNiVI5x2keB/to6TN8XynEqitbogiAyJ3UYraezW7q5rIaz9G90XePXJxkH0S6N5bp2/ehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765486105; c=relaxed/simple;
	bh=pgRpuWgkxvb1QLlJbx9anGvbQu82gl136OzexYMHXsM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LXeO3lWz2YglXzJgwpq50UxSwGtS/5Nqf4FyTzieuMsUS5ONIk8NDMmQvdH2l71XXtjiz9dEXi0tyPqRY7XZV/VnGJCb9lT5HQaIa05WXfa2wWGeRKW+EIws2YOa0hIb3gdgwFB7M8b6EePa9Peri2dIfTKbkZrXbKLlQz2wK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cS+wwO1O; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cS+wwO1O"
Received: from github.com (hubbernetes-node-a757b4c.ac4-iad.github.net [10.52.220.43])
	by smtp.github.com (Postfix) with ESMTPA id 0629164066C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765486103;
	bh=yjpyz7ZOa8xaVfSTdQykGlaYWdaYDYMzG2YpPpMc1pw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cS+wwO1OLkq6u9RlsRUv0yijqOXqhAyn7SxFGquU7XCAnKyQlm4Olyi5TXuGRW8h+
	 tuOabKJPReOra7q7igA5n4kYgoTHi3yMSeYM0ZVtoux52U8N8lo5gaOdKSFvIDoAlH
	 Iq9wOyJEecNmPqqfy0EM6QIKWlitwNnsy4MpYeOI=
Date: Thu, 11 Dec 2025 12:48:23 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032433/000000-b2d74b@github.com>
Subject: [bluez/bluez] b2d74b: l2cap-test: Add tests for LE 2M and Coded PHYs
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

  Branch: refs/heads/1032433
  Home:   https://github.com/bluez/bluez
  Commit: b2d74bbac5c2e650d27ec13f9904ca972d8e4d21
      https://github.com/bluez/bluez/commit/b2d74bbac5c2e650d27ec13f9904ca972d8e4d21
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-test: Add tests for LE 2M and Coded PHYs

This adds the following tests that uses BT_PHY to retrieve the ACL/LE
connection supported LE 2M and Coded PHYs:

L2CAP LE Client - PHY 2M/Coded
L2CAP LE Server - PHY 2M/Coded
L2CAP Ext-Flowctl Client - PHY 2M/Coded
L2CAP Ext-Flowctl Server - PHY 2M/Coded



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
