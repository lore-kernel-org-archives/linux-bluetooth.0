Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355422F7ABB
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472281; cv=none; b=qwqgDUhXfmgpR0gqXQgU7o32zGsCHDBUjkmba63D+U3KlGyVLvfok5ja7aI3kf3U3fue0ZpS0NH+b6XNGgQ2ZxShSdlZ4m7n6aqiizWDO/8YeFyuKdyZMX0Jnjq9I5xY5vPs4TTssE8g2bhpSnorRUydxVZkbQqyYVWAKCWbSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472281; c=relaxed/simple;
	bh=U2CXvxy33tIUwg8AfpK77tb4iEPGMgoDlUqjCVIpTIE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cJLplkYnoQVLQ8G049YXM129wL/DLMcxPi1FaUxbK0w7fPKBueOZDdMwmDmSlMUDUHxISoh1LVbWQ7eav20gFxnFhF6PpXiAM6F3iJ8BkRAXDB4pMkOJSG4SnceigTNuiubIuXgVNK3mH2f7FSJBhX9iR5kxHXFDqWiFNyMLcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ji4QsVUG; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ji4QsVUG"
Received: from github.com (hubbernetes-node-e176a6c.va3-iad.github.net [10.48.201.82])
	by smtp.github.com (Postfix) with ESMTPA id 4A8784E011B
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 15:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762472279;
	bh=+QvGZoiGfIpStFSfR1kFdFCXRE8KuADCaHqPoDnagIc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ji4QsVUGMDSsqiX28rcRSZgiHo3IBuTDvLTC2puJ5mp2Il/fpFatCIHEZuYnv1tob
	 qP8nJOrfvuiLUq6ZDg0mPjekHkRuF3LBvMZ9cStTiVID1o/5PXHe1xgHvAdyV+4XbP
	 hFkmVQhcHfxr9wiK3JkEqu4zpnlzxB/mhbkBsfxo=
Date: Thu, 06 Nov 2025 15:37:59 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020539/10c5ae-000000@github.com>
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

  Branch: refs/heads/1020539
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
