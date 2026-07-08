Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E743B6FE
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512562; cv=none; b=Xiz40S5YCkwgAGuzbCwYnTgw99GXccZ5q2bZ15xIvF6MI//RUyNoG7PIWac29jAaBRj3kBtYRQJ1LJhbNnCPyVUf4G7/AO2xqBPeA6sy3ELIJHfdvbd3jfJU+k6IkthlGcwUwXmM6BcCPrZJOqHl5uajY1kGmBSDIYDCzuORIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512562; c=relaxed/simple;
	bh=AKk5XilfAjcSbiDUxSr3LxV5h0BXOHOyt1qPlC54Oag=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YHJA4+4/Et5H3GVYhXM4Fi03cLRxtlwXCVBqFQ6svo1hC5/EalmjCOFF73LIz3pRg3uqCrx4bVg+m6FjOgkz0NYYeibWy99lpaUAeAcxyf3JZDhJBX8ZZqpXP9prekz687kbSgp9Q6kBi5RMF1OOTvNHAyxWZxkxabqxP7dfHFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K7kBPCbC; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K7kBPCbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783512560;
	bh=PqIEsZdCuk3z86yQHg98aThHyxK26dTeundbkglNhsk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K7kBPCbCp04fVRPJzpETyxwjZ3NbxyGByJfDnU72sqOwJi/UkIIyNoJhHf3ffivNv
	 5Usi/ep5de7uDXwbL3ZFDUtIOwB3haIkyZGdXTk6edTNN4ReYrgH5t1sPGlZL+cLL4
	 50G2thippB5DMcRWfEPvRHHHDfsuh5v8LIP9yK18=
Received: from github.com (hubbernetes-node-a4ac5c6.ac4-iad.github.net [10.52.159.31])
	by smtp.github.com (Postfix) with ESMTPA id 0718078E0EE
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 05:09:20 -0700 (PDT)
Date: Wed, 08 Jul 2026 05:09:20 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107778/435c7a-000000@github.com>
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

  Branch: refs/heads/1107778
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
