Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2453C768B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502230; cv=none; b=VN3adMJs0AlkoScGvkGn8yrGG338DZarEt1YU73FYPebRqA45zatxWVqIo8jt7XokGecIjozbQ7jAcK2ZUzBeW51mftUPkHCkxESBhgM6xrs3FSaDU1rHGioxXofpJIN883dlRwSHvyuzQQ1V63LMoFRDgFWHPvSNHyWMSxQKmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502230; c=relaxed/simple;
	bh=D+VqjfXwYQnn0jqB5R1F66A5JHvZK00MsecguiaDwSs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=O+/IiURb7iP+Kh/nCBBP1HpJpsev3cos6fcNilCkvmVI46CyMDoUKnvlw55HUDvtYrqU4YH+iusJjmSGWoTH2sqiGsCUJeiaA+b9tiEud+VgzMRKDGVgwdQgYHOkXJdBEoqQlfS6WYISLq/wHV4ekXFxw/NOQVh48oYT80yOSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dGKqdVlU; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dGKqdVlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780502228;
	bh=VKfOlFrRNPDBhkwonwaREkv0b0ipNtYYASjdDw6WYZg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dGKqdVlUgD5kxLjA9I73OtXRsC0B8Fqig6uRntxX6qMdndkKsu52UCpQzrTiVm2B+
	 wc5FaY9RJzspjWXxKuFioqEmxqlBg5D4U2WWtdFcr5N/4vNMt/bvAoRH6MIBv3OZNK
	 w7d6d8asXdhcDGUHREADZCBLX1qV2TwrGX/DMMbs=
Received: from github.com (hubbernetes-node-c1f58e9.ash1-iad.github.net [10.56.207.98])
	by smtp.github.com (Postfix) with ESMTPA id 6489B360CD6
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 08:57:08 -0700 (PDT)
Date: Wed, 03 Jun 2026 08:57:08 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/07b6fc-2a6968@github.com>
Subject: [bluez/bluez] 2a6968: advertising: Fix sending extra bytes with
 MGMT_OP_...
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
  Commit: 2a6968b40378dca5650e18e03ad0407738c47be5
      https://github.com/bluez/bluez/commit/2a6968b40378dca5650e18e03ad0407738c47be5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix sending extra bytes with MGMT_OP_ADD_EXT_ADV_DATA

MGMT_OP_ADD_EXT_ADV_DATA expects the command to be of size of
struct mgmt_cp_add_ext_adv_data not mgmt_cp_add_advertising.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
