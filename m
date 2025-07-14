Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7023D29D
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508264; cv=none; b=pHJyI7cASZshwO5O83AHE64RH6XNptIQd8CnqvXJelJHfDXRmWURvm0YjbGNGKo3+uTTVRi7GXnSyR+U87U8LfKUDIGxjQouo3PFZF83gJ3FVIj73uDU8WERSesQcyQ0iOFM+7nJtHsyK6AG4HslsWEUwerCCJoDdMjaVbbtQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508264; c=relaxed/simple;
	bh=kaa9YLKyC1HwlKseN1hlcX5uDYI/r5lLw6gS80ZtWZg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IcE+xcWgRZro0F4v+dW2FoG8U6S+WoGG+PVFoNNKtWGsheaPRLGzZjpcNI6a5KnfAVdXt8QA7BR916FlWHKt9NhUJ3tU+HXcWwn0leyAQiBPR9tcxpI/ekctVWHJffZUfnRwJz3HVZCSwOOYtRPGZeObfQdYWTmHvbm5mRR1iIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RXZVpJh4; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RXZVpJh4"
Received: from github.com (hubbernetes-node-0f8d89c.va3-iad.github.net [10.48.201.23])
	by smtp.github.com (Postfix) with ESMTPA id 5A39A8C08ED
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752508262;
	bh=VYCxdUORMsO039cXm0Y9wYzFG+V7WPZz1hYQFD8TiyY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RXZVpJh42Wd66kEMT7m852Y0RZOYSWmZ4JOPjRqZ0uTkRO+pvLdaHw1f7vQDf7vBI
	 Ip+2wuF+PEOArVam/kku8BnpDyvnimfDNRYKKTirYAsPDL6ehhXhn+1S4n0V0YwvUO
	 i6YDADNmGv9xdxcy9Gr4f+omzIXGE0r0xGd8xYMA=
Date: Mon, 14 Jul 2025 08:51:02 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982133/000000-2ef05e@github.com>
Subject: [bluez/bluez] 2ef05e: monitor: Add sequence number and SDU length to
 ISO...
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

  Branch: refs/heads/982133
  Home:   https://github.com/bluez/bluez
  Commit: 2ef05e5521731cf6ac6168c06848f46f4afd19e3
      https://github.com/bluez/bluez/commit/2ef05e5521731cf6ac6168c06848f46f4afd19e3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M lib/hci.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add sequence number and SDU length to ISO packets

This prints sequence number and SDU length of ISO packets:

> ISO Data RX: Handle 2304 SN 48 flags 0x02 dlen 64 slen 60



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
