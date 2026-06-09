Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109F624BD03
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042881; cv=none; b=bmlseiKjG/szBO9G99HlCQ/c/2U48KwJRMtm+gEYSz4y9YA+i33pHmzcmAj3Qju6gNqFgfE8ZwTj87o+E5bUWNAlX24p7GRVqPJ2oUoBOsKc+EyInA95wDcAMuB6IKTdOomAQZbMoexezIi8xSEbKY+crmJQjW1Rfjq4q6rWTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042881; c=relaxed/simple;
	bh=sAqdcplRpthI/O+PlZ6YD6wW4pXU6ywdUP1TU/ZHS+o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W5l4CBsrHb6o2a0MI1qY3aCqOJLbdYmaErBfeSdHKpbIDYv6nH+Qal00qF2Eo1VOanCFMgmkt+9eyqj36c8cuC5QHJgAGeEzhTVD8v4aG/AiiUEG6qlnVfCNKjuxlI1U6ug7vbCTmqQw5+zOlqG2QM3dDSS3wKcMJNh69xCEPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P8qwsXBH; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P8qwsXBH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781042879;
	bh=kIsu3kKz7ZWtxTupDtcrCyLdhN4fyxRaEnI+FDJgXsE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P8qwsXBH/iDihePTmgOyzyUcgi/4S/nG84VLDOZBKM4uN0deFTtxd3bra1nHHUmfK
	 1hyH2J0Knb0gW4hO7ko5XxbDN140v9a/SHHf96TiFffG/ZBB3aYJKSkgY2HOe1bypz
	 LsU76y2Ld5ZG2JtTXl/uM0QeWt/MluSUSEdOxhAI=
Received: from github.com (hubbernetes-node-819f94a.ash1-iad.github.net [10.56.14.35])
	by smtp.github.com (Postfix) with ESMTPA id 5767884014C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:07:59 -0700 (PDT)
Date: Tue, 09 Jun 2026 15:07:59 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108826/000000-95d160@github.com>
Subject: [bluez/bluez] 95d160: transport: Complete Acquire for Sink ASE
 entering ...
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

  Branch: refs/heads/1108826
  Home:   https://github.com/bluez/bluez
  Commit: 95d16025c92d0a67f5b3886ad18bb80a6efeee31
      https://github.com/bluez/bluez/commit/95d16025c92d0a67f5b3886ad18bb80a6efeee31
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M profiles/audio/transport.c
    M src/shared/bap.c

  Log Message:
  -----------
  transport: Complete Acquire for Sink ASE entering Enabling

On the QoS to Enabling transition the IO is not yet available because
the CIS is not established, so the handler returns early and a pending
Acquire is left unanswered once the IO later arrives.

Notify the connecting callbacks once the fd is attached so the
transport can re-run the Enabling handling and complete the Acquire.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
