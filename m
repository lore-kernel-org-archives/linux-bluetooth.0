Return-Path: <lcapitulino@conectiva.com.br>
Date: Thu, 22 Sep 2005 18:06:03 -0300
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net
Subject: [PATCH 2/2] - Fixes errno overwrite in sdp_connect().
Message-Id: <20050922180603.6bb82eef.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>


If bind() fails (or connect() in the do-while() fails with EBUSY), the 'errno'
contents will be overwritten in the 'fail' label.

 src/sdp.c |    3 +++
 1 files changed, 3 insertions(+)


diff -X /home/lcapitulino/kernels/2.6/dontdiff -Nparu a/src/sdp.c a~/src/sdp.c
--- a/src/sdp.c	2005-08-07 08:19:58.000000000 -0300
+++ a~/src/sdp.c	2005-09-22 17:39:38.000000000 -0300
@@ -3160,6 +3160,7 @@ static inline int sdp_is_local(const bda
 
 sdp_session_t *sdp_connect(const bdaddr_t *src, const bdaddr_t *dst, uint32_t flags)
 {
+	int err;
 	sdp_session_t *session = malloc(sizeof(sdp_session_t));
 	if (!session)
 		return session;
@@ -3204,8 +3205,10 @@ sdp_session_t *sdp_connect(const bdaddr_
 		}
 	}
 fail:
+	err = errno;
 	if (session->sock >= 0)
 		close(session->sock);
 	free(session);
+	errno = err;
 	return 0;
 }
