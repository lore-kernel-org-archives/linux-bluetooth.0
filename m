Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324322CBE6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 20:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427539; cv=none; b=Nce7NfjbAgbA/L3BZtAaP+Kh+TEqtQMqvnZP6/Eeg/BZLgQDjx1tPaMMMcj+DeP/0EvgxlRlAGn8+NTTzYUrw+2o/PYvXkVbXWStgCcC3w38K72pSW+rcaMhs57F//waZ6jnNH34S72TZPfaErfTI3XuT4c7ke9p81e2LKB8rW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427539; c=relaxed/simple;
	bh=bPYYZZg+OX9gkLxzyXeSsM45ypYsTg+iVhIftoAPNWY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JrnDZJ1C7MpMsvjDu7abTbN+WczUR1bjhVpxQ+FoBygIiu0VaDMiWKy1qGTHpM7upiy9yJdaZ+J0yUOzVLEvOeKhqG/SvaNNo8muJRNtvnVOpNOVTIoKVsaT+mG16cmim3orR1nwFHRf7Ynxyk8Z2DO2gQa32prG0qiSiWThylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ja6zyttv; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ja6zyttv"
Received: from github.com (hubbernetes-node-ad85c6c.ash1-iad.github.net [10.56.191.32])
	by smtp.github.com (Postfix) with ESMTPA id A0B3D60111F
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747427536;
	bh=6BFJ5Jbw152Vx9MKqi/3Z2nUQd/HvgyKegQo4xxRvK0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ja6zyttvKhabd0rtzC5UUwk+0mV9dlwzhS9FAU80r6+HdNJl7cCHPCBsPUMb1USlg
	 AXdwKFUQa4JbFBG6J+XQ6t8RqiAuSKBdoDjfivXmOWf+dPmuKgLUIE/orlDSK5AOlr
	 U1mjFggcH0xr5gPznHcgY+VLUrPwx59xIdGyuSSg=
Date: Fri, 16 May 2025 13:32:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/963746/c4c314-000000@github.com>
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

  Branch: refs/heads/963746
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
