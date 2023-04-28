Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A1C77B60
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 22:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346748AbjD1Whr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 18:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346851AbjD1Whk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 18:37:40 -0400
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4469D1BFA
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 15:37:37 -0700 (PDT)
Received: from github.com (hubbernetes-node-6f86103.ash1-iad.github.net [10.56.201.65])
        by smtp.github.com (Postfix) with ESMTPA id 33B6A840263
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 15:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1682721456;
        bh=YNQXx3wVtwWyf/Ta9rfq5mQhZBl2+UvJ8UMvrcYSybc=;
        h=Date:From:To:Subject:From;
        b=BXHJvKxXWanI5b1pJP8rGkmvHKyFYQI3XHR5ltjvBE7fjJEm5TzHS3edL+VHwnm0G
         CKh3cUnFfupF10fOjqTctT64LjUdWtr9lKqNcmchh658y+zwOQ1HY0KzzGXwf4S1cO
         K6tfkgViulrtndvqi7dPZy6KvDhSnTb96Wdy1oEw=
Date:   Fri, 28 Apr 2023 15:37:36 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2f88c5-083e66@github.com>
Subject: [bluez/bluez] a600c9: media: Fix not storing Preferred Delay properly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a600c9bda9fee26d640acb1bf042de3583c6c3df
      https://github.com/bluez/bluez/commit/a600c9bda9fee26d640acb1bf042d=
