Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5F3E2770
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334757; cv=none; b=a7gqfCECjIMddXXA8WnuSc438+CviAYjfC+/hcG6gIbUl6X5NY2NgoAHBiAFLNd+WT5sumAI34zQcXuzJvHxyBujcJsGZZj+d/P+iIsgW00AEUQfCxGUCFgVef6rktpW8XKU2YDssoXTXofJSlvcHNC0ByyfxPwcaB7bqWDlvJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334757; c=relaxed/simple;
	bh=dsdu9ZKZrVVSK4akMiZ9FUgYLnMXI+NpxeS/LxhzXfo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=alrp/FLacbZ7EWViyHA+VOFIxAUOB8mPwMBZacxSgINFPSOvSfsqJhFn2tIbaPctRiTt3LroLlxye9LRpb6RESVaKz9gI9udSqW6HIJ5GTLdjtXGui5JXEUvoZyUoeKUb8XjguQkSKCQjZJzxJLL6jvpKitNx2IOpNwokEHwGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QRkAH7Eo; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QRkAH7Eo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782334755;
	bh=OJc+LplLRhiYV1BE1+3RojjzQ2yPrDxEQgIup6q8AeI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QRkAH7EooDEKmMP1mpO6kfY3Ial9Hem1Hg6RbTSC5CwpQE0+7gfHUTtD/614mpScG
	 2GPY/F8iMoPpWib/mftmfqorOz19sXaf7ZjLkPkea7Ly37k3iMhtMCns7L+h44qqoW
	 KYxtKpHQvgOt3tCMUi4+qezXGjQxD4F1ESaUdyeM=
Received: from github.com (hubbernetes-node-67e9ede.ac4-iad.github.net [10.52.178.45])
	by smtp.github.com (Postfix) with ESMTPA id 4FD58780D05
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 13:59:15 -0700 (PDT)
Date: Wed, 24 Jun 2026 13:59:15 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114528/f46211-000000@github.com>
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

  Branch: refs/heads/1114528
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
