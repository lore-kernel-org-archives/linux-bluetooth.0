Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] test: Use existing AGENT_PATH variable on simple-agent
Date: Thu, 16 May 2013 09:24:55 -0400
Message-Id: <1368710695-22623-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1368710695-22623-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1368710695-22623-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/simple-agent |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/test/simple-agent b/test/simple-agent
index 64b2ca8..5475770 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -148,14 +148,13 @@ if __name__ == '__main__':
 	if options.capability:
 		capability  = options.capability
 
-	path = "/test/agent"
-	agent = Agent(bus, path)
+	agent = Agent(bus, AGENT_PATH)
 
 	mainloop = GObject.MainLoop()
 
 	obj = bus.get_object(BUS_NAME, "/org/bluez");
 	manager = dbus.Interface(obj, "org.bluez.AgentManager1")
-	manager.RegisterAgent(path, capability)
+	manager.RegisterAgent(AGENT_PATH, capability)
 
 	print("Agent registered")
 
@@ -173,6 +172,6 @@ if __name__ == '__main__':
 								timeout=60000)
 		device_obj = device
 	else:
-		manager.RequestDefaultAgent(path)
+		manager.RequestDefaultAgent(AGENT_PATH)
 
 	mainloop.run()
-- 
1.7.9.5

