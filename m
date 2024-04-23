Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DEE339A8
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895740; cv=none; b=lf6Sd+emm2ZpVgZzzXUKyXpMlVpU9bUeWvRytjFIvAG+i9vD20gadFe+ULmTUamqW6Lv9c2KRv03H9weVh8lOJZAkp4a9u8RCd6bvKF5kVTOjDflWy8OEDMV8ckCS6IJQPziYvZ4oCxtJW4eSXNTBajWElWYqPPwASAQ2dNIoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895740; c=relaxed/simple;
	bh=htkebkt5rpjz7UVcN7lhKlf3wIcniUlLpTdy8+wa/Hg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NddHBAcwEoSCcenyyMq+iMm50YmHc2OoQVd7LGu7TCXi1In8yBJvCubO6NTnCKvscBujgF6oqLAWdjTJJfzrIGBnAdvZNmhEQL1ocnTNjexI/wlNdDYYLziyWt1qMbniheUyUr69n9bcUrR7mbFDvyNW8BxwbC2Ux333PTzUpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eJ6/Vzt1; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eJ6/Vzt1"
Received: from github.com (hubbernetes-node-e4d2fc8.ash1-iad.github.net [10.56.144.31])
	by smtp.github.com (Postfix) with ESMTPA id BEA9234031C
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713895737;
	bh=kiK+TeNSs9jfrjiXcvIMqDZXgPGFPNKQr0hl6IxkiKU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eJ6/Vzt1+bk6eWk4MPPGSbRpG8zvpPQl5KjWgiKKnaBhs4T20XDsBafXn0o5XXpG1
	 LS9KKS+35FVxunXNiYrm65EXFFyTU26LIU1awc9WbfXrxb8fw6QHCWADAUBpsR7GqV
	 vDlNiioie79Ao6+g/H2Vsmo1OsdmDPetZy12Z5f0=
Date: Tue, 23 Apr 2024 11:08:57 -0700
From: Andrei Istodorescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8e5f34-30b741@github.com>
Subject: [bluez/bluez] 5b4d9a: shared/bap: Allow NULL bap endpoint in streams
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
  Commit: 5b4d9abfdeee44dd9b70113fccf4c16f07350f79
      https://github.com/bluez/bluez/commit/5b4d9abfdeee44dd9b70113fccf4c16f07350f79
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-04-23 (Tue, 23 Apr 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Allow NULL bap endpoint in streams


  Commit: 30b741baa569bc3dceabb24f2e6a9e7fe1bb87e0
      https://github.com/bluez/bluez/commit/30b741baa569bc3dceabb24f2e6a9e7fe1bb87e0
  Author: Andrei Istodorescu <andrei.istodorescu@nxp.com>
  Date:   2024-04-23 (Tue, 23 Apr 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Get broadcast channel location from stream capabilities

Get the channel location from the stream's configured capabilities,
rather than from the local PACS database capabilities.


Compare: https://github.com/bluez/bluez/compare/8e5f3433dc5f...30b741baa569

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
