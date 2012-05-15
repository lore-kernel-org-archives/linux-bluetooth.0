Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/2] bluetooth: Fix not setting port to 0 when listen fails
Date: Tue, 15 May 2012 19:16:45 +0300
Message-Id: <1337098606-5710-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With some only kernels auto assigning psm seem to fail, leaving the psm
with wrong value:

obexd[2930]: plugins/bluetooth.c:start() listening on channel 9
obexd[2930]: bluetooth: unable to listen in psm 65535
obexd[2930]: plugins/bluetooth.c:start() listening on channel 10
obexd[2930]: bluetooth: unable to listen in psm 65535
---
 plugins/bluetooth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index aab50fd..79de9a2 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -607,6 +607,7 @@ static GSList *start(struct obex_server *server,
 		error("bluetooth: unable to listen in psm %d: %s",
 				service->port, err->message);
 		g_error_free(err);
+		service->port = 0;
 	} else {
 		l = g_slist_prepend(l, io);
 		bt_io_get(io, BT_IO_L2CAP, &err, BT_IO_OPT_PSM, &service->port,
-- 
1.7.7.6

