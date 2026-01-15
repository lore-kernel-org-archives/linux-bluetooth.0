Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEA45BE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 22:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768514490; cv=none; b=RJltGmqWhtvNSBKZxRBzhKX3zGUEjGVa5XRRYer7F68WsoDKfDNoV/ENgcTAYNRfmXjGK+fh6Z1hi68HOFxXP+ayQpHbkZs45CSMz+eMx9qVT4Accj7lvU8tRMsbcYNOzk5iwrRfr8Lc+g/ivyBClVpAL4Vxf24xKA21cjFWFqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768514490; c=relaxed/simple;
	bh=kFG5ig4WcFU+a31TEKnBMSfqO/lFYqVCdUfUFOhjQgk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hHyXqKlQzziUKcy7ZlUww65t4vIqqz73qi59GzIehz8YUbtf221hK6pyve8Eou3tqyrsHk8gaAr6/sIdfeVnnEuhXdV1+yGqSmIYaXdDFeeQPfwnooSMG1ToEUvYY5iegQNeEVR8LBupBKjK5VvK5z6uG4WQgTCSJ+0dQJ1HVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PGv2vxVk; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PGv2vxVk"
Received: from github.com (hubbernetes-node-a04e2f9.va3-iad.github.net [10.48.201.19])
	by smtp.github.com (Postfix) with ESMTPA id 63EA4E02F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768514488;
	bh=TRgHlumELIlfbhzuielBgRDIcPVhiA+ptHt6mosdNsg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PGv2vxVk7xbMnd8fGTiVeL84Z7VForHrx0O7ZUos/p6u4Gy1o/Cqq+RJL9MKpWagg
	 LLtRCrQM9gdEeA4BxxpFoFCe7QWJI4KRBgavltBasGD8c8MfhqOZebZ0xsj6Oxdgtp
	 4jMJwXkSTQ2a1R7Y6KBsjrAURc76dQoZNhR1KnzE=
Date: Thu, 15 Jan 2026 14:01:28 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042511/0ae390-000000@github.com>
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

  Branch: refs/heads/1042511
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
