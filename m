Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: fix spelling mistake: "advetising" -> "advertising"
Date: Wed, 28 Dec 2016 21:17:54 +0000
Message-Id: <20161228211754.6714-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in BT_ERR_RATELIMITED error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e17aacb..0b4dba0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4749,7 +4749,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	case LE_ADV_SCAN_RSP:
 		break;
 	default:
-		BT_ERR_RATELIMITED("Unknown advetising packet type: 0x%02x",
+		BT_ERR_RATELIMITED("Unknown advertising packet type: 0x%02x",
 				   type);
 		return;
 	}
-- 
2.10.2
