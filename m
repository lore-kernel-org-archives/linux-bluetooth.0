Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B02820C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515794; cv=none; b=WoG/HYqyaFMgF5hGCpBBNNqlgYgUWhzUPr92QUU+/mL1URTm1rgnLKJh7a9fPFott1w9d83ft6y2jd94k6kQlwd3xWljNmSP/h1kIdUx8EJJLc9Revm6COXKrwM4XYvCNDWLZVtGtauA2MDlXQLUe8k+QQMOlSG84b2kDt1YTls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515794; c=relaxed/simple;
	bh=S5QwLqK60wW7Nx8bSiEmPddOPQHSARtXTtQMw/OKcXU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sMif+0woX94mUSXhJp8c85Jvmfssqesr9YHLcDzjzseBVuvnPCl7BaTIvjQR6cj9hyobEiVrIWLNp3da/BdrI2Zoi3J33fIx/hgGqVxuNwDW8aZRB1P/3WRryzdOqGR1ZdU44ztv7IExqikrUBpTI9ya01blj85pqlSI20ejdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jx+Jqe/a; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jx+Jqe/a"
Received: from github.com (hubbernetes-node-cf1c5ab.va3-iad.github.net [10.48.206.53])
	by smtp.github.com (Postfix) with ESMTPA id A79A34E12ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745515791;
	bh=0NTQO8capbhgadBqKeUaNFdN9WTlF7vbEGLDx6ctz5k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jx+Jqe/a4rIk3WdBPJOk34vGY+j9RTE7gRRGtX28eq4LMzhtGbMnHNd7InG2RhFQD
	 u6zufi1C77fr3/Ea0NlnrDBARqqcqxjIA1/1vUV5eaYj8aRT+agu5DEpyvZlWY794W
	 nGeFniQ+Y8OdGYtJR08SWnaF5rTlVMjEBn7UY4y4=
Date: Thu, 24 Apr 2025 10:29:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c8bce6-b74d30@github.com>
Subject: [bluez/bluez] 20ea34: src: Add new CablePairing property
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 20ea34e729b230ee4f3c8671bbc8255b65825d6b
      https://github.com/bluez/bluez/commit/20ea34e729b230ee4f3c8671bbc8255b65825d6b
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  src: Add new CablePairing property

This adds initial support for a new CablePairing property.
The property can be used for devices that are paired using a cable and
don't support the expected bonding (with pairing/encryption), for
example like the Sixaxis gamepads.


  Commit: 373146be299fb07de38b841ed1320c0b78d33c12
      https://github.com/bluez/bluez/commit/373146be299fb07de38b841ed1320c0b78d33c12
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print CablePairing property

When using the `info` command, include the new CablePairing value.


  Commit: 56516d6cc8d967b1480fc31a1ac74fe61e04f270
      https://github.com/bluez/bluez/commit/56516d6cc8d967b1480fc31a1ac74fe61e04f270
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: Set CablePairing when pairing a Sixaxis with USB

Sixaxis gamepads don't support encryption. When doing the USB cable
pairing, set the CablePairing property to keep the connection to the
device unencrypted.


  Commit: c5dffe0ce2fea65134d90b30bb27093134c12213
      https://github.com/bluez/bluez/commit/c5dffe0ce2fea65134d90b30bb27093134c12213
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  adapter: Add btd_adapter_has_cable_pairing_devices()

Add a function that can be used to know if any of the known devices have
the `CablePaired` property set.


  Commit: ba101f47dfbad6d4f6fd439570ac4a1093df2ceb
      https://github.com/bluez/bluez/commit/ba101f47dfbad6d4f6fd439570ac4a1093df2ceb
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M profiles/input/device.c
    M profiles/input/manager.c
    M profiles/input/server.c
    M profiles/input/server.h

  Log Message:
  -----------
  input: Automatically use sec level low when using a cable paired device

BT_IO_SEC_LOW is the only way to allow devices that use cable pairing to
establish a connection.

This adds the ability to start the listening input server with
BT_IO_SEC_LOW to avoid breaking support for these devices, and then,
in `hidp_add_connection()`, we check if either `classic_bonded_only` was
disabled or if this device has `CablePairing`. If neither are true, we
bump the security back to BT_IO_SEC_MEDIUM, i.e. enforcing encryption.

This allows supporting these devices without having to change the
classic bonded only option.


  Commit: 08e3277331613bb21c9c5307a98b51bcdd10f56d
      https://github.com/bluez/bluez/commit/08e3277331613bb21c9c5307a98b51bcdd10f56d
  Author: Ludovico de Nittis <ludovico.denittis@collabora.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: Set security level when adding a sixaxis device

When doing the cable pairing for a sixaxis, we may need to change the
listening input server security level.
This is because sixaxis gamepads can only work with the level
BT_IO_SEC_LOW.


  Commit: b74d30fb9f72eafb8d98f9faa4327ce1a66ff4b0
      https://github.com/bluez/bluez/commit/b74d30fb9f72eafb8d98f9faa4327ce1a66ff4b0
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: remove the device of BIS source when modify operation.

When the Client sends a modify operation and PA Sync is
"Do not synchronize to PA", the BIS source information
needs to be cleared.

Fixes: https://github.com/bluez/bluez/issues/1145


Compare: https://github.com/bluez/bluez/compare/c8bce6574327...b74d30fb9f72

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
