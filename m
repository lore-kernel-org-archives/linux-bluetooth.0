Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F93AB28D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790374141; cv=none; b=mTwmxL7n8QTsIC8f6DlHemeJHO3UzuhTUqkp068QPcVY8R5cyaWg/OiDjl3sfEP9QS2tNmZB9nGduOadiGpU2gk+IubzlUSEqSRruQXinS0dj/FWeAOoj8VCFcz7lXBaDh9bt7UX0taj+dBNsBIUr9CE1r844JUEz1EzYf6opC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790374141; c=relaxed/simple;
	bh=gLSLs6WI9NsRdF4r8rmSo0jsRJR2ZyYpQXSAtXeM748=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LpL0sO8cw/VxYQ9rsH9QcWF6c2heD1/IDsWpVJPCK9I32G286UfPsxXBpD7qWdGCJ70T/M4r3b1Bd7rd9VceVg2/c/ny2KpZgqtlKdcPn6CrryVXAqHr8kLkNfjEajt+wb3CBdUjxdt8V0alpiHZmwTTJBOsk2bwRN/6qmpZveA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cgN/v/Rt; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cgN/v/Rt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790374139;
	bh=PZu+kKr1Rn6Aa9xx4MFBuWXgXGDqppAyTC9S9f2iQnw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cgN/v/RtjwJaSJBU/OVbnOYMTVnwHND6RcZcZSgRQgkLD3eOqdw+dVIGMpzuJA3si
	 RGLtxGBOofTNwiRWdKTcKViXiPNuUzfNLja73XxTUn2WXDJiOFDhPgjOpldpQo4WQZ
	 QrVw36vT1Sp0HlQknLJkLYya7Ui9IEFxBFg8MQRE=
Received: from github.com (hubbernetes-node-403cbf2.va3-iad.github.net [10.48.81.80])
	by smtp.github.com (Postfix) with ESMTPA id A6049780106
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:08:59 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:08:59 -0700
From: Nate Mendes <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1174091/000000-bd3485@github.com>
Subject: [bluez/bluez] bd3485: dbus-common: Use audio-speakers icon for
 speakers
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

  Branch: refs/heads/1174091
  Home:   https://github.com/bluez/bluez
  Commit: bd34853c8eca5a954ac24a52c4d37df2e20661f8
      https://github.com/bluez/bluez/commit/bd34853c8eca5a954ac24a52c4d37df2e20661f8
  Author: Nate Mendes <natemendes13@gmail.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    M src/dbus-common.c

  Log Message:
  -----------
  dbus-common: Use audio-speakers icon for speakers

Devices with the Loudspeaker minor class (0x05) currently fall through
to the generic "audio-card" icon, so a Bluetooth speaker is shown as a
sound card.

While "audio-speakers" is not one of the standard icon names [0], it is
implemented in practice by at least the Adwaita, Breeze, Papirus and
elementary themes. PipeWire already maps this minor class to the
speaker form factor and uses "audio-speakers-bluetooth" for the
resulting sink.

[0] https://specifications.freedesktop.org/icon-naming/latest/

Assisted-by: AI



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
