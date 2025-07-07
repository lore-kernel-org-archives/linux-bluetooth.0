Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF233EEDE
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898865; cv=none; b=C4n4zc3vnlRlQfaOtEnkChM94yFdaFokToX7/fIiCf+VWxp7dPi6SykFYIQP7Qaiv1BdF57GrgTsEKj/aHvnESsKS3ZGnkpru1uxPPgTgtACz24S1uVvq/ZpPr4ZMv/9Tuia6hSfS4SOnz6TlbQh/59G5+GLVcNUfaIT7g+iiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898865; c=relaxed/simple;
	bh=0Oey+d1tOoLyAYwUWTea2NkW8GyaBqDmvcJZZdBYCc0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DrInPcmIcQ/mw03P7LtfuDHLkgfByIqZL4pkcAC5AYLEYG0O26ZjkPUibzlYht869B+5L8tjvrNNfaYlHHj7z36r2v4Wq3Rgg97hEFkuWWStm9R2ZbOv8e2pBW4pRD6uediLNyfrvn6ZfTGv0srMEejN5vtVJc5zGxi6ebW0Vgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SyjPqKMm; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SyjPqKMm"
Received: from github.com (hubbernetes-node-6743197.ash1-iad.github.net [10.56.202.72])
	by smtp.github.com (Postfix) with ESMTPA id 1DC2A9211D2
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751898863;
	bh=GEu/LB61Kw2Dqblv+sxTdIznkbPSZwelXsAOK9H5J3s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SyjPqKMmfKkd929fkmXyHVZ9q4QarskYr3PhjKO8GP4NhwYRiHYAJk6ZzEGvyebCt
	 YsEyGxuVyZWStn3fPbrqZiQTh+fTyCRZFWclbMtxfDpcQBBslShnq/MDy7PZMP3WEr
	 IM9erEIhLWxRNDFF3EALWO+HSVCdGFjfn8O4zWL8=
Date: Mon, 07 Jul 2025 07:34:23 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979707/000000-8b7cb1@github.com>
Subject: [bluez/bluez] 8b7cb1: shared/shell: Fix not running pre_run on
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

  Branch: refs/heads/979707
  Home:   https://github.com/bluez/bluez
  Commit: 8b7cb1e3bccc94b51d6a86fc109187ca5fd41bba
      https://github.com/bluez/bluez/commit/8b7cb1e3bccc94b51d6a86fc109187ca5fd41bba
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
Fixes: https://github.com/bluez/bluez/issues/1317



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
