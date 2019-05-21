Return-Path: <SRS0=xYxd=TV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCC8C04AAF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 May 2019 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB7421743
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 May 2019 10:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA36abjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEUKH1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 May 2019 06:07:27 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54802 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfEUKH1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 May 2019 06:07:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so2315500wml.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2019 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5SbUk3aKrn5AHrtL/YEt5wV3RT2zgD/Lqry9ccwwJow=;
        b=WA36abjQyR5MljYeH2z2fgul9w8wvzFMs3V4JkNUQPw9Fx1xqmaAp8CzdCvnMKhnhp
         EGwY1jGSTkq/0zLimmetrXHawlc0FDFEXaEyAZfV2RB/vqaJxr3EuQeurgs1QnX3J0/4
         DwFUPZgXcO9R2PAsJyXw3DA4VBF1gQjt6EIks832NdHlu9l9WroYiOQ1LbWfARV0QGT+
         YGQLHdAXUwZfXCXYjEH427y+4KF1tTVy2K6bXEDZWUW01EpIWscmsy6++RMFXgoK5lBS
         hnX7WZcJHXBUy7itbckvY7sdGkKxO4cbB5BqQ0WNWIxnj+btRg6Qni6rIK9PAbUKkVSt
         yOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5SbUk3aKrn5AHrtL/YEt5wV3RT2zgD/Lqry9ccwwJow=;
        b=Diqfg5YwsqSAwRs8+5AZ16MVNC0To4ZMTpTfuzs7/9B3Lusr78QIAE1Wxsyw/qIRrJ
         ZMe8DFxEwZKa0TQojiRAab/cnromq5Z2eQwQXOTfZhxg5reDLgO9Kga1wTd1mI3fOmDk
         +KseT6XzB2M+TRigqrqC2ZSqErZBuAvdRcSkDInRsDFQYK9L5FAFXuUXSI8jiqz+bdXA
         IEleXoWSSo1ZhZVci16XYCnTKP8nbPkbSkGQycEpadUoWBdHyF0BN1mvk8A97HyUhnDn
         2oGY5EgewnsQe2aOric0etASZURcJNRzKR0SuD3eqRdGpRQSU+dYnaZ6hMpPdEVABYRC
         4CxA==
X-Gm-Message-State: APjAAAXV73C26HDqJAKeF5HUL2FiFio7HsmEwjwE9tKlRFyhX4hhZeZB
        z/LaHW4AvqxxyTX69wc4vKQCFAEA5+A=
X-Google-Smtp-Source: APXvYqyrwQm7wmH2YYlUDkZ6qeaLKk4sLkp6RbNUvLXmNHWkt6tI3ozcvsYDBaHoLTszZPg6gEjkDA==
X-Received: by 2002:a1c:e708:: with SMTP id e8mr2600644wmh.11.1558433244699;
        Tue, 21 May 2019 03:07:24 -0700 (PDT)
Received: from makarhum-Latitude-E5440 ([2a00:1d50:3:0:9566:787b:24dc:25af])
        by smtp.gmail.com with ESMTPSA id j82sm2630947wmj.40.2019.05.21.03.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 03:07:23 -0700 (PDT)
Date:   Tue, 21 May 2019 13:07:22 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check state in l2cap_disconnect_rsp
Message-ID: <20190521100722.GA15063@makarhum-Latitude-E5440>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Because of both sides doing L2CAP disconnection at the same time, it
was possible to receive L2CAP Disconnection Response with CID that was
already freed. That caused problems if CID was already reused and L2CAP
Connection Request with same CID was sent out. Before this patch kernel
deleted channel context regardless of the state of the channel.

