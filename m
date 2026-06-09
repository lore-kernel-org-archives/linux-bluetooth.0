Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111F3911C5
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005783; cv=none; b=IwUz6uE28+3QzLY98CyEvNvrgb0vMe3Tyq4zsshpl53wj3Y3XZvqYbkDRmaWOHlgND69Jujvxgsa53IdBrwHNBdhPqy5mtKIjcojvbK3OTSNVJUmoL9H6BXYTS584mqA8j6rjK1AhAUiYRQ8lQSx0Lm+HBS26dH+OpgTt1eoaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005783; c=relaxed/simple;
	bh=4qFdsObh7ZjT6DUoZXMN7/G1+G2PqETvBj1WRHzb9dA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dDixNzzN8D0td1s7APDif37VdJEBBeSRfmCx5LsWLTNWnWHjL1na7jW8gFKAmpbBM0zWEpf3zJTads48LOeWIObxUNvjRl8d4a6ZI3NzJB0c3AJWaOGTCVJgzfKFL5JOJLPzLv5emQvZj2aXtUivTyrW9ViyyK93U5Xt7Gbt3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jaCD2B2x; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jaCD2B2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781005781;
	bh=QP/qSqU30r2A32Ef7vnzo2SVxxwLvwRyfm/fmYZhuZQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jaCD2B2xAyaumffYg5XvBkwSdTfnj6fzDxMrF2hNZzao6YCMD/UQm6Q1ILhVybBVh
	 qgzXK1eaXNuQ1D0vmvKLjNJrJ2qnlehnp09zEsgR9plKHXCZKgkwqEguh0UP1ZEEbM
	 U0gG+kGiov2R7J2icbQrE3RCbSfq2QumhugHEjJU=
Received: from github.com (hubbernetes-node-7d038a8.ash1-iad.github.net [10.56.196.59])
	by smtp.github.com (Postfix) with ESMTPA id D4D54601050
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 04:49:41 -0700 (PDT)
Date: Tue, 09 Jun 2026 04:49:41 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108483/000000-29bfab@github.com>
Subject: [bluez/bluez] cb89e8: shared/bap: add ASE Control Point error
 responses
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

  Branch: refs/heads/1108483
  Home:   https://github.com/bluez/bluez
  Commit: cb89e837f32c3d7fde71f588ac87e6f912392128
      https://github.com/bluez/bluez/commit/cb89e837f32c3d7fde71f588ac87e6f912392128
  Author: raghu447 <raghavendra.rao@collabora.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: add ASE Control Point error responses

These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.


  Commit: 29bfabd2e21982b8cd70f4f846fa2d3d64ece7c7
      https://github.com/bluez/bluez/commit/29bfabd2e21982b8cd70f4f846fa2d3d64ece7c7
  Author: raghu447 <raghavendra.rao@collabora.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  unit/bap: add SPE tests

Add unit tests for the PTS BAP/USR/SPE/BI-01[5]-C tests.


Compare: https://github.com/bluez/bluez/compare/cb89e837f32c%5E...29bfabd2e219

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
