Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FFC399
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428821; cv=none; b=S6yFWn/oWTHs+IQRlcwRiwjV6B2R5dF6oU6xitNEJaJK5eldR1NBkpoymdFRTJuHKqeop2tkTxAikTKAJE+Utp26s9xYznG8gGQaYd7mc5mXIiMRMARJnNfppkM0eYvgZ29Dm3HC+0lLTYCNbBYXG41D6l1TOWiu7hh2q3fPzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428821; c=relaxed/simple;
	bh=63OA1Ia6HpU/5oZUP2yLt5NLpDd0GnVAXD8BcMuXI3A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HTL1tD9B2TDq/mBZk4z8JSdeOkXorEBe4HWEa451SLxC51HTwiwnKD9n28D37GVV9n2Juc8TQzAbPvB4UQ09rFxi2PzwQKERwqLqz3ZkVC82Av7dHyVc95Ii57FJKQfXHQK4chi0yBPR6GEYhSOQqXq6xRA1G5gVGIUkvZ3OOew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P4KbNiUa; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P4KbNiUa"
Received: from github.com (hubbernetes-node-38032fe.ac4-iad.github.net [10.52.151.31])
	by smtp.github.com (Postfix) with ESMTPA id 31FEE5E06DA
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1710428819;
	bh=s/Vb1a+wAvqON4Lfj1IlS8cYPSNwqam/8NU70z2imvw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P4KbNiUaZZ6orgTPDhD//o/xLDjZccd2q3ADJv3hqJI/J2v5Tjn1BO98ZbxCWXxmc
	 1uIeVvAAhSjWTCJLxKJzTmlDKs1hRdtl39Fk6/37bOe1cpihdCevF0ZFpiPxMs8r3l
	 +MyR+GbQu5nf2q8mFfymxuqiEmyLXDVqFD3DoZW8=
Date: Thu, 14 Mar 2024 08:06:59 -0700
From: vlad-pruteanu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0959cb-84628e@github.com>
Subject: [bluez/bluez] 84628e: client/player: Update minimum LC3 SDU size to
 acco...
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
  Commit: 84628e5d109cbec0bbd515c12c4b5224380784fe
      https://github.com/bluez/bluez/commit/84628e5d109cbec0bbd515c12c4b5224380784fe
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2024-03-14 (Thu, 14 Mar 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Update minimum LC3 SDU size to accommodate 8_1 config

Currently the minimum LC3 SDU size is set to 30B. Thus, if a source
uses the 8_1_1 config which has a SDU size of 26 the sink's capabilities
won't match and the appropriate endpoint won't be created.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
