Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470E221FA6
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529449; cv=none; b=g9b7bfqoZhegH0awL+bMgRXFpIXqwlKWhUwO4KAteFCRtQSqIrWLj/pW7vuGoRnM8l9lPel8nbwtVbe5OXPlmQozS5mT0qvTCZVqRFvBIx89imM2lnCisYR8VUbbiIlSEmFqAV06OP0BQCBiaNrbiYeZ65ebFKfPzJ3AT3vCg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529449; c=relaxed/simple;
	bh=iBEXiJ/gEJtJ+8015GVr85xsPonB7KaBNJQUo/lQkJs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fF54lGvTvTAsGjleIyPXScuPItOdIuypqazDcPcqowWaLBCuZYqcW0KcF2EWBtH6bBNZh9NUNQkkEHtwGSGLrEVLxIm3GIUEKpdH9/K/dGs2Nb3KwlC9BYw2qgp8HsQKl+zg5CrLWHBHASUFC/MAem8RTc0o/WfV30plzZMUkAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BfmSi+O8; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BfmSi+O8"
Received: from github.com (hubbernetes-node-ade5406.va3-iad.github.net [10.48.221.50])
	by smtp.github.com (Postfix) with ESMTPA id 0EC28E07D5
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745529447;
	bh=O9V8f+0mC9pzPUMB5zyWFe4nvsBV1b0kM5wX29K4Qk8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BfmSi+O8vqjkCFTodI8w8jhD31h40kojjqSCRnOQyylVm+Tdbe+scTc3REoV57C93
	 ugmVxEjfuD//zIBtVyj2OvAqEJGiJpk9mpl/68kbNBiPjT3fzK1gEDDQ4rENDzM8yO
	 vik7bdVV1QFVXYozne7YnzaDi1E4PJP+SvnqRgV4=
Date: Thu, 24 Apr 2025 14:17:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b74d30-faca96@github.com>
Subject: [bluez/bluez] 55b02f: workflows: Add checkpatch action
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 55b02fe5a2bd986c4188ecd4ee2a92b1c3837543
      https://github.com/bluez/bluez/commit/55b02fe5a2bd986c4188ecd4ee2a92b1c3837543
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    A .github/workflows/checkpatch.yml

  Log Message:
  -----------
  workflows: Add checkpatch action

This adds checkpatch action rather replacing the custom CI one which
will be going to be disabled.


  Commit: faca96e9c9a347f64e50007261e46e0e23a263b7
      https://github.com/bluez/bluez/commit/faca96e9c9a347f64e50007261e46e0e23a263b7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    A .github/workflows/lint.yml

  Log Message:
  -----------
  workflows: Add lint action

This adds lint action replacing the custom CI one which will be going
to be disabled.


Compare: https://github.com/bluez/bluez/compare/b74d30fb9f72...faca96e9c9a3

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
