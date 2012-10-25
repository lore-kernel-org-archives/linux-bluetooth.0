Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 01/11] Bluetooth: trivial: Remove unneeded assignment
Date: Thu, 25 Oct 2012 15:20:42 +0300
Message-Id: <1351167652-12346-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Assignment is not needed here since err is always gets value.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fae0c70..962a322 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4386,7 +4386,7 @@ static void l2cap_logical_finish_create(struct l2cap_chan *chan,
 	set_bit(CONF_OUTPUT_DONE, &chan->conf_state);
 
 	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
-		int err = 0;
+		int err;
 
 		set_default_fcs(chan);
 
-- 
1.7.9.5

