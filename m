Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3612319D880
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896616; cv=none; b=axUQY8dnS+mqvG0v1Js7LiR0L1OEuSuOC4fFXe7fHGGYDaKv1Uz1keVgorrpmKk+Hl3/b5bO054f1EPYCU3L0QMcEWegz1s0FTot4pAcbeKQRLYnug1x+EKZODrZgQr9YycJwGAHrAwx1sgbyHQCdJ/U8PahdNsLryvn85uHIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896616; c=relaxed/simple;
	bh=2LoMwF+jyyaEJTmn3wwLKrlqdpxqf7+iopSYnIbgsjQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jrdVs+C8t/MXmA+y8TDspxI8DixV6A0AB1j3581zUgneI8NAiP+VcbfwnEw9oVk5ESASbaWCC11oyB47ufQVbJFQnMuSewrXveRW/X242vazB5kLd3jHyB/xORaC+nz4XqgDvILf0F4YKzkLhcfGnbvvgE7HIE5X5EKntY2Gf7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SXjaaDeq; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SXjaaDeq"
Received: from github.com (hubbernetes-node-0d08442.va3-iad.github.net [10.48.15.44])
	by smtp.github.com (Postfix) with ESMTPA id 4C3D84E023F
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 06:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751896613;
	bh=HcAbYI/KCF/XqISi1UVVwN0leAgxopRwSagIqF7+z9s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SXjaaDeqI+frqfWVtR99T9IrzaZUYgfo7934k/2zukMhVzPjiHZsL9zW84bxERh2d
	 /UrzVgm1iQL2tqHSLA3VjlVjsf0SpvnvonYh9TV6NZY7WkTZxGWoRv18N0mqkeFt7a
	 +BUrS4CkjP4v8GSx6moYaQiW5/ANMXTBSclrTtDI=
Date: Mon, 07 Jul 2025 06:56:53 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979695/000000-4a799c@github.com>
Subject: [bluez/bluez] 4a799c: shared/shell: Fix not running pre_run on
 MODE_NON_...
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

  Branch: refs/heads/979695
  Home:   https://github.com/bluez/bluez
  Commit: 4a799cbaf0d190c175a607038d0b53735bc5f6b9
      https://github.com/bluez/bluez/commit/4a799cbaf0d190c175a607038d0b53735bc5f6b9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix not running pre_run on MODE_NON_INTERACTIVE

If a command is given to be run in non-interactive mode the code would
not attempt to execute .pre_run first since some (sub)menus requires that
in order to properly initialize things.

Fixes: https://github.com/bluez/bluez/issues/1394



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
