Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2C1FDE3D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855381; cv=none; b=T99wGYAnrceV9UORuy/HUE/WyCzx9njELQGktgNAX+yORriI2LAyTA6yuLcbYYjslX1zIuBBjTFW7D0ipW7/yCp7vEgY4or7ACft2F60dKVTaBPy+9Nxbh2iO8oaC5Aupkq8pY2C29HPf689uTq7zRSCtFNNpmNkxXyef4a7dBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855381; c=relaxed/simple;
	bh=3nlIPQDbaEXsPR2I17Tlu2gEMwjqTZBK3lTLjC8J2Pg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dZOYjobvVPUOxiXEd55+J7j8c+bmTYP2ZZydL3/Dn50p7aVL2gfBbqotDCMEn6t2UFbhNdBk/EJ6jHCGMwOWQdy4mI6TVAwvi+yzeKwRyl/I0IouAhxWt+frIyyWYcUi3dCVVoL0H91wF0deQlf2cXu5f8XUkTf6DQL9OorzO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lN9VN7w+; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lN9VN7w+"
Received: from github.com (hubbernetes-node-07e44a4.ac4-iad.github.net [10.52.164.21])
	by smtp.github.com (Postfix) with ESMTPA id DA32920965
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745855378;
	bh=ZdrhooJlJlqxFD3/wZ5CHppW0gscINtkbeIyMFQ9VI0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lN9VN7w+9xAl2+QiXsCXorfbRNAmHd1y3OA69jSNCpML36Cg6/FXxwqFnzUkJRviC
	 oT9dxxbiCXzn3qocxVNCJUSIzZIw8KcO0uoQk9+Nr7UrZHE57Uco2+oYml3M3fIEv3
	 zPCjUlN/JOn9IUZ+e133f8L9DlHZoN/+gPlR9jR8=
Date: Mon, 28 Apr 2025 08:49:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957766/000000-4c66c9@github.com>
Subject: [bluez/bluez] 4c66c9: main: Fix scanning alert no. 21
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

  Branch: refs/heads/957766
  Home:   https://github.com/bluez/bluez
  Commit: 4c66c9791afa63a7190493f38ca3b93da47504ad
      https://github.com/bluez/bluez/commit/4c66c9791afa63a7190493f38ca3b93da47504ad
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-28 (Mon, 28 Apr 2025)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix scanning alert no. 21

Comparison of narrow type with wide type in loop condition
Comparison between of type uint16_t and of wider type size_t.

In a loop condition, comparison of a value of a narrow type with a value
of a wide type may result in unexpected behavior if the wider value is
sufficiently large (or small). This is because the narrower value may
overflow. This can lead to an infinite loop.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
