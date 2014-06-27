Return-Path: <cyrus@holtmann.org>
From: Scott James Remnant <scott@netsplit.com>
To: linux-bluetooth@vger.kernel.org
Cc: Scott James Remnant <scott@netsplit.com>
Subject: [RFC] doc: Add EIR to device properties
Date: Fri, 27 Jun 2014 12:31:32 -0700
Message-Id: <1403897492-6233-1-git-send-email-scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch proposes an extension to the D-Bus Device API to allow
an application access to the last EIR data received from a device
in inquiry or advertising mode.

Rationale is that increasing numbers of LE profiles are using custom
fields in the advertising and scan response reports to carry important
information. e.g. the Anki Drive peripherals include necessary
information in the advertiesment that is not replicated in the GATT
Service they export.

It would be nice if it were possible to support these profiles at the
application layer without extending BlueZ every time via a plugin.

Since EIR has a variable-length type field, more complex parsing
would require applications registering the types with BlueZ in advance
putting a higher complexity burden on the daemon, including resolving
conflicts where types overlap. Exposing the raw EIR data to the
application allows them to deal with all such problems in whatever
manner they require.
---
 doc/device-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 577ee60..9620ec0 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -193,3 +193,8 @@ Properties	string Address [readonly]
 
 			Received Signal Strength Indicator of the remote
 			device (inquiry or advertising).
+
+		array{byte} EIR [readonly, optional]
+
+			Last received EIR data from the remote device
+			during inquiry or advertising.
-- 
1.9.3 (Apple Git-50)

