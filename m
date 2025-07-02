Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DC2144B4
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477624; cv=none; b=By0580gh1kFGlDHIRSLJz6BMQaXrrCsjx9dhhOd9sLjP5ohWVMWw3Ugl+3iQHRfqnsfBoGKLVG+yeKrf7rjTlSUqmF0/kGRJ3CSTJb6/WK0oGHflPCOclkgEuXE1NhrFDYB7vZ06eIpG5XKZ2rS8D/jvFyU4hh3LriAMRvpnBc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477624; c=relaxed/simple;
	bh=aWrxiSxUt1b8VdFRMHIugDfpsh7/5AE5YTBI0+bpSuE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qBL7NkUPoVpzs1E9BaCxDgNrQxYM1SE5IAlF4nrTB6BC9OVZRL59/lA/kf/yc/isLmVlBGp+k/zEwj1g/F+B6CpmQRJKMFL+xJLTx/XTMZ5urhaBQzJt7khM9X6Q8RoBTunUpGVgooDsgC9NsIITKSLvCCupsz9bsefsMatiHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DjvXNX9U; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DjvXNX9U"
Received: from github.com (hubbernetes-node-3e7d46f.va3-iad.github.net [10.48.12.58])
	by smtp.github.com (Postfix) with ESMTPA id 502424E042F
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751477622;
	bh=u+zd1/S5+V232KNiwfDwsrk5s26YxsZ8rhUs1jCkoTo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DjvXNX9U9PYm/llp8cCEbCvhHKAQpQ5Pubg82BLRZ7rvueMYaAnrQyhKOlgaLwmkW
	 1qU06zD3MLSbILsYivIvXYr+VYUwhe2T2Zz5pgWS2xHgaVpRK7K1fo+LEnNNV2IdGm
	 MAmgCgVW2J9jQ5PANLdqWfC+m3/RnpmEBRjmlntk=
Date: Wed, 02 Jul 2025 10:33:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977659/c2b027-000000@github.com>
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

  Branch: refs/heads/977659
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
