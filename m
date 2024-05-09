Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6080055
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 21:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290977; cv=none; b=sWhfX9/hPb1ouzvK4jLSF6QXbZVdjSImQiHiIO5VV9B9mjsG+Km4TdQ0L5kAySZ8J1SkS+TZIc9igOD2zQ7Yyj6xXEckgF4ohHEUJUGX6fPn+PgEschNgRfXLt5mPsQIUm+kVlqMQ6CCqvGFzpxQewxfJHg4Wt67xm6FffYav3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290977; c=relaxed/simple;
	bh=ep5HG7ocdmwDg+JEg8KkElUN1ZX6Newh+r5Dv/bopsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDdoG8+QY/g5MEN5LIAkXuk/HYp505tat3tmrIHDZ9TMm7KncengA2vb24uPOjxtBn7rtjHytg0aA7TQ8eLnxfb2pCkb2uAgCTDj8LkNGm8FrPmfTbTW/ZVwyW5uCXkDuhcCRfSYxrzEIdej9phG99r4BEkera9QBCo0MEhr7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com; spf=pass smtp.mailfrom=prestonhunt.com; dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b=CnUSQ5y3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b="CnUSQ5y3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b4952a1aecso1046389a91.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestonhunt-com.20230601.gappssmtp.com; s=20230601; t=1715290974; x=1715895774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux8Mps/K7Xuox2Zey8Eus3v2m5a77QJgt2BRbr7nCiU=;
        b=CnUSQ5y3q7doM6T/ZlHc50yy+IRXONwlDhweMzAvHTKkM2bNv0j1kYHOjLKa4wVOQd
         wPL8jvR9eoh3xPbRGIQUJEL3Cr73p/zdMpaGPsY1CxBxp/AO4vi+Fj34UXTgJN+ltF9Y
         KKhcQx8MH6vHHQ9E+ddJRNpSNls8BErjuPPEKGK79AwDj3wXNjdjgMRdI/1REqB83LLe
         yXKpLzThsyi1atiKKIu8pE8XeM1/YnIF8mCZ2jY1lEGcB992IyZUK3QuUxOW9ARJjAIT
         sV7dF/0TQ8J8uMnRR8t9m+PSZhVv6ElNv+LpTlu4jNlaQhcjVQ4RcripOoFxmfEqQHim
         1TZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290974; x=1715895774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux8Mps/K7Xuox2Zey8Eus3v2m5a77QJgt2BRbr7nCiU=;
        b=BwViKmo6F43lefwI/WXmERtWyJ6k+Amc5EKATZ+PpycQUifxVB7gYiyUpjsdKQUtj3
         aePLkFKuEPv75bpsODscSSI95FZd/Pc0lKFTzj9pVMwVQ0/pne4Mjz0lKh4FYgcJnez/
         5V35W23RSw6WzNwo+26PgSeeU/YEgb7TbxLbs8wCL1BzyhSSYngUiZpyZbkODsdqlR3N
         0i3Vy9eXcOSDduhNocsQxrKIZnWWKPbLxwp8hdBxT098u3TbpGBqbKalTj6xzRJ9nwnH
         qmaIe6GAGM6AuNKgxu0XWqqCRRKzYeRakhGLBibBwM/eTn6c/McpOZ2V938VizYpA1+L
         fjpg==
X-Gm-Message-State: AOJu0YzeG534tFyXpYims3/qzGGn537eOJTxd8Eo3kT5Es33206BqUas
	diHfDxHBsY2AI4TSCxQZkGFKGzo0MM+Q3eA2YbdUYNA8r4epzaewBZFIZH5IdLpAtCu8eoYKMX6
	F
X-Google-Smtp-Source: AGHT+IG5pn9rvN+wu4GZrrnvzihjeUnxgnu8O5j4cHYnkJcDH2ZKdSLVraK0GeJwCiF5Oqo3KiHngQ==
X-Received: by 2002:a17:90b:3118:b0:2b2:c2dd:9cb0 with SMTP id 98e67ed59e1d1-2b6ccd85e94mr687650a91.43.1715290974196;
        Thu, 09 May 2024 14:42:54 -0700 (PDT)
