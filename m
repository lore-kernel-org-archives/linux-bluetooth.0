Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D091C07C3
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754852127; cv=none; b=mx9j3FJrLRKYm5WCY/rHZPG+ChqS7hFehgC1Ny62ijDlxlw47/B/coXJnqaHhNue6KtjEpvrHDo6Lud6ZcA+yAkrOQvehS7NSU1j1/S/cf0P+t4sWqs/9BzYzJz11/Vq7GyHhWHcI41Q8K4gTKIg0vvnlWvN8Vsc5xYkwQHzypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754852127; c=relaxed/simple;
	bh=+g5fZiYh1n1A4zsGP+Saa1+YbZFwLvx3nsZaBRRkzYw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bb6frCS+45JiHd19b3dnrZvP/4mdF57cNjK7hzGkaiE1ml9wjnzqu50TgXeqRVzzZkd7EZnjtMOCzd6cncjZ1ck+9y1iF7GYYpSRYtQdMGkl5L5JpIaixeJYKall63YaVMe5q2QY2NXu6+kL0+BpvoKvx//PEIiCXMQ6ZDpzLLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V6jbPwH6; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V6jbPwH6"
Received: from github.com (hubbernetes-node-fcc9a3b.ac4-iad.github.net [10.52.182.35])
	by smtp.github.com (Postfix) with ESMTPA id 5CA377004BB
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 11:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754852125;
	bh=SoVt44WOVX3jx0tA5TgFWdOox3TOoIKY5aAOovz1POM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V6jbPwH6n5wd+fugduxiKLUEOWFV0bpqMcgh2iu1ftciu3coL+pGgoII4YNNDjqIg
	 t83NonwoJsWaFrdGhGd/xhKyp7o3Lo2jPt9Cu91uD7TlRT1YgU8xQn5nDN+RfjL6Bu
	 h1VAPhct5xc69miQEMqv+awpDeEwGpuWH3O1k35A=
Date: Sun, 10 Aug 2025 11:55:25 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981619/60400b-000000@github.com>
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

  Branch: refs/heads/981619
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
