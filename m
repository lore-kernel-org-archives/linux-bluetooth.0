Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84F46BF
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 02:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424808; cv=none; b=MUqwSCxL7tncUDbKVrBhW25iMh5QXBIUkFhQ8XMSxbS6tgzQ7DmhhXLwX3MA9WAAVay1RLSaXQsygxPkve6BwtrsuHdFEFUbEU4Leu3++rvudz/ew+ESaLgaH8nAvg+L0vAj6Oxp+wIdl2eo+QksGqD4Mgv6O1c+Mym6DzNm3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424808; c=relaxed/simple;
	bh=F8S2Vqip1f1N9rt1PUXZebMZA7wmeTSc5pf2lzNhaZE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qi4eD6VyFyaIVZ5WidUz7crxlTZP44xxK+mSpfh8oaFoNlf6DCsn2DNl2HTjxpMnkHIOTFBb6JwUWvuDdyFrhHFnR2Pj5+SLYXYuFOrAmBXUEbWy70nTY5hGj+xo18ViJHqXNVSKk9LQ5Ap46pKHukd6HIUIzijpFnLAke5c9Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jVdUc0GK; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jVdUc0GK"
Received: from github.com (hubbernetes-node-bc76494.ac4-iad.github.net [10.52.161.24])
	by smtp.github.com (Postfix) with ESMTPA id BA361700512
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751424806;
	bh=hQuiGGxAE+T24zjH1/0WGsCZa6r/KtjXCeMJnWuPlQk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jVdUc0GK9gnfNZDZ3PFPwLCy6YAANPE8TXc2g0UTmaIwKwb4EBcFwDpsvXenzumTj
	 rrDr2sr5svoloPGrUixyPeTYs7Wk4i/zzhm2bog4OoLgAEeD37ywMDxieSuv4nFQo9
	 hEKkJt3puROR96LfPVHzxaIIAFbb9kZJaSHvvhLg=
Date: Tue, 01 Jul 2025 19:53:26 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977969/000000-21cdde@github.com>
Subject: [bluez/bluez] 21cdde: shared/bap: Add stream state check in
 stream_disable
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

  Branch: refs/heads/977969
  Home:   https://github.com/bluez/bluez
  Commit: 21cdde3dcd6810ec9525c54dc3a9e992d330a0dd
      https://github.com/bluez/bluez/commit/21cdde3dcd6810ec9525c54dc3a9e992d330a0dd
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-07-02 (Wed, 02 Jul 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add stream state check in stream_disable

Add a state check so that stream_disable() is a no-op when the stream
is not in ENABLING or STREAMING state. This prevents unexpected state
transitions or redundant operations during cleanup.

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
