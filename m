Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F3C77B73
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 May 2023 16:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjEUQQA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 May 2023 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUQP7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 May 2023 12:15:59 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC9FAC
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 09:15:57 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id A080E240101
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 May 2023 18:15:55 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QPQfz132vz9rxG;
        Sun, 21 May 2023 18:15:54 +0200 (CEST)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: hci_sync req_complete_skb does not get called?
Date:   Sun, 21 May 2023 16:15:51 +0000
Message-Id: <6f0674a4bafc17ab4ab34b0fec99f9e4a1312a90.1684684404.git.pav@iki.fi>
In-Reply-To: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
References: <024df2d86c14fc811701ba27bfa576476bc9c0d6.1684682575.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The patch below adds variants of multi-CIG connection tests to BlueZ
iso-tester that connect them at the same time instead of sequentially.

In test-runner, the test

ISO Connect2 CIG 0x01/0x02 - Success

appears to time out on bluetooth-next/master, as a LE Extended Create
Connection command gets a timeout.

This seems to be because hci_le_ext_create_conn_sync waits for
HCI_LE_Enhanced_Connection_Complete, and things go wrong:

The controller emits HCI_Command_Status first.

Then, kernel queues another command (Disconnect), before the
Connection_Complete event that hci_le_ext_create_conn_sync waits for
arrives.

This replaces hdev->sent_cmd in hci_cmd_work. Because of this, when the
Create_Connection event arrives, hci_cmd_sync_complete for the Create
Connection command won't be called. As a result, creating the connection
hangs until hci_sync timeout.

This looks like timing-sensitive issue in the hci_request/hci_sync
logic: the req_complete* callback for a request will not be called if
another command gets sent while the request waits for an event.

This seems to block the hci_sync queue for a while, so it probably is
not intended behavior?

Example trace from

./tools/iso-tester -d -s "ISO Connect2 CIG 0x01/0x02 - Success"

and for kernel with enabled debug prints:

> __hci_cmd_sync_sk:154: hci0: Opcode 0x2043
> hci_cmd_sync_add:88: hci0: opcode 0x2043 plen 58
> hci_cmd_sync_alloc:66: hci0: skb len 61
> hci_cmd_sync_run:118: hci0: length 1
> hci_cmd_work:4092: hci0 cmd_cnt 1 cmd queued 1
> hci_send_frame:2982: hci0 type 1 len 61
>   Successfully connected
>   Step 1
> hci_conn_drop:1416: hcon ffff888001933000 orig refcnt 1
> hci_send_cmd:3020: hci0 opcode 0x0406 plen 3
> hci_cmd_work:4092: hci0 cmd_cnt 0 cmd queued 1

Here, HCI_Disconnect (0x0406) got queued while
HCI_LE_Extended_Create_Connection (0x2043) sync request is waiting for
HCI_LE_Enhanced_Connection_Complete (0x0a).  The disconnect cmd is not sent
yet, as there's no room in cmd_cnt.

