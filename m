Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 10/11] android/hid: Handle invalid parameters in hal
Date: Tue,  5 Nov 2013 00:20:14 +0200
Message-Id: <1383603615-9953-11-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 45767b8..412258c 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -204,9 +204,8 @@ static bt_status_t hh_get_protocol(bt_bdaddr_t *bd_addr,
 	case BTHH_BOOT_MODE:
 		cmd.mode = HAL_HID_BOOT_PROTOCOL;
 		break;
-	case BTHH_UNSUPPORTED_MODE:
-		cmd.mode = HAL_HID_UNSUPPORTED_PROTOCOL;
-		break;
+	default:
+		return BT_STATUS_PARM_INVALID;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
@@ -236,9 +235,8 @@ static bt_status_t hh_set_protocol(bt_bdaddr_t *bd_addr,
 	case BTHH_BOOT_MODE:
 		cmd.mode = HAL_HID_BOOT_PROTOCOL;
 		break;
-	case BTHH_UNSUPPORTED_MODE:
-		cmd.mode = HAL_HID_UNSUPPORTED_PROTOCOL;
-		break;
+	default:
+		return BT_STATUS_PARM_INVALID;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST,
@@ -275,6 +273,8 @@ static bt_status_t hh_get_report(bt_bdaddr_t *bd_addr,
 	case BTHH_FEATURE_REPORT:
 		cmd.type = HAL_HID_FEATURE_REPORT;
 		break;
+	default:
+		return BT_STATUS_PARM_INVALID;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_GET_REPORT,
@@ -308,6 +308,8 @@ static bt_status_t hh_set_report(bt_bdaddr_t *bd_addr,
 	case BTHH_FEATURE_REPORT:
 		cmd.type = HAL_HID_FEATURE_REPORT;
 		break;
+	default:
+		return BT_STATUS_PARM_INVALID;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_HIDHOST, HAL_OP_HID_SET_REPORT,
-- 
1.8.1.2

