Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1B26F293
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763644; cv=none; b=QG6vNF4nMHB0CRN79H7dgbOtWoL4VQFoaqkgJNGjXTw/daSONtLTdcwqGkP8xKKTiGf2u7/ffGPgsLeyoT4G6hBE4XknnbVp9d0Dx8fOZdyDsYQdd6G3WJkhhykLIo7BwTCMEQmDzGXEOKQjU41PTlUY2TAcQ+Be+PslDV6gcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763644; c=relaxed/simple;
	bh=wlPY1QPZ2y6MlnArLVtPjZmSV9LTnzN4uKbmslCGEJU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZCclahNWJZIxMUNiBYsuyP8sDBcF8+W2v+hfsLkeSE5uHcfc0cf5ej25yq1lxjKjXP+v7fMeDbLYJ84Ls7j4/Ob55TXfDaEXBcCoSnDq3aJsz41tEdtgD3bIWBZ6A3WKMCVf0A8QIyFDbj86woCt53m2ICrOvg4rZJDbFDXxrrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Q43p7hiM; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Q43p7hiM"
Received: from github.com (hubbernetes-node-4b454f7.ac4-iad.github.net [10.52.145.53])
	by smtp.github.com (Postfix) with ESMTPA id DBB0A640866
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773763642;
	bh=wYa5hhlunyOvjPVj1k5ztbn7L7nlq5OaYfuHwEgBVYQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Q43p7hiMihlTCu9sswIZEeXkxoDlOxcMyaldO9iH+rhvi+1glQO/6B5Io0rzz9Pwq
	 GmJ5QdV9zbzUVudzdPjXhIL/4kXHN9O8rpW3zDaxZ2kIRHSQCVITbEDjnteeNsJYwo
	 kWcGl7+FZHjilP+cj8E7EIqn6ywOw6erTjRk3HCA=
Date: Tue, 17 Mar 2026 09:07:22 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a035be-11d05e@github.com>
Subject: [bluez/bluez] 11d05e: shared/ad: Fix not checking length on
 ad_replace_name
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
  Commit: 11d05ece674fa1a31da50bf505bf744628ad9078
      https://github.com/bluez/bluez/commit/11d05ece674fa1a31da50bf505bf744628ad9078
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-16 (Mon, 16 Mar 2026)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Fix not checking length on ad_replace_name

iov may carry move then HCI_MAX_NAME_LENGTH in which case it is
truncated so it doesn't overflow utf8_name.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
