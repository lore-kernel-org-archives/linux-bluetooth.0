Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809333E349
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885506; cv=none; b=lt/+vytRZwTwq5+kdsxw6q/+CKYNgvEFrEKdbk+YNotj6s6bx3P7Mztr0FdyJMRNbXBzQRJEUsxh74AU9j/C0v7nPmC6hA/ZCPejkWI8l78B1wlpS9SfxxaaKd6Cu/13oS8dPTXKKuS8fKcCyzCcUyzFLJ3HKtPejbI4Yfelcdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885506; c=relaxed/simple;
	bh=JXIQssy7T6riFBe+612FXENWDM/a0gGoa2VADMmIThg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q1nKsQaTm1XUeiCTYGHdXKZCUpGWF8/JLY6o9MTo12RaRIfrauTTs99zCdXvhJug3K5cqO9GauHwpa6CcupYCnH+3I+ZiA0DOcNisqTJnlnv8rxVugP4R1aEt1CNdiaJqWZwjWj/Wyu5RJmqqPf/9/F0CF7r73EBWXmivg4ioWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nIt+DWbY; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nIt+DWbY"
Received: from github.com (hubbernetes-node-5ec38c4.ash1-iad.github.net [10.56.212.54])
	by smtp.github.com (Postfix) with ESMTPA id AD56414121A
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 03:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765885503;
	bh=+I5uXnQb/2FNiFpHsIz8XVdGHWwnN5mSLg1mAIuXiAE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nIt+DWbYMi5p4iqgm/jZbNclwH6pdIaTkbuo9+iuO+cQI8YI+h19UhLEFCpvgG1EB
	 lgS+6safrWf6m/4YaRznC0nPHvsNOfjdQXAS3m/1sd4oJbDJKLWzxx4omXLxfoK7uU
	 nx9AbMtKfpm7JwtbQKC57L0JbvRXPjipFTwOn4+Y=
Date: Tue, 16 Dec 2025 03:45:03 -0800
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1033733/000000-b6db9c@github.com>
Subject: [bluez/bluez] b6db9c: doc: Unify properties section name and type
 names
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

  Branch: refs/heads/1033733
  Home:   https://github.com/bluez/bluez
  Commit: b6db9cdaeb7bc8e32afd6f82d73b25655c882348
      https://github.com/bluez/bluez/commit/b6db9cdaeb7bc8e32afd6f82d73b25655c882348
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-12-16 (Tue, 16 Dec 2025)

  Changed paths:
    M doc/org.bluez.Media.rst
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  doc: Unify properties section name and type names



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
