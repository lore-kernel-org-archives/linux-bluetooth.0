Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD532D443
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092811; cv=none; b=qn7XOXN+oNVNTBqspjTPI21p7RZaMIqxtecslu5Gd+DZI4DEgEgRrQngns0OuSfaG+pRAMT0xNs07FwEVE6lQydqvouve0MF3odEYLVfnolOsavCPXiaRuQ+EzVr7vA5ro9dFdLYJWul+2gM0gURNBIjYvWCrc8LZd3EOATWNfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092811; c=relaxed/simple;
	bh=OhKOO3a7qNziHD7P0F5Dg20n2nNULkknlfRh0zp4jms=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=APLjN9oFTcqR9XdaalsHFeAxgK1YcJ0bytYCsXbFG59BvT/VyUs0groUGUhU3hn6dSjJ8rk6q+6j4zXFW3UwwdjuxDMGesYKyFFEcs32ssBQsNwB/X5BOkRoZlor0Vs+v8c9AlkwZYnbh+pnfEXwdV9KT0nboTSqvM1TppR01CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Tq0/BQhC; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Tq0/BQhC"
Received: from github.com (hubbernetes-node-43e8970.ash1-iad.github.net [10.56.224.77])
	by smtp.github.com (Postfix) with ESMTPA id 3831A920832
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764092809;
	bh=0l3I85tQl30q7p2x94VIpDUH0z/UT4L+j0xFB7ThPjc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Tq0/BQhCfp8OcCcNUU/YSEaMX5HjjLDvpQeXrbZhLjThHATyN+v2fWOLqdjFn5jhd
	 cGsUJvwj+9NXnEDnPURxNwpevvWoq+TjNAj56xE/PSFB0FEtl0Hrw4HY1gLI8exPyU
	 Cj4Q2zn9mkMT92/SD3gMdtZzWu2j384M+0i7TkNU=
Date: Tue, 25 Nov 2025 09:46:49 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1027465/000000-df185f@github.com>
Subject: [bluez/bluez] df185f: transport: fix VCP volume updating and sink
 volumes
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

  Branch: refs/heads/1027465
  Home:   https://github.com/bluez/bluez
  Commit: df185f130d75edce1dc58cee6ab1838bc369eec8
      https://github.com/bluez/bluez/commit/df185f130d75edce1dc58cee6ab1838bc369eec8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-25 (Tue, 25 Nov 2025)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: fix VCP volume updating and sink volumes

Signaling VCP volume value update was broken in
media_transport_update_device_volume() due to inverted strcasecmp(), it
also has to be done for all transports since they show the volume.

VCP output volume was incorrectly shown on input transports.  Don't
expose Volume for BAP input transports, since AICS is only partly
implemented.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
