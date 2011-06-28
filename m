Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
Date: Tue, 28 Jun 2011 15:47:52 +0800
Message-ID: <1309247272-11329-3-git-send-email-nami.li@atheros.com>
In-Reply-To: <1309247272-11329-1-git-send-email-nami.li@atheros.com>
References: <1309247272-11329-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Cc: Nami <nami.li@atheros.com>, openobex-users@lists.sourceforge.net,
	haijun@qca.qualcomm.com, hongfan@qca.qualcomm.com
Subject: [openobex-users] [PATCH v3 openobex 3/3] Modify code to read entire
	packet when fd transport format is SEQPACKET.
Reply-To: openobex-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openobex-users>,
	<mailto:openobex-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openobex-users>
List-Post: <mailto:openobex-users@lists.sourceforge.net>
List-Help: <mailto:openobex-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openobex-users>,
	<mailto:openobex-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: openobex-users-bounces@lists.sourceforge.net
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/fdobex.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/lib/fdobex.c b/lib/fdobex.c
index 7fa4a21..1c97e08 100644
--- a/lib/fdobex.c
+++ b/lib/fdobex.c
@@ -79,6 +79,11 @@ static int fdobex_read(obex_t *self, void *buf, int buflen)
 {
 	struct obex_transport *trans = &self->trans;

+	if(trans->data.fd.fmt == FDOBEX_MT_SEQPACKET){
+		/* set buflen large enough to read entire packet */
+		buflen = self->mtu_rx;
+	}
+
 #ifdef _WIN32
 	return  _read(trans->fd, buf, buflen);
 #else
--
1.7.1


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Openobex-users mailing list
Openobex-users@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/openobex-users
