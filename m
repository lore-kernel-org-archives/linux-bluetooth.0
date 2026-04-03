Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49423CA498
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238955; cv=none; b=Xt7znrt4lH1V6nAARL+V+ykyARiPOeIPkDDzAdmZKjzZ3xFQbMHuse9lMGhjLbiDB0KZYJrOPn8YJMYOjhmyuoKeLS5CC/6SWj1F2ZG18/wOSz8pr4c0o3ybvg/Bqv70k+mYvAPbunyU4nWVlb+LrF4Eef6egQoSYm6nPlFR/hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238955; c=relaxed/simple;
	bh=SUKqfxIXx5lmUcyWxVxv8RdjJcNj2wup/69FZ4H4WCo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EFv7xrDnKPZhil7GsstxAujCxpkyXJmrkRLG1bKBEd/osJf94Dfs8akSjyBcan2XyJ1ls3+3/kl397iymlEi/HtkMrjaWoAHIg2gFUp6pE6FefOUZWwdcsNiEAalIje70HcRKrRFUOvo9dZMBrH30aHcm0DUCbB825piYFyhr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ut7P301Q; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ut7P301Q"
Received: from github.com (hubbernetes-node-fc6148b.ac4-iad.github.net [10.52.152.31])
	by smtp.github.com (Postfix) with ESMTPA id DB7DB70107B
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775238953;
	bh=goN+GVFjxNKpD5jCjBLpdDFtToXeqX7S/4RBiElxH2Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ut7P301QU1H+T2RSX0xFk0OqNIsE1o7DVl+JsxJNb7oUMqtYK65xvXQ66tvmJyyVo
	 77gtAGP0WDz4CJkzEZ2cabh1poW8NWN2g01VMj7nbsK16iOEy4YsEyN/7I08jrMO65
	 jl5rryrqNrWKzY0kgN7ExbnHk0YNU4T9ONYfZfh4=
Date: Fri, 03 Apr 2026 10:55:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1076592/c8d25d-000000@github.com>
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

  Branch: refs/heads/1076592
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