Received: from localhost.localdomain (97-115-125-150.ptld.qwest.net. [97.115.125.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea59absm3817455a91.47.2024.05.09.14.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 14:42:53 -0700 (PDT)
From: Preston Hunt <me@prestonhunt.com>
To: linux-bluetooth@vger.kernel.org
Cc: Preston Hunt <me@prestonhunt.com>
Subject: [PATCH BlueZ 1/1] test examples: fix python3 errors
Date: Thu,  9 May 2024 14:42:31 -0700
Message-ID: <20240509214231.2783781-2-me@prestonhunt.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240509214231.2783781-1-me@prestonhunt.com>
References: <20240509214231.2783781-1-me@prestonhunt.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These scripts have "#!/usr/bin/env python3" but have python2 syntax in
several places. Fixed by running the "2to3" utility.
---
 test/exchange-business-cards |  4 +--
 test/get-obex-capabilities   |  6 ++--
 test/list-folders            |  6 ++--
 test/sap_client.py           | 68 ++++++++++++++++++------------------
 test/simple-player           |  4 +--
 5 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/test/exchange-business-cards b/test/exchange-business-cards
index 12d513362..f28d90e30 100755
--- a/test/exchange-business-cards
+++ b/test/exchange-business-cards
@@ -9,10 +9,10 @@ client = dbus.Interface(bus.get_object("org.bluez.obex", "/org/bluez/obex"),
 					"org.bluez.obex.Client")
 
 if (len(sys.argv) < 4):
-	print "Usage: %s <device> <clientfile> <file>" % (sys.argv[0])
+	print("Usage: %s <device> <clientfile> <file>" % (sys.argv[0]))
 	sys.exit(1)
 
-print "Creating Session"
+print("Creating Session")
 path = client.CreateSession(sys.argv[1], { "Target": "OPP" })
 opp = dbus.Interface(bus.get_object("org.bluez.obex", path),
 					"org.bluez.obex.ObjectPush")
diff --git a/test/get-obex-capabilities b/test/get-obex-capabilities
index 25a996e18..c2e5710db 100755
--- a/test/get-obex-capabilities
+++ b/test/get-obex-capabilities
@@ -9,12 +9,12 @@ client = dbus.Interface(bus.get_object("org.bluez.obex", "/org/bluez/obex"),
 					"org.bluez.obex.Client")
 
 if (len(sys.argv) < 3):
-	print "Usage: %s <device> <target>" % (sys.argv[0])
+	print("Usage: %s <device> <target>" % (sys.argv[0]))
 	sys.exit(1)
 
-print "Creating Session"
+print("Creating Session")
 session_path = client.CreateSession(sys.argv[1], { "Target": sys.argv[2] })
 session = dbus.Interface(bus.get_object("org.bluez.obex", session_path),
 					"org.bluez.obex.Session")
 
-print session.GetCapabilities()
+print(session.GetCapabilities())
diff --git a/test/list-folders b/test/list-folders
index 414bb367b..3b080e7ba 100755
--- a/test/list-folders
+++ b/test/list-folders
@@ -22,15 +22,15 @@ def list_folder(folder):
 
 	for i in ftp.ListFolder():
 		if i["Type"] == "folder":
-			print "%s/" % (i["Name"])
+			print("%s/" % (i["Name"]))
 		else:
-			print "%s" % (i["Name"])
+			print("%s" % (i["Name"]))
 
 
 if __name__ == '__main__':
 
 	if len(sys.argv) < 2:
-		print "Usage: %s <device> [folder]" % (sys.argv[0])
+		print("Usage: %s <device> [folder]" % (sys.argv[0]))
 		sys.exit(1)
 
 	folder = None
diff --git a/test/sap_client.py b/test/sap_client.py
index fed13aedc..2da46eee3 100644
--- a/test/sap_client.py
+++ b/test/sap_client.py
@@ -165,7 +165,7 @@ class SAPParam_ConnectionStatus(SAPParam):
 
     def __validate(self):
         if self.value is not None and self.value not in (0x00,  0x01,  0x02,  0x03,  0x04):
-            print "Warning. ConnectionStatus value in reserved range (0x%x)" % self.value
+            print("Warning. ConnectionStatus value in reserved range (0x%x)" % self.value)
 
     def deserialize(self,  buf):
         ret = SAPParam.deserialize(self, buf)
@@ -183,7 +183,7 @@ class SAPParam_ResultCode(SAPParam):
 
     def __validate(self):
         if self.value is not None and self.value not in (0x00,  0x01,  0x02,  0x03,  0x04,  0x05,  0x06,  0x07):
-            print "Warning. ResultCode value in reserved range (0x%x)" % self.value
+            print("Warning. ResultCode value in reserved range (0x%x)" % self.value)
 
     def deserialize(self,  buf):
         ret = SAPParam.deserialize(self, buf)
@@ -201,7 +201,7 @@ class SAPParam_DisconnectionType(SAPParam):
 
     def __validate(self):
         if self.value is not None and self.value not in (0x00,  0x01):
-            print "Warning. DisconnectionType value in reserved range (0x%x)" % self.value
+            print("Warning. DisconnectionType value in reserved range (0x%x)" % self.value)
 
     def deserialize(self,  buf):
         ret = SAPParam.deserialize(self, buf)
@@ -227,7 +227,7 @@ class SAPParam_StatusChange(SAPParam):
 
     def __validate(self):
         if self.value is not None and self.value not in (0x00,  0x01,  0x02,  0x03,  0x04,  0x05):
-            print "Warning. StatusChange value in reserved range (0x%x)" % self.value
+            print("Warning. StatusChange value in reserved range (0x%x)" % self.value)
 
     def deserialize(self,  buf):
         ret = SAPParam.deserialize(self, buf)
@@ -245,7 +245,7 @@ class SAPParam_TransportProtocol(SAPParam):
 
     def __validate(self):
         if self.value is not None and self.value not in (0x00,  0x01):
-            print "Warning. TransportProtoco value in reserved range (0x%x)" % self.value
+            print("Warning. TransportProtoco value in reserved range (0x%x)" % self.value)
 
     def deserialize(self,  buf):
         ret = SAPParam.deserialize(self, buf)
@@ -728,7 +728,7 @@ class SAPClient:
         self.port = first_match["port"]
         self.host = first_match["host"]
 
-        print "SAP Service found on %s(%s)" % first_match["name"] % self.host
+        print("SAP Service found on %s(%s)" % first_match["name"] % self.host)
 
     def __connectRFCOMM(self):
         self.sock=BluetoothSocket( RFCOMM )
@@ -739,19 +739,19 @@ class SAPClient:
     def __sendMsg(self, msg):
         if isinstance(msg,  SAPMessage):
             s = msg.serialize()
-            print "\tTX: " + msg.getContent()
+            print("\tTX: " + msg.getContent())
             return self.sock.send(s.tostring())
 
     def __rcvMsg(self,  msg):
         if isinstance(msg,  SAPMessage):
-            print "\tRX Wait: %s(id = 0x%.2x)" % (msg.name, msg.id)
+            print("\tRX Wait: %s(id = 0x%.2x)" % (msg.name, msg.id))
             data = self.sock.recv(self.bufsize)
             if data:
                 if msg.deserialize(array('B',data)):
-                    print "\tRX: len(%d) %s" % (len(data), msg.getContent())
+                    print("\tRX: len(%d) %s" % (len(data), msg.getContent()))
                     return msg
                 else:
-                    print "msg: %s" % array('B',data)
+                    print("msg: %s" % array('B',data))
                     raise BluetoothError ("Message deserialization failed.")
             else:
                 raise BluetoothError ("Timeout. No data received.")
@@ -797,8 +797,8 @@ class SAPClient:
                     return False
             else:
                 return False
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_disconnectByClient(self, timeout=0):
@@ -808,8 +808,8 @@ class SAPClient:
             time.sleep(timeout) # let srv to close rfcomm
             self.__disconnectRFCOMM()
             return True
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_disconnectByServer(self, timeout=0):
@@ -823,8 +823,8 @@ class SAPClient:
 
             return self.proc_disconnectByClient(timeout)
 
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_transferAPDU(self,  apdu = "Sample APDU command"):
@@ -832,8 +832,8 @@ class SAPClient:
             self.__sendMsg(SAPMessage_TRANSFER_APDU_REQ(apdu))
             params = self.__rcvMsg(SAPMessage_TRANSFER_APDU_RESP()).getParams()
             return True
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_transferATR(self):
@@ -841,8 +841,8 @@ class SAPClient:
             self.__sendMsg(SAPMessage_TRANSFER_ATR_REQ())
             params = self.__rcvMsg(SAPMessage_TRANSFER_ATR_RESP()).getParams()
             return True
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_powerSimOff(self):
@@ -850,8 +850,8 @@ class SAPClient:
             self.__sendMsg(SAPMessage_POWER_SIM_OFF_REQ())
             params = self.__rcvMsg(SAPMessage_POWER_SIM_OFF_RESP()).getParams()
             return True
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_powerSimOn(self):
@@ -862,8 +862,8 @@ class SAPClient:
                 return self.proc_transferATR()
 
             return True
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_resetSim(self):
@@ -874,23 +874,23 @@ class SAPClient:
                 return self.proc_transferATR()
 
             return True
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_reportStatus(self):
         try:
             params = self.__rcvMsg(SAPMessage_STATUS_IND()).getParams()
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_transferCardReaderStatus(self):
         try:
             self.__sendMsg(SAPMessage_TRANSFER_CARD_READER_STATUS_REQ())
             params = self.__rcvMsg(SAPMessage_TRANSFER_CARD_READER_STATUS_RESP()).getParams()
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_errorResponse(self):
@@ -899,8 +899,8 @@ class SAPClient:
             self.__sendMsg(SAPMessage_CONNECT_REQ())
 
             params = self.__rcvMsg(SAPMessage_ERROR_RESP()).getParams()
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
     def proc_setTransportProtocol(self,  protocol = 0):
@@ -922,8 +922,8 @@ class SAPClient:
             else:
                 return False
 
-        except BluetoothError , e:
-            print "Error. " +str(e)
+        except BluetoothError as e:
+            print("Error. " +str(e))
             return False
 
 if __name__ == "__main__":
diff --git a/test/simple-player b/test/simple-player
index 190e047e2..8a1cb1e33 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -1,7 +1,7 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: LGPL-2.1-or-later
 
-from __future__ import print_function
+
 
 import os
 import sys
@@ -119,7 +119,7 @@ class InputHandler:
 			return True
 
 		try:
-			exec "self.player.%s" % s
+			exec("self.player.%s" % s)
 		except Exception as e:
 			print(e)
 			pass
-- 
2.42.0

