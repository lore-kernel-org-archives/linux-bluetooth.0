Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8E37882B
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981055; cv=none; b=Jrf392xqeI/vy008vkjXXhzJqr0YiNx3voVLVrt20Dsl96erffy5nB3KYs3bYLeh+wR6I0hGahbmSyWTMmjJOH6POteViIu7ULSmH/rzb3F4UtxYTWi2Vl+CQBw2krFC8ztxsyQU2OYuYHtQklOzqKjEhRvOXrJisaW+d2TGDCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981055; c=relaxed/simple;
	bh=LrBXmnrY358dD+BaZl5YEJQDQIF3ZrJB3tJKzZ7LBw4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uCPi/HJJG5Ds7W88+VNHcHwSIrs6HfR9FEEWM3tmmy5Vxp5lVr2vMX2WdGg5665UIVrwt6TaAMzyPEoObB3sgojGu/SYzgaSgiTwgbxuCNKYGnxOqAz49GOUSTFdH8HJsCh0uH5ekJ/htOzZDvRw4FJrO3fgwr4xaDBn9xf8YVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=d1ckJ2cE; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="d1ckJ2cE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791981053;
	bh=nZV6lvtLFBFktmHOvJ4B0DOFyOe+3nykhv7r/qb27Jw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d1ckJ2cEp1KBRuZsiClHf8jB6iJfVNJIF18AxmxxS5bK+soTz4evo+MKsh7rLTds0
	 jAB17pSi56wChbZMDKbAZ0R/SMTVB3uc2v54uy2DWRyCM5fdTs1l5xDghhmUJ9MW+a
	 iv0dWUOXiJR1fQxW7RQTVjB1YrvI1Jir7F6GVpBZUMs1OSGxqU851/AqSwjdcpPT/F
	 u0hGLg0hsUH6DNBqPfejFCc3ByQaX9H7oAmyUrCxJOQ8qVm925XGfsqePQOdw/oqLx
	 1IB4oNTco0tE59f/H0KgzhrgMw+7wgqk02nLhrr8ZJCntktJrkUzAAXVK7CmkZL0kC
	 FS6BHwjt+sPqQ==
Received: from github.com (hubbernetes-node-a4ac5c6.ac4-iad.github.net [10.52.159.31])
	by smtp.github.com (Postfix) with ESMTPA id 3EF6D3400E3
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 05:30:53 -0700 (PDT)
Date: Wed, 14 Oct 2026 05:30:53 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1185477/000000-362660@github.com>
Subject: [bluez/bluez] 362660: hci: add ext adv interface
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

  Branch: refs/heads/1185477
  Home:   https://github.com/bluez/bluez
  Commit: 3626600cc14afa7d8b40b7c13be4e8e8a8e98d93
      https://github.com/bluez/bluez/commit/3626600cc14afa7d8b40b7c13be4e8e8a8e98d93
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-10-14 (Wed, 14 Oct 2026)

  Changed paths:
    M lib/bluetooth/hci.c
    M lib/bluetooth/hci.h
    M lib/bluetooth/hci_lib.h

  Log Message:
  -----------
  hci: add ext adv interface

Wrap extended advertising HCI command interfaces.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
