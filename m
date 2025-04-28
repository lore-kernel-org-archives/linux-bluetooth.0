Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4727F25F79D
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853258; cv=none; b=vAzYhgnTkfcYtZF4Iown6y2LHac2MjK4XiWBaXG0Jr9Vho40HJkCF/zth10vn9WO5H+kofwV/pMEwCsWdTxdGYiPrTCpT71ljV5El2QolnOMtEjv7j+wrEko473euTEloBR2qEmucbSnCh3iakc1KUFyi6rHO6IlWIgZufSqnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853258; c=relaxed/simple;
	bh=QkdDiIAxxs+OMdtqpJvpXj1p+4tplBG1nbE0pbO77JU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lPd+hMW2DNeSH+GGETMAJ1QzB4ab1Y+SwI55b9Y3gpO4vkYm6CJqg2zxwmi3Lkf+Itrc8LkWiQl5RQyxmNdS9njVec8rUCSVLnzqS5kFV1NFZC4cP+PAVRkTA1SDkMiK1GOmtzr9gc/0mpfyacvirJLInhhW4USMLFNE2Pxonx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RF3fwS6O; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RF3fwS6O"
Received: from github.com (hubbernetes-node-b2cf291.va3-iad.github.net [10.48.163.18])
	by smtp.github.com (Postfix) with ESMTPA id 5590C8C087B
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745853256;
	bh=dOf9F3sihkgRjBxcsjpEXhB5VT/QUXt+4bhFewXUPPM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RF3fwS6OE6+PpN+vYUJhSdRvFv63wfnHwlSgA+BckTkXwycZA3gmQeD4KY1Sscfg7
	 HernFSL92RVo6f/IUxrVpsgx+A7RcxdrNFQ3ABCYy+l1e3ArQewpXByeFZ7a+OMuP6
	 F0/NvMTT+lTjDnt1lLkVyERuyZiUtHam7qmPq+9Q=
Date: Mon, 28 Apr 2025 08:14:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957482/eff3c7-000000@github.com>
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

  Branch: refs/heads/957482
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
