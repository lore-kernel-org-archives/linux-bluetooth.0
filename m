Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 12/12 v3] gobex: make connection id check less strict
Date: Fri, 11 Nov 2011 16:29:06 +0200
Message-Id: <1321021746-5991-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
References: <1321021746-5991-1-git-send-email-luiz.dentz@gmail.com>
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
should only try to validate it in case a header is received.

Reported by Hendrik Sattler <post@hendrik-sattler.de>
---
 gobex/gobex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 8a23485..7840304 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -694,7 +694,7 @@ static gboolean check_connid(GObex *obex, GObexPacket *pkt)
 
 	hdr = g_obex_packet_get_header(pkt, G_OBEX_HDR_CONNECTION);
 	if (hdr == NULL)
-		return FALSE;
+		return TRUE;
 
 	g_obex_header_get_uint32(hdr, &id);
 
-- 
1.7.6.4

