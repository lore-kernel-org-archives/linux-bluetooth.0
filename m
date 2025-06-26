Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89A52ECD22
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951206; cv=none; b=S8nYAoa8DTmeAhu0trqje7qdX14qTVSbtMLybUWEMALCCBAmQYTX/ejhhWm1elwWx6tHym7RvN6yLsbk6myb7i5rlzHcR7rGeMABnrf0jV6Tr4VqkKp6ns+HWqkSkQWMfEPVD0f43d2/lxnLcQIwjdvbTUM/w+Hli/bDKj4Q44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951206; c=relaxed/simple;
	bh=VgmFhMir7pFtE7XkwqO5yOuQjit2wMbmfTDCrhYM5lo=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ajb6vFF/VEk42AqUiz+kUmSOUGhi2eMkloMAF4J8F99ehO4+NjxY6jSsBG87GJ4GqoapaUCY+ZyLFvMu9ERCbXeVUNoxqTk4cE6zOwEgN/zcfI2uZK4JrddIRKDnkvQGWoTopNvq/eEDa2zBH95fY/zl/mV0O1vmLAPDdP1qrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=5TaJakmu; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="5TaJakmu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:From:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iMm4FLia4o7yEtV9yv6ac4fzuOoIUPChBBlkelkuqSA=; b=5TaJakmugaslb7CbTRD0JOBXVK
	s/aTkCjslnNBbAV+6tOpMpPo9vOibY49wPnc3Anl0O7WFCEPWCImzCy/HzF2Hb6+OLnCIXmcnzWTV
	WouSdp+eDoNZJHyTvwLSxjKt/0r3z3EbQDWUvy1kQ4xL+ZlLiSa0nCEvd5wiQk73Js04EFjDSvjp8
	O5YiHuBBuq1P9pSnPJVL0DnDO149Y8G2vOCBe/vzSaDuZj2lX6wrfS4jQDTHxfcGez7Lyr5WgUeb3
	/7YrzuWWnVwzhZIVSa4XNrQKk+2sdsYYFZ1lwV63qot/wj8rTe02HZAx+W9RLvruw5jsndq0vip/+
	OyMtLCgA==;
Date: Thu, 26 Jun 2025 17:19:55 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] gatt-client: avoid UAF after acquire notify failure
Message-ID: <20250626171955.42cca18f@akair>
In-Reply-To: <20250625140545.1610812-1-andreas@kemnade.info>
References: <20250625140545.1610812-1-andreas@kemnade.info>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Wed, 25 Jun 2025 16:05:45 +0200
schrieb Andreas Kemnade <andreas@kemnade.info>:

> If a disconnect happens during AcquireNotify dbus calls, a lot of
> debris is left over. Subsequent calls to AcquireNotify will return
> NotPermitted and StopNotify leads to an UAF, crashing bluetoothd.
> 
> Fix that by also clean up the socket stuff on failure.
> 
Hmm, I should rather send a dbus answer, too instead of letting the app
waiting for timeout.
I will send an extended version (then with the correct subj prefix)

Regards,
Andreas
