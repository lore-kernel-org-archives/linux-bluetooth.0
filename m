Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC78316F83A
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329596; cv=none; b=j5V/gtV+oo56q+I14WR3lT6Goc4RxZy0slq6Umal8FKgCntaC3jn0bV58mYbMZPAYrX4eXWufaziN/3VCByzW8mKVYLLLYoE1O6dv6tsjVBR8zwWgmWRnJh+b0m9DEt7Kxri6n99FXffnAJvjBqNpVDvVPQ1Hsp3JiTfjtH9mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329596; c=relaxed/simple;
	bh=2NbZ10YDD4pNq0CPdtA9QHDKgZlBaAUuaLHTDFDDSuU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TXC++f5DL56zfVh/itHktI1sJd+j5ZG8ECsOvhfmHk+5KO9GLO1XU2eQuO4HoNQ24Luy+M2ug7WJUZC5nQX2wkA42N9K7wE8RK1S3tLzstd48wtpU0NT/W4nXHSCMQ+I03CMcFiapo0VMDwhFI5aLd0U+1q+r+AivPq2iecYTgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dkCPBXFi; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dkCPBXFi"
Received: from github.com (hubbernetes-node-91932c9.ac4-iad.github.net [10.52.134.20])
	by smtp.github.com (Postfix) with ESMTPA id E2BF17010E9
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712329593;
	bh=N+ljMcF0OAZTQTUlFDvDm5Q7aY0cyM0BwvsBmKi/6Js=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dkCPBXFiyk5Gn5Gnmu6hv9sdj5ipv5Cp7+VTk8qHLSijssHkXDPxxM1uZZWjgg9Yq
	 9FLFJ+diJ5k67jlTtmHvRrF6Ld3uR+JMy5U5zvDsOq36KzrhgRL+P9WTk5gLE3c8YU
	 tha8+i3IcKzlPDwBC6VuzcN3LuHMCX46tYghxFJo=
Date: Fri, 05 Apr 2024 08:06:33 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/031174-98bed1@github.com>
Subject: [bluez/bluez] 98bed1: device: Fix airpods pairing
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 98bed16d254c3f1b2075290c69e74749d08c39b4
      https://github.com/bluez/bluez/commit/98bed16d254c3f1b2075290c69e74=
749d08c39b4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-04-05 (Fri, 05 Apr 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix airpods pairing

Apple Airpods are discoverable and pairable in BREDR mode, but also
advertise in unconnectable mode in LE with the same Public address, at th=
e
same time. As the pairing process uses the latest seen address, sometimes=

it uses the LE Public address to pair, which fails.

This commit introduces the connectable state when selecting the bearer to=

use for a connection. The last_seen value is used only for connectable
devices.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
