Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76540248864
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014439; cv=none; b=Q6HCXNvTxkctwsTaEB7nY94HYKvtWVWO2mwGhHjrnjcUrvl0+CtDJTZia+k7NwGxo61MSKaunuIPLPFMs7lB1/tbDogTxiVErVFOeq6cywG5pM+0u8kiDCvn3Ew3Xce0sXUt+YfBKqoNBQQL7ixzCR1QWlvfYjdWwCaRe9+wIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014439; c=relaxed/simple;
	bh=goIEJJ3C7aMzVcmvDgxeVcxDTWwuYPtud4fJHQxsFY4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rz/ytLp4q+xaK/mYpRvKSPCTydhkgahw3ta/oHsR7o2l4o9qwIgwCvGOb0y6VGRLBOULawbETRlDVJF/UvYG6ErTPa7sKTD4fn2G0Pdrji4mfRRp0p8b2fAg0AcSf2JFM5vOpVrFPyVkxGSSyUVpC9BV5O2CpCrVD+6wD0KEsPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dSYUzrQZ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dSYUzrQZ"
Received: from github.com (hubbernetes-node-25778e7.ac4-iad.github.net [10.52.131.39])
	by smtp.github.com (Postfix) with ESMTPA id 6D39B70041F
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 15:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745014437;
	bh=xshY1A3/Q4u351qs5lQ6YTS6v4Fe8H/7jhqdUpMHvEI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dSYUzrQZ9fAMeyD/SoyliRmzV2slmNhw7Uc9gg1QnRIVDbdXuugVTSKgJOPDYtSi6
	 /XIipimYE8q7nY6ovBpvpqpH+1/eQoFjeY7YCzE6vMzy/ltMil0HqXyT/pP2MO78IL
	 KQU2c028d2FmJRNlAnbtq/8FDzVDzKe4Su/8Hs70=
Date: Fri, 18 Apr 2025 15:13:57 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8d472b-e3c5f6@github.com>
Subject: [bluez/bluez] e3c5f6: workflows: Add stale action
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
  Commit: e3c5f6050a8bc8844c66ec8ddca37ade083fe64f
      https://github.com/bluez/bluez/commit/e3c5f6050a8bc8844c66ec8ddca37ade083fe64f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-18 (Fri, 18 Apr 2025)

  Changed paths:
    A .github/workflows/stale.yml

  Log Message:
  -----------
  workflows: Add stale action

This adds stale action to which marks github issues as stale after 30
days of inactivity, after an issue is marked as stale if it remais
stale for another 5 days then it is marked as closed.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
