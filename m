Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDAB2030A
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Aug 2025 03:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754450177; cv=none; b=RM5DRdAIGlgP4esoVPVgOM+tYUWr/kYAHyiF5DGac+WyzKmMrm8hc50qUhu6FGyIo5kooFt0X5ACGkFlNHNObbLxmeW9QM4esnVu7J9pTKdZOjdZTcjP6EewFtA6AZV+hQKJ1PPJSZM3B4aI/LgXsBPmVKZ/TbWa7J7ff6zTyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754450177; c=relaxed/simple;
	bh=Sxnf/Uo3RrSo7lfEYVtgz/oKC+Ya/IVWbAICLiUpsuc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FtX4kfvVrqdYV6kZy26/biJJkfkLPbSQ764Of5rlPxn2qSFzFvBSTcJxSqOgbnJjD/mZlBEHfNpHXFPFI7O3Om/DFrwgjLOlttHpqyCFMoGwFC9lNps8u4I0tF5sXBS3bz0KHpvBX25gQj++/EqJvjVWxA0sqMfISa6WTHrxK+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CP0B/t+4; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CP0B/t+4"
Received: from github.com (hubbernetes-node-5a2bf5c.ash1-iad.github.net [10.56.128.54])
	by smtp.github.com (Postfix) with ESMTPA id 84D8A9203FA
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Aug 2025 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754450175;
	bh=REw/DDNd3rHtN6rXlQEdvN/iT178ALYUjHKFDulXXjA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CP0B/t+4EfxC60FiOp5hXWn3xihY7K5b6Xf4qoiWmpHss5RhpOHskiXmX7PWxdbtX
	 PScRw/5/eh/wjjnTQIt3wZGTTTEPyE7oNiWD8Qj+uAWK+WyGuL5cUKbJ/ApMkRbsev
	 P6S0vbAMNWoAQ6kGexonxcm+qs//NWWs+412+70o=
Date: Tue, 05 Aug 2025 20:16:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/988588/94ccc2-000000@github.com>
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

  Branch: refs/heads/988588
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
