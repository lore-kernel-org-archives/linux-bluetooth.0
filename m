Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] test: Python import cleanup
Message-Id: <20140118014507.85FAE10065C@puck.mtv.corp.google.com>
Date: Fri, 17 Jan 2014 17:45:07 -0800 (PST)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some test scripts use "from gi.repository import GObject" whereas others
use "import gobject". gi.repository is not always available on embedded
systems, so convert all instances to this format:

try:
  from gi.repository import GObject
except ImportError:
  import gobject as GObject

Also, sort the imports in this order: system, dbus, gobject, bluezutils
---
 test/ftp-client        | 12 +++++++-----
 test/map-client        | 15 ++++++++-------
 test/monitor-bluetooth |  8 +++++---
 test/opp-client        | 11 +++++++----
 test/pbap-client       | 10 ++++++----
 test/simple-agent      |  8 +++++---
 test/simple-endpoint   |  7 +++++--
 test/simple-obex-agent |  8 +++++---
 test/simple-player     | 10 +++++++---
 test/test-adapter      |  4 ++--
 test/test-alert        | 15 ++++++++++-----
 test/test-cyclingspeed | 10 ++++++----
 test/test-device       | 10 ++++++----
 test/test-discovery    |  8 +++++---
 test/test-health       | 11 +++++++----
 test/test-health-sink  |  9 ++++++---
 test/test-heartrate    | 10 ++++++----
 test/test-hfp          | 12 +++++++-----
 test/test-manager      |  6 ++++--
 test/test-nap          |  2 +-
 test/test-network      |  2 +-
 test/test-profile      |  8 +++++---
 test/test-proximity    | 10 ++++++----
 test/test-thermometer  | 10 ++++++----
 24 files changed, 133 insertions(+), 83 deletions(-)

diff --git a/test/ftp-client b/test/ftp-client
index ae3cbcb..78c32b3 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -2,14 +2,16 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-import gobject
-
+from optparse import OptionParser
+import os.path
 import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-import os.path
-from optparse import OptionParser
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME='org.bluez.obex'
 PATH = '/org/bluez/obex'
@@ -142,7 +144,7 @@ if  __name__ == '__main__':
 		sys.exit(0)
 
 	bus = dbus.SessionBus()
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 
 	client = dbus.Interface(bus.get_object(BUS_NAME, PATH,),
 							CLIENT_INTERFACE)
diff --git a/test/map-client b/test/map-client
index f3c657f..b9695da 100755
--- a/test/map-client
+++ b/test/map-client
@@ -2,15 +2,16 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-import gobject
-
-import sys
+from optparse import OptionParser
 import os
+from pprint import pformat
+import sys
 import dbus
 import dbus.mainloop.glib
-from optparse import OptionParser
-
-from pprint import pformat
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME='org.bluez.obex'
 PATH = '/org/bluez/obex'
@@ -185,7 +186,7 @@ if  __name__ == '__main__':
 		exit(0)
 
 	bus = dbus.SessionBus()
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 
 	client = dbus.Interface(bus.get_object(BUS_NAME, PATH),
 							CLIENT_INTERFACE)
diff --git a/test/monitor-bluetooth b/test/monitor-bluetooth
index bc5ddaf..d9b5472 100755
--- a/test/monitor-bluetooth
+++ b/test/monitor-bluetooth
@@ -2,10 +2,12 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-import gobject
-
 import dbus
 import dbus.mainloop.glib
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 relevant_ifaces = [ "org.bluez.Adapter1", "org.bluez.Device1" ]
 
@@ -48,5 +50,5 @@ if __name__ == '__main__':
 			dbus_interface="org.freedesktop.DBus.ObjectManager",
 			signal_name="InterfacesRemoved")
 
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 	mainloop.run()
diff --git a/test/opp-client b/test/opp-client
index 878c263..62d5b84 100755
--- a/test/opp-client
+++ b/test/opp-client
@@ -2,12 +2,15 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
+from optparse import OptionParser
+import os.path
 import sys
 import dbus
-import gobject
 import dbus.mainloop.glib
