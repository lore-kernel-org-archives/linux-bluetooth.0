Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADCF2E36EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451429; cv=none; b=BMG6ENKJCzt1E+mxTSKu8yK62Ro4xGlnTnvBAY6us5zk7rZ8iSpMj459fYi/3kU2TD8GqlwM4bvYxuEE48fZASOD6GyfiTujc1vCDZoayUGmqT4ozayYl1yXXfkd1h4tLJrTIOrB1U7JH2+SulHycJ42CSoU+Nf9/0CKL90hjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451429; c=relaxed/simple;
	bh=tH51lcfKMLKqgt9RiQzfv0LTaKY6RT8023bhv8Mhjyw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=febyjKvzQ6bgkMU4a2UZvn/3/7/KFuUoCe6vGkkq9vPsZqpGjZowew3DvnmpS9F3hlLh3wSNfV5zAahCILK4H3KmNslrhk0gzSVHsxa1D7wtanYCqbVUSTDQkY3+y/++Ec55xxKXPxU8Dsal3TKQZZQVHCiwgvfUVr49MEF0sBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bB2c1W6D; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bB2c1W6D"
Received: from github.com (hubbernetes-node-bc27a34.ash1-iad.github.net [10.56.201.78])
	by smtp.github.com (Postfix) with ESMTPA id EEF59920836
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753451427;
	bh=uGq6XIgw+Nedf4q3p/eLopq5MmXRNyymRjK4ele0VRE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bB2c1W6D1/A87RrGDHmZWOsFv+3bAr6sJXAxD968+q7HXmljqYTmviSIlNCubMS3U
	 +gkFG5IwKxP1uJqh+5iVJ44qkSgGbN/tTV/H8d7QJe5qLr4Df6GUCTefH539dNOlNm
	 yI9rNTXn7dvQv3NT0ODXjNB8U4gckDjQ4Gm6Lnvg=
Date: Fri, 25 Jul 2025 06:50:26 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/da772d-00ffc5@github.com>
Subject: [bluez/bluez] 6939c4: btdev: Add le_big on BT_HCI_CMD_LE_CREATE_BIG
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
  Commit: 6939c4706c908541278aab9ddad5624f2c32744d
      https://github.com/bluez/bluez/commit/6939c4706c908541278aab9ddad5624f2c32744d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-25 (Fri, 25 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Add le_big on BT_HCI_CMD_LE_CREATE_BIG

When handling BT_HCI_CMD_LE_CREATE_BIG create a struct le_big to
represent it otherwise the likes of BT_HCI_CMD_LE_TERM_BIG will not be
able to detect a BIG was created.


  Commit: d427a2a5f1977f1620dc9128863ad0d64d056ccb
      https://github.com/bluez/bluez/commit/d427a2a5f1977f1620dc9128863ad0d64d056ccb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-25 (Fri, 25 Jul 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix handling of BT_HCI_CMD_LE_TERM_BIG

BT_HCI_CMD_LE_TERM_BIG shall cleanup the BIS connections and if there
are remote connected then they shall be notified with
BT_HCI_EVT_LE_BIG_SYNC_LOST so they can proceed to cleanup as well.


  Commit: 00ffc553a194c2ca1db52dacd42838a135b4ef65
      https://github.com/bluez/bluez/commit/00ffc553a194c2ca1db52dacd42838a135b4ef65
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-25 (Fri, 25 Jul 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix handling of getpeername

getpeername can either return an error set in the errno or the
returned size can be invalid but in that case errno is not set so
printing it would generate bogus message.


Compare: https://github.com/bluez/bluez/compare/da772d62b295...00ffc553a194

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
