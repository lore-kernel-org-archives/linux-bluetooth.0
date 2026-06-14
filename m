Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803EE23AE9B
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438924; cv=none; b=h9UE3xFMGHSHW37FgZ301InLlFztLxqwiYzp3jotJpbs2u3sQNeBGv/w27a4OQ/5Nk5PJj3HFA4ZJGmxUIjoRX8IPs7xOE8I389HlFyOsLD5XujqFsSxf3Z8ZpC2r313N9cpOAkxR/DuWu0E6gn9fPMr0wKmmV5RhLVPOr6sGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438924; c=relaxed/simple;
	bh=iEBWd5stksROjhEyksfwCi6tzZadJs815PLHoVbKXIc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lvW6qj2kBctq4TPB8nStcVepkhzjz8rX+uS51wtbcfWnUL2MUAIsG1B9K+pkpTkndNgfoYCrUMNR0RNeHAg5HVAzw6qShqDW0MEPldYfxbEjvoavPxIimknZeJYmfZCMAIHmRcyxXjoz7WWII+w2WD+293BwJNNxop3zqQ/KIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jyeSqsMU; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jyeSqsMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781438922;
	bh=P2YJyxtx4A0YiQUOKZVmfagIWfxAWquCKHQh1H0okkE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jyeSqsMUAuF783JxJ3Kcthnx8Hx06OI36FP5tXpvYwKLIgPjyx/BkKkxMuX0sglhG
	 ZPFHrKMLu3UiI8dAIGw/WrLtEGQqVunjYpw6MW4U2+OkMeJvGrGT1b+z2RcsBtEVpK
	 55JR2nQSWJFwTgzp+Ex1nl/0yNQ9gwj5dyL3Y8J4=
Received: from github.com (hubbernetes-node-bf1b5ca.ash1-iad.github.net [10.56.191.33])
	by smtp.github.com (Postfix) with ESMTPA id A687F520FF8
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:08:42 -0700 (PDT)
Date: Sun, 14 Jun 2026 05:08:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1111248/964d7f-000000@github.com>
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

  Branch: refs/heads/1111248
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
