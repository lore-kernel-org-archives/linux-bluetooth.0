Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: Scott James Remnant <scott@netsplit.com>
Subject: [PATCH 1/2] core: don't set BR/EDR support when no flags present
Date: Thu,  3 Apr 2014 15:27:33 -0700
Message-Id: <1396564054-20566-1-git-send-email-scott@netsplit.com>
In-Reply-To: <CAHZ1yCmu26xibOaeGUP3HGhp7cvC0eXuviJBRq2VDD0fE6U6SQ@mail.gmail.com>
References: <CAHZ1yCmu26xibOaeGUP3HGhp7cvC0eXuviJBRq2VDD0fE6U6SQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The logic for setting the BR/EDR supported flag checked for the
non-presence of the BR/EDR Unsupported flag without checking whether
any flags were present at all.

This meant all LE-only devices that returned Scan Response Data were
being marked as supporting BR/EDR, since the flag was only set in the
initial AD and not the SRD.
---
 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index e396a3d..b8b9a9c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4342,7 +4342,8 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	device_update_last_seen(dev, bdaddr_type);
 
-	if (bdaddr_type != BDADDR_BREDR && !(eir_data.flags & EIR_BREDR_UNSUP))
+	if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
+					!(eir_data.flags & EIR_BREDR_UNSUP))
 		device_set_bredr_support(dev, true);
 
 	if (eir_data.name != NULL && eir_data.name_complete)
-- 
1.9.1.423.g4596e3a

