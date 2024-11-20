Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713FA939
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117136; cv=none; b=oYrcyjlR1Hy64R9iXIXJv30cOqknEPDiZ1caWfLLKiDy7y5gKRcvF/VCajlggHJJ8fw5EBYpF0MbqTGDctk7rnyBL71B3CBA5MF8XjwZtFaRA5jQR34cNIyGmXiqP0WB9bCrtWejlIltkWv3U4K4LqIIBOwg+uy1NkGFKvuQgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117136; c=relaxed/simple;
	bh=efj9CyeXNrljWK+H9qh2v3VGZ/eNQ4VFoPbj1wCh1rw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZLB2s2TaKuY1VH1cNtbOa437IoKkulCXmWOVGhOx0tymFITbXIx6pt6fKQfYfSCFCckqbP9SMe3a56Dg/Ykb5mg3eh8cnMTEL0RszGoJPIvz47fgHbyDLq2YYw/AnuJp9mObxjMTh1gwQ5Ia0hRgUuh8vcWFBvCHXpYhECd1N/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CRsCapZD; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CRsCapZD"
Received: from github.com (hubbernetes-node-31aca59.ac4-iad.github.net [10.52.137.37])
	by smtp.github.com (Postfix) with ESMTPA id 65FE85E0AAE
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1732117134;
	bh=v+suTL/P15kUDhn4NOA88tkojiuqMFGB4UFRb3DWdVA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CRsCapZDY4T18GvorDLogb7xCZGZU+PXdmNzTZRTeSN3dK4IhQLEWtPNqWPTVTS69
	 KSwWRK4LJ9WKM6aPAVfyRfqgpVVWIlS91rrcaoBMXLSaMNnLHDvFpykM7/8LVAdP74
	 3ofSa/jdRsf/yAONMogkS8Gm4XvI2DMMaKRSZ7oU=
Date: Wed, 20 Nov 2024 07:38:54 -0800
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5c6535-e59a91@github.com>
Subject: [bluez/bluez] da5b5b: shared/ad: fix -std=c23 build failure
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
  Commit: da5b5b0ecb1ead38676768ef78d46449d404bdc0
      https://github.com/bluez/bluez/commit/da5b5b0ecb1ead38676768ef78d46449d404bdc0
  Author: Rudi Heitbaum <rudi@heitbaum.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: fix -std=c23 build failure

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `bluez` fails the build as:

    src/shared/ad.c:1090:24: error: incompatible types when returning type '_Bool' but 'const char *' was expected
     1090 |                 return false;
          |                        ^~~~~


  Commit: 4d60826865c760cc4e5718b6414746a394768110
      https://github.com/bluez/bluez/commit/4d60826865c760cc4e5718b6414746a394768110
  Author: Rudi Heitbaum <rudi@heitbaum.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: fix -std=c23 build failure

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `bluez` fails the build as:

    src/shared/shell.c:365:24: error: incompatible types when returning type '_Bool' but 'struct input *' was expected
      365 |                 return false;
          |                        ^~~~~


  Commit: 6f3111eb680df9c13502aacd65554846a9e13a3f
      https://github.com/bluez/bluez/commit/6f3111eb680df9c13502aacd65554846a9e13a3f
  Author: Rudi Heitbaum <rudi@heitbaum.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M src/shared/gatt-helpers.c

  Log Message:
  -----------
  shared/gatt-helpers: fix -std=c23 build failure

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `bluez` fails the build as:

    src/shared/gatt-helpers.c:1136:24: error: incompatible types when returning type '_Bool' but 'struct bt_gatt_request *' was expected
     1136 |                 return false;
          |                        ^~~~~
    src/shared/gatt-helpers.c:1250:24: error: incompatible types when returning type '_Bool' but 'struct bt_gatt_request *' was expected
     1250 |                 return false;
          |                        ^~~~~
    src/shared/gatt-helpers.c:1478:24: error: incompatible types when returning type '_Bool' but 'struct bt_gatt_request *' was expected
     1478 |                 return false;
          |                        ^~~~~


  Commit: a0aee49df1d8aba8fe81bd6077ae9571ea93e5be
      https://github.com/bluez/bluez/commit/a0aee49df1d8aba8fe81bd6077ae9571ea93e5be
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add helper to parse BASE

This adds a shared/bap helper to parse BASE. Any plugin that wishes to
parse a BASE structure can call this helper and provide a callback to
process each BIS.


  Commit: 8054693b0c5b6b201a262b4db7ddd0a4cb239a5c
      https://github.com/bluez/bluez/commit/8054693b0c5b6b201a262b4db7ddd0a4cb239a5c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bap.h

  Log Message:
  -----------
  bap: Add helpers to convert iso_qos to/from bap_qos

This adds public BAP helpers to convert iso_qos to bap_qos and reversed.
This is needed for the BASS plugin to handle the Scan Delegator (BASS
Server) role internally (to create/handle BAP streams when receiving the
Add Source command from a Broadcast Assistant).


  Commit: 66a83fde5c4932d57e0eb084d35ad1374d331e17
      https://github.com/bluez/bluez/commit/66a83fde5c4932d57e0eb084d35ad1374d331e17
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/bass.h

  Log Message:
  -----------
  bap: Rework BASE parsing

This replaces the internal parse_base with bt_bap_parse_base from
shared/bap. A bis callback is added to handle parsed streams.

The Broadcast Assistant implementation in the BASS plugin is also
updated to use bap qos instead of iso qos, since the BISes are
now parsed along with bap qos structure.


  Commit: 3babeefa17b60ff34a4859ab0e7f9b637e307575
      https://github.com/bluez/bluez/commit/3babeefa17b60ff34a4859ab0e7f9b637e307575
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bap.h

  Log Message:
  -----------
  bap: Make default PA sync QoS public

This make the default BAP QoS parameters for PA Create Sync public,
to be available to other plugins that might need to listen for
Broadcasters (like BASS).


  Commit: ac56526b7e392453f6d20e18abecfbb8f88bd1d6
      https://github.com/bluez/bluez/commit/ac56526b7e392453f6d20e18abecfbb8f88bd1d6
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/bass.h

  Log Message:
  -----------
  bass: Rework Scan Delegator to handle BAP streams

This updates the Scan Delegator implementation to be handled internally in
BASS: The BASS Server is responsible to handle Write Commands for the Add
Source operation by creating long-lived PA sync, parsing the BASE,
creating and configuring BAP streams, as well as enabling them.


  Commit: e618932b968fd021a532588bf26612a64cc3d5fa
      https://github.com/bluez/bluez/commit/e618932b968fd021a532588bf26612a64cc3d5fa
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bap.h

  Log Message:
  -----------
  bap: Remove API to probe device from BASS

This removes the BAP API to probe broadcasters from BASS, since BASS is
now directly adding the Broadcast Audio Announcement Service UUID to the
broadcaster device, and it will internally handle the probe.


  Commit: e59a915db9d8e274bc2aa8214a920c8abe72203f
      https://github.com/bluez/bluez/commit/e59a915db9d8e274bc2aa8214a920c8abe72203f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-11-20 (Wed, 20 Nov 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Remove PA idle timer logic

This removes BAP support for long-lived PA sync (added for Scan Delegator
support), since it is now handled inside the BASS plugin. This also
removes the PA idle timer logic, since PA/BIG sync requests are now
ordered inside the kernel.


Compare: https://github.com/bluez/bluez/compare/5c65356cae64...e59a915db9d8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
