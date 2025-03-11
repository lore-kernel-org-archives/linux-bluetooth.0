Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0413DB9F
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709931; cv=none; b=n3sy7oPqty5VuKaNrNGryFKJIaqR2WzXJZ3oWjNlRnp6zAU/eztRLxMfKy+1MTBqMBbqwIAl9pJkF6arOq3+q6Os/sUACPmRKYWYVjocMd5+xOYTvzjZGQAH4CoWKRaxdVprEzc3nLvTeOhk6nd4TwL4fUZL1ftyrx9sU+FKl4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709931; c=relaxed/simple;
	bh=Geb7eNdPhhR24bpZZTBGKM55BBef7jS+JKohgsd5prA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=O43YP8Lky57Bv66xESBg48MDhFDlc/Vq/x5xgeWR7yBbtEL/N6t8B/00EeK3P9ihYSG4Ns2GIeKqwOuRSWJzZRFYRW5oSHS4A/g6SYj9fx1CPSFhMuRJiqrEBTin6bajGmDVTx88vBenep2o5raYT4G0F+FvtmjgEzEj4ID/its=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XHcS+h/A; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XHcS+h/A"
Received: from github.com (hubbernetes-node-44d41b7.va3-iad.github.net [10.48.200.74])
	by smtp.github.com (Postfix) with ESMTPA id 2E471E03F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741709929;
	bh=6JSfKipauhMgTOgXlj6g1KT4PqF5X5b51t7c5CSy9kE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XHcS+h/A0GewL+MmlX8NlIKXW91zhujJdmusr+Kt6W1s+fqw1ugZDNZ6eqmePw7YY
	 TU5ijKX/AvenJXHXJHk8o+l2eFrAsd/TsIpcy/HtRWlXgyAT1TitENVcUMDpf5p7Ui
	 BX9pt2cgLAMo4r/rda4NVxhN3Kbdon/mAsD+121k=
Date: Tue, 11 Mar 2025 09:18:49 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4d3c72-95055d@github.com>
Subject: [bluez/bluez] 8f280a: shared/bap: Make bap_get_session public
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
  Commit: 8f280aadbbae9417a5bf6fabaf190b699336080c
      https://github.com/bluez/bluez/commit/8f280aadbbae9417a5bf6fabaf190b699336080c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Make bap_get_session public

This makes bap_get_session public, so that a reference to the bap session
can be obtained and processed from the BASS plugin, for the Broadcast
Assistant implementation.

In case a session is not found, this commit also adds a NULL check for
the new bap that is created, in case the provided db reference is NULL
and therefore a session fails to be added, to avoid any invalid memory
access.


  Commit: fd622a5bb2e3409f39956edba20afc6fa3cff09e
      https://github.com/bluez/bluez/commit/fd622a5bb2e3409f39956edba20afc6fa3cff09e
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bap.h
    M profiles/audio/bass.c

  Log Message:
  -----------
  bap: Remove bap_get_session

This removes the bap_get_session API from the BAP plugin interface and
replaces the call inside BASS with the shared/bap API.


  Commit: 5204f17cb9d32b05e64081d0940e26b8f5cd05fb
      https://github.com/bluez/bluez/commit/5204f17cb9d32b05e64081d0940e26b8f5cd05fb
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bap.h
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  bap: Move default qos to shared/bap

This moves the default BAP QoS structure to shared/bap, to be accessible
from other plugins without involving the BAP plugin.


  Commit: 6a03579d170e53568c952ba7b977f5f72020efb8
      https://github.com/bluez/bluez/commit/6a03579d170e53568c952ba7b977f5f72020efb8
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add APIs to convert iso_qos to bap_qos

This adds APIs to convert iso_qos to bap_qos and reversed.


  Commit: 8850bad1e027e27eaf4a2e2940173a6cc236d2e9
      https://github.com/bluez/bluez/commit/8850bad1e027e27eaf4a2e2940173a6cc236d2e9
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M Makefile.plugins
    M profiles/audio/bap.c
    R profiles/audio/bap.h
    M profiles/audio/bass.c

  Log Message:
  -----------
  bap: Remove interface

