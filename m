Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Check for minimum data length in eir_has_data_type()
Date: Mon, 26 Mar 2012 14:21:42 +0300
Message-Id: <1332760902-16071-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1332760902-16071-1-git-send-email-johan.hedberg@gmail.com>
References: <1332760902-16071-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If passed 0 as data_length the (parsed < data_length - 1) test will be
true and cause a buffer overflow. In practice we need at least two bytes
for the element length and type so add a test for it to the very
beginning of the function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 83cd301..fa2c778 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -913,6 +913,9 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 {
 	size_t parsed = 0;
 
+	if (data_len < 2)
+		return false;
+
 	while (parsed < data_len - 1) {
 		u8 field_len = data[0];
 
-- 
1.7.9.1

