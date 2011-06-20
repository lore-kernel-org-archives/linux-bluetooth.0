Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <haijun@qca.qualcomm.com>, <openobex-users@lists.sourceforge.net>,
	Nami <nami.li@atheros.com>
Subject: [PATCH openobex 3/3] Modify fdobex_read to read the entire packet when data tarnsprot format is SEQPACKET,
Date: Mon, 20 Jun 2011 13:47:29 +0800
Message-ID: <1308548849-11615-3-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
References: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


---
 lib/fdobex.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/fdobex.c b/lib/fdobex.c
index 45c56ff..7a44fbd 100644
--- a/lib/fdobex.c
+++ b/lib/fdobex.c
@@ -78,6 +78,8 @@ static int fdobex_read(obex_t *self, void *buf, int buflen)
 {
 	struct obex_transport *trans = &self->trans;

+	if(trans->data.fd.fmt == FDOBEX_MT_SEQPACKET)
+		buflen = self->mtu_rx;
 #ifdef _WIN32
 	return  _read(trans->fd, buf, buflen);
 #else
--
1.7.1