This removes the BAP plugin interface and updates the BAP and
BASS plugins to use shared/bap APIs.


  Commit: debc77530f24d99ef9f906a05af75fc5ebc4657a
      https://github.com/bluez/bluez/commit/debc77530f24d99ef9f906a05af75fc5ebc4657a
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Free stream path

This frees BASS setup paths, to avoid memory leaks like below:

==5877==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 43 byte(s) in 1 object(s) allocated from:
    0x7ab1adefd9c7 in malloc ../../../../src/libsanitizer/asan/
                                        asan_malloc_linux.cpp:69
    0x7ab1ad08f937 in __vasprintf_internal libio/vasprintf.c:116
    0x7ab1ad135d62 in ___asprintf_chk debug/asprintf_chk.c:34
    0x5c2197401338 in asprintf /usr/include/x86_64-linux-gnu/bits/
                                                      stdio2.h:137
    0x5c2197401338 in setup_configure_stream profiles/audio/bass.c:420


  Commit: 86d6b74ff002fa84973188565ebfd2780d828a8f
      https://github.com/bluez/bluez/commit/86d6b74ff002fa84973188565ebfd2780d828a8f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Add support for Sync Flow Control

This adds support for Sync Flow Control by supporting command
Write Sync Flow Control Enable:

< HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
        Flow control: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4
        Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
        Status: Success (0x00)

To act according to the spec this enabled SCO data packets to be
properly processed and generate Number of Completed Packets event:

sco-tester[40]: < SCO Data TX:.. flags 0x00 dlen 9
> HCI Event: Number of Completed P.. (0x13) plen 5
	Num handles: 1
        Handle: 42 Address: 00:AA:01:01:00:00 (Intel Corporation)


  Commit: b7ef134eb9789d33c8edb84a3b98008da0cb95c5
      https://github.com/bluez/bluez/commit/b7ef134eb9789d33c8edb84a3b98008da0cb95c5
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: send SCO setup events to bthost

Send required SCO setup events to bthost conns, so data can be passed to
the linked connection.


  Commit: ce1abc32b3fc5ab6352bfcd1e68cf829eae77acf
      https://github.com/bluez/bluez/commit/ce1abc32b3fc5ab6352bfcd1e68cf829eae77acf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M monitor/bt.h

  Log Message:
  -----------
  bthost: add hooks receiving SCO connections and data

Add hooks for new SCO connections and receiving SCO data. SCO
connection accept/reject flow remains unimplemented.


  Commit: 87d4f95dc31208863b93d22fd035f049297a10ca
      https://github.com/bluez/bluez/commit/87d4f95dc31208863b93d22fd035f049297a10ca
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: check sent SCO data is received at bthost

When sending data, also check that the data is received by bthost.


  Commit: 7da93164f483306b5c360cf3edbd2f6e6ae89c24
      https://github.com/bluez/bluez/commit/7da93164f483306b5c360cf3edbd2f6e6ae89c24
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M emulator/btdev.c
    M emulator/btdev.h
    M emulator/hciemu.c
    M emulator/hciemu.h

  Log Message:
  -----------
  btdev: support disabling commands

Add function to return command mask, so that it is possible to disable
some in tests if needed.


  Commit: 95055def8cd29810bcc7a97bcd5ad95c74d314a6
      https://github.com/bluez/bluez/commit/95055def8cd29810bcc7a97bcd5ad95c74d314a6
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-03-11 (Tue, 11 Mar 2025)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add tests for different SCO flow control modes

Change "SCO CVSD Send - Success" to send multiple packets.
Add tests

SCO CVSD Send No Flowctl - Success
SCO CVSD 1.1 Send - Success
SCO CVSD 1.1 Send No Flowctl - Success


Compare: https://github.com/bluez/bluez/compare/4d3c721ee037...95055def8cd2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
