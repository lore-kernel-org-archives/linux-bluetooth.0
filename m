Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE23093CE
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766132272; cv=none; b=HMM3RmbnwvSQoeximxlNaaghAKk35aLYdR/3EQABysrUmFGAcBfeECp9PZ/HbYeCw9m5CePvIIHxLUa+nPcg8ahaspas1ayYiIHHZtY7h6lgakiidkW0riCTnq3kWC/ix1FTrePa29tVSoWURY3Dfl8YlCkGd8uEmp+LNbLTAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766132272; c=relaxed/simple;
	bh=gGCP/6TUpd1lq8DbvVK8LO/NUDca425F8vbcRSksVA4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HBZzMryISYWrw377uFwdcYkoYT5H5gBY2sHcyy7wo6ZPfuzuA7xahdOtjQKJHl/RCXkBdDl+d8KnndVqOhLrTGvC1s7ILSz1Rxr0oFvoHjWhD+GG/5NcRYDTb6ME6xZMzDhv6cXtUKrZETV9V3TuQdI22GkTyzf98b7IpX/YkFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S94sfYEg; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S94sfYEg"
Received: from github.com (hubbernetes-node-8236f14.va3-iad.github.net [10.48.221.80])
	by smtp.github.com (Postfix) with ESMTPA id 0D97FE0BF2
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 00:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766132270;
	bh=51wutAYEPAzg+t9vTWO3T5iLT37UQmE6nKpzclExnTE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S94sfYEglki1CAK/c0PAFW5IqpH/mTutRZzKscJJ+pR3D0Idsm31+TmQXcu4BHCD7
	 t3RQfaLwpVyxmjmh6eZ4reBO269vDyLxj9LLHC/zfihmEs5KxINpILSd3hR5vXj8tr
	 K0hCvWun006470ze7rpMP3Ptfw7LZt+ajKUqTYOk=
Date: Fri, 19 Dec 2025 00:17:50 -0800
From: Dmitry Baryshkov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1034905/000000-ae4c1d@github.com>
Subject: [bluez/bluez] d490c3: shared/shell: Don't init input for
 non-interactive...
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

  Branch: refs/heads/1034905
  Home:   https://github.com/bluez/bluez
  Commit: d490c3e1d08d53580ac08ad12be57ba92ded61cd
      https://github.com/bluez/bluez/commit/d490c3e1d08d53580ac08ad12be57ba92ded61cd
  Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
  Date:   2025-12-19 (Fri, 19 Dec 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Don't init input for non-interactive shells

Only the interactive shell is supposed to read comments from the input
file descriptor. Rework bt_attach_shell() in order to stop calling
input_new() / io_new() in a non-interactive case.

Fixes #700


  Commit: ae4c1d79c8b33cd5f78fff1abe91b09f350135bc
      https://github.com/bluez/bluez/commit/ae4c1d79c8b33cd5f78fff1abe91b09f350135bc
  Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
  Date:   2025-12-19 (Fri, 19 Dec 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: make bt_attach_shell more obvious

There are only two cases, interactive and non-interactive. Make that
more obvious by using if-else rather than two if-checks.


Compare: https://github.com/bluez/bluez/compare/d490c3e1d08d%5E...ae4c1d79c8b3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
