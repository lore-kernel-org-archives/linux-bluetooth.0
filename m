Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082F23643B
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743590569; cv=none; b=AZug/7Uw2ISFD/WN3kuC5iJRNcLJvz2yTuhH7P012tYGivj6MXeEHqjdWFsR1c1+lMtBQDX/rO4HjXNcPzEIsygyYrhIFg6f2V6PJBNQ3lxY+UA5pb/vkERo72GkqH/U6PuGHmMXO2ENabIu8zb6x67/H231X6k4dsed2JYMNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743590569; c=relaxed/simple;
	bh=dgMiauFDEz3kK9PEJa0Bj1Z8cZs7AhE6cIvaDNvogss=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GfkzcB1ACyo3ZNU2ksPn5e4ua2ntyCYGRifSZ/9O/IsaXiV717W36xcFP0ck+z7lDFUHzCr6qVqmCSmP0pudjVf4JDHicmfiAzJKa9c6BV7vFalbczdHXzVZ8EP4ybFROsJyMr27Q8VVhAOmj7LxWAlChBVCaEHcHymqjh/0AUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ezgZ1NG3; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ezgZ1NG3"
Received: from github.com (hubbernetes-node-b5cd4ab.ash1-iad.github.net [10.56.175.27])
	by smtp.github.com (Postfix) with ESMTPA id 865BF920409
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743590567;
	bh=1KeJDXKob1zGHwx0eJIK2ss70wh6TKtDKgNJJZfOiSE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ezgZ1NG3QSHIc/s0eTPyZKD8W5QFsa/oGOFNAQnYZQvC/ZfY2Ly2Er9tsVU8PwDan
	 os4tNshBSWgAp0c6H6nCDXUvWDCkzCTHNHoDX8V3HzM3l5AAO5AytWNlIL66dTcFIL
	 tMDgA/dlu36kBrsHURtQsK4HzEQy9NKZIQRppuXw=
Date: Wed, 02 Apr 2025 03:42:47 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6d20a3-0efa20@github.com>
Subject: [bluez/bluez] 0efa20: Release 5.82
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
  Commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
      https://github.com/bluez/bluez/commit/0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2025-04-02 (Wed, 02 Apr 2025)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.82



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
