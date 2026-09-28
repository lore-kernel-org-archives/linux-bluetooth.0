Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BD4FB9B5
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790631122; cv=none; b=RW2KXG5XtNo63aXYpNoDCIE9J7hT6h0mGUcWOvxQammw57m/IzRVNMykXMHVYv764bo6C8OXuuvbKF2oxsciJGgydgCrJtWkPzSg41ZFpqJf7Y4d15ngIrp9FE1biXBsNXOzVDthVDsU7qfmuvin3c4vL6HR2LHP/3/WoGxnBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790631122; c=relaxed/simple;
	bh=ICp/nWFeD+gceAxEopwcw28X8m/GgTfPyvqOnew7pRk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U9cwKFPuy3dtZHzV1ILo7rddhTWfGJFhX5s07Zoj5vjQ5ZPUc6FqYclvHKX9vvIjobdS2rVUt60Ozh+e1S9PjZrTb87Jn/rCTiP7BCP62W/c48tCNrvZwmUDxO/8C6YK5cQ87KRh8xDUJB4QiHn2wSdnaTOeVJqLx52sTFgvACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VZth2RxU; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VZth2RxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790631118;
	bh=HBduS1azHeykAqIa5qi/2VZiZH8ZDYtWLzrQhaZSdn8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VZth2RxUkZ47jYB/laEI1o3aaiSiGd/9OekA+G4Bvfrqs7gEbFpAGYv82JL548b3Y
	 QIEdb4PQCUPmmeoFYIcjqYDOTUL3EJDFnA/BJawfgJw+DEBwNTRz3/N+hTAEkQGmab
	 uWRsYbyo754Hp3CvkYn1dgSePwF0WfcsZaMUXsiY=
Received: from github.com (hubbernetes-node-e637f89.ac4-iad.github.net [10.52.202.57])
	by smtp.github.com (Postfix) with ESMTPA id EE593740625
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 14:31:57 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:31:57 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173750/419a14-000000@github.com>
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

  Branch: refs/heads/1173750
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
