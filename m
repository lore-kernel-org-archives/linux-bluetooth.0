Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] monitor: Fix selecting PSM for L2CAP frame
Date: Wed, 18 Feb 2015 22:46:32 +0100
Message-Id: <1424295992-29506-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1424295992-29506-1-git-send-email-szymon.janc@tieto.com>
References: <1424295992-29506-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Current code could fail to pick up right PSM resulting in using PSM 1
for non-SDP traffic.

Fix following:
> ACL Data RX: Handle 3 flags 0x02 dlen 9
    Channel: 64 len 5 [PSM 1 mode 0] {chan 0}
      invalid frame size
> ACL Data RX: Handle 3 flags 0x02 dlen 20
    Channel: 64 len 16 [PSM 1 mode 0] {chan 0}
      invalid frame size
      2b 42 52 53 46 3d 32 35 35 0d e4                 +BRSF=255..
< ACL Data TX: Handle 3 flags 0x00 dlen 28
    Channel: 256 len 24 [PSM 3 mode 0] {chan 1}
    RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
       Address: 0x69 cr 0 dlci 0x1a
       Control: 0xef poll/final 0
       Length: 20
       FCS: 0x3e
      0d 0a 2b 42 52 53 46 3a 20 38 37 31 0d 0a 0d 0a  ..+BRSF: 871....
      4f 4b 0d 0a 3e                                   OK..>

instead of:
> ACL Data RX: Handle 4 flags 0x02 dlen 20
    Channel: 64 len 16 [PSM 3 mode 0] {chan 1}
    RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
       Address: 0x6b cr 1 dlci 0x1a
       Control: 0xef poll/final 0
       Length: 12
       FCS: 0xe4
      41 54 2b 42 52 53 46 3d 32 35 35 0d e4           AT+BRSF=255..
< ACL Data TX: Handle 4 flags 0x00 dlen 28
    Channel: 384 len 24 [PSM 3 mode 0] {chan 1}
    RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
       Address: 0x69 cr 0 dlci 0x1a
       Control: 0xef poll/final 0
       Length: 20
       FCS: 0x3e
      0d 0a 2b 42 52 53 46 3a 20 38 37 31 0d 0a 0d 0a  ..+BRSF: 871....
      4f 4b 0d 0a 3e                                   OK..>
---
 monitor/l2cap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 342bd8e..7a6edbe 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -232,10 +232,13 @@ static int get_chan_data_index(const struct l2cap_frame *frame)
 					chan_list[i].ctrlid == 0)
 			continue;
 
-		if (chan_list[i].handle != frame->handle &&
+		if (chan_list[i].ctrlid != 0 &&
 					chan_list[i].ctrlid != frame->index)
 			continue;
 
+		if (chan_list[i].handle != frame->handle)
+			continue;
+
 		if (frame->in) {
 			if (chan_list[i].scid == frame->cid)
 				return i;
-- 
1.9.3

