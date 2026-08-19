Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B13CF21D
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169486; cv=none; b=BhNWbqAf+qGquCJJfMvu/1ZUakF/LraLtqkkTRzY282dBWe60yjZP1YEdU91UIaGM7vzDJ02yY48lyNcIDh12T6pVzEYZH7cYJCPjMbdfa+uR//lrI3YOiG61PH5Ip8xsNxvfgMkFsh+FPx/M9bHyNWsnK9+INQ23MBrW+kbMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169486; c=relaxed/simple;
	bh=Hq1qMM7BuZ9+LMte7785v2Ifok3jG7i9QxSMLvz1qbU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Qz53WvPkvuOaO4S7/L0Swe9woOVZzf/Iz6uNoCMfNsqyrSiAK/mtjnmNyRyV1U1CFUntrgHtTkacldlvtUlERJkJ3wTIhdgHh2VLyzBUjSEVkspuHzY8M+izWfhoAMS96oR0vyFX/Yl+ksVf2/0o6tXlTxlQnGf3QSYPdaZe32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KSBaPCzK; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KSBaPCzK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787169484;
	bh=LgSMKKIvJr+E71LH2YFW/tUnIhoEXUE6USgfyXLqbDM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KSBaPCzKb/w0IXUJroe4oNzXjgsJxH8o+2Jq4lrGBXu3sCjCD679ipU07w73OYnzB
	 yh4WF64N/ACjXQMBMGTvTVztTeD9MHuR6m0ey3xJQuK3IljWPAyFNiId0zKHlNCOza
	 yNaF3IWPqUqPKs2N5G/b5gnkMZiZgi1ENEPVfAWo=
Received: from github.com (hubbernetes-node-632feb1.ac4-iad.github.net [10.52.206.106])
	by smtp.github.com (Postfix) with ESMTPA id 29DE6A134D
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:58:04 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:58:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148340/dc5d10-000000@github.com>
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

  Branch: refs/heads/1148340
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
