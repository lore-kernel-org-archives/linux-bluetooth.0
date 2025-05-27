Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F961D63F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380374; cv=none; b=QWy/UCnpSGM+lgYDdsHjwZlclouLYgqB7TqfZ45wfu3kvz+ACC4eWe7ZcFTjz/KVyrhBRmBJmRvRtMmxdA9AK65RwiPWBd1fY2MuYrvz+Fvu4VpPx/NZyWhWIJIT/ZZLmoupCq4B46P6xZ7gFIzLbyf1s7dMqVH2Hr9Ks+AdPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380374; c=relaxed/simple;
	bh=1zMaZtsx1BDUwtcfKH8XX05s054uPmDR7Kg5enyHS68=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CqgNV7sOsPyXN4SzBDS3S/PwUiSL4afoyZOP+gNx5mRXR8Z8hCjx+Yn2OlGZXLNEe285Mg2LxC8/HTlzJTG53uIcLsgdPLopaJuw3waoloWjmjgXs2lyRpqOT4/w2KqCH6rejFSs6Lw9O/hVxhudi0gsBL/2yrWYnby+jLgmkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B+GNIWz2; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B+GNIWz2"
Received: from github.com (hubbernetes-node-5475eda.ash1-iad.github.net [10.56.164.44])
	by smtp.github.com (Postfix) with ESMTPA id 5927860092C
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748380372;
	bh=aT68KxmSt2OuioRsGsaT9NUANzJJ4oMemtozYDZxwBQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B+GNIWz2Tbte+7bdhzny0K5rVN/g8zoChm49Csd2PuQrTlNIeuC+dCc5i9/GW8f5m
	 oB4e6ey7x2FrxzwfftUeRSWY1z8/CfLKHxk3jvjv1eBZf2yeL+sm6sMrpoBfj48J9h
	 PrPC63JM9RiuCNluoppnKdt4PizNZEvjuhZRByz4=
Date: Tue, 27 May 2025 14:12:52 -0700
From: Remi Pommarel <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b14bfe-2a552b@github.com>
Subject: [bluez/bluez] 088de1: shared/bap: Fix not handling read offset
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
  Commit: 088de118d17c017d66030384d772395e0e26345d
      https://github.com/bluez/bluez/commit/088de118d17c017d66030384d772395e0e26345d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not handling read offset

Some attributes may need to handle offset other than 0 in case read long
procedure is used, so this properly handles that for PAC_SINK_CHRC_UUID
and PAC_SOURCE_CHRC_UUID.

In addition to PAC record this also uses
gatt_db_attribute_set_fixed_length for attributes that are considered of
fixed size so gatt_db can handle offset directly.

Fixes: https://github.com/bluez/bluez/issues/1294


  Commit: 2a552b93de8b319a8350b1057be4a53c025ab28e
      https://github.com/bluez/bluez/commit/2a552b93de8b319a8350b1057be4a53c025ab28e
  Author: Remi Pommarel <repk@triplefau.lt>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M plugins/policy.c

  Log Message:
  -----------
  policy: Fix service retry counters reset

Control and Target retries counter were reset when service state
goes from CONNECTED to DISCONNECTED, but usually an extra DISCONNECTING
state is reached before going to DISCONNECTED. This causes retry counter
to not being reset in this case, leading to service not being able to
initialize on next connection. Source, sink and HS retry counter were
only reset when limit was reached, moreover HS timer was not removed on
CONNECTED state.

Reset all service retry counter as soon as CONNECTED state is reached to
avoid that. Also remove hs timer to match other services.


Compare: https://github.com/bluez/bluez/compare/b14bfe90ae4e...2a552b93de8b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
