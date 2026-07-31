Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F0243CE7A
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519061; cv=none; b=QO9uV7fNEniFtB3h1Pe9e52lfcGTmZU5M+1TK4sA29YLgul84QbcYgjIAyQdD6acF2zNNhGN2rHJkkTIzKg1ArPzgb84slyGQJqqumVb4dlGpjb35bpKafT9XI+1Tc6CxP6tj4ni6lfCivz2IcwNnleU9mXMY1aU+HsmgiqOFCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519061; c=relaxed/simple;
	bh=cf4VhTkSZMZlJBcHoL3vfOO78Et+myN6NhoQ0yq/uFY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NuIJaGPDCu+XQaspapuf9I4Ch8jOFOVYsoHZR2wk5Xr8q1ibHIU9kBbHvTxvxnm+GAUQFWHUyWd5/hTE8l2F6Kz0tTeY58zOH7vgiDBTJ/j7XnYlAQYPm8rya8M/j89HXKnxurpN/GOq+NJkKW06eaQMj1irl86Em7hre6Ym7fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=b/REIpbQ; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="b/REIpbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785519058;
	bh=oRj9i/va7Rs2m9BfoYLw/DSxOkCT4XTuwJ1hY4ZJEuo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=b/REIpbQBh4AN9gJKKFGv47JzsKjABHQs4uCtdV0XTGMCpf9oHEJHoVcheCHAr+eE
	 8p+ZllJ0vQOMrgDCIFiKTevjnACMhKtq5BlQj5coZ+JSMjxzygTumkiMl13gja27T1
	 s/018+JQTZLtldaQpDaTKm3xRHyqYH4E7vSVaMxk=
Received: from github.com (hubbernetes-node-fefc343.va3-iad.github.net [10.48.68.94])
	by smtp.github.com (Postfix) with ESMTPA id B2BCF180C47
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jul 2026 10:30:58 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:30:58 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/058d4c-1e08fd@github.com>
Subject: [bluez/action-ci] 1e08fd: sync_repo: check workflow branch even when
 master ...
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
  Commit: 1e08fd655d42fdf3e66a3909d086f165486cbb3f
      https://github.com/bluez/action-ci/commit/1e08fd655d42fdf3e66a3909d086f165486cbb3f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-31 (Fri, 31 Jul 2026)

  Changed paths:
    M sync_repo.sh

  Log Message:
  -----------
  sync_repo: check workflow branch even when master is in sync

The script exited as soon as origin master matched upstream, so the
workflow branch was never checked and could stay stale indefinitely.

Drop the early exit and only gate the push to master on that
comparison, then always verify the workflow branch actually contains
every commit of master before deciding to rebase it.

The full (unshallow) fetch is moved up so it happens in both paths, and
the workflow branch checkout uses -B since the ref may already exist
locally after the fetch.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
