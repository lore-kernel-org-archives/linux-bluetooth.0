Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH v3 5/5] Add "unit test" for new UUID functions
Date: Mon, 14 Mar 2011 15:53:59 -0300
Message-Id: <1300128839-6293-6-git-send-email-epx@signove.com>
In-Reply-To: <1300128839-6293-1-git-send-email-epx@signove.com>
References: <1300128839-6293-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools  |    6 +-
 test/uuidtest.c |  319 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 324 insertions(+), 1 deletions(-)
 create mode 100644 test/uuidtest.c

diff --git a/Makefile.tools b/Makefile.tools
index 9c43202..1a1f5a1 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -142,7 +142,8 @@ bin_PROGRAMS += test/l2test test/rctest
 noinst_PROGRAMS += test/gaptest test/sdptest test/scotest \
 			test/attest test/hstest test/avtest test/ipctest \
 					test/lmptest test/bdaddr test/agent \
-					test/btiotest test/test-textfile
+					test/btiotest test/test-textfile \
+					test/uuidtest
 
 test_hciemu_LDADD = @GLIB_LIBS@ lib/libbluetooth.la
 
@@ -175,6 +176,9 @@ test_agent_LDADD = @DBUS_LIBS@
 test_btiotest_SOURCES = test/btiotest.c btio/btio.h btio/btio.c
 test_btiotest_LDADD = @GLIB_LIBS@ lib/libbluetooth.la
 
+test_uuidtest_SOURCES = test/uuidtest.c
+test_uuidtest_LDADD = lib/libbluetooth.la
+
 test_test_textfile_SOURCES = test/test-textfile.c src/textfile.h src/textfile.c
 
 dist_man_MANS += test/rctest.1 test/hciemu.1
diff --git a/test/uuidtest.c b/test/uuidtest.c
new file mode 100644
index 0000000..a8b46d7
--- /dev/null
+++ b/test/uuidtest.c
@@ -0,0 +1,319 @@
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/uuid.h>
+
+const char *base = "00000000-0000-1000-8000-00805F9B34FB";
+
+uint8_t xbase[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb};
+
+uint16_t sixteen = 0x1234;
+const char *uuidsixteen128 = "00001234-0000-1000-8000-00805F9B34FB";
+const char *uuidsixteen16 = "0x1234";
+const char *uuidsixteen16a = "1234";
+
+uint8_t xuuidsixteen[] = {0x00, 0x00, 0x12, 0x34, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb};
+
+uint32_t thirtytwo = 0x12345678;
+const char *uuidthirtytwo32 = "0x12345678";
+const char *uuidthirtytwo32a = "12345678";
+const char *uuidthirtytwo128 = "12345678-0000-1000-8000-00805F9B34FB";
+
+uint8_t xuuidthirtytwo[] = {0x12, 0x34, 0x56, 0x78, 0x00, 0x00, 0x10, 0x00,
+			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb};
+
+const char *malformed[] = {
+	"0",
+	"01",
+	"012",
+	"xxxx",
+	"xxxxx",
+	"0xxxxx",
+	"0123456",
+	"012g4567",
+	"012345678",
+	"0x234567u9",
+	"01234567890",
+	"00001234-0000-1000-8000-00805F9B34F",
+	"00001234-0000-1000-8000 00805F9B34FB",
+	"00001234-0000-1000-8000-00805F9B34FBC",
+	"00001234-0000-1000-800G-00805F9B34FB",
+	NULL,
+	};
+
+int main(int argc, char *argv[])
+{
+	bt_uuid_t u, u2, u3, u4, u5, ub, u128;
+	uint128_t n, i;
+	char buf[512];
+	int s;
+
+	memcpy(&n, xbase, 16);
+	ntoh128(&n, &i);
+
+	if (bt_string_to_uuid(&u, base)) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_string_to_uuid(&ub, base)) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u.type != 128) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (ub.type != 128) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (memcmp(&u.value.u128, &i, 16) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (memcmp(&ub.value.u128, &i, 16) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (memcmp(&ub.value.u128, &u.value.u128, 16) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u, &ub) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	bt_uuid_to_string(&u, buf, sizeof(buf));
+	/* printf("%s\n", buf); */
+
+	if (strcasecmp(buf, base) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	memcpy(&n, xuuidsixteen, 16);
+	ntoh128(&n, &i);
+
+	bt_uuid16_create(&u, sixteen);
+	bt_uuid_to_uuid128(&u, &u128);
+
+	if (bt_string_to_uuid(&u2, uuidsixteen16)) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_string_to_uuid(&u3, uuidsixteen16a)) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_string_to_uuid(&u4, uuidsixteen128)) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	bt_uuid128_create(&u5, i);
+
+	if (u.type != 16) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u128.type != 128) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u.value.u16 != sixteen) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u2.type != 16) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u3.type != 16) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u4.type != 128) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u5.type != 128) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u, &u2) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u2, &u3) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u, &u3) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u3, &u4) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u4, &u5) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u5, &u) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u, &ub) == 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u5, &ub) == 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u, &u128) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&ub, &u128) == 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	memcpy(&n, xuuidthirtytwo, 16);
+	ntoh128(&n, &i);
+
+	bt_uuid32_create(&u, thirtytwo);
+	bt_uuid_to_uuid128(&u, &u128);
+	bt_string_to_uuid(&u2, uuidthirtytwo32);
+	bt_string_to_uuid(&u3, uuidthirtytwo32a);
+	bt_string_to_uuid(&u4, uuidthirtytwo128);
+	bt_uuid128_create(&u5, i);
+
+	/*
+	bt_uuid_to_string(&u2, buf, sizeof(buf));
+	printf("%s\n", buf);
+
+	bt_uuid_to_string(&u3, buf, sizeof(buf));
+	printf("%s\n", buf);
+
+	bt_uuid_to_string(&u4, buf, sizeof(buf));
+	printf("%s\n", buf);
+	*/
+
+	if (u.type != 32) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u128.type != 128) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u.value.u32 != thirtytwo) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u2.type != 32) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u3.type != 32) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u4.type != 128) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (u5.type != 128) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u, &u2) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u2, &u3) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u3, &u4) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u4, &u5) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u5, &u) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u, &ub) == 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u5, &ub) == 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&u, &u128) != 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	if (bt_uuid_cmp(&ub, &u128) == 0) {
+		printf("Fail %d\n", __LINE__);
+		return 1;
+	}
+
+	for (s = 0; malformed[s]; ++s) {
+		if (bt_string_to_uuid(&u3, malformed[s]) == 0) {
+			printf("Fail %s %d\n", malformed[s], __LINE__);
+			return 1;
+		}
+	}
+
+	return 0;
+}
-- 
1.7.1

