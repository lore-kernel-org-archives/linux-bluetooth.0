Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090901070204.GA27211@jh-x301>
References: <eb7933e20908270824w2dc3ae2x8257d20d307ce6fd@mail.gmail.com>
	 <2d5a2c100908271008v67bb1b86xa5ad5ef6e95ba49a@mail.gmail.com>
	 <20090901070204.GA27211@jh-x301>
Date: Tue, 1 Sep 2009 14:09:01 +0300
Message-ID: <eb7933e20909010409x4b85fa1bt162e52ecce028310@mail.gmail.com>
Subject: Re: [PATCH] AVDTP start/stop handling during disconnection
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 1, 2009 at 10:02 AM, Johan Hedberg<johan.hedberg@nokia.com> wrote:

> So Daniel, could you split out the first part of your patch and resend it?


>From 627850090c93152b8faa3e4a724df24dbc556d4e Mon Sep 17 00:00:00 2001
From: Daniel Orstadius <daniel.orstadius@gmail.com>
Date: Tue, 1 Sep 2009 13:55:44 +0300
Subject: [PATCH] Reject AVDTP START/STOP when disconnecting

---
 audio/avdtp.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 8046dda..839f035 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2223,9 +2223,12 @@ static gboolean request_timeout(gpointer user_data)
 		break;
 	case AVDTP_CLOSE:
 		error("Close request timed out");
-		if (lsep && lsep->cfm && lsep->cfm->close)
+		if (lsep && lsep->cfm && lsep->cfm->close) {
 			lsep->cfm->close(session, lsep, stream, &err,
 						lsep->user_data);
+			if (stream)
+				stream->close_int = FALSE;
+		}
 		break;
 	case AVDTP_SET_CONFIGURATION:
 		error("SetConfiguration request timed out");
@@ -2675,9 +2678,11 @@ static gboolean avdtp_parse_rej(struct avdtp *session,
 			return FALSE;
 		error("CLOSE request rejected: %s (%d)",
 				avdtp_strerror(&err), err.err.error_code);
-		if (sep && sep->cfm && sep->cfm->close)
+		if (sep && sep->cfm && sep->cfm->close) {
 			sep->cfm->close(session, sep, stream, &err,
 					sep->user_data);
+			stream->close_int = FALSE;
+		}
 		return TRUE;
 	case AVDTP_ABORT:
 		if (!stream_rej_to_err(buf, size, &err, &acp_seid))
@@ -3138,6 +3143,11 @@ int avdtp_start(struct avdtp *session, struct
avdtp_stream *stream)
 	if (stream->lsep->state != AVDTP_STATE_OPEN)
 		return -EINVAL;

+	if (stream->close_int == TRUE) {
+		error("avdtp_start: rejecting start since close is initiated");
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	req.first_seid.seid = stream->rseid;

@@ -3156,6 +3166,11 @@ int avdtp_close(struct avdtp *session, struct
avdtp_stream *stream)
 	if (stream->lsep->state < AVDTP_STATE_OPEN)
 		return -EINVAL;

+	if (stream->close_int == TRUE) {
+		error("avdtp_close: rejecting close since it is already inititated");
+		return -EINVAL;
+	}
+
 	memset(&req, 0, sizeof(req));
 	req.acp_seid = stream->rseid;

-- 
1.6.0.4


Thanks for the feedback.

/Daniel
