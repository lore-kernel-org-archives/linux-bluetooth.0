Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A77E792
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456576; cv=none; b=PHQwMFNKd5UQQtJCiJR561zzrsl+8z7LwJVH0j7WEJjRcKt2vCwOUUTiXtjSTc9CGevXDgBUKOceFt9mYVBiMyBaQZA1iKPVuUMUIyzh8uCEmgJbfhm6RFEDb1tVHf8l57A5KOkMYsER86PvXK+oEvZMXFKDTNr6ARsFEnSXwk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456576; c=relaxed/simple;
	bh=q8qFV0yen7V06FBhpdws/Zyjn0UJoDSHnVX5qA7RIXI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aIcfp0mWObQ96YaSId5518BpLIxd1t5kZyLt5x46zHkAMSgzMDxWg9bIenVYZ4LFJrAcQ7l1QbQHGpEzIr+ijV6QLk+7F/uBtVlly+KhFCy2Ju2CpLcuNMRF55cut7nH3yqAm4fKjTMYr27MtLX08Lq9Pvo+WGB8ijD9d2FH2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XoLew9FJ; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XoLew9FJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786456574;
	bh=1qeP521kEj4/Bfv5R0a3cuTHImuZV3Uo5gZJIUOXB30=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XoLew9FJ42j7QCYKvtgZPYjBaoEOifE2d28e+S+BD8uSBIXCcV4xPBK7ZFfYqg41C
	 CcW3W5+iai9BmgV2qkNXf5T+/S93+9UM8I01oCQM9/U2OtCwqjgGbyEqvUSUkrKXQ5
	 zOWFhuJMb0ahTHPvzpO1YeqXtcl1XP0gKFj1a02s=
Received: from github.com (hubbernetes-node-8138036.va3-iad.github.net [10.48.70.98])
	by smtp.github.com (Postfix) with ESMTPA id 271D3181330
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 06:56:14 -0700 (PDT)
Date: Tue, 11 Aug 2026 06:56:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1126078/a317a3-000000@github.com>
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

  Branch: refs/heads/1126078
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
