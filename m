Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1E381AEA
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773960974; cv=none; b=s1BLBrjwPWoqH9fkdIy9zGrTPuKD3YQaxY3c5UQyhKF7RUpCAZXUYGz13tO5HBBgMXgFgiW0jPoMWJswt9tKq1GPk6BfZYMhgiZ7w0ueAwn38URH4OJwxFBZSkBmOUv3u44m3rIMd7k5i7pILN0gkVcHpRXdzbvF6gu5XkK7ktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773960974; c=relaxed/simple;
	bh=rytgMnUOFQOIOiBOSyeigVBrAeugLvrZ4uVFDAJ4i2g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OoHlKMvUUGOjOprQ2l4E6tgTBOM1KiI+xkRyDos3hKk+dSe9A9/kqX7HvxLsnVfqwms96kYNREUxDj+5limQubTYuP7lZmZZ5sgeZQSsRZ99bfTWoKCFLiKYpt27Dz9kRMN9UxQaKVOYbIxuYBIONN4SrY/6q3e68wX0JPr7ivU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V//8UyMV; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V//8UyMV"
Received: from github.com (hubbernetes-node-d21ef52.ash1-iad.github.net [10.56.224.28])
	by smtp.github.com (Postfix) with ESMTPA id 1CC676C0275
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 15:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773960972;
	bh=eJecMh7FskOrpq9+DPsZPgJoWhFSUNAl/wM+t6h8VB0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V//8UyMVXxQAFJU/l3TJ/B+D/zSKwuswI9sG8oslZgUqDaRT1CXzHWByIPUGLNHIv
	 m9URmBslpOtkNaT8xUolsMQObYf+taLUBA7YbMnF/S3OivEaHmsKbYLCS7m0Pfu1JU
	 EgLlCeP1VN/jKd7n73TOFFUjf3XO8BUFxaDQomFI=
Date: Thu, 19 Mar 2026 15:56:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055023/34b31e-000000@github.com>
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

  Branch: refs/heads/1055023
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
