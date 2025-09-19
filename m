Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C232BEC27
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309588; cv=none; b=fO7//W48r8c5kqhsTcmvFiWkV9fD88HcrtaMgNFqjdt8M5WJXCfIw9rmjr7lUG/9VeIDB6MGCG9CPxlrZbYTCrf79p9CKsP5TptDQRWdb3nv5RRuA/iCvBJL1Agxj8AqzSLZ+rdi4CxszDXjEqnPgVaETRSxSO3ym/M+cab9EX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309588; c=relaxed/simple;
	bh=LBozaph14m/kAzzjNXCk7J00B3METFjI/5JGRI84XmM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lmwaaIadf95yi0p7PKOxeKxFwd0jZr7dwBYHiOJ2tMYU0P58JH7KysVZXctGnoe6vx1DnVro2ny5r/R+5wK0760XawfkMK9/VOPWSZ6Q0sB38dZIMwKAa6OuWcqLrsi/KilYnP96RhQUyZd+C7R9sGcLp6C3pe42VKPlfThJ2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A/8pv2bG; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A/8pv2bG"
Received: from github.com (hubbernetes-node-3dbdc0d.ac4-iad.github.net [10.52.167.40])
	by smtp.github.com (Postfix) with ESMTPA id 1F0A5700DA5
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Sep 2025 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758309586;
	bh=xIEXH7O+65dPvfyCgFhWmi+5Kfita5sy1QgK7PKA8xM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A/8pv2bGHlY7SQqF1DZegX+9mfG/CjJfnCOvX8FxmT22eVqN+R3QvIa5e07SLY9S+
	 1IkPletMzJYfLe6R+IZRrMaIncZZ1jeRtVRMJjDXuQUtr9EwgLba2FxCncuR+Y2rYV
	 W3SkHgf83x8KDibeiHlKdGSYQTrIyUYqCdyEtFn8=
Date: Fri, 19 Sep 2025 12:19:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1003939/166210-000000@github.com>
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

  Branch: refs/heads/1003939
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
