Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFDB3126B0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627532; cv=none; b=uy2mSeTttRlrVC41ixA8SjgeXtbrBKT8nvMCypEPc8BbkvHNggXljwy1nUGd5YgepaY7UeiBId2iaOf3pHnCbQeelGFzAydZWn02c56yrZIfKV9YUwv5kuJ91jaRUjZ/bx2DUs0iLLRzCPcy9lWVc5eUyj97OUlOzYQtpcwnIS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627532; c=relaxed/simple;
	bh=nd+wuEfIG1rRJQ9WWTWnxJRrzg6fYTHGXJpq9SH7bEI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QgX7gEvDOb7w212McwYAiiy/A/+tlV0lGspg/BXX69vPZRPLsWwTzKLMDaJMk1fGcjPWrkbFF2JIuXDUlrRYEOQvdVwHRA0WKI5Olr3BaGsxRf9damTA1uzIIvI5mEiGQ+0UG6MF9jHAVmnC7j5QQ1jzuFYJeDacGp1H7PsaOBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CW3ZpmG8; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CW3ZpmG8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783627530;
	bh=44rFGbvtiGFboE+fsu/wLwAHKj9+npLi/RDfuE68QzY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CW3ZpmG8Xea7Rwq8n5yG69hB8grKit19ozS7DV/rXdVeoswXAA88VrcEmX14PCC6r
	 oX6oRa9MYduFmh0DDRj362W2jI9Nc6yT83M7E4y9+NiDiX/U6fuOTWesRg3xE+edto
	 nU3RWu5fapP8ne8Cs/mCkmwEiuyUPOYozmI6byOw=
Received: from github.com (hubbernetes-node-07327a1.va3-iad.github.net [10.48.130.37])
	by smtp.github.com (Postfix) with ESMTPA id D17983412C5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 13:05:30 -0700 (PDT)
Date: Thu, 09 Jul 2026 13:05:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108772/45183e-000000@github.com>
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

  Branch: refs/heads/1108772
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
