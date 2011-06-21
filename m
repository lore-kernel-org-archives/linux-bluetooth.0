Return-Path: <cyrus@holtmann.org>
From: Nami <nami.li@atheros.com>
To: <linux-bluetooth@vger.kernel.org>
Date: Tue, 21 Jun 2011 11:35:44 +0800
Message-ID: <1308627344-8757-3-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308627344-8757-1-git-send-email-nami.li@atheros.com>
References: <1308627344-8757-1-git-send-email-nami.li@atheros.com>
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
 lib/fdobex.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/fdobex.c b/lib/fdobex.c
index 7fa4a21..46a0796 100644
--- a/lib/fdobex.c
+++ b/lib/fdobex.c
@@ -79,6 +79,9 @@ static int fdobex_read(obex_t *self, void *buf, int buflen)
 {
 	struct obex_transport *trans = &self->trans;

+	if(trans->data.fd.fmt == FDOBEX_MT_SEQPACKET)
+		buflen = self->mtu_rx;
+
 #ifdef _WIN32
 	return  _read(trans->fd, buf, buflen);
 #else
--
1.7.1


------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
Openobex-users mailing list
Openobex-users@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/openobex-users
