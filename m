Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9C1F130A
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940672; cv=none; b=fGBVciA0R8T4Kunb16LvCGfAgyyr5gEzTQn0lPVUAxoCGQyg1oQbA8t4rAUnEoPLCu2hA7GuMaZAefZLPgBDMzKmWilsKDFV5lwtKKzAeDJ46cvNBmkjNRdfxW1Mzmge98lVyNcB0PRgjw8Ho2mp1bU/BrniqbBERO29x5jevq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940672; c=relaxed/simple;
	bh=t4cTt6X776zw1yU+ipT0DKKNUFG+Ia4tj0suzVAussI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kGm/F0MSEUWL1ko1Y6EXIb1vS6Rse/ZU7uxN0aCoKFfu7fF0IknCNK80FdyktP/z8IIhdTRRGKMfs+622odEAu8vLWdMMtnmCevsoLZ+DKHwxqYkcWfedde5beZ4hxRvI/bOwMHxQVqetOVTSTtGaxnbAhhZF0nmZqWsiQUQPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=N0Ud5Gnb; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="N0Ud5Gnb"
Received: from github.com (hubbernetes-node-1ebb270.ash1-iad.github.net [10.56.157.30])
	by smtp.github.com (Postfix) with ESMTPA id B764B1411C3
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Oct 2025 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761940670;
	bh=1EpAFlyIJKkgTmMwUhodVcQrLjfqIxANgWboET2JiXg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=N0Ud5GnbmPKlk207ooDXBaqUsw3ddmPavCGHTJTOS8+TXvB18vXTx75aQwEHkc8Bn
	 26HiNbYlutg8bVj0EFGlMKvbfGT+Dn901Fja4ThdDMAuGSyI69U6wfhjRwHUBu71wH
	 s6lPqqGfZkg/03AtgsCvR1q2RI8VQR7V9UJKEbGM=
Date: Fri, 31 Oct 2025 12:57:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1007812/1fbdb2-000000@github.com>
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

  Branch: refs/heads/1007812
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
