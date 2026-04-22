Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFD351C1F
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872624; cv=none; b=c+dfMS+UkausHZxg+HIelneFrVPRWlqcpO7hpqY6yUElLEVvzLCJyK/zypGq3kE7lsN57L0HagRHAfHNWtGhEO02BuRWFfk+iBIT1+junuFBQzf3ONgjxl6XG4/LpMVnpTUTR6oWmAtJc9gvgWypbYd8kgmDrxk31Lr6iKkMWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872624; c=relaxed/simple;
	bh=YRQpX5a7wkmh52jkJ1BrN7DZJ466YLEZcyFSVzo4rkU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Yhjjx0u8EAZIr6ypLSEw2XXXzWgUZ9N0x6QZBfHBjFnZ306pCkmbA/lX45rPox+wU1yBlI/jbm7Y2W2O1Fa1WVIGQeZpewyk6FW73Zd/qYmriZhVBXT7LBR2iawhzR0N/w/my011ukNBfNF3VtGbn3A98EDJiCP9x99LRFMu0Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fqek7AB7; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fqek7AB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776872620;
	bh=otU3Xb+m3nhrIryJ1/ux6jKY4ylxYBk37LO6kq1JBR8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fqek7AB7VbkabGp1Ihzem2LRWOprrZwH2jfAEH6W5LZpjpQYmrKO7syeFjH+yfCA2
	 dX2wUCz0u9uXYDGDS312vCCh63NVzHflp+PtM2KRDC1cGxBv/uv5T03VAKwyNq10VR
	 ZvYNlvoP9BlFDXTEZIakv7H2GiEWB2knddjlWB6k=
Received: from github.com (hubbernetes-node-941a233.ac4-iad.github.net [10.52.220.86])
	by smtp.github.com (Postfix) with ESMTPA id 4B30F78102C
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 08:43:40 -0700 (PDT)
Date: Wed, 22 Apr 2026 08:43:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084336/000000-e4a8b6@github.com>
Subject: [bluez/bluez] e4a8b6: input: Fix checking LE bonding on HIDP
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

  Branch: refs/heads/1084336
  Home:   https://github.com/bluez/bluez
  Commit: e4a8b629ca08b64fc1ae7371299935706a961d53
      https://github.com/bluez/bluez/commit/e4a8b629ca08b64fc1ae7371299935706a961d53
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-22 (Wed, 22 Apr 2026)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input: Fix checking LE bonding on HIDP

HIDP is classic only, LE uses HOG, so there is no point in checking the
bonding with the address type which in case the device supports
dual-mode will map to LE random/public address.

Fixes: https://github.com/bluez/bluez/issues/2034



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
