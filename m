Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31B236E465
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 20:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320888; cv=none; b=bMSGFID2I5oPjFlHMd++QKT0ZLkyd4W/V6kWET4rtcLhwaHLHVzu2gG9EWLN/ghaqKOo2QKyB95O0tXNvKlYhOBiRRJZwYwEmsj8I580J+C2BszusRwLKN3SNoWcB9Eag/ACM7iqk8yn2enKWnQh7gd+LGp7ig9UuuN9LtqxOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320888; c=relaxed/simple;
	bh=4YEAPekPqMQHJGTvFEW8AcsuEdUt9dhz67Ob5uwTZgA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=S1Otf1DqTS5vk2db1pqeHHR0iQMRkPQNvJASJyA+/mdPJ6grX8XMYVLeFj8pkzkp82t2LDM6/ZsmiBJm4PTEBf0vIDiwmbFeY937EV43tDwEbZ1WBKylDISyIgj9D3foMioc1Y2JWnNyZSmcv0u++J6X1ZFo81N9BnpGKV8mn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K4NpOKlg; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K4NpOKlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777320886;
	bh=h4Zrxrd21JAVMCpXc7rQokYIOpytFx8gFhuTaTLX7Q8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K4NpOKlgUL6toKjBCk8lcEzDJtZSeA0Zl6lxdBjI+22bFciO7Oswig2Wl/eK+zmIx
	 e9IBnPOAnRtFsqTCCqsDmqxj2YpypWx+79HU0jY6mnqKufRVXxAM0X4JebglYyPSnF
	 ID0FPkFtCeDxP9NFaw9ebtJ2rF4n1/xhVTVOd6Ms=
Received: from github.com (hubbernetes-node-5200a80.ash1-iad.github.net [10.56.128.27])
	by smtp.github.com (Postfix) with ESMTPA id E1F866010FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 13:14:46 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:14:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086393/000000-a388a8@github.com>
Subject: [bluez/bluez] a388a8: monitor: Add decoding support for Public
 Broadcast...
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

  Branch: refs/heads/1086393
  Home:   https://github.com/bluez/bluez
  Commit: a388a8bf390b3cdbd1d26f34f924eb394bb7ce5d
      https://github.com/bluez/bluez/commit/a388a8bf390b3cdbd1d26f34f924eb394bb7ce5d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-27 (Mon, 27 Apr 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding support for Public Broadcast Announcements

This adds support for decoding Public Broadcast Announcements (PBP).



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
