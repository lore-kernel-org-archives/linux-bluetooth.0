Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401CA331A6D
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863595; cv=none; b=f/3iA/MjjDBdMbOg2xPXJIAeB/OYtvZbbuMPHqGor/3FqnFgJW/UhTbSeD4jVWqR1dyWgKfZyJ/eN6e3a+bGc2jnjyMeITjoQ3uCxawNw6m6BpbG9rl7dSdSa30rnK0g6NLomh0A9fDn2GFPe4tHQoel3pTQcyj2ECMBFN2AOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863595; c=relaxed/simple;
	bh=/LhlDDK9Rnzss67aV0F2nXgtccEB+RfeJ8fPmnp4mwc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PW3/votKnNkeu6bptctacwXe7tOBMIEzknBiHufv4P9lkNeWFLB6HDw+hgpx+kTJG46BvQSkFnANmEEwXpFK5/NVWbaAN2LpV/rfG9uz+Fb0huPLteWqszxqUhu4j9t9dFyaFM7ntomBX6+gjzd4S+gmmTQ1Li036AMbK2Gmvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K99COaDg; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K99COaDg"
Received: from github.com (hubbernetes-node-b0b59b4.va3-iad.github.net [10.48.132.44])
	by smtp.github.com (Postfix) with ESMTPA id 2F34CE1058
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761863593;
	bh=SvLEDb5oyXJe7cGRpc0aiwx65s/Z0oovR19oQ5IuGiM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K99COaDgitubvyaj+oNo7yvqBitYLKlRFFI5KqnZXpw7KhQCeDRT2ODnN1YatCkpo
	 LvUXbZYCFdb9l0p0OLLZNKYTcsD6DKN3HILB+d2wDyAtCSRKIaRwc0qCBDHNEeWshz
	 nAVs25CgpBJiKpBJ/NT5M3hYt473dqnU5vHbYBnM=
Date: Thu, 30 Oct 2025 15:33:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1017827/32a5af-000000@github.com>
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

  Branch: refs/heads/1017827
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
