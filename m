Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB51B7F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324863; cv=none; b=isBx4nODBB4Wgnyy6fr8Nla77VQH5OMU61LfderfQypORscspeYlALYoasIrYh8mOJYbCQTIFW5DBMZcIjGd9OCdnBLO5j1iBrk0wX75/+Qo+9Z1JndmSSE7Xp8sXBPmlnzcXz6n5xeFeGJt3ZF1xItmUA77VuuMLSFmXu3iKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324863; c=relaxed/simple;
	bh=Gwy20SwvM7M2yvdO7nvNZA0eEy3abGgNRwRmLjMsKJI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JVFbktfJNHY53OjKMHhP2EZ1BfvO/MhtqpOScobRxks59Hz/0gaInEr8YuGM+h1qSPU5zBxjcGRlNkzSJye9Yg1Eez7Y6XOzNqh3nDFgBcD8eJQRr2dOTATvoUMNqJy8I9rhHyan2UZ09Cl/TEB6hPAc/iAkqAN7KVq6fLlb4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=eAHXckLc; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="eAHXckLc"
Received: from github.com (hubbernetes-node-6557e6c.ac4-iad.github.net [10.52.136.14])
	by smtp.github.com (Postfix) with ESMTPA id E881E5E11A5
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1719324860;
	bh=0UN6iBoLthbDBXBIatdCuK+PIRejDl0ZIzvdDX6FyvQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=eAHXckLcHzBfz5Ce/JVvhgszloFxICwpMh8DM6/khtLr56fE9pUMYzK9ZKnkQguv8
	 5+1E3cTA/FDKeFPu/7FGF/1ozTcJ0M9Xd/whx5GJYxMtfGlu/q8kq9rXylwyUR7VOH
	 aKel2PJYKBC/WbzwEKD4k6HRTRevYyibWr0bpl0k=
Date: Tue, 25 Jun 2024 07:14:20 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5ebaea-944909@github.com>
Subject: [bluez/bluez] e45362: shared/util: Fix null pointer dereference in
 util_...
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
  Commit: e453627223db0d6488d2bdb2847dfc0865047730
      https://github.com/bluez/bluez/commit/e453627223db0d6488d2bdb2847dfc0865047730
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2024-06-25 (Tue, 25 Jun 2024)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Fix null pointer dereference in util_ltv_foreach()

In the existing code, iov.iov_base is initialized with (void *) data,
assuming data is always valid. However, if "data" happens to be NULL,
dereferencing iov.iov_base in util_iov_pull_u8(&iov, &l) leading to
segmentation fault.

To address this issue added explicit checks for data at the beginning of
the function to ensure its not NULL before proceeding with any operations

The following log was captured while running Broadcast Sink setup:

==79178==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000
(pc 0x5631fc6550b1 bp 0x7ffedd247450 sp 0x7ffedd2473a0 T0)
==79178==The signal is caused by a READ memory access.
==79178==Hint: address points to the zero page.
    #0 0x5631fc6550b1 in get_u8 src/shared/util.h:206
    #1 0x5631fc6550b1 in util_iov_pull_u8 src/shared/util.c:680
    #2 0x5631fc6552f7 in util_ltv_foreach src/shared/util.c:194
    #3 0x5631fc4b57eb in parse_base profiles/audio/bap.c:1189
    #4 0x5631fc4b57eb in iso_pa_sync_confirm_cb profiles/audio/bap.c:1253
    #5 0x5631fc4d5990 in server_cb btio/btio.c:265
    #6 0x5631fc4d5990 in server_cb btio/btio.c:242
    #7 0x71d33511bc43 in g_main_context_dispatch
    (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
    #8 0x71d3351712b7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xab2b7)
    #9 0x71d33511b2b2 in g_main_loop_run
    (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
    #10 0x5631fc738ea8 in mainloop_run src/shared/mainloop-glib.c:66
    #11 0x5631fc7397b6 in mainloop_run_with_signal
    src/shared/mainloop-notify.c:189
    #12 0x5631fc355c3a in main src/main.c:1467
    #13 0x71d334429d8f in __libc_start_call_main
    ../sysdeps/nptl/libc_start_call_main.h:58
    #14 0x71d334429e3f in __libc_start_main_impl ../csu/libc-start.c:392


  Commit: 13da9252995465a904d1be944b8647c69ab98a94
      https://github.com/bluez/bluez/commit/13da9252995465a904d1be944b8647c69ab98a94
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-25 (Tue, 25 Jun 2024)

  Changed paths:
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Rename LC3_BASE

This renames LC3_BASE to LC3_TYPE_BASE, so the meaning
of the define is more clear.


  Commit: 98013b74e5b12b30dd5fa86c1f78c8234d7eeac5
      https://github.com/bluez/bluez/commit/98013b74e5b12b30dd5fa86c1f78c8234d7eeac5
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-25 (Tue, 25 Jun 2024)

  Changed paths:
    M src/shared/lc3.h
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Move BASE defines to lc3.h

This moves the BASE related defines introduced in
test-bap to lc3.h.


  Commit: 409251a95b6f452f000421c129c7b1b5b87478a6
      https://github.com/bluez/bluez/commit/409251a95b6f452f000421c129c7b1b5b87478a6
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-25 (Tue, 25 Jun 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add support to config multiple bsrc streams

This adds support to configure multiple bsrc streams.


  Commit: 4571cdba13a3b915be6e87858a4138a6bd701771
      https://github.com/bluez/bluez/commit/4571cdba13a3b915be6e87858a4138a6bd701771
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-25 (Tue, 25 Jun 2024)

  Changed paths:
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Add defines for BASE with multiple BISes

This adds defines for BASE configurations with multiple BISes.


  Commit: 944909f2b2c850c270fa72b876d61657329a81f4
      https://github.com/bluez/bluez/commit/944909f2b2c850c270fa72b876d61657329a81f4
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-25 (Tue, 25 Jun 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Source STR MBIS tests

4.14.3 Broadcast Audio Stream with Multiple BISes - Source

     Test Purpose:
     Verify that a Broadcast Source IUT can stream multiple
     BISes to a Broadcast Sink.

     Test Case Configuration:
     BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]
     BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]
     BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1]
     BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2]
     BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1]
     BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2]
     BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1]
     BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2]
     BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1]
     BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2]
     BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1]
     BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2]
     BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3]
     BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4]
     BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5]
     BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6]
     BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]

     Pass verdict:
     If the Codec ID is LC3, the IUT sends encoded LC3 audio
     data in BIS Data PDUs on each synchronized BIS.

     If the Codec ID is a vendor-specific Codec ID, the IUT
     sends BIS Data PDUs on each synchronized BIS. The parameters
     included in the Codec_Specific_Configuration data are as
     defined in TSPX_VS_Codec_Specific_Configuration.

     If the Codec ID is LC3, each parameter included in
     Codec_Specific_Configuration data is formatted in an LTV
     structure with the length, type, and value specified in
     Table 4.83.

Test Summary
------------
BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1] Passed
BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2] Passed
BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1] Passed
BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2] Passed
BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1] Passed
BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2] Passed
BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1] Passed
BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2] Passed
BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1] Passed
BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2] Passed
BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1] Passed
BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2] Passed
BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3] Passed
BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4] Passed
BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5] Passed
BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6] Passed
BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]      Passed


Compare: https://github.com/bluez/bluez/compare/5ebaeab4164f...944909f2b2c8

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
