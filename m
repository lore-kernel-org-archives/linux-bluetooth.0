Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BCD271A9A
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766033; cv=none; b=MuUuUJZgVnvM0N0mVcdMtO3Czl08474vYY+mwB0M5Zg4+1gcTEZeLWOhTwY+P2QhDoo/dTbnsWtA5YYd9LgsB6hOT1XdeA4e8e5Z9JIIMh0CFyGWUhrXkZ9wRSESIzg3uYWlk7ueO/POd56t5UWTVaXSQFWuI5+P87RkHJT0oEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766033; c=relaxed/simple;
	bh=ZqmJT00s/3qvr8dnNNMXvVx2uJTqCPqezJF1AsBo51Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=d7nk/Tpv02pOa5EDhpsvrKtv46qigwi0I3gpjXlvgWzpq9yP2eQP9ti6D2i44wXpWZClfbCZwM3qnFuydN9syYb2mFAah1VSBC6Qa6Fbo7OB8XzENo1wAEsPEM9mRxCtlchDSuZQPD77q5AGzxMPNUwujYSLyx2/sm21NgVvCgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Tn28dNpY; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Tn28dNpY"
Received: from github.com (hubbernetes-node-2076a09.va3-iad.github.net [10.51.99.31])
	by smtp.github.com (Postfix) with ESMTPA id 8D7939010EB
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775766031;
	bh=AUvA+6igx1qFFKZ1BbFEy90blEtUwW8AIoSsJJCD2/o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Tn28dNpY4bTq9BLfE+Aj69Rep9vdgy77KHZZIogLMLiNQxtbmKm4exZJfe1DHeqET
	 Tqcy1XdjLAcHKepAi9Drdif74vBVA4G8ErEqvdu5QrLSaNeWiS5EXdlHgK6AenwP2z
	 8rYSiBRGdZfGrb/G4b+f6mHYN7CHEWVhhoTUrtvY=
Date: Thu, 09 Apr 2026 13:20:31 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1078829/e7cf12-000000@github.com>
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

  Branch: refs/heads/1078829
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
