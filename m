Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CC1B4F09
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763075730; cv=none; b=SjFLvtkRJ2vc/4qmH71DGStvBObtdhmkL90ifn6Gl5XzrjtDozU1gsvAQozdwez1VJJ3GhmoR1YqFODJTX2CTss3VferRiuDp2wzo7Gkznc64OghI4su2ljsOsTO51wMVyZxuUD55BY7ONqqAMB9mUG07AwTfgENHFjcLb/z0MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763075730; c=relaxed/simple;
	bh=GPvZP+mD7R6WwSA6RiuHrcJ6dz3oAg8/8Frd52ky7Wo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W97B8YMwcYxV13Wuojm9p9EjDwym8F9uoa9t0QTWJB2aG4Ya1K+mayq9PEYSI9lyzy3UAMr02MomRxfzwIDGOgU1BQD2+GkDGdrCtuE3GTDEBJeEWGLNuKN3FbLuqHKa77ZmTVQK7SXD8Nd6o+vifgjTLq26mKuyC09IuqlM8LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lvXT6dnr; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lvXT6dnr"
Received: from github.com (hubbernetes-node-2a226e6.ash1-iad.github.net [10.56.212.89])
	by smtp.github.com (Postfix) with ESMTPA id D9C3A1403F0
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 15:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763075727;
	bh=n1b5lXuWtD/74GJmofMtQRBs9JlUNR+m8GTTdsIzmrE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lvXT6dnrpmiPCAetTpvufANBT4BdA3O6Ga7CLxesX9ez1pIQwkoWqa+CvkridIZhK
	 x0AxDmAVfiOxu0MKTgS2m+YgK78KsOYmbFa79CyhOmg4rQM999y+8UW3aGqD/dkMV1
	 r/XoF0pmQT+vJMwMSK3y+iPxj/RsWChma89YRHlA=
Date: Thu, 13 Nov 2025 15:15:27 -0800
From: Daniel Tang <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023205/000000-f3a24c@github.com>
Subject: [bluez/bluez] f3a24c: mpris-proxy: Only be started by
 pipewire.service
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

  Branch: refs/heads/1023205
  Home:   https://github.com/bluez/bluez
  Commit: f3a24c8a3b8636f832c720a50e069b506e7ba5a0
      https://github.com/bluez/bluez/commit/f3a24c8a3b8636f832c720a50e069b506e7ba5a0
  Author: Daniel Tang <danielzgtg.opensource@gmail.com>
  Date:   2025-11-13 (Thu, 13 Nov 2025)

  Changed paths:
    M tools/mpris-proxy.service.in

  Log Message:
  -----------
  mpris-proxy: Only be started by pipewire.service

After `systemctl --user mask pipewire`, all related services including
this should stop starting on login. A non-console-interactive user
without the default sound server is unlikely to have any MPRIS clients
running, and disabling the service reduces memory usage and attack
surface. PulseAudio is obsolete, jack2 users have professional
solutions, and non-PipeWire users can ignore the `systemctl enable`
warning or use a drop-in.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
