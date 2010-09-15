Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: par-gunnar.p.hjalmdahl@stericsson.com,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC] D-Bus API for out of band association model
Date: Wed, 15 Sep 2010 09:58:47 +0200
Message-Id: <1284537527-22783-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On behalf of ST-Ericsson SA, below is our proposal of API for out of band
association model. To give you a bit more overview how this will be integrated
into BlueZ:

.RequestRemoteOobData should be called from hcid_dbus_request_io_cap to
check if any data was exchange/retrieved from remote device. Returned data
will be stored (if any) and used to reply with proper IO capabilities as well
as to to return retrieved data. This will involve some changes in flow from
io_capa_request onwards.

Please let me know if you have any comments. Implementation will follow.

BR,
Andrzej


---
 doc/adapter-api.txt |   14 ++++++++++++++
 doc/agent-api.txt   |   14 ++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 6098c76..0dd628e 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -5,6 +5,7 @@ Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
 Copyright (C) 2005-2006  Johan Hedberg <johan.hedberg@nokia.com>
 Copyright (C) 2005-2006  Claudio Takahasi <claudio.takahasi@indt.org.br>
 Copyright (C) 2006-2007  Luiz von Dentz <luiz.dentz@indt.org.br>
+Copyright (C) 2010       ST-Ericsson SA <andrzej.kaczmarek@tieto.com>
 
 
 Adapter hierarchy
@@ -173,6 +174,19 @@ Methods		dict GetProperties()
 
 			Possible errors: org.bluez.Error.DoesNotExist
 
+		struct{
+			array{byte}, array{byte}
+		} GetLocalOobData()
+
+			Retrieves current C and R values used for out-of-band
+			bonding association model.
+
+			The return value is struct containing two arrays of
+			bytes, C and R values retrieved from local device.
+
+			Possible errors: org.bluez.Error.InProgress
+					 org.bluez.Error.Failed
+
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index d8d35c0..323ccf1 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -3,6 +3,7 @@ BlueZ D-Bus Agent API description
 
 Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
 Copyright (C) 2005-2006  Johan Hedberg <johan.hedberg@nokia.com>
+Copyright (C) 2010       ST-Ericsson SA <andrzej.kaczmarek@tieto.com>
 
 
 Agent hierarchy
@@ -68,6 +69,19 @@ Methods		void Release()
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
 
+		struct{
+			array{byte}, array{byte}
+		} RequestRemoteOobData(object device)
+
+			This method gets called when the service daemon
+			needs out-of-band data for an authentication.
+
+			The return value should be struct containing two
+			arrays of bytes, C and R values retrieved from
+			remote device.
+
+			Possible errors: org.bluez.Error.NoData
+
 		void Authorize(object device, string uuid)
 
 			This method gets called when the service daemon
-- 
1.7.0.4

