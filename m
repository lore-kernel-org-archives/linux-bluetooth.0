Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D430DEB2
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370632; cv=none; b=omDUCVfYCm4v/BDrlwd018umVKkaUm9GId7/S5BKwvfq8KeLo040fYgaYNjAT1NQg+PvWYR+R9bf5M6z1bNhP28T3ajYfPG182WUocx9pgWR5C9QuwFKFoKn5ueLeIidYjfpEp6NSO7ERnV5vwPqRUILxNyVmUfYaJhwgXNGzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370632; c=relaxed/simple;
	bh=mh65kNk6NqkJ5NILBVW5kJzfnolrcIn2C+6KcnhhJsI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IORd24G1+q3IT2Sr/Ef9GSUyqjDcXXDxf/QndYuLW2qkmHSi0yyjVnhv6uVf6RSlAvb4NqUh1pnZyrs/ohEmTX3glHX9C+gPRA6JmqiVS1I+5ZzPHr8CIPwiqYVIvldpN94/afm0ss44j2KNG5ygpzM0X57l1/5GQXdH+nSgs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PFWM0y2P; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PFWM0y2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777370630;
	bh=+tooMri743oGYif1QhGg94SzQEyffA6ubebkyZ5b8ys=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PFWM0y2PB5CFmlohFTP89YyS0yuIYkCETrif/ZB4ycvzLzI7fFyvJdyr4bbFqnIyA
	 PnLEvR+YdRrmUsIxLzpgYz5MGQPxoUPb0AOgTiQSqLQFj9zqz9Zsq1rRDFmNHRpFnf
	 300CKE1dN5m/EM/j2bFNIgJaHPA/uPF/B4EaCdZo=
Received: from github.com (hubbernetes-node-27ea65f.ash1-iad.github.net [10.56.224.61])
	by smtp.github.com (Postfix) with ESMTPA id DA5456010CC
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 03:03:50 -0700 (PDT)
Date: Tue, 28 Apr 2026 03:03:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086318/9100a7-000000@github.com>
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

  Branch: refs/heads/1086318
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
