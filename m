Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D778286D73
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766559160; cv=none; b=EIOadV7NXBsMexYckm3uujJliB3s+uWlupAUUl+Q4zxXitl5WXAdcxV+5xSzA8X0bgTbJaIy9H+EE1r14WQH9BcgP2dzGF0ZPUDPTHQtmXolQt7ehdlaaeHWTp83c1kyu6uQbuusdEla//Gi30ZUWYqAQO57p2F0/nUkuJgoYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766559160; c=relaxed/simple;
	bh=UEOh9QPQ7+7KYn9oRLXltC/kMrzvXH5+B1Y0kHOfNko=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uNoKCTGlSnr7WIicayiDsq8cfSvFdby54+wCY4zlbYbHKIC0Kf4q0ZE6csYYijQkTmqPYX/780Y9yYctfjsYsUj2tLf0DvdwBiU+1UyWi/eDZ64cNuwBrtyxs/3KgcdVSJhyHzTVMttcJuaFsOWMQIZiQs9iAhPUEUmgaVdTBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Tgnu0pvn; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Tgnu0pvn"
Received: from github.com (hubbernetes-node-5558481.ash1-iad.github.net [10.56.166.33])
	by smtp.github.com (Postfix) with ESMTPA id 3AFBF920834
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 22:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766559158;
	bh=ZUDjaM8CLbqQoGQNViZKE4ojYunYXNhhClhc/NrYc6U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Tgnu0pvnZaCxBULo1G8VDeSru0EHF3MAIaDycC2OQr3ezT62inuIN93iUtWozrnOY
	 qRn6Po74IA/sC+0VFDM3B3yj49g4XntTfDm/ErQbwVOjLMv2NJwubh/na/wDeWsbyM
	 5nskrw6EMkKpBRGsSg+mIWIEMfLjg9AZboJP52Cw=
Date: Tue, 23 Dec 2025 22:52:38 -0800
From: maheshtalewad <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1036285/000000-15a776@github.com>
Subject: [bluez/bluez] 15a776: Enhanced Accept Synchronous Connection Request
 com...
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

  Branch: refs/heads/1036285
  Home:   https://github.com/bluez/bluez
  Commit: 15a776371b22f50cf474a696b6c2684484d4b6a0
      https://github.com/bluez/bluez/commit/15a776371b22f50cf474a696b6c2684484d4b6a0
  Author: Mahesh Talewad <mahesh.talewad@nxp.com>
  Date:   2025-12-24 (Wed, 24 Dec 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  Enhanced Accept Synchronous Connection Request command is handled in emulator.

Implemented the command - Enhanced Accept Synchronous Connection Request
command in emulator[emulator/btdev.c].

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
