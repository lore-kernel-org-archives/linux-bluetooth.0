Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A1712A16D
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209921; cv=none; b=qFXIC/IWh7CANUcUatb+c9pDvuuCKJH4++pljT2JjlmSBqQE3D/W0CfhynCgDTbn2uOGRWNsfAcVxM6gl1xy0kabkmyGcr3JCS8S5FztfUgisuJh3ZbRvVmdDFA95e7Y7mSGxRqYBttvsd4Grpf8eusEDxW2FhafdbG4slw008o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209921; c=relaxed/simple;
	bh=XU8ECNGGjYlePBiFRSm2wWUVy7DigaKnggY4pYnFQSM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=n/lFmN8ILYyh8kboMxBKiV6Vn44USBAO7R+Y0VkszBRwDdSR55DoHDOp6Vr9Jb7mcCZ653OWyaOHGzWXvqDxzYLwWR1XyCgfSrZUWsvrwt7YeBbC/bWv0M6aeLE9SlLjaIu1ap93KSLFRjYTTzCyPRqqQ8WQGuRTmD0qQbcPPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XIAYlu8g; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XIAYlu8g"
Received: from github.com (hubbernetes-node-f23f10c.ash1-iad.github.net [10.56.145.40])
	by smtp.github.com (Postfix) with ESMTPA id 9962034012C
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 11:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1706209918;
	bh=mUBg2341YaxTk8sKMApD4Wu8TvD0pbzBMs8WeG3uf4M=;
	h=Date:From:To:Subject:From;
	b=XIAYlu8gVgTWSk+/NVQe6d9uyBsoCKftUrGBMZR1RJarEhzJd2zNGxt9EbtN45Fvk
	 pS5Fu1OL56GuVLCRdSe3zzCCbbJKOStZ9knwt30vPVuq74JmtkGzGuxRP9oa5Yn4xM
	 YswJGFQTLQ1u8tjUlg1UnnntmV5rM8EUiL0+e0T4=
Date: Thu, 25 Jan 2024 11:11:58 -0800
From: Emil Velikov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d994c9-1cd6c8@github.com>
Subject: [bluez/bluez] 460dd9: btdev: Fix not clearing le_pa_sync_handle on
 reset
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
  Commit: 460dd92431ea328b88bbdb1169fcb06b755d5c6f
      https://github.com/bluez/bluez/commit/460dd92431ea328b88bbdb1169fcb06b755d5c6f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not clearing le_pa_sync_handle on reset

le_pa_sync_handle needs to be clear on reset otherwise the coce won't
be able to handle Create PA Sync commands.


  Commit: 7a1c6f31ed4f9b6e9f8c5a9fe2fe3089816eb917
      https://github.com/bluez/bluez/commit/7a1c6f31ed4f9b6e9f8c5a9fe2fe3089816eb917
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add btd_device_set_connectable

In case of devices advertising BCAA, aka. Broadcast Source, it shall be
possible to connect to them using something LE Audio Broadcast
procedures so this introduces btd_device_set_connectable so driver can
inform the core when the device is connectable even when it is
advertising using GAP broadcaster role for example.


  Commit: 35858e173aadb5e8e746e8f90503c225325e1b73
      https://github.com/bluez/bluez/commit/35858e173aadb5e8e746e8f90503c225325e1b73
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Mark device as connectable if a broadcast Endpoint is found

If a broadcast Endpoint is found this uses btd_device_set_connectable to
make it as connectable since the Endpoint can be used to setup a
broadcast stream which requires the device object.


  Commit: 215e6c7083da6a495b8755418052bd46344240c5
      https://github.com/bluez/bluez/commit/215e6c7083da6a495b8755418052bd46344240c5
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: remove unused variable builtin_nodist


  Commit: 14c7f21292b1a5dca3ec3f1745be5badf815c043
      https://github.com/bluez/bluez/commit/14c7f21292b1a5dca3ec3f1745be5badf815c043
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M Makefile.am
    M Makefile.mesh
    M Makefile.tools

  Log Message:
  -----------
  build: remove .service files from DEPENDENCIES lists

The DEPENDENCES lists are for binary objects, while the service files
are required by systemd (et al) after the install stage. The services
files are referenced by _DATA, so the service.in -> service conversion
can happen then.


  Commit: 808d008aace3ea419afce4665ba72aac217931f8
      https://github.com/bluez/bluez/commit/808d008aace3ea419afce4665ba72aac217931f8
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M Makefile.am
    M Makefile.mesh
    M Makefile.tools

  Log Message:
  -----------
  build: remove explicit DEPENDENCIES handling

We currently duplicate the DEPENDENCIES handling that autotools does for
us. We have two types of objects - libraries or generated headers.

Former are part of the LDADD, the latter in BUILT_SOURCES.


  Commit: 116524c01de45989d3e17b3a8b29226458a57d1e
      https://github.com/bluez/bluez/commit/116524c01de45989d3e17b3a8b29226458a57d1e
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M Makefile.am
    M Makefile.mesh
    M Makefile.obexd
    M Makefile.tools
    M configure.ac
    M mesh/bluetooth-mesh.service.in
    M obexd/src/obex.service.in
    M src/bluetooth.service.in
    M tools/bluetooth-logger.service.in

  Log Message:
  -----------
  build: manage .service.in files via configure.ac

Considering we do basic substitution, we don't need to manually sed,
track dependencies, dist nor clean. Just add the files to
AC_CONFIG_FILES() call it a day - it does everything for us.


  Commit: 10d6d908b5fe29e4da487b9bd51bbf04653e9684
      https://github.com/bluez/bluez/commit/10d6d908b5fe29e4da487b9bd51bbf04653e9684
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M acinclude.m4

  Log Message:
  -----------
  build: enable gc/dead code removal

Currently, there's plenty of unused code in most binaries. Enable
-fdata/function-sections, which allows the linker garbage collection to
do its job.

On a maintainer build, this reduces the (unstriped) binaries from 117 to
114MiB.


  Commit: 1cd6c874c2712f0a51058f6a5fc132f01a6f4255
      https://github.com/bluez/bluez/commit/1cd6c874c2712f0a51058f6a5fc132f01a6f4255
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M Makefile.obexd

  Log Message:
  -----------
  build: install dbus-org.bluez.obex.service symlink

obex.service has an alias(dbus-org.bluez.obex.service) which is created
as it's enabled. At the same time, the dbus service references the alias
itself.

Thus the dbus socket activation can happen, only when the service is
already enabled/running... Which defeats the whole purpose.

Create/install the respective symlink/alias, so that any user looking
for the dbus will start it.

Note: we need a hook here instead of LN_S to create the in-tree file,
since `install' aggressively dereferences it.


Compare: https://github.com/bluez/bluez/compare/d994c9d45dad...1cd6c874c271
