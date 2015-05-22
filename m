Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Move avdtp common  code into src/shared
Date: Fri, 22 May 2015 19:28:03 +0900
Message-id: <1432290483-2910-7-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
References: <1432290483-2910-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves avdtp common definition into src/shared.
---
 Makefile.am            |   1 +
 android/avdtp.c        | 240 +------------------------------------------------
 profiles/audio/avdtp.c | 240 +------------------------------------------------
 3 files changed, 3 insertions(+), 478 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 9e94648..2db0a4d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -108,6 +108,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/hci.h src/shared/hci.c \
 			src/shared/hci-crypto.h src/shared/hci-crypto.c \
 			src/shared/hfp.h src/shared/hfp.c \
+			src/shared/avdtp-common.h \
 			src/shared/uhid.h src/shared/uhid.c \
 			src/shared/pcap.h src/shared/pcap.c \
 			src/shared/btsnoop.h src/shared/btsnoop.c \
diff --git a/android/avdtp.c b/android/avdtp.c
index 7e61280..3bf2f23 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -45,245 +45,7 @@
 #include "src/shared/queue.h"
 #include "avdtp.h"
 #include "../profiles/audio/a2dp-codecs.h"
-
-#define MAX_SEID 0x3E
-static unsigned int seids;
-
-#ifndef MAX
-# define MAX(x, y) ((x) > (y) ? (x) : (y))
-#endif
-
-#define AVDTP_DISCOVER				0x01
-#define AVDTP_GET_CAPABILITIES			0x02
-#define AVDTP_SET_CONFIGURATION			0x03
-#define AVDTP_GET_CONFIGURATION			0x04
-#define AVDTP_RECONFIGURE			0x05
-#define AVDTP_OPEN				0x06
-#define AVDTP_START				0x07
-#define AVDTP_CLOSE				0x08
-#define AVDTP_SUSPEND				0x09
-#define AVDTP_ABORT				0x0A
-#define AVDTP_SECURITY_CONTROL			0x0B
-#define AVDTP_GET_ALL_CAPABILITIES		0x0C
-#define AVDTP_DELAY_REPORT			0x0D
-
-#define AVDTP_PKT_TYPE_SINGLE			0x00
-#define AVDTP_PKT_TYPE_START			0x01
-#define AVDTP_PKT_TYPE_CONTINUE			0x02
-#define AVDTP_PKT_TYPE_END			0x03
-
-#define AVDTP_MSG_TYPE_COMMAND			0x00
-#define AVDTP_MSG_TYPE_GEN_REJECT		0x01
-#define AVDTP_MSG_TYPE_ACCEPT			0x02
-#define AVDTP_MSG_TYPE_REJECT			0x03
-
-#define REQ_TIMEOUT 6
-#define ABORT_TIMEOUT 2
-#define DISCONNECT_TIMEOUT 1
-#define START_TIMEOUT 1
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-
-struct avdtp_common_header {
-	uint8_t message_type:2;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-} __attribute__ ((packed));
-
-struct avdtp_single_header {
-	uint8_t message_type:2;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-	uint8_t signal_id:6;
-	uint8_t rfa0:2;
-} __attribute__ ((packed));
-
-struct avdtp_start_header {
-	uint8_t message_type:2;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-	uint8_t no_of_packets;
-	uint8_t signal_id:6;
-	uint8_t rfa0:2;
-} __attribute__ ((packed));
-
-struct avdtp_continue_header {
-	uint8_t message_type:2;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-} __attribute__ ((packed));
-
-struct seid_info {
-	uint8_t rfa0:1;
-	uint8_t inuse:1;
-	uint8_t seid:6;
-	uint8_t rfa2:3;
-	uint8_t type:1;
-	uint8_t media_type:4;
-} __attribute__ ((packed));
-
-struct seid {
-	uint8_t rfa0:2;
-	uint8_t seid:6;
-} __attribute__ ((packed));
-
-#elif __BYTE_ORDER == __BIG_ENDIAN
-
-struct avdtp_common_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t message_type:2;
-} __attribute__ ((packed));
-
-struct avdtp_single_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t message_type:2;
-	uint8_t rfa0:2;
-	uint8_t signal_id:6;
-} __attribute__ ((packed));
-
-struct avdtp_start_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t message_type:2;
-	uint8_t no_of_packets;
-	uint8_t rfa0:2;
-	uint8_t signal_id:6;
-} __attribute__ ((packed));
-
-struct avdtp_continue_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t message_type:2;
-} __attribute__ ((packed));
-
-struct seid_info {
-	uint8_t seid:6;
-	uint8_t inuse:1;
-	uint8_t rfa0:1;
-	uint8_t media_type:4;
-	uint8_t type:1;
-	uint8_t rfa2:3;
-} __attribute__ ((packed));
-
-struct seid {
-	uint8_t seid:6;
-	uint8_t rfa0:2;
-} __attribute__ ((packed));
-
-#else
-#error "Unknown byte order"
-#endif
-
-/* packets */
-
-struct discover_resp {
-	struct seid_info seps[0];
-} __attribute__ ((packed));
-
-struct getcap_resp {
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct start_req {
-	struct seid first_seid;
-	struct seid other_seids[0];
-} __attribute__ ((packed));
-
-struct suspend_req {
-	struct seid first_seid;
-	struct seid other_seids[0];
-} __attribute__ ((packed));
-
-struct seid_rej {
-	uint8_t error;
-} __attribute__ ((packed));
-
-struct conf_rej {
-	uint8_t category;
-	uint8_t error;
-} __attribute__ ((packed));
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-
-struct seid_req {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-} __attribute__ ((packed));
-
-struct setconf_req {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-	uint8_t rfa1:2;
-	uint8_t int_seid:6;
-
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct stream_rej {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-	uint8_t error;
-} __attribute__ ((packed));
-
-struct reconf_req {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-
-	uint8_t serv_cap;
-	uint8_t serv_cap_len;
-
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct delay_req {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-	uint16_t delay;
-} __attribute__ ((packed));
-
-#elif __BYTE_ORDER == __BIG_ENDIAN
-
-struct seid_req {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-} __attribute__ ((packed));
-
-struct setconf_req {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-	uint8_t int_seid:6;
-	uint8_t rfa1:2;
-
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct stream_rej {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-	uint8_t error;
-} __attribute__ ((packed));
-
-struct reconf_req {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-
-	uint8_t serv_cap;
-	uint8_t serv_cap_len;
-
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct delay_req {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-	uint16_t delay;
-} __attribute__ ((packed));
-
-#else
-#error "Unknown byte order"
-#endif
+#include "src/shared/avdtp-internal.h"
 
 struct in_buf {
 	gboolean active;
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index b26f1ba..fa91cf6 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -45,6 +45,7 @@
 #include "src/log.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/avdtp-internal.h"
 #include "src/adapter.h"
 #include "src/device.h"
 
@@ -52,245 +53,6 @@
 #include "sink.h"
 #include "source.h"
 
-#define MAX_SEID 0x3E
-static unsigned int seids;
-
-#ifndef MAX
-# define MAX(x, y) ((x) > (y) ? (x) : (y))
-#endif
-
-#define AVDTP_DISCOVER				0x01
-#define AVDTP_GET_CAPABILITIES			0x02
-#define AVDTP_SET_CONFIGURATION			0x03
-#define AVDTP_GET_CONFIGURATION			0x04
-#define AVDTP_RECONFIGURE			0x05
-#define AVDTP_OPEN				0x06
-#define AVDTP_START				0x07
-#define AVDTP_CLOSE				0x08
-#define AVDTP_SUSPEND				0x09
-#define AVDTP_ABORT				0x0A
-#define AVDTP_SECURITY_CONTROL			0x0B
-#define AVDTP_GET_ALL_CAPABILITIES		0x0C
-#define AVDTP_DELAY_REPORT			0x0D
-
-#define AVDTP_PKT_TYPE_SINGLE			0x00
-#define AVDTP_PKT_TYPE_START			0x01
-#define AVDTP_PKT_TYPE_CONTINUE			0x02
-#define AVDTP_PKT_TYPE_END			0x03
-
-#define AVDTP_MSG_TYPE_COMMAND			0x00
-#define AVDTP_MSG_TYPE_GEN_REJECT		0x01
-#define AVDTP_MSG_TYPE_ACCEPT			0x02
-#define AVDTP_MSG_TYPE_REJECT			0x03
-
-#define REQ_TIMEOUT 6
-#define ABORT_TIMEOUT 2
-#define DISCONNECT_TIMEOUT 1
-#define START_TIMEOUT 1
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-
-struct avdtp_common_header {
-	uint8_t message_type:2;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-} __attribute__ ((packed));
-
-struct avdtp_single_header {
-	uint8_t message_type:2;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-	uint8_t signal_id:6;
-	uint8_t rfa0:2;
-} __attribute__ ((packed));
-
-struct avdtp_start_header {
-	uint8_t message_type:2;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-	uint8_t no_of_packets;
-	uint8_t signal_id:6;
-	uint8_t rfa0:2;
-} __attribute__ ((packed));
-
-struct avdtp_continue_header {
-	uint8_t message_type:2;
-	uint8_t packet_type:2;
-	uint8_t transaction:4;
-} __attribute__ ((packed));
-
-struct seid_info {
-	uint8_t rfa0:1;
-	uint8_t inuse:1;
-	uint8_t seid:6;
-	uint8_t rfa2:3;
-	uint8_t type:1;
-	uint8_t media_type:4;
-} __attribute__ ((packed));
-
-struct seid {
-	uint8_t rfa0:2;
-	uint8_t seid:6;
-} __attribute__ ((packed));
-
-#elif __BYTE_ORDER == __BIG_ENDIAN
-
-struct avdtp_common_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t message_type:2;
-} __attribute__ ((packed));
-
-struct avdtp_single_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t message_type:2;
-	uint8_t rfa0:2;
-	uint8_t signal_id:6;
-} __attribute__ ((packed));
-
-struct avdtp_start_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t message_type:2;
-	uint8_t no_of_packets;
-	uint8_t rfa0:2;
-	uint8_t signal_id:6;
-} __attribute__ ((packed));
-
-struct avdtp_continue_header {
-	uint8_t transaction:4;
-	uint8_t packet_type:2;
-	uint8_t message_type:2;
-} __attribute__ ((packed));
-
-struct seid_info {
-	uint8_t seid:6;
-	uint8_t inuse:1;
-	uint8_t rfa0:1;
-	uint8_t media_type:4;
-	uint8_t type:1;
-	uint8_t rfa2:3;
-} __attribute__ ((packed));
-
-struct seid {
-	uint8_t seid:6;
-	uint8_t rfa0:2;
-} __attribute__ ((packed));
-
-#else
-#error "Unknown byte order"
-#endif
-
-/* packets */
-
-struct discover_resp {
-	struct seid_info seps[0];
-} __attribute__ ((packed));
-
-struct getcap_resp {
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct start_req {
-	struct seid first_seid;
-	struct seid other_seids[0];
-} __attribute__ ((packed));
-
-struct suspend_req {
-	struct seid first_seid;
-	struct seid other_seids[0];
-} __attribute__ ((packed));
-
-struct seid_rej {
-	uint8_t error;
-} __attribute__ ((packed));
-
-struct conf_rej {
-	uint8_t category;
-	uint8_t error;
-} __attribute__ ((packed));
-
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-
-struct seid_req {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-} __attribute__ ((packed));
-
-struct setconf_req {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-	uint8_t rfa1:2;
-	uint8_t int_seid:6;
-
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct stream_rej {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-	uint8_t error;
-} __attribute__ ((packed));
-
-struct reconf_req {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-
-	uint8_t serv_cap;
-	uint8_t serv_cap_len;
-
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct delay_req {
-	uint8_t rfa0:2;
-	uint8_t acp_seid:6;
-	uint16_t delay;
-} __attribute__ ((packed));
-
-#elif __BYTE_ORDER == __BIG_ENDIAN
-
-struct seid_req {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-} __attribute__ ((packed));
-
-struct setconf_req {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-	uint8_t int_seid:6;
-	uint8_t rfa1:2;
-
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct stream_rej {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-	uint8_t error;
-} __attribute__ ((packed));
-
-struct reconf_req {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-
-	uint8_t serv_cap;
-	uint8_t serv_cap_len;
-
-	uint8_t caps[0];
-} __attribute__ ((packed));
-
-struct delay_req {
-	uint8_t acp_seid:6;
-	uint8_t rfa0:2;
-	uint16_t delay;
-} __attribute__ ((packed));
-
-#else
-#error "Unknown byte order"
-#endif
-
 struct in_buf {
 	gboolean active;
 	int no_of_packets;
-- 
2.1.4

