Return-Path: <cyrus@holtmann.org>
From: Johan Hovold <jhovold@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hovold <jhovold@gmail.com>
Subject: [PATCH BlueZ] csr_bcsp: fix link establishment
Date: Fri, 27 Apr 2012 15:03:58 +0200
Message-Id: <1335531838-10627-1-git-send-email-jhovold@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The current link-establishment implementation times out if a packet is
not received after the link is active (i.e. reception of CONF_RESP).

Fix by making sure that the link establishment loop in open is
terminated when ubcsp sets the UBCSP_PACKET_SENT flag (on reception of
CONF_RESP) rather than UBCSP_PACKET_RECEIVED (on reception of any later
packages).

---

Hi,

This patch is required in order to be able to use devices with link managers
that do not send any packets after the link has been established (i.e. after
sending CONF_RESP).

I have two devices here; one which sends an HCI_EVENT_PKT after link
establishment and one which doesn't. Both work with hciattach, but bccmd times
out during link establishment with the latter one. Both work with bccmd with
the patch applied.

It appears to me that this is a bug which has perhaps simply not been
discovered as most devices do send something after LE. The ubcsp
implementation, however, clearly sets the UBCSP_PACKET_SENT flag when reaching
the link-active state and not the received flag which csr_open_bcsp checks for.

Thanks,
Johan


 tools/csr_bcsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/csr_bcsp.c b/tools/csr_bcsp.c
index 7bfaf5a..f7afe53 100644
--- a/tools/csr_bcsp.c
+++ b/tools/csr_bcsp.c
@@ -118,7 +118,7 @@ int csr_open_bcsp(char *device, speed_t bcsp_rate)
 	while (1) {
 		delay = ubcsp_poll(&activity);
 
-		if (activity & UBCSP_PACKET_RECEIVED)
+		if (activity & UBCSP_PACKET_SENT)
 			break;
 
 		if (delay) {
-- 
1.7.8.5
