Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Add Link Loss Alert for Proximity Reporter API
Date: Thu, 19 Jan 2012 15:38:22 -0300
Message-Id: <1326998302-2297-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1326486016-755-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1326486016-755-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PropertyChanged signal for LinkLossAlertLevel property is emitted when
a given remote device writes a new value for the Alert Level characteristic
in the local Link Loss service. Each platform is free to define the actions
for the detected signal.
---
 doc/proximity-api.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/doc/proximity-api.txt b/doc/proximity-api.txt
index 3e49149..0c60d47 100644
--- a/doc/proximity-api.txt
+++ b/doc/proximity-api.txt
@@ -82,3 +82,9 @@ Properties
 			was changed by the remote device. Property shared
 			between Path Loss and Find Me. Values: "none", "mild",
 			"high".
+
+		string LinkLossAlertLevel [readonly]
+
+			This property indicates that Alert Level characteristic
+			in the local Link Loss Service was changed by the
+			remote device. Values: "none", "mild", "high".
-- 
1.7.8.1

