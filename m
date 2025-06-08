Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106EF224FA
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749415284; cv=none; b=fRtl3dZbNR3X6Z1tP6DmYwPddv0uf4iJ4fcbCc4nDi6RvhPQeI+dNnIdsz50o6U6BtFHVs1UNjY3b6C15XfwHsx5hlOIlpyU78ljVCNVP5TzqMuUHg6DCMY37I9GhJP/fFZVUnGGwYxP3pQj8/8qf3vTdnpgBa/UfNADtltUY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749415284; c=relaxed/simple;
	bh=Q0fq5vZ+qh/i6jXOvFe3y4t3boI5Wu8QNB3ivl+9GoE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aSs+vQsv6kgk/9apA06ZUi4AYC46fx6pBgkjCQ6Jl11tgItjbdACtd2kfpDEL38rs6nWccj7+Av7fgirewg4ER0gw9E1logVNF9aZyIG3qMO8niWKCEvUfn+2XXHurprxLCv9GMrGfLtcPM7CJ5Vp4tpGkgr5k4UF6WmR5sHSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=merdhCc4; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="merdhCc4"
Received: from github.com (hubbernetes-node-3c06efd.ash1-iad.github.net [10.56.182.38])
	by smtp.github.com (Postfix) with ESMTPA id 1439F140849
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749415282;
	bh=02SP+y6HfiSwvHvdUNzKIEXs/hP8GbHC2PeMYo6YfGM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=merdhCc4PmbiaWV44GXQ62Jw/EVzhhi5PZLwpfaUhMOzZH+Halt/9XeEAXOMzYBSV
	 mz6F2H0I0k1DuEh1gnGUBCceonAyFRVIkcoe6w9Tl/uijxZQnrZMmS3TzCcrBk8uia
	 AJ1b5CbgN1QEFYBjq7bkP62xQCUEpM7omsc61thM=
Date: Sun, 08 Jun 2025 13:41:22 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969619/000000-a2652a@github.com>
Subject: [bluez/bluez] a2652a: shared/bap: check lpac type in
 bap_bcast_stream_new()
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

  Branch: refs/heads/969619
  Home:   https://github.com/bluez/bluez
  Commit: a2652a7f4b23bb6e98c0e8451c715f8b2e324fab
      https://github.com/bluez/bluez/commit/a2652a7f4b23bb6e98c0e8451c715f8b2e324fab
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-08 (Sun, 08 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: check lpac type in bap_bcast_stream_new()

bap_bcast_stream_new() shall refuse to create streams if lpac is not of
broadcast type.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
