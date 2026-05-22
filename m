Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA111327BF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471978; cv=none; b=j/mgGfe8tPSUf6vNBmxSMMiYnSfLAeDQncGMM3JPYyXZr4eiIUZ2TUUfEPLl2TLX2mRZMCPhkNps8xFLcmE+TLQLsU0xil5fJ4fGvXJU8O7H0XCiz+gHXUXpkfLwqyv5l460TXTJ5xbn8C8JxV2QcxviNDWW0UVWJi66zea5ofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471978; c=relaxed/simple;
	bh=q4iwybuhlahkqQ8JYMRUdZnkPGEX4Czb6JZaAJPHRQY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oMx8E47xde23zDkR0kxWD4l5khVhfiS44C8xMgcPJz5Mh0WTYBsawooBP/XKjEQIZ3pmzYptx6WjM1YxqBo49/A4/fbff2mGiz/qq2+hhutnyfF/ksNflaqGbEbH6CrAMKCF6oLwY648VEFEZffpS21zgimatOihsczjVQ67on0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=U+2M+zIL; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="U+2M+zIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779471977;
	bh=lWBLhOD3AjKVAfLW5RQEzaAVSgfKoVkjUNhCCXrRDbU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=U+2M+zILgBSv7yO7sIrCVE0N0uIHuTtv5uBMG2dCpPvGJdRYWOYZJGKFKr7vGzsZq
	 YkI5CoEDEoKhuP+45TuUJQ6KOqJKKHues9UAzma5Gw/1F4tn24BqubMAhoiPXDW1gQ
	 SGy64pjbf19rQDBqyNzAKZAE/uwmKdmM1O1c2OxE=
Received: from github.com (hubbernetes-node-4e5a553.va3-iad.github.net [10.48.221.106])
	by smtp.github.com (Postfix) with ESMTPA id EF8637806E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 10:46:16 -0700 (PDT)
Date: Fri, 22 May 2026 10:46:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1094712/f2d501-000000@github.com>
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

  Branch: refs/heads/1094712
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
