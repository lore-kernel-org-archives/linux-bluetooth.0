Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF40347C7
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731563; cv=none; b=n0296DNInUNnPfXij409H2J+3kQ+8QMybom0duJY4Z+ezjcye2l+0Tbk2R6RlJXB3TZOOl5/OoAP0TvfPb0X8fZZPIWbMoqfPgil67DjPX+q9Or+bvgBK9v/MktGMeW5iTP1/I3T3H3AJwBnDQu2szxlNvpzYs6IWDYc8h4uX+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731563; c=relaxed/simple;
	bh=QEiGhtojd4rNQ4aRTqnKmnZW1nAouoc8zIV3hXhulgI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i4dJclnf+24TcdnA1sRM3xQGbJOAUZYpXfifq8T+buas5dCdAuoL6Pq548eilAVq00OUOkQ9nOtocJixUPu+RKzkDMLhMDRHGSztjP+KjY5vjFXhVt3dzvPAY9NL+6adlPyKUWICblA5I5aM8vq/jarSbajumc2lvafrlxnYBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Le1fnVIz; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Le1fnVIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779731561;
	bh=GrmryyBgdgyEBkgOnZwE7W9Bt6kdwtbtwvvs211kNJs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Le1fnVIzhbhPGcNjt0xAVSH4mqgMisOwCok+8bJzbhAH5RBZfjXUimtxL5/0bEX5N
	 XFHJIXP1vXQvyUyVN5uGRRJnRvvTSFojjqZ96D6tqnD3+CXfonHKXyW+xTIr7Qbha8
	 OlRnV2aed5Dmk7UpfcIrfUg8xmOodp6zzv3t7tFY=
Received: from github.com (hubbernetes-node-95aaa0f.va3-iad.github.net [10.48.143.10])
	by smtp.github.com (Postfix) with ESMTPA id E4BD9780150
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 10:52:41 -0700 (PDT)
Date: Mon, 25 May 2026 10:52:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1085439/06d3ff-000000@github.com>
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

  Branch: refs/heads/1085439
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
