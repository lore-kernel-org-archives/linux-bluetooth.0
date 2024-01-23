Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3334E1D0
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 22:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048033; cv=none; b=KUC2yp8If26Y1TamFiMwjPQFhsOqtrE2Zz84PtlhKxIe7IbojL2T652QnYQZ2PaxXwM4O2+RgJ7DznIwmEQUPJJt9raQL8gxOuLgc4+WRUQbE98xbkdp+267UN4qw4f4QhadUDQJu5BLBSSuMYXK50QpqhQ5v83M0Ygs7YZrgsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048033; c=relaxed/simple;
	bh=jHby9yLrqY9j2qpo8S8GXZrZQlUrpXD02mjaTrMCNSI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=izUTydAWN17SFMYGyV3ybvZhznwz2FRfkn64M9DfeyI8ugSMs4HuDpg+MIKgjrLZieFjwsQS0arTe9irWDLyOPwr3extUhkLuKmACpAzM9IIibZlTvTR6VJ4r8dcr5YCC6RnzEDMdynAp4G5jn4wbhelddYkCLmHSrNtQo+tjq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Er5VdVt/; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Er5VdVt/"
Received: from github.com (hubbernetes-node-90cd870.va3-iad.github.net [10.48.131.26])
	by smtp.github.com (Postfix) with ESMTPA id A9EBB8C0417
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1706048030;
	bh=mra050QQRvh77dGzX38AJVNDRB0XlznLK7/CcOfnAbI=;
	h=Date:From:To:Subject:From;
	b=Er5VdVt/e3A9xhFtenhQvqxuAPBVkobr2Afef/oz0lDtUoykamLsSMeHpNw3wpKXd
	 9NczcXwym0YdDQJ9u5O+ohnjtw5VGKJLcxaRQi7XQIecmjrMKUNl5UkATnj/rmu7Rc
	 5+zLzXwkg2r+ifRZBVeIui/hAWwFDRfQgWvNbNag=
Date: Tue, 23 Jan 2024 14:13:50 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/15e7d5-d994c9@github.com>
Subject: [bluez/bluez] 08bf0b: bap: Add missing Metadata property
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
  Commit: 08bf0b2a85f33a09b0a832aa3c984377209b38b5
      https://github.com/bluez/bluez/commit/08bf0b2a85f33a09b0a832aa3c984377209b38b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-23 (Tue, 23 Jan 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Add missing Metadata property

This adds missing Metadata property to MediaEndpoint objects.


  Commit: d994c9d45dad68bc060add77642fdc37834cd7c1
      https://github.com/bluez/bluez/commit/d994c9d45dad68bc060add77642fdc37834cd7c1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-23 (Tue, 23 Jan 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not handling out of order responses

When EATT is enabled it is possible that response are generated out of
order, since they may come from different sockets/fds, so this attempts
to detect when that happens by checking if the state has already been
changed.


Compare: https://github.com/bluez/bluez/compare/15e7d5a4d24a...d994c9d45dad
