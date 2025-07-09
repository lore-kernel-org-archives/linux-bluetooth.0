Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13313238D57
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086849; cv=none; b=fBtU6izfA7Fbk98n/SaALGMvpNjRqHHP8CCOJLO6zNHGfT7Ijsgt1Kdkd+qFWHY2GYzLRVQlLRaFV5QH7jjgEDn39tJ1FJPIm6VJ8VMxksfoT3hLmE20ddsGp6wojP02S0+MeTfVDhGKZM7T1JbaTvWY5rm3u0+OGAgl9iym/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086849; c=relaxed/simple;
	bh=gC3PjE6x/md8qaaNOcl7dyh9wstG236ke9U6eC9UAsU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RR+QNt/Sj+FD0U2jDEqq50CIU1iUwcxNuenWNf1aaAdwGEvj4ddKC+dqv7Gp9RJ299DzYhkdvNS7iiD9qIGMhg+qIE8irKjcDZT+NQ50B+Udro4O3wZLNp0Hi8w6u1lSOvXjwNfWUV4WN5AaPA5DbD2YJx7E1J8o35Da9+dJfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E5zREPqi; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E5zREPqi"
Received: from github.com (hubbernetes-node-87ff4d4.ac4-iad.github.net [10.52.181.48])
	by smtp.github.com (Postfix) with ESMTPA id 2D3A47005B0
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752086847;
	bh=vLnuj1u2m7u6s3pLsxbYwiPCBzV5tFSE3K+OK0mGW4c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E5zREPqiPwy5H0Jr3eGfccjiernEwpi/dL51dba/JqYHilSSzgbF30wMFcu8hfi7d
	 39rkCGoTOhsxu/3U9gyoT6Jh0skUy54lahVdgEqCY1Uly6QY/UkzCvALtdMz0yAVFg
	 0+svK6ftYJR+VGZHtAa1GAO70C+pN3kuW8WUMKLg=
Date: Wed, 09 Jul 2025 11:47:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/24a327-784607@github.com>
Subject: [bluez/bluez] 784607: btio: Fix coding style
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
  Commit: 784607f89c9d6956420f252965ce3ce8a0b13017
      https://github.com/bluez/bluez/commit/784607f89c9d6956420f252965ce3ce8a0b13017
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-09 (Wed, 09 Jul 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix coding style

Fix going over 80 columns.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