e3583c6c3df
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-25 (Tue, 25 Apr 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix not storing Preferred Delay properly

Preferred Delay properties were being stored as qos->pd_* instead of
qos->ppd_*.


  Commit: 1abd45bb45bf284745d58f5cbd82a7bf39b1ed35
      https://github.com/bluez/bluez/commit/1abd45bb45bf284745d58f5cbd82a=
7bf39b1ed35
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-25 (Tue, 25 Apr 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix crash detaching streams

If a stream is being detached but bt_bap reference is already 0 don't
attempt to detach the stream as they would be freed anyway:

Invalid read of size 8
   at 0x19A360: bap_free (bap.c:2576)
   by 0x19A360: bt_bap_unref (bap.c:2735)
   by 0x19A360: bt_bap_unref (bap.c:2727)
   by 0x160E9A: test_teardown (test-bap.c:412)
   by 0x1A8BCA: teardown_callback (tester.c:434)
 Address 0x55e05e0 is 16 bytes inside a block of size 160 free'd
   at 0x48480E4: free (vg_replace_malloc.c:872)
   by 0x1AD5F6: queue_foreach (queue.c:207)
   by 0x19A1C5: bt_bap_detach (bap.c:3879)
   by 0x19A1C5: bt_bap_detach (bap.c:3855)
   by 0x19A33F: bap_free (bap.c:2574)


  Commit: 614d6630271584a29c3de5f9e705bd4af656a5f8
      https://github.com/bluez/bluez/commit/614d6630271584a29c3de5f9e705b=
d4af656a5f8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-25 (Tue, 25 Apr 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  share/bap: Fix not removing timeout on bap_free

This fixes not removing the process_id timeout when freeing the session
which can cause the following crash:

Invalid read of size 8
  at 0x18EB39: bap_debug (bap.c:553)
  by 0x1913A8: bap_process_queue (bap.c:3542)
  by 0x1A8630: timeout_callback (timeout-glib.c:25)
Address 0x55e0650 is 128 bytes inside a block of size 160 free'd
  at 0x48480E4: free (vg_replace_malloc.c:872)


  Commit: 74206678a97bfa23ab6f8a9966bc88e798031e3c
      https://github.com/bluez/bluez/commit/74206678a97bfa23ab6f8a9966bc8=
8e798031e3c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-27 (Thu, 27 Apr 2023)

  Changed paths:
    M src/shared/tester.c
    M src/shared/tester.h

  Log Message:
  -----------
  shared/tester: Add support for NULL PDUs

This adds support for NULL PDUs which can be used to skip a round of
TX/RX.


  Commit: 3fa45f728cd7bc60dbd30e6bac5d93233f16a2d6
      https://github.com/bluez/bluez/commit/3fa45f728cd7bc60dbd30e6bac5d9=
3233f16a2d6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-27 (Thu, 27 Apr 2023)

  Changed paths:
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Fix typo

Fix typo s/BT_BAP_CONFIG_LATENCY_BALACED/BT_BAP_CONFIG_LATENCY_BALANCED


  Commit: 0b230fd2ba3844d989c3f514729246abbd86026f
      https://github.com/bluez/bluez/commit/0b230fd2ba3844d989c3f51472924=
6abbd86026f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-27 (Thu, 27 Apr 2023)

  Changed paths:
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Update configuration to use iovec

This use iovec as expected storage for capabilities and configuration
so it is inline with what bluetoothctl has been using making it simpler
to reuse these definitions.


  Commit: f7a518c855908d11ecaa0716a62ff97feec546ee
      https://github.com/bluez/bluez/commit/f7a518c855908d11ecaa0716a62ff=
97feec546ee
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-28 (Fri, 28 Apr 2023)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce SCC tests for LC3

4.8.1 Unicast Client Initiates a Config Codec Operation =E2=80=93 LC3
(Page 39):

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Config Codec
  operation for an LC3 codec.

  Test Case Configuration:
  BAP/UCL/SCC/BV-001-C [UCL SRC Config Codec, LC3 8_1]
  BAP/UCL/SCC/BV-002-C [UCL SRC Config Codec, LC3 8_2]
  BAP/UCL/SCC/BV-003-C [UCL SRC Config Codec, LC3 16_1]
  BAP/UCL/SCC/BV-004-C [UCL SRC Config Codec, LC3 16_2]
  BAP/UCL/SCC/BV-005-C [UCL SRC Config Codec, LC3 24_1]
  BAP/UCL/SCC/BV-006-C [UCL SRC Config Codec, LC3 24_2]
  BAP/UCL/SCC/BV-007-C [UCL SRC Config Codec, LC3 32_1]
  BAP/UCL/SCC/BV-008-C [UCL SRC Config Codec, LC3 32_2]
  BAP/UCL/SCC/BV-009-C [UCL SRC Config Codec, LC3 44.1_1]
  BAP/UCL/SCC/BV-010-C [UCL SRC Config Codec, LC3 44.1_2]
  BAP/UCL/SCC/BV-011-C [UCL SRC Config Codec, LC3 48_1]
  BAP/UCL/SCC/BV-012-C [UCL SRC Config Codec, LC3 48_2]
  BAP/UCL/SCC/BV-013-C [UCL SRC Config Codec, LC3 48_3]
  BAP/UCL/SCC/BV-014-C [UCL SRC Config Codec, LC3 48_4]
  BAP/UCL/SCC/BV-015-C [UCL SRC Config Codec, LC3 48_5]
  BAP/UCL/SCC/BV-016-C [UCL SRC Config Codec, LC3 48_6]
  BAP/UCL/SCC/BV-017-C [UCL SNK Config Codec, LC3 8_1]
  BAP/UCL/SCC/BV-018-C [UCL SNK Config Codec, LC3 8_2]
  BAP/UCL/SCC/BV-019-C [UCL SNK Config Codec, LC3 16_1]
  BAP/UCL/SCC/BV-020-C [UCL SNK Config Codec, LC3 16_2]
  BAP/UCL/SCC/BV-021-C [UCL SNK Config Codec, LC3 24_1]
  BAP/UCL/SCC/BV-022-C [UCL SNK Config Codec, LC3 24_2]
  BAP/UCL/SCC/BV-023-C [UCL SNK Config Codec, LC3 32_1]
  BAP/UCL/SCC/BV-024-C [UCL SNK Config Codec, LC3 32_2]
  BAP/UCL/SCC/BV-025-C [UCL SNK Config Codec, LC3 44.1_1]
  BAP/UCL/SCC/BV-026-C [UCL SNK Config Codec, LC3 44.1_2]
  BAP/UCL/SCC/BV-027-C [UCL SNK Config Codec, LC3 48_1]
  BAP/UCL/SCC/BV-028-C [UCL SNK Config Codec, LC3 48_2]
  BAP/UCL/SCC/BV-029-C [UCL SNK Config Codec, LC3 48_3]
  BAP/UCL/SCC/BV-030-C [UCL SNK Config Codec, LC3 48_4]
  BAP/UCL/SCC/BV-031-C [UCL SNK Config Codec, LC3 48_5]
  BAP/UCL/SCC/BV-032-C [UCL SNK Config Codec, LC3 48_6]

  Pass verdict:
  The IUT successfully writes to the ASE Control point with the opcode
  set to 0x01 (Config Codec) and correctly formatted parameter values
  from Table 4.9.
  The Codec_ID field is a 5-octet field with octet 0 set to the LC3
  Coding_Format value defined in Bluetooth Assigned Numbers, octets 1=E2=80=
=934
  set to 0x0000.

Test Summary
------------
BAP/UCL/SCC/BV-001-C [UCL SRC Config Codec, LC3 8_1] Passed
BAP/UCL/SCC/BV-002-C [UCL SRC Config Codec, LC3 8_2] Passed
BAP/UCL/SCC/BV-003-C [UCL SRC Config Codec, LC3 16_1] Passed
BAP/UCL/SCC/BV-004-C [UCL SRC Config Codec, LC3 16_2] Passed
BAP/UCL/SCC/BV-005-C [UCL SRC Config Codec, LC3 24_1] Passed
BAP/UCL/SCC/BV-006-C [UCL SRC Config Codec, LC3 24_2] Passed
BAP/UCL/SCC/BV-007-C [UCL SRC Config Codec, LC3 32_1] Passed
BAP/UCL/SCC/BV-008-C [UCL SRC Config Codec, LC3 32_2] Passed
BAP/UCL/SCC/BV-009-C [UCL SRC Config Codec, LC3 44.1_1] Passed
BAP/UCL/SCC/BV-010-C [UCL SRC Config Codec, LC3 44.1_2] Passed
BAP/UCL/SCC/BV-011-C [UCL SRC Config Codec, LC3 48_1] Passed
BAP/UCL/SCC/BV-012-C [UCL SRC Config Codec, LC3 48_2] Passed
BAP/UCL/SCC/BV-013-C [UCL SRC Config Codec, LC3 48_3] Passed
BAP/UCL/SCC/BV-014-C [UCL SRC Config Codec, LC3 48_4] Passed
BAP/UCL/SCC/BV-015-C [UCL SRC Config Codec, LC3 48_5] Passed
BAP/UCL/SCC/BV-016-C [UCL SRC Config Codec, LC3 48_6] Passed
BAP/UCL/SCC/BV-017-C [UCL SNK Config Codec, LC3 8_1] Passed
BAP/UCL/SCC/BV-018-C [UCL SNK Config Codec, LC3 8_2] Passed
BAP/UCL/SCC/BV-019-C [UCL SNK Config Codec, LC3 16_1] Passed
BAP/UCL/SCC/BV-020-C [UCL SNK Config Codec, LC3 16_2] Passed
BAP/UCL/SCC/BV-021-C [UCL SNK Config Codec, LC3 24_1] Passed
BAP/UCL/SCC/BV-022-C [UCL SNK Config Codec, LC3 24_2] Passed
BAP/UCL/SCC/BV-023-C [UCL SNK Config Codec, LC3 32_1] Passed
BAP/UCL/SCC/BV-024-C [UCL SNK Config Codec, LC3 32_2] Passed
BAP/UCL/SCC/BV-025-C [UCL SNK Config Codec, LC3 44.1_1] Passed
BAP/UCL/SCC/BV-026-C [UCL SNK Config Codec, LC3 44.1_2] Passed
BAP/UCL/SCC/BV-027-C [UCL SNK Config Codec, LC3 48_1] Passed
BAP/UCL/SCC/BV-028-C [UCL SNK Config Codec, LC3 48_2] Passed
BAP/UCL/SCC/BV-029-C [UCL SNK Config Codec, LC3 48_3] Passed
BAP/UCL/SCC/BV-030-C [UCL SNK Config Codec, LC3 48_4] Passed
BAP/UCL/SCC/BV-031-C [UCL SNK Config Codec, LC3 48_5] Passed
BAP/UCL/SCC/BV-032-C [UCL SNK Config Codec, LC3 48_6] Passed
Total: 32, Passed: 32 (100.0%), Failed: 0, Not Run: 0


  Commit: 3b5c0e5ed0763195157ae1eacc2250a935726803
      https://github.com/bluez/bluez/commit/3b5c0e5ed0763195157ae1eacc225=
0a935726803
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-28 (Fri, 28 Apr 2023)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Fix runtime error

This fixes the following errors:

src/shared/util.c:271:2: runtime error: null pointer passed as argument
2, which is declared to never be null


  Commit: 083e66d3ac2df4baabe0ab42fc7a93c47709bf39
      https://github.com/bluez/bluez/commit/083e66d3ac2df4baabe0ab42fc7a9=
3c47709bf39
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-28 (Fri, 28 Apr 2023)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add SCC tests for Vendor-Specific codec

4.8.2 Unicast Client Initiates a Config Codec Operation =E2=80=93
Vendor-Specific (page 42):

  Test Purpose:
  Verify that a Unicast Client IUT can initiate a Config Codec
  operation for a vendor-specific codec.

  Test Case Configuration:
  BAP/UCL/SCC/BV-033-C [UCL SRC Config Codec, VS]
  BAP/UCL/SCC/BV-034-C [UCL SNK Config Codec, VS]

  Pass verdict:
  The IUT successfully writes to the ASE Control Point characteristic
  with the opcode set to 0x01 (Config Codec) and the specified
  parameters. The Codec_ID parameter is formatted with octet 0 set to
  0xFF, octets 1=E2=80=932 set to TSPX_VS_Company_ID, and octets 3=E2=80=93=
4 set to
  TSPX_VS_Codec_ID.

Test Summary
------------
BAP/UCL/SCC/BV-033-C [UCL SRC Config Codec, VS]      Passed
BAP/UCL/SCC/BV-034-C [UCL SNK Config Codec, VS]      Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0


Compare: https://github.com/bluez/bluez/compare/2f88c59391b8...083e66d3ac=
2d
