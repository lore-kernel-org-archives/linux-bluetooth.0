Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB33B377034
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 18:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389268; cv=none; b=qp3cJcZ4Ad75qX9lpJFpzWBamXaPu/XHTmtxJxZgELE4Y8GY4e5FlhwNkhIAZZRI+YpES3PPsxa3LBD0yRQygJJ66il9gJSH82Kd7EInxndQEiUzeZPPT6MgVGr0ITWsbbiGYu4N0sUzZcyEINvJZSdr2I1h5p4WROiuq6a0n6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389268; c=relaxed/simple;
	bh=gqifnkLfsIyjZKkS5FkT1s2SccKCXCW/9lenmh2amcE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q7qL37wJjasWJKRn6ow7XvVXhvJIEHGe+30ok4v0NbVfjEIj/mECBOHkfwnL8MNouTdCpAPS2xM67PlHO7WbHZyFzZSiwPzEIVqhl0LmR5IB+KFtq4o00lQoZ+l9qtpyrhVK3EEGIRbL1id+viryDWIrm4CkGGN5DCQf+5e+hUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XcVDF0gJ; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XcVDF0gJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779389265;
	bh=cU6sb/+swHL9yGdkTtLBtBdObr1uqqhgzq3H+o1VjlU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XcVDF0gJ/alaZmkm86B6WpMR/OoiazL+BwGdum8+rrIME9AixxqIkTQvJ5U6HiniP
	 IzQNnyH/s9OkA2wU2KT8P1YMn9tRgEWTSLwm36ynmAJngv/RUgXgP6aQAdTLOXtcVT
	 1zPFNACk7DizkCFD4RDUbUYtbvUAm5eVdAa8gD+I=
Received: from github.com (hubbernetes-node-373be95.ac4-iad.github.net [10.52.147.31])
	by smtp.github.com (Postfix) with ESMTPA id E24E6940325
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 11:47:45 -0700 (PDT)
Date: Thu, 21 May 2026 11:47:45 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/9b6d3e-3dfee9@github.com>
Subject: [bluez/action-ci] 0be099: all: Fix "exit" typos
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
  Commit: 0be0998f89cd216d1b4d3461e583db3840832774
      https://github.com/bluez/action-ci/commit/0be0998f89cd216d1b4d3461e583db3840832774
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M entrypoint.sh
    M sync_repo.sh

  Log Message:
  -----------
  all: Fix "exit" typos


  Commit: 3dfee91519ae21d4828ed91b26a91f951cbef3f0
      https://github.com/bluez/action-ci/commit/3dfee91519ae21d4828ed91b26a91f951cbef3f0
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M entrypoint.sh
    M sync_repo.sh

  Log Message:
  -----------
  *.sh: Fix double quote errors from shellcheck

Fix all double-quote warnings from shellcheck:
Double quote to prevent globbing and word splitting.

And add quotes in the "echo" calls that show how those commands are run.


Compare: https://github.com/bluez/action-ci/compare/9b6d3efc8435...3dfee91519ae

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
