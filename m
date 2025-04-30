Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9725A2CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019871; cv=none; b=KvJi/gAVlt/J8zrViN1m4TzAbwZRlLoxgawCRIpAUt6XMpu0C9PMCijwVRCycs8g0d3oH0y5FAk/zWeNkgXE2+F4RnWapz/RfhnXUNJyEvnZ2o5qQauefPd/a9eGXRYX8jE4KH8jFcZ8LDuQnu5dvM4/skXBOP+MBl1BlKvj88U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019871; c=relaxed/simple;
	bh=zyIu2TNXVrVFSReAuMdZ+lhlfhLbYRGW9Ht0rYnIlgQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XYGHhtiwwwTJ63912khHucuP3K/EXtP9yhCV6Dxq9+/QOD3miVsQaG+BFLYlFNBLnFEMvqFV+VwI9dT00++v20hnyNccobEyJONC4udg5GtYdpyWdLFG64VwxJF3I6T8I0pjK5xAD5vaTENMhP5S0v9c2AroUavHx7HSnIlfRoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YO6rsEfT; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YO6rsEfT"
Received: from github.com (hubbernetes-node-5020715.ash1-iad.github.net [10.56.149.41])
	by smtp.github.com (Postfix) with ESMTPA id 3CAE2921291
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746019869;
	bh=7D/ZkYzKEFNbWQPEsTVs1Ov/72F8btZNTc7XwNuC8Zc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YO6rsEfTYPDDBpLwMtEAt3kzZfu2PnZzhLyMtaa+NqfGnnyzt9OFqGXFcA0MjqPfj
	 YUEqG/D4gARzdYasQg7/NTT8PP3sdALvYc8AlhN7lKyGpfLnc7PQTdTQA5IBe1yXDs
	 bFb1+EW3nvlymEeBSDUAGHwITbmUu3zI5lGydX1c=
Date: Wed, 30 Apr 2025 06:31:09 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/237d81-5b6c09@github.com>
Subject: [bluez/bluez] 570a55: device: Fix not setting
 DEVICE_FLAG_REMOTE_WAKEUP ...
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
  Commit: 570a5505fc79c16ad69f79d6db57ee79e409828a
      https://github.com/bluez/bluez/commit/570a5505fc79c16ad69f79d6db57ee79e409828a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-30 (Wed, 30 Apr 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix not setting DEVICE_FLAG_REMOTE_WAKEUP when required

Due to the introduction of DEVICE_FLAG_ADDRESS_RESOLUTION it is no
longer possible to check if the kernel has support for it ahead of time
since that would depend on device->supported_flags which is only updated
with MGMT_OP_ADD_DEVICE _after_ services are probed.

Fixes: https://github.com/bluez/bluez/issues/1207


  Commit: 5b6c096fb859a70a0792b97ad7aca3190404a5a0
      https://github.com/bluez/bluez/commit/5b6c096fb859a70a0792b97ad7aca3190404a5a0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-30 (Wed, 30 Apr 2025)

  Changed paths:
    A .github/workflows/codacy.yml

  Log Message:
  -----------
  workflows: Add codacy action


Compare: https://github.com/bluez/bluez/compare/237d818ef294...5b6c096fb859

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
