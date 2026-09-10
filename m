Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A2560ABF
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789062769; cv=none; b=BuRJ5U7wzSf68iNAGvld0kKERLA/ktzyowkYLx6kGNdLfD6W0O/Fx66U+J/SC8VrIfJq31AnS4aKGaOj6YER2vpLibp5jowMFsbYl+YkH11gZ2Y9tmmP9x3O7ozmo4fRDJp7ASIqWOq7Ifb0AirHI2XsvD7/5xOW8+NKG0dHz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789062769; c=relaxed/simple;
	bh=n8crEt8Uk3SshMMbPqHga9Um6qkvnhKpoZ6l2nnqlDQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UVj6ahpmZ94zrSKwVt4ElMpfj5M3CP+CPCaHYluymh319fIBdz9xvMua2PC0zncjSTak1O0hnQb9y2AROYGTpon4geTOkV4Y7gl6cB47HcV6UKA2Xsjb9uz88s6yu/1w7dwqUuHOxhuTwd89IKrA0KRAHr0MsVLtzmqaZNUHN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eQQUt7VL; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eQQUt7VL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789062755;
	bh=SpjKdsU1agSbI8PGcC58fTg+Bi0/2rnaZO1LEyfCuoo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eQQUt7VLL88eTo+djO1JauWwvkVH19diOzTd6V2Xehx50nPHPGSN5MtI1pe+sE6E8
	 mHpnUo6OUeZTFqOckggSyfMMojL1zG6nkbv4rh2vhk2fhKrO1Z6mx9tU7D+lZiymZe
	 JOD+azJEOYPQsbdxWBhp0nIRKD0Y7bWymrwZ293M=
Received: from github.com (hubbernetes-node-9c21654.va3-iad.github.net [10.48.68.76])
	by smtp.github.com (Postfix) with ESMTPA id 18673280DA0
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 10:52:35 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:52:35 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/436a7d-08efb9@github.com>
Subject: [bluez/action-ci] 08efb9: sync_patchwork: don't let one series abort
 the who...
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
  Commit: 08efb9023d9aacdde8a5cf7b9425877d99ba5661
      https://github.com/bluez/action-ci/commit/08efb9023d9aacdde8a5cf7b9425877d99ba5661
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M cleanup_pr.py
    M libs/utils.py
    M sync_patchwork.py

  Log Message:
  -----------
  sync_patchwork: don't let one series abort the whole run

An error while processing a series, such as the mail server rejecting the
notification, aborted the script and every series and pull request queued
after it was left untouched until the next run.

Handle the failures per series and per pull request, log them, and keep
going. The exit code still reports that something went wrong so the run
doesn't turn green silently.

Read the PR list before closing any of them as well, otherwise the
pagination shifts and the entries are skipped, and stop reporting a PR
title without a patchwork id as an error since most of them don't have
one.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
