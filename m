Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A0230BDC
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748541053; cv=none; b=TY8PlfhzmAolVaRpkJbD5q0BNOZHH75kDTMC0w8HGA1Gz+KvMRoeN3cZSu6YgPlWahOnlm2hYn0I8Q6JCkGAj4tskNDz8YP+QqkGcmQD67dVaq0inv4kF9e5qNKGoV2Q8oDDWaBXjIyf3OymGLbB3us/t66PGXbnH9GMBGbxiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748541053; c=relaxed/simple;
	bh=y/0fyO2QsEAQquRMWHCHIwt68GIyk38BSgtc3IyiPHI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Kf4r4hZGFwV4TITqULvHfGsHfgtq1uEpYj7rhqHyAYnSdG4nTPUKXiug6QYQ4mJ9bEY2iYfKE4louEtDLG60QDxZEP1MysWH7YZ5Gon4VGMWSWqVH+5jXVMdhhxA1JN5LL9r+bi9IQKIlN8wY781YzaTwADbnTkWvKsmfj/hTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZN54Z8YH; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZN54Z8YH"
Received: from github.com (hubbernetes-node-332f0c4.ac4-iad.github.net [10.52.154.34])
	by smtp.github.com (Postfix) with ESMTPA id 7D354213C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 May 2025 10:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748541051;
	bh=mndeVkunCMHbZjpAjzs3otFr397mH4wlOxNC6vjDX7I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZN54Z8YH5j1G+Ya7sy1lyOAx1Tsi+e4HNVn9L2BNI71Ej1DtTOrg+EUqoGkKLjH7B
	 rqQepw8+oshO6c8I8BOEoBMDNqhEPE901eNtu/JzYH6rpuRyd//XWWDO9zN4ZZWoTv
	 5RJY1v8AATifeThnszYEvyw8PTbPUCeSh/KXYKFU=
Date: Thu, 29 May 2025 10:50:51 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/967405/000000-23db68@github.com>
Subject: [bluez/bluez] 23db68: bass: Fix not setting SID for assistant objects
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

  Branch: refs/heads/967405
  Home:   https://github.com/bluez/bluez
  Commit: 23db68383cf9217969e68eb372b1c4019ba54d6b
      https://github.com/bluez/bluez/commit/23db68383cf9217969e68eb372b1c4019ba54d6b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-29 (Thu, 29 May 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix not setting SID for assistant objects

The assistant objects shall contain the SID so it can properly be sent
with MediaAssistant.Push/BT_BASS_ADD_SRC.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
