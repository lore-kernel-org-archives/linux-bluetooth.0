Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D398248C
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 May 2025 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747498810; cv=none; b=tX/eqZ0W8pHju6Ryxfal2ojY24w5ATPEllabebd6CEl5yyvaroQjgh9C+lqxX6iQjtOB8pLoFjCBAbQq8yWpLAWr0yR8RCsLKPNdUR8MYTtg0lgS4uk6znTL4Tknc07mN0lMlkcIamUYIHZlTtFRVmL+6bcV1feIJ3PojGuGe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747498810; c=relaxed/simple;
	bh=yNqsG4fzty8ubJAws8JfFEfqWy69RwkB64OEglQ49Fw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KsnfeqGF8+xRDC4QPZC21D8v9ahbjGw80DMR2dBRyLniZi7eCSMVbcZGUulOTEoYPD7WSr1JJEWyErW9YBnbxXzpUSBc788L9oMz/p/N1e2ymbOA33+W+A0fNoWyiM93dBiX02+KUnxVdsQkjbbozKKn+nFMNkKLc+j10SW0nrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lbUJ3tUc; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lbUJ3tUc"
Received: from github.com (hubbernetes-node-db81ca5.ac4-iad.github.net [10.52.125.17])
	by smtp.github.com (Postfix) with ESMTPA id F2EC92002C
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 May 2025 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747498808;
	bh=DAm1yqPDu/TVIbfD79zoLTyyzdzme/CFv+uRYjl0iS0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lbUJ3tUc87YPG14P/O6y4x/00F6inznb9c5471eqFItOB9P2nsSYIAGNUYXkgFZWx
	 JqSO6QWQLaEyRMBttUy+/WeQO8/d0dUCcoCrxx99H0gH9/ZTv1LzwHy+uxxqXSA5to
	 Emji3VMmP0Hf5ElSo4SvP8gtxxVXz6LoS45OkN/M=
Date: Sat, 17 May 2025 09:20:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962080/72f7f3-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/962080
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
