Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDC2405E7
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765478986; cv=none; b=gmz8/21SM+TZzWxUpwO52EShd/uS6UL58Y+BTh619v9iEEqjMIPLFHrsDxR8ZnCXmriVY2ULgtEXnOJsgxdkgY98zddAG70TtvRTKlYPEgOh+Z/2owC05a8A8vKDHJZwWzF/8rmVjJmJjXnU7ii/8SYXlcy4A5w1w2ZleLOBD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765478986; c=relaxed/simple;
	bh=Aq1AP8Q7Qk+EixbCwuRYnotsbL90jghx9HxBtXgdbzw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rFy6EdHxu9eFKK6Ei0XjBvVgI2ybPHk50IZIDjd+gFuomReiZFVYw1PjY+SphSACIm66uRw0FwxWSjYPHeI4X8eINPW0C79kAWIzwGcj4lUMqyp7/+lqT+I6pKC076OfVWSgGmhu/1XJ35OuUKGhJP2JGd5glgLNA+npZESvwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Zu3cSnX/; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Zu3cSnX/"
Received: from github.com (hubbernetes-node-92ac431.ac4-iad.github.net [10.52.173.51])
	by smtp.github.com (Postfix) with ESMTPA id 61190640B2C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 10:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765478984;
	bh=T3yP3yRKHP6l1ad5I1uFOUC65VdxOGs4d+P5PsR7AVE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Zu3cSnX/Jp5QdBQAODH0L4ivP53jarnqd315PTVMCmq4wX1BOY48dl2anUTMgs7qB
	 WpMC1fC+qAOXSYR+cIly9WS7RO1Xewlu3JNjZFagQlgxiNhvrkbFJLUfWs2vhCEIKq
	 TwVYPTAtbnOe/6HX9TQHDg4H6RRSH45ecFx+REDU=
Date: Thu, 11 Dec 2025 10:49:44 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032412/000000-f212f4@github.com>
Subject: [bluez/bluez] 804bf0: doc: Add new telephony related profiles
 interfaces
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

  Branch: refs/heads/1032412
  Home:   https://github.com/bluez/bluez
  Commit: 804bf0af085cc4fe6d7000c84bc977ebf8b1d14e
      https://github.com/bluez/bluez/commit/804bf0af085cc4fe6d7000c84bc97=
7ebf8b1d14e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Call.rst
    A doc/org.bluez.Telephony.rst

  Log Message:
  -----------
  doc: Add new telephony related profiles interfaces

These are interfaces are meant to be generic to the telephony related
"headset" profiles like HSP HS, HFP HF, and CCP.


  Commit: 578e40558cca624174756d478b7a0f8f3db517af
      https://github.com/bluez/bluez/commit/578e40558cca624174756d478b7a0=
f8f3db517af
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    A profiles/audio/telephony.c
    A profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Add shared interfaces implementation

This implements the Telephony and Call DBus interfaces which will be
shared by telephony related "headset" profiles.


  Commit: d467194ff30e22ba83514008cea837c6a8719fb5
      https://github.com/bluez/bluez/commit/d467194ff30e22ba83514008cea83=
7c6a8719fb5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add skeleton for HFP profile

This starts the Telephony interface for HFP HF, allowing to connect to
the remote HFP AG device.


  Commit: 9fc417f1a3fcbb1765f08c0ed8ea2546e5881234
      https://github.com/bluez/bluez/commit/9fc417f1a3fcbb1765f08c0ed8ea2=
546e5881234
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP SLC connection and event support

This implements the HFP HF SLC connection and events support for the
Telephony DBus interface.


  Commit: f212f42553cc9b4b69b4d15fbbaf5ff2d9858b36
      https://github.com/bluez/bluez/commit/f212f42553cc9b4b69b4d15fbbaf5=
ff2d9858b36
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-12-11 (Thu, 11 Dec 2025)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-telephony.rst
    M client/main.c
    A client/telephony.c
    A client/telephony.h

  Log Message:
  -----------
  client/telephony: Add new submenu

This add a new submenu to bluetoothctl to be able to manage telephony
related "headset" profiles.
It currently allows to control calls from an HFP phone, i.e. starts a
call, hangup a call, accepting or rejecting an incoming call.

Audio part is not yet supported.


Compare: https://github.com/bluez/bluez/compare/804bf0af085c%5E...f212f42=
553cc

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
