Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 06/11] attrib: Fix coding style for various enc_*/dec_* functions
Date: Fri, 19 Jul 2013 13:34:12 -0400
Message-Id: <1374255257-8753-7-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1374255257-8753-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Fix coding style for enc_read_blob(), enc_read_blob_resp(),
dec_read_resp(), enc_error_resp(), enc_find_info_req(),
enc_find_info_resp() and enc_prep_write().
---
 attrib/att.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index d2b78bd..675deb6 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -597,7 +597,7 @@ uint16_t enc_read_req(uint16_t handle, uint8_t *pdu, size_t len)
 }
 
 uint16_t enc_read_blob_req(uint16_t handle, uint16_t offset, uint8_t *pdu,
-									size_t len)
+								size_t len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
 							sizeof(offset);
@@ -682,7 +682,7 @@ uint16_t enc_read_resp(uint8_t *value, size_t vlen, uint8_t *pdu, size_t len)
 }
 
 uint16_t enc_read_blob_resp(uint8_t *value, size_t vlen, uint16_t offset,
-							uint8_t *pdu, size_t len)
+						uint8_t *pdu, size_t len)
 {
 	if (pdu == NULL)
 		return 0;
@@ -698,7 +698,8 @@ uint16_t enc_read_blob_resp(uint8_t *value, size_t vlen, uint16_t offset,
 	return vlen + 1;
 }
 
-ssize_t dec_read_resp(const uint8_t *pdu, size_t len, uint8_t *value, size_t vlen)
+ssize_t dec_read_resp(const uint8_t *pdu, size_t len, uint8_t *value,
+								size_t vlen)
 {
 	if (pdu == NULL)
 		return -EINVAL;
@@ -718,7 +719,7 @@ ssize_t dec_read_resp(const uint8_t *pdu, size_t len, uint8_t *value, size_t vle
 }
 
 uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
-							uint8_t *pdu, size_t len)
+						uint8_t *pdu, size_t len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(opcode) +
 						sizeof(handle) + sizeof(status);
@@ -736,7 +737,8 @@ uint16_t enc_error_resp(uint8_t opcode, uint16_t handle, uint8_t status,
 	return min_len;
 }
 
-uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu, size_t len)
+uint16_t enc_find_info_req(uint16_t start, uint16_t end, uint8_t *pdu,
+								size_t len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(start) + sizeof(end);
 
@@ -777,7 +779,7 @@ uint16_t dec_find_info_req(const uint8_t *pdu, size_t len, uint16_t *start,
 }
 
 uint16_t enc_find_info_resp(uint8_t format, struct att_data_list *list,
-							uint8_t *pdu, size_t len)
+						uint8_t *pdu, size_t len)
 {
 	uint8_t *ptr;
 	size_t i, w;
@@ -995,7 +997,8 @@ uint16_t dec_mtu_resp(const uint8_t *pdu, size_t len, uint16_t *mtu)
 }
 
 uint16_t enc_prep_write_req(uint16_t handle, uint16_t offset,
-			const uint8_t *value, size_t vlen, uint8_t *pdu, size_t len)
+					const uint8_t *value, size_t vlen,
+					uint8_t *pdu, size_t len)
 {
 	const uint16_t min_len = sizeof(pdu[0]) + sizeof(handle) +
 								sizeof(offset);
-- 
1.7.9.5

