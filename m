Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/13] android: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:35 +0100
Message-Id: <1417541318-24259-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 android/avdtp.c            |  3 +++
 android/avdtptest.c        |  1 +
 android/client/if-bt.c     | 28 +++++++++++++++++++++++++++
 android/gatt.c             |  1 +
 android/hal-bluetooth.c    | 15 +++++++++++++++
 android/hal-utils.c        |  2 ++
 android/handsfree-client.c |  3 +++
 android/system/audio.h     | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 101 insertions(+)

diff --git a/android/avdtp.c b/android/avdtp.c
index 9f2527f..853fdf3 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -1765,6 +1765,9 @@ static gboolean avdtp_delayreport_cmd(struct avdtp *session,
 	case AVDTP_STATE_CLOSING:
 		err = AVDTP_BAD_STATE;
 		goto failed;
+	case AVDTP_STATE_CONFIGURED:
+	case AVDTP_STATE_OPEN:
+	case AVDTP_STATE_STREAMING:
 	default:
 		break;
 	}
diff --git a/android/avdtptest.c b/android/avdtptest.c
index a56b9c0..ce39519 100644
--- a/android/avdtptest.c
+++ b/android/avdtptest.c
@@ -141,6 +141,7 @@ static void send_command(void)
 	case CMD_DELAY:
 		avdtp_delay_report(avdtp , avdtp_stream , 250);
 		break;
+	case CMD_NONE:
 	default:
 		break;
 	}
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 4f1a9d9..776098e 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -289,6 +289,8 @@ static void ssp_request_cb(bt_bdaddr_t *remote_bd_addr, bt_bdname_t *bd_name,
 
 		terminal_prompt_for(prompt, ssp_request_yes_no_answer);
 		break;
+	case BT_SSP_VARIANT_PASSKEY_ENTRY:
+	case BT_SSP_VARIANT_PASSKEY_NOTIFICATION:
 	default:
 		haltest_info("Not automatically handled\n");
 		break;
@@ -554,6 +556,19 @@ static void set_adapter_property_p(int argc, const char **argv)
 		property.len = sizeof(timeout);
 		break;
 
+	case BT_PROPERTY_BDADDR:
+	case BT_PROPERTY_UUIDS:
+	case BT_PROPERTY_CLASS_OF_DEVICE:
+	case BT_PROPERTY_TYPE_OF_DEVICE:
+	case BT_PROPERTY_SERVICE_RECORD:
+	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
+	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
+	case BT_PROPERTY_REMOTE_RSSI:
+	case BT_PROPERTY_REMOTE_VERSION_INFO:
+	case BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP:
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	case BT_PROPERTY_LOCAL_LE_FEATURES:
+#endif
 	default:
 		haltest_error("Invalid property %s\n", argv[3]);
 		return;
@@ -630,6 +645,19 @@ static void set_remote_device_property_p(int argc, const char **argv)
 		property.len = strlen(argv[4]);
 		property.val = (char *) argv[4];
 		break;
+	case BT_PROPERTY_BDNAME:
+	case BT_PROPERTY_BDADDR:
+	case BT_PROPERTY_UUIDS:
+	case BT_PROPERTY_CLASS_OF_DEVICE:
+	case BT_PROPERTY_TYPE_OF_DEVICE:
+	case BT_PROPERTY_SERVICE_RECORD:
+	case BT_PROPERTY_ADAPTER_SCAN_MODE:
+	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
+	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
+	case BT_PROPERTY_REMOTE_RSSI:
+	case BT_PROPERTY_REMOTE_VERSION_INFO:
+	case BT_PROPERTY_LOCAL_LE_FEATURES:
+	case BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP:
 	default:
 		return;
 	}
diff --git a/android/gatt.c b/android/gatt.c
index b9b3c7b..3cf4f67 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -5146,6 +5146,7 @@ static uint32_t add_sdp_record(const bt_uuid_t *uuid, uint16_t start,
 	case BT_UUID128:
 		sdp_uuid128_create(&u, &uuid->value.u128);
 		break;
+	case BT_UUID_UNSPEC:
 	default:
 		return 0;
 	}
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index cceb196..b13cffe 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -116,6 +116,21 @@ static void adapter_prop_from_hal(const bt_property_t *property, uint8_t *type,
 	case HAL_PROP_ADAPTER_SCAN_MODE:
 		enum_prop_from_hal(property, len, val, bt_scan_mode_t);
 		break;
+	case BT_PROPERTY_BDNAME:
+	case BT_PROPERTY_BDADDR:
+	case BT_PROPERTY_UUIDS:
+	case BT_PROPERTY_CLASS_OF_DEVICE:
+	case BT_PROPERTY_TYPE_OF_DEVICE:
+	case BT_PROPERTY_SERVICE_RECORD:
+	case BT_PROPERTY_ADAPTER_BONDED_DEVICES:
+	case BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT:
+	case BT_PROPERTY_REMOTE_FRIENDLY_NAME:
+	case BT_PROPERTY_REMOTE_RSSI:
+	case BT_PROPERTY_REMOTE_VERSION_INFO:
+	case BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP:
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	case BT_PROPERTY_LOCAL_LE_FEATURES:
+#endif
 	default:
 		*len = property->len;
 		memcpy(val, property->val, property->len);
diff --git a/android/hal-utils.c b/android/hal-utils.c
index f18a82c..004d89d 100644
--- a/android/hal-utils.c
+++ b/android/hal-utils.c
@@ -395,6 +395,8 @@ const char *btproperty2str(const bt_property_t *property)
 		}
 		break;
 #endif
