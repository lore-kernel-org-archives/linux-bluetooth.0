Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767FB21FF35
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554081; cv=none; b=K7lNAauW+PKYiJRusbfijy5iDl2CwIQ8X2zV/+eBRY3sNYwkFOZAdyJdrHaxPKKHggSajJ1R7t7gp3bvyDBClARBBHCBNl2t5GF50Mbnk/4oorROuYM4u0b3PwUL84+LFI+ehvTWS2FSO+t/IVX+KbS4UGV2SFwLsptwllE7LwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554081; c=relaxed/simple;
	bh=/W0H3ygrukosSMyCMCh0cfvUw0cCQ0STge7v8iB28Cg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MkHv0wt4sF5fpXNMs/lTTQcIhJhMKB6wSroyw8eLU8xIHu8RPf0yyWq6ZgFAXyWG6t4u4JmezFLKa7IrDxwCUjvzSqIAfLikTQXvYUBoupA0v886+dukjNP/H1ukmGQitqjH5erfSM3Sxp7tutVyzADYG8ApXdjRy7xwKwhsarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BibBRNTM; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BibBRNTM"
Received: from github.com (hubbernetes-node-7025aa1.ash1-iad.github.net [10.56.15.68])
	by smtp.github.com (Postfix) with ESMTPA id 84B766005CA
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765554079;
	bh=YfCriHWDVFlrTvCGvzacWBJGs7HA60EUe2dvc5ZqJdU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BibBRNTMB/IPiQx+WZNII5HoAU7EAvhIjEzAZ4ZUGbTi29agDBHe1BkO/3HzgBhvM
	 gYARozTypL5JgRVQmqSPZ8LA0vfBEmDgaRArDNqMmOXBBiFqzq3lHeb8ZuHwJYBtr5
	 2WjYp9TeNJBnI7UItL4jglUBF3MMYSIbB6bC7MSg=
Date: Fri, 12 Dec 2025 07:41:19 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032433/b2d74b-000000@github.com>
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

  Branch: refs/heads/1032433
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
