Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AFC22FF35
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975865; cv=none; b=ruvd6mRApvkdUecGK/YXe8HPNy08/DONK75wHwDeYuBHzI2CQXi7BI3lo8bAbk/Fi4cterANZy70w9iSLATtxQfa3tsn9kzJ52lFR+mosaX9ULZWB1x5qcqjcyNf/oF89w5dZKhrK5u3fVRklLK9BS70CTuA7Bl7UqiocqmeiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975865; c=relaxed/simple;
	bh=KpPUhLLQeC5bLxCw+1hc1gCgAn7iaD2tqaqjF8vFV6w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Wt0obBjlhTNnnhExwB7u6w/A9uHK5GK0hSu/5qR+4Qs30NttR1vwwNG6gI50GK9hjb8aChDz6ZCk0/E0+4/GXTo2NhxGm9ynEPUrkxyrNrNfCqjy/GBm8sM/h+rYXxIYY9zU3K5eAFRhGR9lk57fAHtRAuZsiPVi4S8v3EaWFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RlbSN4Rj; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RlbSN4Rj"
Received: from github.com (hubbernetes-node-7efa694.ash1-iad.github.net [10.56.212.86])
	by smtp.github.com (Postfix) with ESMTPA id B557C14121B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 04:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751975862;
	bh=AlsOiXmSFDzbMV+aaBxLbBV36yXEEMFCmhFNSotTKe8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RlbSN4RjB2w7FH2rq8TeO5+kQoWvq/coToyDNg9kKo2AZRykHwIAr0CHqdeXy66j0
	 2QFmbns0Ou0KphT11WMf72O/jGwE+sAPZ9+SVbDkYZH4MobUvNuit26Gp/xTxxqpcK
	 kvTC5eKdqod4LbOZodXoDRqKWaptfqd18UOTJbL4=
Date: Tue, 08 Jul 2025 04:57:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979927/c74271-000000@github.com>
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

  Branch: refs/heads/979927
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
