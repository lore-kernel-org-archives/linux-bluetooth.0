Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] monitor: Opencode strndupa in print_string
Date: Wed, 31 Jul 2013 10:51:39 +0200
Message-ID: <1375260699-7271-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Strndupa is GNU extension. print_string is simple and opencoding
strndupa is not a big loss.

This fix linkage error with bionic library which doesn't provide
strndupa.

target Executable: btmon (out/target/product/grouper/obj/EXECUTABLES/
    btmon_intermediates/LINKED/btmon)
prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.6/bin/../lib/gcc/
    arm-linux-androideabi/4.6.x-google/../../../../
    arm-linux-androideabi/bin/ld: out/target/product/grouper/obj/
    EXECUTABLES/btmon_intermediates/monitor/sdp.o: in function
    print_string:external/bluetooth/bluez/monitor/sdp.c:146: error:
    undefined reference to 'strndupa'
collect2: ld returned 1 exit status
make: *** [out/target/product/grouper/obj/EXECUTABLES/
    btmon_intermediates/LINKED/btmon] Error
---
 monitor/sdp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/monitor/sdp.c b/monitor/sdp.c
index 45ee59b..4eb398b 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -143,7 +143,11 @@ static void print_uuid(uint8_t indent, const uint8_t *data, uint32_t size)
 
 static void print_string(uint8_t indent, const uint8_t *data, uint32_t size)
 {
-	char *str = strndupa((const char *) data, size);
+	char *str = alloca(size + 1);
+
+	str[size] = '\0';
+	strncpy(str, (const char *) data, size);
+
 	print_field("%*c%s [len %d]", indent, ' ', str, size);
 }
 
-- 
1.8.3.4

