Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A093ACEFF
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132782; cv=none; b=r/uDdyhf2EUG9FmCTrdGsQ2rRU1jLmNSv0vNyInvrLIQWu9h0N6fGDOoMuv/OHUhTe+XHRk17p4YR/TKB3WzgHw8O/+77SEpqSFJPW5XK8zCum8hcUe/2BpVhAsDcES5y+ZH1cux2SdLSiUD35BD5g+dlyn3QtcaS+S7E85v2fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132782; c=relaxed/simple;
	bh=apv2XtKhNCcwU2hAAslbHGYaBkhary/iQ7EDGTXHJSI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cE0rJC4jGBA31wEHEkqV5GT+1D1G1QtRds7HY32pIL82Vy1yS87WCIYo3bCLKeOkUBpGTLvGMwvcgjGTN6FDRE3jbipQ7TcrwRGlwoB8Di/Oh9dNZKK6KRw96pi0OmecsDnNGQK9kxO2dIjkrV6y6U0fOoIblCXU7L8hdjhep74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZLv3DMCy; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZLv3DMCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782132780;
	bh=HhfvghEFRIF2ek/WpXP76PbhAvGF6XMnutUillvfYNE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZLv3DMCyhJeAkVp/oupj//zjFHopXg+kGfs8SG0mNt8yq+aO20+6x1WOQx3+o7w6P
	 2yXPzzb/uht4L/fKbdsBj2zJd7Imh72xpgJEdL8T1OzYgOIJI26X8Ao9JrlAC7qMfr
	 J1Ywpp5hxbsIgDO/6WIuDsDUhPJTmhtYxCC6vthY=
Received: from github.com (hubbernetes-node-e35d28e.ash1-iad.github.net [10.56.207.56])
	by smtp.github.com (Postfix) with ESMTPA id 7478B18070D
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 05:53:00 -0700 (PDT)
Date: Mon, 22 Jun 2026 05:53:00 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9305ae-5792da@github.com>
Subject: [bluez/bluez] 5792da: monitor: Add decoding of new MSFT extension
 featur...
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
  Commit: 5792da929b5caa454b9143b5cfd6f42950f381c6
      https://github.com/bluez/bluez/commit/5792da929b5caa454b9143b5cfd6f42950f381c6
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-06-22 (Mon, 22 Jun 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding of new MSFT extension feature bits



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