-import os.path
-from optparse import OptionParser
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME='org.bluez.obex'
 PATH = '/org/bluez/obex'
@@ -97,7 +100,7 @@ if  __name__ == '__main__':
 		sys.exit(0)
 
 	bus = dbus.SessionBus()
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 
 	client = dbus.Interface(bus.get_object(BUS_NAME, PATH),
 							CLIENT_INTERFACE)
diff --git a/test/pbap-client b/test/pbap-client
index c02833b..51e26eb 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -2,13 +2,15 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-import gobject
-
-import sys
 import os
+import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME='org.bluez.obex'
 PATH = '/org/bluez/obex'
@@ -113,7 +115,7 @@ if  __name__ == '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 
 	bus = dbus.SessionBus()
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 
 	client = dbus.Interface(bus.get_object(BUS_NAME, PATH),
 							CLIENT_INTERFACE)
diff --git a/test/simple-agent b/test/simple-agent
index 854e1af..a69299a 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -2,13 +2,15 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-from gi.repository import GObject
-
+from optparse import OptionParser
 import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-from optparse import OptionParser
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 BUS_NAME = 'org.bluez'
diff --git a/test/simple-endpoint b/test/simple-endpoint
index 590f83a..0164cff 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -6,7 +6,10 @@ import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-import gobject
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 A2DP_SOURCE_UUID = "0000110A-0000-1000-8000-00805F9B34FB"
@@ -94,7 +97,7 @@ if __name__ == '__main__':
 
 	path = "/test/endpoint"
 	endpoint = Endpoint(bus, path)
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 
 	properties = dbus.Dictionary({ "UUID" : A2DP_SOURCE_UUID,
 					"Codec" : SBC_CODEC,
diff --git a/test/simple-obex-agent b/test/simple-obex-agent
index f15e9d1..05ec4ed 100755
--- a/test/simple-obex-agent
+++ b/test/simple-obex-agent
@@ -2,12 +2,14 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-import gobject
-
 import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME = 'org.bluez.obex'
 PATH = '/org/bluez/obex'
@@ -63,7 +65,7 @@ if __name__ == '__main__':
 	path = "/test/agent"
 	agent = Agent(bus, path)
 
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 
 	manager.RegisterAgent(path)
 	print("Agent registered")
diff --git a/test/simple-player b/test/simple-player
index 01bec06..23e78ad 100755
--- a/test/simple-player
+++ b/test/simple-player
@@ -1,12 +1,16 @@
 #!/usr/bin/python
 
 from __future__ import print_function
+
 import os
 import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-import gobject
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 class Player(dbus.service.Object):
@@ -56,7 +60,7 @@ class Player(dbus.service.Object):
 					signature="sv")
 
 			handler = InputHandler(self)
-			gobject.io_add_watch(sys.stdin, gobject.IO_IN,
+			GObject.io_add_watch(sys.stdin, GObject.IO_IN,
 							handler.handle)
 
 	@dbus.service.method("org.freedesktop.DBus.Properties",
@@ -136,7 +140,7 @@ if __name__ == '__main__':
 
 	path = "/test/player"
 	player = Player(bus, path)
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 
 	if len(sys.argv) > 2:
 		player.set_object(sys.argv[2])
diff --git a/test/test-adapter b/test/test-adapter
index 5deeda4..959a437 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -2,10 +2,10 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
+from optparse import OptionParser, make_option
 import sys
-import dbus
 import time
-from optparse import OptionParser, make_option
+import dbus
 import bluezutils
 
 bus = dbus.SystemBus()
diff --git a/test/test-alert b/test/test-alert
index 066e537..43b3cf3 100755
--- a/test/test-alert
+++ b/test/test-alert
@@ -1,12 +1,17 @@
 #!/usr/bin/python
+
 from __future__ import absolute_import, print_function, unicode_literals
+
+import optparse
+import os
+import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-import gobject
-import optparse
-import sys
-import os
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME = 'org.bluez'
 ALERT_INTERFACE = 'org.bluez.Alert1'
@@ -149,7 +154,7 @@ parser.disable_interspersed_args()
 
 dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
 bus = dbus.SystemBus()
-mainloop = gobject.MainLoop()
+mainloop = GObject.MainLoop()
 alert = dbus.Interface(bus.get_object(BUS_NAME, BLUEZ_OBJECT_PATH),
 								ALERT_INTERFACE)
 alert_agent = AlertAgent(bus, TEST_OBJECT_PATH, alert, mainloop)
diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
index 75bd7d7..d49041f 100755
--- a/test/test-cyclingspeed
+++ b/test/test-cyclingspeed
@@ -6,13 +6,15 @@ from __future__ import absolute_import, print_function, unicode_literals
 Cycling Speed and Cadence test script
 '''
 
-import gobject
-
+from optparse import OptionParser, make_option
 import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-from optparse import OptionParser, make_option
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME = 'org.bluez'
 CYCLINGSPEED_MANAGER_INTERFACE = 'org.bluez.CyclingSpeedManager1'
@@ -190,5 +192,5 @@ if __name__ == "__main__":
 			print("Unknown command")
 			sys.exit(1)
 
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 	mainloop.run()
diff --git a/test/test-device b/test/test-device
index 3d7b852..b490d53 100755
--- a/test/test-device
+++ b/test/test-device
@@ -2,13 +2,15 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-from gi.repository import GObject
-
+from optparse import OptionParser, make_option
+import re
 import sys
 import dbus
 import dbus.mainloop.glib
-import re
-from optparse import OptionParser, make_option
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
diff --git a/test/test-discovery b/test/test-discovery
index c13bfac..73b8161 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -2,11 +2,13 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-from gi.repository import GObject
-
+from optparse import OptionParser, make_option
 import dbus
 import dbus.mainloop.glib
-from optparse import OptionParser, make_option
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 compact = False
diff --git a/test/test-health b/test/test-health
index 052a602..343f29c 100755
--- a/test/test-health
+++ b/test/test-health
@@ -3,11 +3,14 @@
 from __future__ import absolute_import, print_function, unicode_literals
 # -*- coding: utf-8 -*-
 
+import sys
 import dbus
 import dbus.service
-import gobject
 from dbus.mainloop.glib import DBusGMainLoop
-import sys
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME = 'org.bluez'
 PATH = '/org/bluez'
@@ -16,7 +19,7 @@ HEALTH_MANAGER_INTERFACE = 'org.bluez.HealthManager1'
 HEALTH_DEVICE_INTERFACE = 'org.bluez.HealthDevice1'
 
 DBusGMainLoop(set_as_default=True)
-loop = gobject.MainLoop()
+loop = GObject.MainLoop()
 
 bus = dbus.SystemBus()
 
@@ -48,7 +51,7 @@ def enter_mainloop():
 	try:
 		print("Entering main lopp, push Ctrl+C for finish")
 
-		mainloop = gobject.MainLoop()
+		mainloop = GObject.MainLoop()
 		mainloop.run()
 	except KeyboardInterrupt:
 		pass
diff --git a/test/test-health-sink b/test/test-health-sink
index 32afd71..52be535 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -3,11 +3,14 @@
 from __future__ import absolute_import, print_function, unicode_literals
 # -*- coding: utf-8 -*-
 
+import sys
 import dbus
 import dbus.service
-import gobject
 from dbus.mainloop.glib import DBusGMainLoop
-import sys
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 BUS_NAME = 'org.bluez'
 PATH = '/org/bluez'
@@ -16,7 +19,7 @@ HEALTH_MANAGER_INTERFACE = 'org.bluez.HealthManager1'
 HEALTH_DEVICE_INTERFACE = 'org.bluez.HealthDevice1'
 
 DBusGMainLoop(set_as_default=True)
-loop = gobject.MainLoop()
+loop = GObject.MainLoop()
 
 bus = dbus.SystemBus()
 
diff --git a/test/test-heartrate b/test/test-heartrate
index f26b3db..5e4e7e5 100755
--- a/test/test-heartrate
+++ b/test/test-heartrate
@@ -6,13 +6,15 @@ from __future__ import absolute_import, print_function, unicode_literals
 Heart Rate Monitor test script
 '''
 
-import gobject
-
+from optparse import OptionParser, make_option
 import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-from optparse import OptionParser, make_option
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 BUS_NAME = 'org.bluez'
@@ -102,5 +104,5 @@ if __name__ == "__main__":
 			print("unknown command")
 			sys.exit(1)
 
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 	mainloop.run()
diff --git a/test/test-hfp b/test/test-hfp
index 873de0a..a806043 100755
--- a/test/test-hfp
+++ b/test/test-hfp
@@ -2,16 +2,18 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-from gi.repository import GObject
-
+from optparse import OptionParser, make_option
 import os
+from socket import SOCK_SEQPACKET, socket
 import sys
 import dbus
-import glib
 import dbus.service
 import dbus.mainloop.glib
-from optparse import OptionParser, make_option
-from socket import SOCK_SEQPACKET, socket
+import glib
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 mainloop = None
 audio_supported = True
diff --git a/test/test-manager b/test/test-manager
index 1e3882f..4f5994f 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -2,10 +2,12 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-from gi.repository import GObject
-
 import dbus
 import dbus.mainloop.glib
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 def interfaces_added(path, interfaces):
diff --git a/test/test-nap b/test/test-nap
index 197e3c2..00a2585 100755
--- a/test/test-nap
+++ b/test/test-nap
@@ -2,10 +2,10 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
+from optparse import OptionParser, make_option
 import sys
 import time
 import dbus
-from optparse import OptionParser, make_option
 import bluezutils
 
 bus = dbus.SystemBus()
diff --git a/test/test-network b/test/test-network
index 3e8713f..6f09486 100755
--- a/test/test-network
+++ b/test/test-network
@@ -2,10 +2,10 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
+from optparse import OptionParser, make_option
 import sys
 import time
 import dbus
-from optparse import OptionParser, make_option
 import bluezutils
 
 bus = dbus.SystemBus()
diff --git a/test/test-profile b/test/test-profile
index b78d00c..2791580 100755
--- a/test/test-profile
+++ b/test/test-profile
@@ -2,15 +2,17 @@
 
 from __future__ import absolute_import, print_function, unicode_literals
 
-from gi.repository import GObject
-
+from optparse import OptionParser, make_option
 import os
 import sys
 import uuid
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-from optparse import OptionParser, make_option
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 
 class Profile(dbus.service.Object):
 	fd = -1
diff --git a/test/test-proximity b/test/test-proximity
index 2f47824..66b7bc2 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -6,12 +6,14 @@ from __future__ import absolute_import, print_function, unicode_literals
 Proximity Monitor test script
 '''
 
-import gobject
-
+from optparse import OptionParser, make_option
 import sys
 import dbus
 import dbus.mainloop.glib
-from optparse import OptionParser, make_option
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 BUS_NAME = 'org.bluez'
@@ -64,5 +66,5 @@ if __name__ == "__main__":
 	print("Proximity SetProperty('%s', '%s')" % (args[0], args[1]))
 	device_prop.Set(PROXIMITY_MONITOR_INTERFACE, args[0], args[1])
 
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 	mainloop.run()
diff --git a/test/test-thermometer b/test/test-thermometer
index 6c143be..7e67c23 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -6,13 +6,15 @@ from __future__ import absolute_import, print_function, unicode_literals
 Thermometer test script
 '''
 
-import gobject
-
+from optparse import OptionParser, make_option
 import sys
 import dbus
 import dbus.service
 import dbus.mainloop.glib
-from optparse import OptionParser, make_option
+try:
+  from gi.repository import GObject
+except ImportError:
+  import gobject as GObject
 import bluezutils
 
 BUS_NAME = 'org.bluez'
@@ -93,5 +95,5 @@ if __name__ == "__main__":
 			print("unknown command")
 			sys.exit(1)
 
-	mainloop = gobject.MainLoop()
+	mainloop = GObject.MainLoop()
 	mainloop.run()
-- 
1.8.5.3

