Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E352140E34
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964959; cv=none; b=sGy7cIFevXxat6zUe9x4Btz6F36zYksQpLFrY+uXyO+o/Arjy5iGFg+f2Fh6lW/ZpjJgsFlrcadT6sSc16AVm9n5fRfJKgU1vigvOVcWsOMMlb3XtUS+8U28JEk3BXcdS+RdfFrl9Aoil1tWXiudJxuLMdCS/ovSovSeB1kCLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964959; c=relaxed/simple;
	bh=GLN+a29bKNXtb470UQwEkWjwAyf/YeJ1etVOOcf5NV8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nPz3R8ufCzBrmerjgiPVSQXNAjlMXBui5Y+zeE1J8oCXYjbT+ExBZB7YwXIsdbDLmsW5286ygXKbDhvTRZ/C8yK3+5v2fbVr2bskIFbjlAPUu+sXEJIUbAqVSgz1xW2mm/S1nVQ4iAgtA8ojtS9bFNgLq3/IM6hlpS1S2BjD4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NNiM0sJq; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NNiM0sJq"
Received: from github.com (hubbernetes-node-487d45e.ac4-iad.github.net [10.52.141.22])
	by smtp.github.com (Postfix) with ESMTPA id 563EA211F7
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748964957;
	bh=xxPTkD+KVstrIyO+nvvDxkSdy2KHHBa2mViTW0VFSso=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NNiM0sJq2Hkki3HiTv5oTd4xDg5smd90+voZ8GjuWAUDPUp0Rm69A/F7yE4zSvQB5
	 oMfxtJ3huEjADh3OoUxC5mH+yxUxdDx3fQCtmecZnWd35S/00M5KsswPX3X3uqLd7/
	 qIIKdq7sGsSOBWAEAU9qgoKC/MZ4HFNf/DBD6QuM=
Date: Tue, 03 Jun 2025 08:35:57 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968319/000000-022aba@github.com>
Subject: [bluez/bluez] de6ced: obexd: Pass at_(un)register value to logind
 callbacks
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

  Branch: refs/heads/968319
  Home:   https://github.com/bluez/bluez
  Commit: de6ced6bf6fe97b23cc2bb72f67cc5b9cfdc43b8
      https://github.com/bluez/bluez/commit/de6ced6bf6fe97b23cc2bb72f67cc=
5b9cfdc43b8
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M obexd/client/pbap.c
    M obexd/plugins/bluetooth.c
    M obexd/src/logind.c
    M obexd/src/logind.h

  Log Message:
  -----------
  obexd: Pass at_(un)register value to logind callbacks

Logind (un)registers callbacks that it calls when the user's state change=
s.
Callbacks may also be called during (un)registration.
Clients may need to handle those initial/final calls specially.

Pass an argument indicating whether this is being called during
(un)registration, and modify existing callbacks to ignore that argument.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: cfd2117ffd837f4a010569573a39c4c778c6e4f0
      https://github.com/bluez/bluez/commit/cfd2117ffd837f4a010569573a39c=
4c778c6e4f0
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  pbap: use the public DBus connection

PBAP must not use its own private DBus connection, as it needs to
receive messages sent to the bus name of the public connection.

PBAP must not unregister itself when the program is exiting, as it might
cause a long delay.  Unregistering at exit is redundant anyway, as the
service will be implicitly unregistered when the connection is closed.

But PBAP must unregister itself when the user becomes inactive mid-sessio=
n,
so systems with multiple users logged in at once can share bluetooth.

Use the public DBus connection instead of a private one,
and explicitly unregister the profile if appropriate.

Thanks Pauli Virtanen for pointing out the exit issue:
https://lore.kernel.org/linux-bluetooth/ae15a9fa4bf0bd509dd3d44f1f364e241=
e50956c.camel@iki.fi/

Reported-by: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
Closes: https://lore.kernel.org/linux-bluetooth/333ad76e-0aba-4f93-b141-8=
e69fb47535f@collabora.com/
Suggested-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: 022aba4af5ce76618fa3612352c0d9ac0b60e353
      https://github.com/bluez/bluez/commit/022aba4af5ce76618fa3612352c0d=
9ac0b60e353
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M obexd/src/main.c
    M obexd/src/obexd.h

  Log Message:
  -----------
  Revert "obexd: Support creating private system/session bus connections"=


This reverts commit 237d818ef294e22be87fba69b3cdd79c75c201e7,
which encouraged the use of private DBus connections.
Doing so caused a bug, so it's better to remove the temptation for now
and re-add it if a legitimate use case is ever found.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>


Compare: https://github.com/bluez/bluez/compare/de6ced6bf6fe%5E...022aba4=
af5ce

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
