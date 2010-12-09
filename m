Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Dec 2010 16:41:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: roystonr@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, skrovvid@codeaurora.org,
	rshaffer@codeaurora.org
Subject: Re: A2DP reconfigure with BMW Carkit (supporting multi streams)
 timeouts.
Message-ID: <20101209144103.GA30557@jh-x301>
References: <3b53a90114d801b0adba526895deed74.squirrel@www.codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
In-Reply-To: <3b53a90114d801b0adba526895deed74.squirrel@www.codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Royston,

On Thu, Dec 09, 2010, roystonr@codeaurora.org wrote:
> Change expected:
> avdtp_get_seps should be able to provide the SEP of the one used in the
> AVDTP_CLOSE previously. But there weren't any previously closed streams
> then provide the SEP which is not in use (as done currently).
> 
> Kindly let us know whether our understanding is right and can this be a
> suspected cause of the issue seen. Correct if mistaken.

Sounds like that might be the cause. Have you experimented with patching
the bluez code to reuse the same SEP as was used for the Close? If not
I'd advice you to do that so we can be sure that a change to the ACP SEP
selection logic makes sense.

Right now the reconfiguration happens in audio/a2dp.c where there's a
setup->reconfigure flag to track if a new stream should be configured
after receiving close_ind. The a2dp_reconfigure function in a2dp.c is
responsible for selecting the remote SEP. Could you try the attached
(completely untested) patch to see if it helps? It stores the old remote
SEP in the setup structure when starting the Close procedure in which
case a2dp_reconfigure() shouldn't try to reselect a new remote SEP but
use the stored one instead.

Johan

--h31gzZEtNLTqOjlF
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="acp_sep_selection.patch"

diff --git a/audio/a2dp.c b/audio/a2dp.c
index b1e94d9..7ed84e9 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -2032,6 +2032,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 				error("avdtp_close failed");
 				goto failed;
 			}
+			setup->rsep = avdtp_stream_get_remote_sep(tmp->stream);
 			break;
 		}
 
@@ -2061,6 +2062,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 				error("avdtp_close failed");
 				goto failed;
 			}
+			setup->rsep = avdtp_stream_get_remote_sep(sep->stream);
 		}
 		break;
 	default:
diff --git a/audio/avdtp.c b/audio/avdtp.c
index 1683e7c..33178c3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -3133,6 +3133,12 @@ gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 	return TRUE;
 }
 
+struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
+						struct avdtp_stream *stream)
+{
+	return avdtp_get_remote_sep(stream->session, stream->rseid);
+}
+
 gboolean avdtp_stream_get_transport(struct avdtp_stream *stream, int *sock,
 					uint16_t *imtu, uint16_t *omtu,
 					GSList **caps)
diff --git a/audio/avdtp.h b/audio/avdtp.h
index 9406fa7..5f37dc3 100644
--- a/audio/avdtp.h
+++ b/audio/avdtp.h
@@ -257,6 +257,8 @@ gboolean avdtp_stream_has_capability(struct avdtp_stream *stream,
 				struct avdtp_service_capability *cap);
 gboolean avdtp_stream_has_capabilities(struct avdtp_stream *stream,
 					GSList *caps);
+struct avdtp_remote_sep *avdtp_stream_get_remote_sep(
+						struct avdtp_stream *stream);
 
 unsigned int avdtp_add_state_cb(avdtp_session_state_cb cb, void *user_data);
 

--h31gzZEtNLTqOjlF--
