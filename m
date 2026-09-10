Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64E55D86A
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061609; cv=none; b=DiNaSrRHj1Mc6kpDmZnk4s40sauVKg2unpaJGk0rSXnt/CDQatyZwnDSIowInKTtTyqZr9H/sF5gAquagighmii8vz+5GpD+64x1quzKToe2V9RFhD8LAFK0T29okYthfZhAHNYAPyOQZRRs7PFPz4mJHSuvTNTUdWRium3BI9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061609; c=relaxed/simple;
	bh=oiLINQrDSVJuM/CJgA1N8+noAD5348Ucp3IOuyXSEDM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q3AY6AHtWE17DixdA0f/cAb0aYXppFqd8CO3UliMfNJ2xvnMoWD9Q8ldCynvpMLMFeRu2YS6GnY0hczD10gcnVywY0oaRGwjBadPIkojerljybElEuUD3AdGoK4opFNeUhIveLkLOnFJIJnZVVqqOs7RNsijnDigKWByNG9BkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hDAVIXEV; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hDAVIXEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789061602;
	bh=/bJKmdLf0XWxZc8l+8PLGZr6zzk8GZWTIyUzvUrq6bU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hDAVIXEVpGZveNm7UQZ8Z6fuF0n+9BaSnn2+zGKbxj7noB8t7u1NIdGuLTlCPAKAM
	 0K1Phduqx42FyhuAt6k9zo5I+g/byQFGhPsltdFH31fduXyrZ0VqM6NWLZ3wBV/qxp
	 v3yPGKVTaZHAtxnkCukWnS0lXNRSPF4pgbeiGqqQ=
Received: from github.com (hubbernetes-node-7b6ea2e.ash1-iad.github.net [10.56.191.34])
	by smtp.github.com (Postfix) with ESMTPA id A667C92135E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:33:22 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:33:22 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/c4559c-2857bb@github.com>
Subject: [bluez/action-ci] 2857bb: cleanup_pr: read the PR list before closing
 any of...
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: 2857bb3d326d5b772120c830aa50030de53e7f01
      https://github.com/bluez/action-ci/commit/2857bb3d326d5b772120c830aa50030de53e7f01
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M cleanup_pr.py

  Log Message:
  -----------
  cleanup_pr: read the PR list before closing any of them

The PRs are closed while iterating over the paginated list of the open
PRs. Closing one removes it from that list, so the offsets of the pages
that are not fetched yet shift and the entries are silently skipped: out
of the 14 stale PRs only 8 were handled in a single run.

Read the whole list first so the iteration is not affected.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
