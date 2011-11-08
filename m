Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/2] gobex: make connection id check less strict
Date: Tue,  8 Nov 2011 14:58:01 +0200
Message-Id: <1320757081-22620-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320757081-22620-1-git-send-email-luiz.dentz@gmail.com>
References: <1320757081-22620-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

OBEX spec says:

  Only the first packet in the request needs to contain the Connection
  Id header...

  If a Connection Id header is received with an invalid connection
  identifier, it is recommended that the operation be rejected with the
  response code (0xD3) “Service Unavailable”.

Since not all requests packets need to contain Connection Id header we
should only try to validate it if it is part of the packet.

Reported by Hendrik Sattler <post@hendrik-sattler.de>
---
 gobex/gobex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index b0f3716..f685162 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -691,7 +691,7 @@ static gboolean check_connid(GObex *obex, GObexPacket *pkt)
 
 	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_CONNECTION);
 	if (hdr == NULL)
-		return FALSE;
+		return TRUE;
 
 	g_obex_header_get_uint32(hdr, &id);
 
-- 
1.7.6.4

