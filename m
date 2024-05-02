Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129837147
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660379; cv=none; b=aeLcGbPV3iaogmwvUVRbYj0gZStjasCESZgrxaWIvh2mBLM4SS/VTpcfChGGbF9siPXejxx+B/fVv566hQDny2YAU0JjOHkTDX9tRyCFeRfkDArpEjrbC7KBuG2k//1t4uKWIXwPjGQdn56U8T09y41Qtq6OzaG/2IZTx5Lyd6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660379; c=relaxed/simple;
	bh=rv5BFLbh3MyJDaTqi03ATPhGENnBjwHITDZJTolojBI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NW5dtPQ4EdO9i/24F71KHrE9vjVgVP04L/LjlqYRdAW7ODgHg+VFlrEiOgmPosAggP3ydqa+fQXRbraZ618a3LicpoiIlNU3Q6VzoVitCloS2Gz130EEBOioxPgruMQEznvDKvM3BhL1VLV5iRuvVdzbMcGNXfTCKr7lnR/8/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H3XvgFNQ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H3XvgFNQ"
Received: from github.com (hubbernetes-node-bf35b53.ac4-iad.github.net [10.52.201.49])
	by smtp.github.com (Postfix) with ESMTPA id 00CF87006DE
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1714660377;
	bh=QcQC9Hc7q05bz4m8BTCYsD3Dure5mdTebe9mdLlK6vA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H3XvgFNQUln0I1+Edh72Aq6Kn26mIp5UDJg0yaA+tr0PgYcT/K1PTcRsTcV0jJDcM
	 GTmvyClbi9k1DUSY8n/+bj7IBiHIvJYryajqyWv6ECpFnNTgTEdWz2q2eiKhBuxQ68
	 mOr7FRL1VjnqpWOm8kKyvW/COrUzSnQSa+sMjlS8=
Date: Thu, 02 May 2024 07:32:56 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6fc599-14057f@github.com>
Subject: [bluez/bluez] f40c58: src/shared: Make default length handle EA
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
  Commit: f40c5857d70a91e417e22da9da20f4193414b8a3
      https://github.com/bluez/bluez/commit/f40c5857d70a91e417e22da9da20f4193414b8a3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-02 (Thu, 02 May 2024)

  Changed paths:
    M src/shared/ad.c
    M src/shared/ad.h

  Log Message:
  -----------
  src/shared: Make default length handle EA

By default bt_ad was setting just BT_AD_MAX_DATA_LEN (31) which is not
enough to handle devices advertising using EA, so this switches the
default to be BT_EA_MAX_DATA_LEN (251) since EA is much more common
nowadays and for those case where the it is not supported (e.g. for
advertisers without EA support) then shall be using bt_ad_set_max_len
to adjust the maximum length.

Fixes: https://github.com/bluez/bluez/issues/832


  Commit: 14057f2cc0ea31b0f332e65dcfba2197b1e280f2
      https://github.com/bluez/bluez/commit/14057f2cc0ea31b0f332e65dcfba2197b1e280f2
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2024-05-02 (Thu, 02 May 2024)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: gatt_register_app: fix parsing of UUIDs

- argv[0] (shell command) must not be used as UUID argument
- fixed linked list iteration


Compare: https://github.com/bluez/bluez/compare/6fc599e334ce...14057f2cc0ea

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
