Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED38DC3526F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 21:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbiDDV2i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379299AbiDDQ5b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 12:57:31 -0400
Received: from smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC43B3EC
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 09:55:35 -0700 (PDT)
Received: from github.com (hubbernetes-node-3db70e2.va3-iad.github.net [10.48.204.69])
        by smtp.github.com (Postfix) with ESMTPA id 958545C105E
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 09:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1649091334;
        bh=EVWIEjDCoU3BuMMCTTAYmoT+ytChG6mDO0ceio9Od3Q=;
        h=Date:From:To:Subject:From;
        b=KjKL5UThddTCMUzFV5XR7FAZQmzNFRm2u78wht+zA5UPikrJaY7KdBPFoQ3CimbTX
         A51Thu/c2ww9Dpmaw3Y10mzDepqT8R0DLmHYKmPRkPgH//XmQmNJA9bCAxHxNTHOKm
         U/Tc+V26eW1a3zp9WJkovTPcLKFWnN4LHzo9Aa9M=
Date:   Mon, 04 Apr 2022 09:55:34 -0700
From:   BluezTestBot <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/234d60-3627ed@github.com>
Subject: [bluez/bluez] 0f3828: tools: Fix g_dbus_setup_private connection
 check i...
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master=0D
  Home:   https://github.com/bluez/bluez=0D
  Commit: 0f382885d4a304dd781aa212ca1ee7b19fd46918=0D
      https://github.com/bluez/bluez/commit/0f382885d4a304dd781aa212ca1ee=
7b19fd46918=0D
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>=0D
  Date:   2022-04-04 (Mon, 04 Apr 2022)=0D
=0D
  Changed paths:=0D
    M tools/mpris-proxy.c=0D
=0D
  Log Message:=0D
  -----------=0D
  tools: Fix g_dbus_setup_private connection check in mpris-proxy=0D
=0D
=0D
  Commit: 7fdfb67284a2f93b13c008e69ff04f462e45c791=0D
      https://github.com/bluez/bluez/commit/7fdfb67284a2f93b13c008e69ff04=
f462e45c791=0D
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>=0D
  Date:   2022-04-04 (Mon, 04 Apr 2022)=0D
=0D
  Changed paths:=0D
    M monitor/packet.c=0D
=0D
  Log Message:=0D
  -----------=0D
  monitor: Fix out-of-bound read in print_le_states=0D
=0D
Accessing le_states_desc_table array with value 15 can cause=0D
out-of-bound read because current size of array is 14.=0D
=0D
Currently this cannot lead to any problems becase we do no have such=0D
state in le_states_comb_table but this could be changed in future and=0D
raise described problem.=0D
=0D
Found by Linux Verification Center (linuxtesting.org) with the SVACE=0D
static analysis tool.=0D
=0D
=0D
  Commit: d328abaa1715d3d8df05b06a2e09429fcdeebe34=0D
      https://github.com/bluez/bluez/commit/d328abaa1715d3d8df05b06a2e094=
29fcdeebe34=0D
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>=0D
  Date:   2022-04-04 (Mon, 04 Apr 2022)=0D
=0D
  Changed paths:=0D
    M tools/hciattach_tialt.c=0D
=0D
  Log Message:=0D
  -----------=0D
  tools: Fix buffer overflow in hciattach_tialt.c=0D
=0D
Array 'c_brf_chip' of size 8 could be accessed by index > 7. We should=0D=

limit array access like in previous check at line 221.=0D
=0D
Found by Linux Verification Center (linuxtesting.org) with the SVACE=0D
static analysis tool.=0D
=0D
=0D
  Commit: 497a0b220dbdd9b10d0ba797645d327cd6cfb6e5=0D
      https://github.com/bluez/bluez/commit/497a0b220dbdd9b10d0ba797645d3=
27cd6cfb6e5=0D
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>=0D
  Date:   2022-04-04 (Mon, 04 Apr 2022)=0D
=0D
  Changed paths:=0D
    M tools/btsnoop.c=0D
=0D
  Log Message:=0D
  -----------=0D
  tools: Fix signed integer overflow in btsnoop.c=0D
=0D
If malformed packet is proceed with zero 'size' field we will face with=0D=

wrong behaviour of write() call. Value 'toread - 1' gives wrong sign=0D
for value 'written' (-1) in write() call. To prevent this we should=0D
check that 'toread' is not equal to zero.=0D
=0D
Found by Linux Verification Center (linuxtesting.org) with the SVACE=0D
static analysis tool.=0D
=0D
=0D
  Commit: 1e664b9838cd84a921360806de084c749a60304b=0D
      https://github.com/bluez/bluez/commit/1e664b9838cd84a921360806de084=
c749a60304b=0D
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>=0D
  Date:   2022-04-04 (Mon, 04 Apr 2022)=0D
=0D
  Changed paths:=0D
    M tools/btmgmt.c=0D
    M tools/hex2hcd.c=0D
=0D
  Log Message:=0D
  -----------=0D
  tools: Limit width of fields in sscanf=0D
=0D
In tools/btmgmt.c and tools/hex2hcd.c few sscanf does not limit width=0D
of fields. This could lead to static overflow and stack corruption.=0D
=0D
Found by Linux Verification Center (linuxtesting.org) with the SVACE=0D
static analysis tool.=0D
=0D
=0D
  Commit: 4afbef7790ce0b1b30afaade19af17903e05a801=0D
      https://github.com/bluez/bluez/commit/4afbef7790ce0b1b30afaade19af1=
7903e05a801=0D
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>=0D
  Date:   2022-04-04 (Mon, 04 Apr 2022)=0D
=0D
  Changed paths:=0D
    M src/device.c=0D
=0D
  Log Message:=0D
  -----------=0D
  device: Limit width of fields in sscanf=0D
=0D
In src/device.c few sscanf does not limit width of uuid field. This=0D
could lead to static overflow and stack corruption.=0D
=0D
Found by Linux Verification Center (linuxtesting.org) with the SVACE=0D
static analysis tool.=0D
=0D
=0D
  Commit: 3627eddea13042ffc0848ae37356f30335ce2e4b=0D
      https://github.com/bluez/bluez/commit/3627eddea13042ffc0848ae37356f=
30335ce2e4b=0D
  Author: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>=0D
  Date:   2022-04-04 (Mon, 04 Apr 2022)=0D
=0D
  Changed paths:=0D
    M src/gatt-database.c=0D
=0D
  Log Message:=0D
  -----------=0D
  gatt: Fix double free and freed memory dereference=0D
=0D
If device is no longer exists or not paired when notifications send it=0D=

is possible to get double free and dereference of already freed memory.=0D=

=0D
To avoid this we need to recheck the state of device after sending=0D
notification.=0D
=0D
Found by Linux Verification Center (linuxtesting.org) with the SVACE=0D
static analysis tool.=0D
=0D
=0D
Compare: https://github.com/bluez/bluez/compare/234d60423c3b...3627eddea1=
30=0D
