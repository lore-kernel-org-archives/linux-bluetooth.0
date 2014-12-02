Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/13] profiles: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:27 +0100
Message-Id: <1417541318-24259-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 profiles/alert/server.c  |  1 +
 profiles/audio/a2dp.c    | 12 ++++++++++++
 profiles/audio/avrcp.c   |  1 +
 profiles/audio/control.c |  2 ++
 profiles/health/mcap.c   |  1 +
 5 files changed, 17 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 8601bf1..aefcff8 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -406,6 +406,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		len = enc_notification(al_adapter->hnd_value[type],
 					nd->value, nd->len, pdu, len);
 		break;
+	case NOTIFY_SIZE:
 	default:
 		DBG("Unknown type, could not send notification");
 		goto end;
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 6b72f99..75503f3 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1619,6 +1619,9 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 			}
 		}
 		break;
+	case AVDTP_STATE_CONFIGURED:
+	case AVDTP_STATE_CLOSING:
+	case AVDTP_STATE_ABORTING:
 	default:
 		error("SEP in bad state for requesting a new stream");
 		goto failed;
@@ -1675,6 +1678,8 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 			cb_data->source_id = g_idle_add(finalize_resume,
 								setup);
 		break;
+	case AVDTP_STATE_CLOSING:
+	case AVDTP_STATE_ABORTING:
 	default:
 		error("SEP in bad state for resume");
 		goto failed;
@@ -1719,6 +1724,9 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 		}
 		sep->suspending = TRUE;
 		break;
+	case AVDTP_STATE_CONFIGURED:
+	case AVDTP_STATE_CLOSING:
+	case AVDTP_STATE_ABORTING:
 	default:
 		error("SEP in bad state for suspend");
 		goto failed;
@@ -1806,6 +1814,10 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 		if (avdtp_suspend(session, sep->stream) == 0)
 			sep->suspending = TRUE;
 		break;
+	case AVDTP_STATE_IDLE:
+	case AVDTP_STATE_CONFIGURED:
+	case AVDTP_STATE_CLOSING:
+	case AVDTP_STATE_ABORTING:
 	default:
 		break;
 	}
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5c3c4f9..11de6ee 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3610,6 +3610,7 @@ static void state_changed(struct btd_device *device, avctp_state_t old_state,
 		session_init_browsing(session);
 
 		break;
+	case AVCTP_STATE_BROWSING_CONNECTING:
 	default:
 		return;
 	}
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index ab94a57..3985362 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -96,6 +96,8 @@ static void state_changed(struct btd_device *dev, avctp_state_t old_state,
 		g_dbus_emit_property_changed(conn, path,
 					AUDIO_CONTROL_INTERFACE, "Connected");
 		break;
+	case AVCTP_STATE_BROWSING_CONNECTING:
+	case AVCTP_STATE_BROWSING_CONNECTED:
 	default:
 		return;
 	}
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index a20a7ad..cc47a1e 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -952,6 +952,7 @@ static gboolean parse_set_opts(struct mcap_mdl_cb *mdl_cb, GError **err,
 			c->mdl_reconn_req = va_arg(args,
 						mcap_remote_mdl_reconn_req_cb);
 			break;
+		case MCAP_MDL_CB_INVALID:
 		default:
 			g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
 						"Unknown option %d", cb);
-- 
1.9.1