Example where leftover Disconnection Response (frame #402) causes local
device to delete L2CAP channel which was not yet connected. This in
turn confuses remote device's stack because same CID is re-used without
properly disconnecting.

Btmon capture before patch:
** snip **
> ACL Data RX: Handle 43 flags 0x02 dlen 8                #394 [hci1] 10.748949
      Channel: 65 len 4 [PSM 3 mode 0] {chan 2}
      RFCOMM: Disconnect (DISC) (0x43)
         Address: 0x03 cr 1 dlci 0x00
         Control: 0x53 poll/final 1
         Length: 0
         FCS: 0xfd
< ACL Data TX: Handle 43 flags 0x00 dlen 8                #395 [hci1] 10.749062
      Channel: 65 len 4 [PSM 3 mode 0] {chan 2}
      RFCOMM: Unnumbered Ack (UA) (0x63)
         Address: 0x03 cr 1 dlci 0x00
         Control: 0x73 poll/final 1
         Length: 0
         FCS: 0xd7
< ACL Data TX: Handle 43 flags 0x00 dlen 12               #396 [hci1] 10.749073
      L2CAP: Disconnection Request (0x06) ident 17 len 4
        Destination CID: 65
        Source CID: 65
> HCI Event: Number of Completed Packets (0x13) plen 5    #397 [hci1] 10.752391
        Num handles: 1
        Handle: 43
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5    #398 [hci1] 10.753394
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 12               #399 [hci1] 10.756499
      L2CAP: Disconnection Request (0x06) ident 26 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 43 flags 0x00 dlen 12               #400 [hci1] 10.756548
      L2CAP: Disconnection Response (0x07) ident 26 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 43 flags 0x00 dlen 12               #401 [hci1] 10.757459
      L2CAP: Connection Request (0x02) ident 18 len 4
        PSM: 1 (0x0001)
        Source CID: 65
> ACL Data RX: Handle 43 flags 0x02 dlen 12               #402 [hci1] 10.759148
      L2CAP: Disconnection Response (0x07) ident 17 len 4
        Destination CID: 65
        Source CID: 65
= bluetoothd: 00:1E:AB:4C:56:54: error updating services: Input/o..   10.759447
> HCI Event: Number of Completed Packets (0x13) plen 5    #403 [hci1] 10.759386
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 12               #404 [hci1] 10.760397
      L2CAP: Connection Request (0x02) ident 27 len 4
        PSM: 3 (0x0003)
        Source CID: 65
< ACL Data TX: Handle 43 flags 0x00 dlen 16               #405 [hci1] 10.760441
      L2CAP: Connection Response (0x03) ident 27 len 8
        Destination CID: 65
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 43 flags 0x00 dlen 27               #406 [hci1] 10.760449
      L2CAP: Configure Request (0x04) ident 19 len 19
        Destination CID: 65
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 1013
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0
> HCI Event: Number of Completed Packets (0x13) plen 5    #407 [hci1] 10.761399
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 16               #408 [hci1] 10.762942
      L2CAP: Connection Response (0x03) ident 18 len 8
        Destination CID: 66
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
*snip*

Similar case after the patch:
*snip*
> ACL Data RX: Handle 43 flags 0x02 dlen 8            #22702 [hci0] 1664.411056
      Channel: 65 len 4 [PSM 3 mode 0] {chan 3}
      RFCOMM: Disconnect (DISC) (0x43)
         Address: 0x03 cr 1 dlci 0x00
         Control: 0x53 poll/final 1
         Length: 0
         FCS: 0xfd
< ACL Data TX: Handle 43 flags 0x00 dlen 8            #22703 [hci0] 1664.411136
      Channel: 65 len 4 [PSM 3 mode 0] {chan 3}
      RFCOMM: Unnumbered Ack (UA) (0x63)
         Address: 0x03 cr 1 dlci 0x00
         Control: 0x73 poll/final 1
         Length: 0
         FCS: 0xd7
< ACL Data TX: Handle 43 flags 0x00 dlen 12           #22704 [hci0] 1664.411143
      L2CAP: Disconnection Request (0x06) ident 11 len 4
        Destination CID: 65
        Source CID: 65
> HCI Event: Number of Completed Pac.. (0x13) plen 5  #22705 [hci0] 1664.414009
        Num handles: 1
        Handle: 43
        Count: 1
> HCI Event: Number of Completed Pac.. (0x13) plen 5  #22706 [hci0] 1664.415007
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 12           #22707 [hci0] 1664.418674
      L2CAP: Disconnection Request (0x06) ident 17 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 43 flags 0x00 dlen 12           #22708 [hci0] 1664.418762
      L2CAP: Disconnection Response (0x07) ident 17 len 4
        Destination CID: 65
        Source CID: 65
< ACL Data TX: Handle 43 flags 0x00 dlen 12           #22709 [hci0] 1664.421073
      L2CAP: Connection Request (0x02) ident 12 len 4
        PSM: 1 (0x0001)
        Source CID: 65
> ACL Data RX: Handle 43 flags 0x02 dlen 12           #22710 [hci0] 1664.421371
      L2CAP: Disconnection Response (0x07) ident 11 len 4
        Destination CID: 65
        Source CID: 65
> HCI Event: Number of Completed Pac.. (0x13) plen 5  #22711 [hci0] 1664.424082
        Num handles: 1
        Handle: 43
        Count: 1
> HCI Event: Number of Completed Pac.. (0x13) plen 5  #22712 [hci0] 1664.425040
        Num handles: 1
        Handle: 43
        Count: 1
> ACL Data RX: Handle 43 flags 0x02 dlen 12           #22713 [hci0] 1664.426103
      L2CAP: Connection Request (0x02) ident 18 len 4
        PSM: 3 (0x0003)
        Source CID: 65
< ACL Data TX: Handle 43 flags 0x00 dlen 16           #22714 [hci0] 1664.426186
      L2CAP: Connection Response (0x03) ident 18 len 8
        Destination CID: 66
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 43 flags 0x00 dlen 27           #22715 [hci0] 1664.426196
      L2CAP: Configure Request (0x04) ident 13 len 19
        Destination CID: 65
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 1013
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0
> ACL Data RX: Handle 43 flags 0x02 dlen 16           #22716 [hci0] 1664.428804
      L2CAP: Connection Response (0x03) ident 12 len 8
        Destination CID: 66
        Source CID: 65
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
*snip*

Fix is to check that channel is in state BT_DISCONN before deleting the
channel.

This bug was found while fuzzing Bluez's OBEX implementation using
Synopsys Defensics.

Reported-by: Matti Kamunen <matti.kamunen@synopsys.com>
Reported-by: Ari Timonen <ari.timonen@synopsys.com>
Signed-off-by: Matias Karhumaa <matias.karhumaa@gmail.com>
---
 net/bluetooth/l2cap_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b53acd6..25e8859 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4371,6 +4371,12 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn,
 
 	l2cap_chan_lock(chan);
 
+	if (chan->state != BT_DISCONN) {
+		l2cap_chan_unlock(chan);
+		mutex_unlock(&conn->chan_lock);
+		return 0;
+	}
+
 	l2cap_chan_hold(chan);
 	l2cap_chan_del(chan, 0);
 
-- 
2.7.4

