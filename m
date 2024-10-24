Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235D1AB6CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786782; cv=none; b=Uq9zqUZOstqQeTxmHl7CcL5HXmOpKT9CQvISFxm0739Q3B7YFPp9xFHV6fwRicECnYgshI1fGL0Cn+3E/0QAMO9GK7zmuaYyoaERb2liCB+xpi5vvimVQmGaPIL+HqDGBKQvaETFtn4AKhI8eL6UrRrriLnCU9a9Qbdanxl33/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786782; c=relaxed/simple;
	bh=aQn8n+Mzj4iw4BoyqgXhinvfawD7PBM2uRXf3ztlFn0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WCuztt6VsQdu+PrTea4HWbKsndwymtB2BF4YiK9aEB+bQAomj7cSF1xK+CyWQHpP6SqeXt7y4E5IRwktNWZCyB6n/ieYyWRasiMPRPF2dVYalw8QJWDW4Z4U3Jp8CTsEP5Fwf+MvAAHdGosyQuJEGFCAk1XNEhwcdSXm99Obskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gqOlJb5X; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gqOlJb5X"
Received: from github.com (hubbernetes-node-e84f3c3.ac4-iad.github.net [10.52.142.32])
	by smtp.github.com (Postfix) with ESMTPA id 84FB25E0A10
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729786778;
	bh=W1amd+WOqieMtgCrAq17hJ/XzXbLy1X8a6N00eevO6k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gqOlJb5XxLWtN3pgAYQNndgNbsO1VJhwa7mAZJDwI/J/IoWO8z2pLTV/SWLzxEhdk
	 DXaMBhn2NnfeXh7cYO9GDivwGbDn4AdDTN+c6k1z9TPGcfyntOM8qX7MFj7KicqgN1
	 RYScnyWjKs2/BC0RuzRhbq0i43W/10j5FVhCLIjA=
Date: Thu, 24 Oct 2024 09:19:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d35bae-806a55@github.com>
Subject: [bluez/bluez] 806a55: shared/shell: Fix not displaying first prompt
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
  Commit: 806a552d53c787c0ddea9328a09b0ef124bca26e
      https://github.com/bluez/bluez/commit/806a552d53c787c0ddea9328a09b0ef124bca26e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-10-24 (Thu, 24 Oct 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix not displaying first prompt

Sometimes the prompt is not display when it is just set once (e.g.
bluetoothctl when bluetoothd is not running).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
