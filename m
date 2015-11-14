Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH 1/2] monitor/avctp: Fix typos
Date: Sat, 14 Nov 2015 13:28:57 +0100
Message-Id: <1447504138-3575-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 monitor/avctp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 232365e..a024a0f 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -64,7 +64,7 @@
 #define AVC_SUBUNIT_PRINTER		0x02
 #define AVC_SUBUNIT_DISC		0x03
 #define AVC_SUBUNIT_TAPE		0x04
-#define AVC_SUBUNIT_TURNER		0x05
+#define AVC_SUBUNIT_TUNER		0x05
 #define AVC_SUBUNIT_CA			0x06
 #define AVC_SUBUNIT_CAMERA		0x07
 #define AVC_SUBUNIT_PANEL		0x09
@@ -259,8 +259,8 @@ static const char *subunit2str(uint8_t subunit)
 		return "Disc";
 	case AVC_SUBUNIT_TAPE:
 		return "Tape";
-	case AVC_SUBUNIT_TURNER:
-		return "Turner";
+	case AVC_SUBUNIT_TUNER:
+		return "Tuner";
 	case AVC_SUBUNIT_CA:
 		return "CA";
 	case AVC_SUBUNIT_CAMERA:
@@ -268,7 +268,7 @@ static const char *subunit2str(uint8_t subunit)
 	case AVC_SUBUNIT_PANEL:
 		return "Panel";
 	case AVC_SUBUNIT_BULLETIN_BOARD:
-		return "Bulleting Board";
+		return "Bulletin Board";
 	case AVC_SUBUNIT_CAMERA_STORAGE:
 		return "Camera Storage";
 	case AVC_SUBUNIT_VENDOR_UNIQUE:
@@ -368,7 +368,7 @@ static const char *error2str(uint8_t status)
 	case AVRCP_STATUS_INVALID_SCOPE:
 		return "Invalid Scope";
 	case AVRCP_STATUS_OUT_OF_BOUNDS:
-		return "Range Out of Bonds";
+		return "Range Out of Bounds";
 	case AVRCP_STATUS_MEDIA_IN_USE:
 		return "Media in Use";
 	case AVRCP_STATUS_IS_DIRECTORY:
@@ -376,7 +376,7 @@ static const char *error2str(uint8_t status)
 	case AVRCP_STATUS_NOW_PLAYING_LIST_FULL:
 		return "Now Playing List Full";
 	case AVRCP_STATUS_SEARCH_NOT_SUPPORTED:
-		return "Seach Not Supported";
+		return "Search Not Supported";
 	case AVRCP_STATUS_SEARCH_IN_PROGRESS:
 		return "Search in Progress";
 	case AVRCP_STATUS_INVALID_PLAYER_ID:
@@ -520,9 +520,9 @@ static const char *value2str(uint8_t attr, uint8_t value)
 		case 0x01:
 			return "OFF";
 		case 0x02:
-			return "All Track Suffle";
+			return "All Track Shuffle";
 		case 0x03:
-			return "Group Suffle";
+			return "Group Shuffle";
 		default:
 			return "Reserved";
 		}
@@ -759,7 +759,7 @@ static const char *foldertype2str(uint8_t type)
 	case 0x01:
 		return "Titles";
 	case 0x02:
-		return "Albuns";
+		return "Albums";
 	case 0x03:
 		return "Artists";
 	case 0x04:
@@ -1425,7 +1425,7 @@ response:
 			printf("(UNPLUGGED)\n");
 			break;
 		default:
-			printf("(UNKOWN)\n");
+			printf("(UNKNOWN)\n");
 			break;
 		}
 		break;
-- 
2.6.2

