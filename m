Return-Path: <cyrus@holtmann.org>
Date: Fri, 10 Dec 2010 12:32:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: roystonr@codeaurora.org, linux-bluetooth@vger.kernel.org,
	skrovvid@codeaurora.org, rshaffer@codeaurora.org
Subject: Re: A2DP reconfigure with BMW Carkit (supporting multi streams)
 timeouts.
Message-ID: <20101210103242.GA21860@jh-x301>
References: <3b53a90114d801b0adba526895deed74.squirrel@www.codeaurora.org>
 <20101209144103.GA30557@jh-x301>
 <AANLkTik78DiC7TgWtR0q=xPs+ZZq470_md-gJWv8tB8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <AANLkTik78DiC7TgWtR0q=xPs+ZZq470_md-gJWv8tB8f@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luiz,

On Fri, Dec 10, 2010, Luiz Augusto von Dentz wrote:
> I guess it would be better to have the call to
> avdtp_stream_get_remote_sep on close_cfm, it is probably safer to do
> there and less code too, but the fix is probably right.

Good point. Attach is a patch which does this. Could we now please get
some feedback from the reporter if this really helps? :)

Johan

--dDRMvlgZJXvWKvBx
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="acp_sep_selection.patch"

diff --git a/audio/a2dp.c b/audio/a2dp.c
index b1e94d9..b46cef1 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1097,6 +1097,9 @@ static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		return;
 	}
 
+	if (!setup->rsep)
+		setup->rsep = avdtp_stream_get_remote_sep(stream);
+
 	if (setup->reconfigure)
 		g_timeout_add(RECONFIGURE_TIMEOUT, a2dp_reconfigure, setup);
 }
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
 

--dDRMvlgZJXvWKvBx--