+	case BT_PROPERTY_REMOTE_VERSION_INFO:
+	case BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP:
 	default:
 		sprintf(p, "%p", property->val);
 	}
diff --git a/android/handsfree-client.c b/android/handsfree-client.c
index 9818a47..a81830c 100644
--- a/android/handsfree-client.c
+++ b/android/handsfree-client.c
@@ -428,6 +428,9 @@ static void cmd_complete_cb(enum hfp_result result, enum hfp_error cme_err,
 		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR_CME;
 		ev.cme = cme_err;
 		break;
+	case HFP_RESULT_CONNECT:
+	case HFP_RESULT_RING:
+	case HFP_RESULT_NO_DIALTONE:
 	default:
 		error("hf-client: Unknown error code %d", result);
 		ev.type = HAL_HF_CLIENT_CMD_COMP_ERR;
diff --git a/android/system/audio.h b/android/system/audio.h
index 1d045b3..d2da76d 100644
--- a/android/system/audio.h
+++ b/android/system/audio.h
@@ -1295,6 +1295,30 @@ static inline bool audio_is_valid_format(audio_format_t format)
         case AUDIO_FORMAT_PCM_FLOAT:
         case AUDIO_FORMAT_PCM_24_BIT_PACKED:
             return true;
+        case AUDIO_FORMAT_INVALID:
+        case AUDIO_FORMAT_DEFAULT:
+        case AUDIO_FORMAT_MP3:
+        case AUDIO_FORMAT_AMR_NB:
+        case AUDIO_FORMAT_AMR_WB:
+        case AUDIO_FORMAT_AAC:
+        case AUDIO_FORMAT_HE_AAC_V1:
+        case AUDIO_FORMAT_HE_AAC_V2:
+        case AUDIO_FORMAT_VORBIS:
+        case AUDIO_FORMAT_OPUS:
+        case AUDIO_FORMAT_AC3:
+        case AUDIO_FORMAT_E_AC3:
+        case AUDIO_FORMAT_MAIN_MASK:
+        case AUDIO_FORMAT_SUB_MASK:
+        case AUDIO_FORMAT_AAC_MAIN:
+        case AUDIO_FORMAT_AAC_LC:
+        case AUDIO_FORMAT_AAC_SSR:
+        case AUDIO_FORMAT_AAC_LTP:
+        case AUDIO_FORMAT_AAC_HE_V1:
+        case AUDIO_FORMAT_AAC_SCALABLE:
+        case AUDIO_FORMAT_AAC_ERLC:
+        case AUDIO_FORMAT_AAC_LD:
+        case AUDIO_FORMAT_AAC_HE_V2:
+        case AUDIO_FORMAT_AAC_ELD:
         default:
             return false;
         }
@@ -1341,6 +1365,30 @@ static inline size_t audio_bytes_per_sample(audio_format_t format)
     case AUDIO_FORMAT_PCM_FLOAT:
         size = sizeof(float);
         break;
+    case AUDIO_FORMAT_INVALID:
+    case AUDIO_FORMAT_DEFAULT:
+    case AUDIO_FORMAT_MP3:
+    case AUDIO_FORMAT_AMR_NB:
+    case AUDIO_FORMAT_AMR_WB:
+    case AUDIO_FORMAT_AAC:
+    case AUDIO_FORMAT_HE_AAC_V1:
+    case AUDIO_FORMAT_HE_AAC_V2:
+    case AUDIO_FORMAT_VORBIS:
+    case AUDIO_FORMAT_OPUS:
+    case AUDIO_FORMAT_AC3:
+    case AUDIO_FORMAT_E_AC3:
+    case AUDIO_FORMAT_MAIN_MASK:
+    case AUDIO_FORMAT_SUB_MASK:
+    case AUDIO_FORMAT_AAC_MAIN:
+    case AUDIO_FORMAT_AAC_LC:
+    case AUDIO_FORMAT_AAC_SSR:
+    case AUDIO_FORMAT_AAC_LTP:
+    case AUDIO_FORMAT_AAC_HE_V1:
+    case AUDIO_FORMAT_AAC_SCALABLE:
+    case AUDIO_FORMAT_AAC_ERLC:
+    case AUDIO_FORMAT_AAC_LD:
+    case AUDIO_FORMAT_AAC_HE_V2:
+    case AUDIO_FORMAT_AAC_ELD:
     default:
         break;
     }
-- 
1.9.1

