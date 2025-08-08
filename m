Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED2288CC
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673390; cv=none; b=SYKof33FzKhM0e6aqoEHySyST2fHg91Ghqrh/5zhfSPKodl/M+ikkklGQ9YTmN6sUIFIyqSDSvvmwYnM5OuN1PzE04IGz8IYBYD3bW5CyNhQIBT2rrswVwPzLShtTf/A2pWvPQBm6bHPI9OGvlWO+dAMTuujMq1v4Ap93R4wSPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673390; c=relaxed/simple;
	bh=pI3s8EqRzF10VuLsdXVOK0576vpXCQ6LGev6QeB3Oss=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZJc2iBMsNh6Jae0t9ma43kPZfle1ocxpt3MSd+p4a4oFaBKBzaASWO+Ikl/bWSUDaU/BpZMdsuk1xC/Y0gBiJwNOOcVDkGJ/+80hIG+SdE9eNcMvgvY/Wypq2/JxjWz8c/ZPIKeByJ3QcJLr/KNqoZ2VwtXoTw2jOos28zncw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ezRU1g55; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ezRU1g55"
Received: from github.com (hubbernetes-node-725cff4.va3-iad.github.net [10.48.184.55])
	by smtp.github.com (Postfix) with ESMTPA id CA6034E081A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754673387;
	bh=6c18rBUcjuAuVZPwe34mR0ireAnoDMODzf0xa1mSTms=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ezRU1g55GAhhae8zc8E40RpQu3ooQNkN09cK/XHYSwvAaxJMRDeBG1tecXENhH73D
	 8bdVMMcjEGNtdDo45uqV5vdyb/2my2fr6GBkZpJ87hlwmeDM6cx5kK+n9yOy9WlG0u
	 Dx6R0igNTXfskdj4dXv8awnJYSvUZdHxBi0HUCPU=
Date: Fri, 08 Aug 2025 10:16:27 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989478/000000-d61530@github.com>
Subject: [bluez/bluez] d61530: lib/uuid: Do not use mixed-case letters in
 UUIDs
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

  Branch: refs/heads/989478
  Home:   https://github.com/bluez/bluez
  Commit: d61530a9fb9065d53561ff5447629cfcff9b47b9
      https://github.com/bluez/bluez/commit/d61530a9fb9065d53561ff5447629cfcff9b47b9
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-08 (Fri, 08 Aug 2025)

  Changed paths:
    M lib/uuid.h

  Log Message:
  -----------
  lib/uuid: Do not use mixed-case letters in UUIDs



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
