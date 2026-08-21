Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E027280A
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787285303; cv=none; b=CiYGplcHrfVYJCma60Mn/iK8mWHJ600JeNKulHWvQBZP3cCzHeMCncAMpvbVeSEpmfM7uuIhWtchGgqRVmNj4iPhXHyF+IpPA3WTb0Jq1C2taueYXZsa6b7BXZ6/GGyd4MbqYe5Q+SWp3QCktPk1A/ZhOrux0FlUUBM3mQmpv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787285303; c=relaxed/simple;
	bh=6tmkrRf4SQaVCVRHS4UlnGOV7UXds1WdBENZViuca0E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sle4bl/VvcapSZc+psiRrRiB0htHi/AlG/0UCea9oqt09OCZNqSPhT0169AvlT8S9wkULyl8d4+gekdaAKnSwIYeBk8/N8wb2NM0ghaI/4RKvJCoXmy9iganZJ6TLwLjE7H2xfEcsuOHU8G36T4BprYCFFT10PAx0x8azt0hdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iJyogjYt; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iJyogjYt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787285301;
	bh=lI79sD3u6xjUzmXXQ69Xec5od9kNJzK9jwbo9SWGr4w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iJyogjYttR92A6U9+361BYLDbJpeUJ5TrOk92xTUf+u5wz7Vnks4/Bzwzoys/HIPp
	 aqgBRjsPzS2Q8Fs2VU9vMOWRyEnW1EotUmDZlg/91EL2OBdn2tnHr2dMm84WiQtJaI
	 ePkx6ILLX3tlJNfKL8jewzaUZ9RP+y497hoeVvK8=
Received: from github.com (hubbernetes-node-2d14c13.ash1-iad.github.net [10.56.80.26])
	by smtp.github.com (Postfix) with ESMTPA id 6BF0E18088E
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 21:08:21 -0700 (PDT)
Date: Thu, 20 Aug 2026 21:08:21 -0700
From: hudsonzuo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149440/000000-263b7f@github.com>
Subject: [bluez/bluez] 263b7f: gatt-server: Fix integer overflow
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

  Branch: refs/heads/1149440
  Home:   https://github.com/bluez/bluez
  Commit: 263b7fb4cf45a4cb7426858c6559c301dd38050d
      https://github.com/bluez/bluez/commit/263b7fb4cf45a4cb7426858c6559c301dd38050d
  Author: zuohsh <zuohongsheng@kylinos.cn>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Fix integer overflow

By using size_t for realloc len and rejecting allocations exceeding
UINT16_MAX , to prevent truncation into the uint16_t field.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
