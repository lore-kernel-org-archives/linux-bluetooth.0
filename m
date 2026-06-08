Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727ED3672BE
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918186; cv=none; b=Rhh4sy+ZEj/chhTOwp7EGgpnHXmDyKmafKPlz1nACNAPG4rjjqDx1x3HrRlTYKq3O8s01BwMC7k+2M+R7OXPS3+shu5EWLQBUAQmN8u2xjcGyJdyXg7prVl64lVvJn92yOj0Tn3X5m4Puc4xBeShN4tlvdf8oKzH7m7O6xC9RZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918186; c=relaxed/simple;
	bh=LQUyOakIJ49V21HHsc+Oe4fQpwVJbx5AUWI+X3/p2zk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YWM+Fltb8J2tiYPbWOmTM5lkB5nDbF3bZ0xhXT9CXVe9jI9+Z+CGHZbqwd/GpYgiprbaxthFzpv/Rk9prYy7NtBLCpXOEgYA+Y0vuHzSUu/C0P5J/FybvMyCNp79uEQgkT4HIT79xkSfjtNTBgs10oxbPJqZ+fv41h1IM4lcT9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mq5+pxSO; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mq5+pxSO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780918181;
	bh=BZ6pZLLjDAfhwyvtlHlSjBN6oThltplg9Ngicn11bGg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mq5+pxSOE54BBMYxKhtZl95/TEwQPUMv28wWWbgxQ77wlxXn66hFg4HoNuRzLw/ri
	 4rqJDC422NO5tayWmMIHwKbWieooBPDIoPUacKAzbbS+3B+edr/L48lODOkYO3fGxu
	 8Bv7AV6mSaAMLXrgdcbo1GV16lx1fuqLQlPSM5kw=
Received: from github.com (hubbernetes-node-7652e94.ac4-iad.github.net [10.52.83.31])
	by smtp.github.com (Postfix) with ESMTPA id 8CFBA7400FE
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 04:29:41 -0700 (PDT)
Date: Mon, 08 Jun 2026 04:29:41 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107783/000000-78a1c0@github.com>
Subject: [bluez/bluez] 78a1c0: bap: Fix CCC value for ASE control point
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

  Branch: refs/heads/1107783
  Home:   https://github.com/bluez/bluez
  Commit: 78a1c0fc320e63b4da717c4aca293ddb0a44dafd
      https://github.com/bluez/bluez/commit/78a1c0fc320e63b4da717c4aca293ddb0a44dafd
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Fix CCC value for ASE control point

WriteWithoutResponse was missing



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