>   hciemu: vhci: > 01 43 20 3a 00 00 00 01 00 02 01 aa 00 07 60 00  .C :..........`.
>   hciemu: vhci:   60 00 18 00 28 00 00 00 2a 00 00 00 00 00 60 00  `...(...*.....`.
>   hciemu: vhci:   60 00 18 00 28 00 00 00 2a 00 00 00 00 00 60 00  `...(...*.....`.
>   hciemu: vhci:   60 00 18 00 28 00 00 00 2a 00 00 00 00 00        `...(...*.....
>   hciemu: vhci: command 0x2043
>   hciemu: vhci: event 0x0f opcode 0x2043
>   hciemu: vhci: < 04                                               .
>   hciemu: vhci:   0f 04                                            ..
>   hciemu: vhci:   00 01 43 20                                      ..C
> hci_rx_work:4017: hci0
> hci_rx_work:4061: hci0 Event packet
> hci_event_packet:7527: hci0: event 0x0f
> hci_cmd_status_evt:4291: hci0: opcode 0x2043
> hci_cs_le_ext_create_conn:2910: hci0: status 0x00
> hci_sent_cmd_data:3083: hci0 opcode 0x2043

The HCI_LE_Extended_Create_Connection command status event arrived.  The
hci_sync request is waiting for a different event, so the status event didn't
complete it.

hci_cmd_status_evt makes room in cmd_cnt and queues cmd_work.

> hci_cmd_work:4092: hci0 cmd_cnt 1 cmd queued 1
> hci_send_frame:2982: hci0 type 1 len 6

The queued HCI_Disconnect was sent to the driver.  At this point hdev->sent_cmd
is replaced by the skb of the HCI_Disconnect, and the completion callback of
the HCI_LE_Extended_Create_Connection sync request will never be called.

>   hciemu: vhci: conn1 0x46c340 handle 0x002b
>   hciemu: vhci: conn2 0x46d410 handle 0x002a
>   hciemu: btdev: meta event 0x0a
>   hciemu: btdev: event 0x3e
>   hciemu: btdev: < 04                                               .
>   hciemu: btdev:   3e 1f                                            >.
>   hciemu: btdev:   0a 00 2b 00 01 00 00 00 00 01 aa 00 00 00 00 00  ..+.............
>   hciemu: btdev:   00 00 00 00 00 00 00 00 28 00 00 00 2a 00 00     ........(...*..
>   hciemu: btdev: meta event 0x12
>   hciemu: btdev: event 0x3e
>   hciemu: btdev: < 04                                               .
>   hciemu: btdev:   3e 06                                            >.
>   hciemu: btdev:   12 00 01 2b 00 00                                ...+..
>   hciemu: vhci: meta event 0x0a
>   hciemu: vhci: event 0x3e
>   hciemu: vhci: < 04                                               .
>   hciemu: vhci:   3e 1f                                            >.
>   hciemu: vhci:   0a 00 2b 00 00 00 01 00 02 01 aa 00 00 00 00 00  ..+.............
>   hciemu: vhci:   00 00 00 00 00 00 00 00 28 00 00 00 2a 00 00     ........(...*..
> hci_rx_work:4017: hci0
> hci_rx_work:4061: hci0 Event packet
> hci_event_packet:7527: hci0: event 0x3e
> hci_le_meta_evt:7112: hci0: subevent 0x0a
> hci_le_enh_conn_complete_evt:5988: hci0: status 0x00

Here the Connection Complete event (0x0a) arrives, but hci_req_cmd_complete and
hci_cmd_sync_complete are not called.

Some time passes without hci_sync activity:

> hci_dev_hold:1460: hci0 orig refcnt 16
> hci_send_cmd:3020: hci0 opcode 0x2016 plen 2
> hci_conn_hold:1406: hcon ffff888001935000 orig refcnt 1
> hci_cmd_work:4092: hci0 cmd_cnt 0 cmd queued 1
> hci_dev_hold:1460: hci0 orig refcnt 16
> hci_send_cmd:3020: hci0 opcode 0x2016 plen 2
> hci_conn_hold:1406: hcon ffff888001935000 orig refcnt 1
> hci_cmd_work:4092: hci0 cmd_cnt 0 cmd queued 1
>   hciemu: vhci: meta event 0x12
>   hciemu: vhci: event 0x3e
>   hciemu: vhci: < 04                                               .
>   hciemu: vhci:   3e 06                                            >.
>   hciemu: vhci:   12 00 00 2b 00 00                                ...+..
> hci_rx_work:4017: hci0
> hci_rx_work:4061: hci0 Event packet
> hci_event_packet:7527: hci0: event 0x3e
> hci_le_meta_evt:7112: hci0: subevent 0x12
> hci_le_ext_adv_term_evt:6004: hci0: status 0x00
>   mgmt: src/shared/mgmt.c:can_read_data() [0x0000] event 0x000b
>   hciemu: vhci: > 01 06 04 03 01 01 13                             .......
>   hciemu: vhci: command 0x0406
>   hciemu: vhci: event 0x0f opcode 0x0406
>   hciemu: vhci: < 04                                               .
>   hciemu: vhci:   0f 04                                            ..
>   hciemu: vhci:   00 01 06 04                                      ....
> hci_rx_work:4017: hci0
> hci_rx_work:4061: hci0 Event packet
> hci_event_packet:7527: hci0: event 0x0f
> hci_cmd_status_evt:4291: hci0: opcode 0x0406
> hci_cs_disconnect:2760: hci0: status 0x00
> hci_req_cmd_complete:3954: opcode 0x0406 status 0x00
> hci_sent_cmd_data:3083: hci0 opcode 0x0406
> hci_cmd_work:4092: hci0 cmd_cnt 1 cmd queued 1
> hci_send_frame:2982: hci0 type 1 len 5
>   hciemu: vhci: event 0x05
>   hciemu: vhci: < 04                                               .
>   hciemu: vhci:   05 04                                            ..
>   hciemu: vhci:   00 01 01 16                                      ....
> hci_rx_work:4017: hci0
> hci_rx_work:4061: hci0 Event packet
> hci_event_packet:7527: hci0: event 0x05
> hci_disconn_complete_evt:3383: hci0: status 0x00
>   hciemu: btdev: event 0x05
>   hciemu: btdev: < 04                                               .
>   hciemu: btdev:   05 04                                            ..
>   hciemu: btdev:   00 01 01 13                                      ....
>   hciemu: bthost: > 04 3e 1f 0a 00 2b 00 01 00 00 00 00 01 aa 00 00  .>...+..........
>   hciemu: bthost:   00 00 00 00 00 00 00 00 00 00 00 28 00 00 00 2a  ...........(...*
>   hciemu: bthost:   00 00                                            ..
>   hciemu: bthost: event 0x3e
>   hciemu: bthost: meta event 0x0a
>   hciemu: bthost: ia 00:AA:01:00:00:00 type 0x01 ra 00:AA:01:02:00:01 type 0x01
> hci_conn_drop:1416: hcon ffff888001932000 orig refcnt 1
>   hciemu: vhci: > 01 16 20 02 2b 00                                .. .+.
>   hciemu: vhci: command 0x2016
>   hciemu: vhci: event 0x0f opcode 0x2016
>   hciemu: vhci: < 04                                               .
>   hciemu: vhci:   0f 04                                            ..
>   hciemu: vhci:   00 01 16 20                                      ...
>   hciemu: vhci: meta event 0x04
>   hciemu: vhci: event 0x3e
>   hciemu: vhci: < 04                                               .
>   hciemu: vhci:   3e 0c                                            >.
> hci_dev_put:1452: hci0 orig refcnt 15
> hci_dev_put:1452: hci0 orig refcnt 14
> hci_rx_work:4061: hci0 Event packet
> hci_event_packet:7527: hci0: event 0x0f
> hci_cmd_status_evt:4291: hci0: opcode 0x2016
> hci_cs_le_read_remote_features:2936: hci0: status 0x00
> hci_req_cmd_complete:3954: opcode 0x2016 status 0x00
> hci_sent_cmd_data:3083: hci0 opcode 0x2016
> hci_rx_work:4017: hci0
>   hciemu: vhci:   04 00 2b 00 40 39 00 f0 01 00 00 00              ..+.@9......
> hci_rx_work:4017: hci0
> hci_rx_work:4061: hci0 Event packet
> hci_event_packet:7527: hci0: event 0x3e
> hci_le_meta_evt:7112: hci0: subevent 0x04
> hci_le_remote_feat_complete_evt:6555: hci0: status 0x00
> hci_conn_drop:1416: hcon ffff888001935000 orig refcnt 2
>   hciemu: bthost: > 04 05 04 00 01 01 13                             .......
>   hciemu: bthost: event 0x05
>   hciemu: bthost: > 04 3e 06 12 00 01 2b 00 00                       .>....+..
>   hciemu: bthost: event 0x3e
>   hciemu: bthost: meta event 0x12
>   hciemu: bthost: Unsupported LE Meta event 0x12
> ISO Connect2 CIG 0x01/0x02 - Success - teardown
> hci_unregister_dev:2687: ffff888001928000 name hci0 bus 0
> hci_send_cmd:3020: hci0 opcode 0x0406 plen 3
> hci_cmd_work:4092: hci0 cmd_cnt 1 cmd queued 1
> hci_send_frame:2982: hci0 type 1 len 6
> Bluetooth: hci0: command 0x0406 tx timeout
> hci_cmd_work:4092: hci0 cmd_cnt 1 cmd queued 0
> __hci_cmd_sync_sk:192: hci0: end: err -110
> __hci_cmd_sync_sk:154: hci0: Opcode 0x200e

... until hci_sync timeout for the LE Create Connection connection is
reached, and it tries to send LE Create Connection Cancel to cancel the
operation even though it succeeded.

Then things start to go wrong and the test ultimately hangs, as the
emulator gets torn down due to timeout at a bad time.  Increasing the
test timeout makes it pass after 6sec, but not clear if this can cause
problems on a real controller.

---
 tools/iso-tester.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index fc2a84215..840e53e6b 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2303,6 +2303,14 @@ int main(int argc, char *argv[])
 	test_iso("ISO QoS - Invalid", &connect_invalid, setup_powered,
 							test_connect);
 
+	test_iso2("ISO Connect2 CIG 0x01/0x02 - Success", &connect_2_16_2_1,
+							setup_powered,
+							test_connect2);
+
+	test_iso2("ISO Connect2 CIG auto/auto - Success", &connect_2a_16_2_1,
+							setup_powered,
+							test_connect2);
+
 	test_iso2("ISO Connect2 CIG 0x01/0x02 Seq - Success", &connect_2_16_2_1,
 							setup_powered,
 							test_connect2_seq);
-- 
2.40.1

