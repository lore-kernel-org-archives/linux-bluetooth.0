Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B8221726
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729492; cv=none; b=TnQz9XxklLLfzu7lmAM5woI+8JgiavM9F/ULev+8TksgsiDWQokcf7X8QiUxB0+/sYNjVB6poTESpZFwvA9cGiN3FdN8KOVNxx8MB2fYYNBhpDbYMKfplIJ3PDFXYJn5ECqUEIEyOfFn5Z5JyC3Flcj6QZdIdDdjauG+BeQEz8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729492; c=relaxed/simple;
	bh=X1fT+0VXYk/yHljuXobQRFI/3aOdGgAmAOWmcRWu6vA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a3Qp1zIbRpLnI+1SN6kOF3pggsiCbbh8GW7g7OAp7q4158tcHWW0cCJZ38APuXKZdYbfkWesZcy2wv4SoYou7NKXPX0L2w/kPE37+chGkRf23mtQimVife74Ok/Q7sU2ZEMLW7tqj3eXPtSASuEfPN1JZc9g+v2YOArUPG2McXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lhlwjQFL; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lhlwjQFL"
Received: from github.com (hubbernetes-node-2bbc117.ac4-iad.github.net [10.52.132.21])
	by smtp.github.com (Postfix) with ESMTPA id C31216407A4
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758729489;
	bh=F8ulOo7c7U6t0E9Ux6nj/9apmU2tdRlzfWFv8OsnRlA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lhlwjQFL86va1pPrZwbJKds7mWfLjLW1xRwu5ll0Mn9PyrSCg3OSPeRzbVIEwPjQd
	 0RElBNA62aW0dlL/UpsSbxO5C5pegHiJNiockKJ/ss/BvcOMYX2IOIV88WXZAWKLkP
	 MZIehLI1zu6y4N/PpraEtrncOIKNkS1R1HI3ql+g=
Date: Wed, 24 Sep 2025 08:58:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995289/8c6057-000000@github.com>
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

  Branch: refs/heads/995289
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
