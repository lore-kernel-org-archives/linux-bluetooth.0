Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/13] obexd: List all enum values in switch
Date: Tue,  2 Dec 2014 18:28:33 +0100
Message-Id: <1417541318-24259-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
References: <1417541318-24259-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As described in coding style M10.
---
 obexd/client/map.c    | 2 ++
 obexd/plugins/vcard.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 76cf055..e6c1073 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1929,6 +1929,8 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	case MAP_ET_MESSAGE_SHIFT:
 		map_handle_folder_changed(map, event, event->folder);
 		break;
+	case MAP_ET_MEMORY_FULL:
+	case MAP_ET_MEMORY_AVAILABLE:
 	default:
 		break;
 	}
diff --git a/obexd/plugins/vcard.c b/obexd/plugins/vcard.c
index b36e4bf..aaa126b 100644
--- a/obexd/plugins/vcard.c
+++ b/obexd/plugins/vcard.c
@@ -574,6 +574,7 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 		else if (format == FORMAT_VCARD30)
 			category_string = "TYPE=INTERNET;TYPE=WORK";
 		break;
+	case FIELD_TYPE_OTHER:
 	default:
 		if (format == FORMAT_VCARD21)
 			category_string = "INTERNET";
@@ -616,6 +617,7 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 		else if (format == FORMAT_VCARD30)
 			category_string = "TYPE=INTERNET;TYPE=WORK";
 		break;
+	case FIELD_TYPE_OTHER:
 	default:
 		if (format == FORMAT_VCARD21)
 			category_string = "INTERNET";
-- 
1.9.1

