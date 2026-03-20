Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52425CC74
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031206; cv=none; b=hPrBL5iEvNEsKGoDspML6jJlihOybSU+i1BL/LqV63ZUFiPRpnxH3MQSWk2vkgfAj1TyzbFeB/Gf54R177FQjT5xkhza8ckE/Wemfb1MY2oVz8QM4LyfCXCRenENKyqH4v4/1P/KEZZfJn0uXM9juhUDf12e1IK8JgB82h+M/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031206; c=relaxed/simple;
	bh=b60kYJrsbuVbwa2UfLBZSz3XdDjvUveljFFHMFNSLqM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uZUkZAxI0uJhJKJkA/a+kuR4Xj7QplSpK2SmgLVepkOETV3ddCrIFEqBJv21Wihfh0UuiSMEvAUIsgh71cOPd1unflmWy8GcOZNXi1+ZwfexnCjeZWwmAQkLCPNhibTagReYLtcAIQBXNZ/mH6OQQLZ5Q2lPQM5ynLGeAUaA/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DDnAQ8XD; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DDnAQ8XD"
Received: from github.com (hubbernetes-node-dfa6f38.va3-iad.github.net [10.48.200.81])
	by smtp.github.com (Postfix) with ESMTPA id 0D7AFE06A5
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774031205;
	bh=gzLFVlD9JCEZJnxOFUcifrhcEBJOINZbkP7dCP6ufFI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DDnAQ8XDmkcQwWuRpLUs8BdA4knEO1OqBaOHmsCCZ46kdUCFnSH4V/W8+U9Ml0Xmo
	 IzdIkI39sljdQaryguUnrPsF9Xu5dPb4tnOFOLoy2Tp5GZcNgksIxa7D1gkYmV2zvz
	 I75xWpjm9k55EgpPMZsvSs2kMpEX0c6C1KLqw3Iw=
Date: Fri, 20 Mar 2026 11:26:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055282/f484da-000000@github.com>
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

  Branch: refs/heads/1055282
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
