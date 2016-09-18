Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 5/6] Bluetooth: Fix advertising instance validity check for flags
Date: Sun, 18 Sep 2016 12:50:06 +0200
Message-Id: <1474195807-12310-5-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Flags are not allowed in Scan Response.

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cdc88f4..61e8153 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6067,7 +6067,8 @@ static bool tlv_data_is_valid(u32 adv_flags, u8 *data, u8 len, bool is_adv_data)
 	for (i = 0, cur_len = 0; i < len; i += (cur_len + 1)) {
 		cur_len = data[i];
 
-		if (data[i + 1] == EIR_FLAGS && flags_managed(adv_flags))
+		if (data[i + 1] == EIR_FLAGS &&
+		    (!is_adv_data || flags_managed(adv_flags)))
 			return false;
 
 		if (data[i + 1] == EIR_TX_POWER && tx_power_managed(adv_flags))
-- 
2.7.4

