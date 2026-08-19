Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C23368A5
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179770; cv=none; b=nAEiqNJYRqAyY3YnVytoxdTMp9iPT+VjGGDrej4ReFg3XL4etFnntpSLVyhO4u0bVZJDvoWLNL+OyycMfcJvPGZEkms9cvMGV55UlHzOt+L9N6fHsjFNNkngZ8RrI8zmJfNQbLR+fIegJqJv8HnNm4GcCSTMu0ToWFGfaXtIzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179770; c=relaxed/simple;
	bh=IRhQHXYA5ipL9mjB2J5Hess54XMVqXTuLuOu1TY80tU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FpGKELP7NHX3ltPGNv9aRN8PhRinM5qi2yEbTDm3IxePG3U6s2MeroBNRDxmcNUZK+Fns3DcmdxHuWI4iraNSUjlKrt3BNLNHIJmbnv3CZyJzn+pDfJ0+SrknJMmJE6llskk5pncxDSHloo+CaNIzxqV6WNyEMmMgV+KpWUJ2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RTxluJ6Y; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RTxluJ6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787179767;
	bh=JRggW/tCakSOGwEJ4OIyFOXX8eDykQJE8Zq/fUwK74c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RTxluJ6Y9XLByJsbxcG5La424l+GVjW4vq/SNJf2c0QRRRhpR/2EqcGAhpYPWOHK2
	 Iw9y6azKfEZlix9VY81nx4KGoziWju1oswbQ/x0e0O7Z3/8ZO1KHPgDYZuFvW3QX8z
	 20bjHdHjtcQVPXfz6L8uKQO1goSbONuvWA5xUFZc=
Received: from github.com (hubbernetes-node-7db4f4f.ac4-iad.github.net [10.52.142.16])
	by smtp.github.com (Postfix) with ESMTPA id D3358941224
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:49:27 -0700 (PDT)
Date: Wed, 19 Aug 2026 15:49:27 -0700
From: Matthias Kurz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148725/000000-1b0576@github.com>
Subject: [bluez/bluez] 89bad6: battery: Add component battery objects
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

  Branch: refs/heads/1148725
  Home:   https://github.com/bluez/bluez
  Commit: 89bad6ff34483e62d69c8cadba6168614183e16b
      https://github.com/bluez/bluez/commit/89bad6ff34483e62d69c8cadba6168614183e16b
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M src/battery.c
    M src/battery.h

  Log Message:
  -----------
  battery: Add component battery objects

Allow one Bluetooth device to export multiple Battery1 objects while
keeping the legacy aggregate object at the device path.

Component objects expose their parent Device1 path, a stable identifier,
an optional percentage, and an optional charging state. Extend
BatteryProvider1 handling with the same semantics so external providers can
publish multiple batteries too.

Keep component objects and their new properties behind the experimental
D-Bus flag while the API is being established.

Assisted-by: Codex:gpt-5.6-sol


  Commit: 40c6627b67601ede87e22984f244650d41b04833
      https://github.com/bluez/bluez/commit/40c6627b67601ede87e22984f244650d41b04833
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M doc/org.bluez.Battery.rst
    M doc/org.bluez.BatteryProvider.rst

  Log Message:
  -----------
  doc: Document component battery objects

Describe the experimental component Battery1 properties, their opaque
object paths, and how BatteryProvider1 implementations publish several
batteries for one device.

Assisted-by: Codex:gpt-5.6-sol


  Commit: 9cee02acee2a6ba3ec9d0e0c1d7f4b336065fd14
      https://github.com/bluez/bluez/commit/9cee02acee2a6ba3ec9d0e0c1d7f4b336065fd14
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    M Makefile.plugins
    A profiles/fastpair/fastpair.c
    A profiles/fastpair/message-stream.c
    A profiles/fastpair/message-stream.h
    A unit/test-fastpair.c

  Log Message:
  -----------
  fastpair: Add Message Stream battery profile

Connect to the experimental Fast Pair Message Stream service advertised by
compatible BR/EDR devices and parse its 16-bit-length framed messages.

Publish left, right, and case values as component Battery1 objects.
Include unknown percentage and charging-state transitions. Decode unknown
levels using the generic Battery Notification status bit while treating
the TWS-specific case value 0xff as unavailable.

If only the Message Stream is lost, invalidate its values and reconnect.
Use exponential backoff and reset it only after a battery-producing stream
remains stable. Remove the objects once the BR/EDR bearer disappears.

Keep pending connection callbacks alive through cancellation and ignore
callbacks for detached or superseded channels.

Assisted-by: Codex:gpt-5.6-sol


  Commit: 1b0576a01208bd36fb240d04edde6f481c7ce1ce
      https://github.com/bluez/bluez/commit/1b0576a01208bd36fb240d04edde6f481c7ce1ce
  Author: Matthias Kurz <m.kurz@irregular.at>
  Date:   2026-08-19 (Wed, 19 Aug 2026)

  Changed paths:
    M Makefile.tools
    A test/test-fastpair

  Log Message:
  -----------
  test: Add Fast Pair Message Stream tool

Add a standalone profile client that prints Fast Pair Message Stream frames
and can optionally publish left, right, and case values through
BatteryProvider1.

Publish dynamic component lifecycle signals, scope providers per adapter,
and invalidate measurements when a stream closes. Warn users to disable the
built-in Fast Pair plugin when using the external profile.

Assisted-by: Codex:gpt-5.6-sol


Compare: https://github.com/bluez/bluez/compare/89bad6ff3448%5E...1b0576a01208

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
