Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B5296162
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013162; cv=none; b=dGaUWh29z8nYItNPi0rRowkj8PwLE0J2oQGkGaUTX9J6jdWgJ4dHmPEdRLt35AW/gkjsQtWCeoxJcyTyn4E3JAocyvA2+o7DSSDRaK8NJNqcUeIPm8rkPVLHyL9d+cVsYrmYs9bVoBqO7bzsOAqlKeY6ivOkcom+L4MZJZLlh/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013162; c=relaxed/simple;
	bh=eiDm3JELduG1YGs/Bw2+Bma+nOuoSz9lGtIUV0autqA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YtoLN0GadBiVddHuIHBNv5Ae8oHY3WbFY9P/2NK1VCL1F1Kc87Zjd3oO5+8bU5V5QQhsM0aArB3Oml7Gn9yDHQss2h13wEnXrflmkZy/3hlefDefiDDKcAGAahKmPe9suas9MvaG3+cMP/LEWqm4SxTQ/DR22x8yPhfFDrf5CLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mwmcRO0a; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mwmcRO0a"
Received: from github.com (hubbernetes-node-82fd503.va3-iad.github.net [10.48.142.37])
	by smtp.github.com (Postfix) with ESMTPA id 3B18E8C050C
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748013160;
	bh=R7nqug1bqXTVGyt0cxqnoozaQrj7CpGMzRC/9PE5cTo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mwmcRO0aoo2+g+ZqIAAheTyw5WWR8f/1C4BZHO2WzvQZZUgrSeONAAYTToa9YypxK
	 uNX5nXGe3eZafXvsnuGgbZaVQYEzDP6RthMVrK79HRcFeqAaGGkRBPuQytXowbGY1Y
	 awYX6F7a+25hOHdEik/rD+8tayuveeegW5JmurSY=
Date: Fri, 23 May 2025 08:12:40 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0402c0-1fe5a8@github.com>
Subject: [bluez/bluez] 593f8b: lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE
 define
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
  Commit: 593f8b06fff2d5e0edf5243ca639f1109c3a4cf4
      https://github.com/bluez/bluez/commit/593f8b06fff2d5e0edf5243ca639f=
1109c3a4cf4
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M lib/mgmt.h

  Log Message:
  -----------
  lib/mgmt: Add MGMT_DEV_DISCONN_AUTH_FAILURE define


  Commit: 8b08f903948c878a4327c15718d7b3d17e18d722
      https://github.com/bluez/bluez/commit/8b08f903948c878a4327c15718d7b=
3d17e18d722
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  org.bluez.Device: Add Disconnected signal

This adds Disconnected signal which can be used by clients to discover
the reason of a disconnection.


  Commit: 53db78000e3e8d9a961363ee2a1aac65e16a7446
      https://github.com/bluez/bluez/commit/53db78000e3e8d9a961363ee2a1aa=
c65e16a7446
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  src/device: Add Disconnected signal to propagate disconnection reason

Currently a client application is informed of the disconnection by the
update of the Connected property to false.
This sends a Disconnected signal with the disconnection reason before
the property is updated.

This helps client application to know the reason for the disconnection
and to take appropriate action.


  Commit: 1fe5a858bd974684f4a9ff59f9e4669c67490fed
      https://github.com/bluez/bluez/commit/1fe5a858bd974684f4a9ff59f9e46=
69c67490fed
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display disconnection reason

The new org.bluez.Device1.Disconnected signal propagates the
disconnection reason.


Compare: https://github.com/bluez/bluez/compare/0402c0674644...1fe5a858bd=
97

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
