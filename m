Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH] android/build: Fix build for kitkat
Date: Fri, 14 Nov 2014 16:04:03 +0100
Message-Id: <1415977443-16255-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix missing kitkat build failure:
external/bluetooth/bluez/android/client/if-hf.c: At top level:
external/bluetooth/bluez/android/client/if-hf.c:108:1: error: unknown
type name 'bthf_wbs_config_t'
external/bluetooth/bluez/android/client/if-hf.c:108:1: error: unknown
type name 'bthf_wbs_config_t'
external/bluetooth/bluez/android/client/if-hf.c: In function
'str2bthf_wbs_config_t':
external/bluetooth/bluez/android/client/if-hf.c:108:1: error:
'bthf_wbs_config_t' undeclared (first use in this function)
external/bluetooth/bluez/android/client/if-hf.c:108:1: note: each
undeclared identifier is reported only once for each function it appears
in
external/bluetooth/bluez/android/client/if-hf.c: At top level:
external/bluetooth/bluez/android/client/if-hf.c:109:2: error:
'BTHF_WBS_NONE' undeclared here (not in a function)
external/bluetooth/bluez/android/client/if-hf.c:110:2: error:
'BTHF_WBS_NO' undeclared here (not in a function)
external/bluetooth/bluez/android/client/if-hf.c:111:2: error:
'BTHF_WBS_YES' undeclared here (not in a function)
make: ***
[out/target/product/hammerhead/obj/EXECUTABLES/haltest_intermediates/bluez/android/client/if-hf.o]
Error 1
---
 android/client/if-hf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index d24612a..6b798f8 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -105,11 +105,13 @@ SINTMAP(bthf_call_addrtype_t, -1, "(unknown)")
 	DELEMENT(BTHF_CALL_ADDRTYPE_INTERNATIONAL),
 ENDMAP
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 SINTMAP(bthf_wbs_config_t, -1, "(unknown)")
 	DELEMENT(BTHF_WBS_NONE),
 	DELEMENT(BTHF_WBS_NO),
 	DELEMENT(BTHF_WBS_YES),
 ENDMAP
+#endif
 
 /* Callbacks */
 
-- 
1.9.1

