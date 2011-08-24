Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Aug 2011 10:04:56 -0400
Subject: [RFC 1/4] Bluetooth: Add LE link type for debugfs output
Message-ID: <1314194696.2219.14.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add LE link type as known connection type for debugfs stringizing
output.
---
 net/bluetooth/hci_sysfs.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index a6c3aa8..22f1a6c 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -23,6 +23,8 @@ static inline char *link_typetostr(int type)
 		return "SCO";
 	case ESCO_LINK:
 		return "eSCO";
+	case LE_LINK:
+		return "LE";
 	default:
 		return "UNKNOWN";
 	}
-- 
1.7.4.1

