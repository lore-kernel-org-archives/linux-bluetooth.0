Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F94EA383
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823495; cv=none; b=E/7v+A2cWinP0vkigI6chqbq2Es6FltmCtF/zn+a3qyvsgBmRZ3Q3vSnq3d9hkQ1Dn4PybGhCz/aOLX/CnakMIL6W8aTGgJiqHyWEAVKXodVacXOJX209HbR2SCnGQCQT1AhM7LJmwhuH+e0wQyfpU26NtAtE6zV9H0u8LzGPvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823495; c=relaxed/simple;
	bh=EPdnpdCwSzYa8wghg/Egq/b05Tcfrbrycf/bwezaj84=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JM36AH+5reCrGmprODGwvUpV6nYVB1z75pn3LJwhr8YDFbHZ5sYB3RoU/1Yl6JOpJ7mctfeuMGQhqDf49wnRqf8NlO5EnQRSlG9uGTFEu8OrZjCVqI+quCywh80W273YKt/w0G/oZTMkiwn/jiVJfkxHRe5bJv8ISFHr0w4KOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DnmngED2; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DnmngED2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784823484;
	bh=zQCOZLWn6Lr2fU67317zmVA5+pKqP/PM7ayQX0xkPxM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DnmngED2eJyHxtBtQ2iX2KLwl9lA+NreFKtPh3gIIr4bPLs0O9yPVdKNauBJ0pvYr
	 nnJ/ECFzdWO4UsFJ/a99I21pT4L+U8zX+nkXbeNWxkku8zQndFFtEDpuX3CQG52mQ7
	 h0HnKj5+ROqk1eH37E2uclDNzbAKgBWmQTkJCpGA=
Received: from github.com (hubbernetes-node-4410124.ash1-iad.github.net [10.56.226.56])
	by smtp.github.com (Postfix) with ESMTPA id E57B3921393
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jul 2026 09:18:04 -0700 (PDT)
Date: Thu, 23 Jul 2026 09:18:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128884/6588df-000000@github.com>
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

  Branch: refs/heads/1128884
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
