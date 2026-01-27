Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4770327BF8
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539256; cv=none; b=EWSXXm07hX0j4oIkBBqndPUGk4+v+DuGz9DFcnI6TAW3nSy6jPmroUTHz+IAGV+7Wl3Q2SOhzCYyy4JUQs7/kkiGGRm+2O51Lym63IPcT8VtwMswVTTUOrOcPwVESHZQmSz22IVGUcd+AAMyLfhZ/0MlaO4mB95DeRkCDJmSJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539256; c=relaxed/simple;
	bh=taZ4gT+aJPCg1f5QcJ+ADoq+52XTRjx91eOZ1ebASps=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=klDeBPXSi323oHit3jZ1/n66W8ttQpmHKIJeMbs8iZN5IAqiXuKsgUROfddKc+hmb7geVIxh0dVhcq2NCH6Mezplny5YQRa88xUlGdQmR4HE0kc6XMOUT6laHwhi2sjkSqjsymVbafbwo54qgVMmSgKCr1fyBi1ynvZrB7YJJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jy3g80ES; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jy3g80ES"
Received: from github.com (hubbernetes-node-481bfca.ash1-iad.github.net [10.56.225.57])
	by smtp.github.com (Postfix) with ESMTPA id 2E278141268
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769539254;
	bh=w4nLsUYzjefCn/OfiFEkOoyFd7RRSjuUlOfYkT/Fb7E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jy3g80ES44aJkZeaLtZaIcBpu7JXJ6bieF48Mod9tXtReevx9IgefHHxMMbUxP2Nf
	 2e17QwsMkmztLDFqypGLK8RYZR6KVBGAEKHbuGJBd/XPc8H7zPdjQosWtGpoIFsyys
	 fjU0jRzF4lyKXQEXsptMVIxSbzlEo6TXEHiIWelo=
Date: Tue, 27 Jan 2026 10:40:54 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1047702/3d7d42-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1047702
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
