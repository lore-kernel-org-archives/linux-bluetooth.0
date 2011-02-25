Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Add filter option to test/test-discovery
Date: Fri, 25 Feb 2011 18:38:31 -0300
Message-Id: <1298669911-12942-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new --filter option, which can be used to only show discovery
results which satisfy a given (Python) expression. This expression can
use any property of a discovered device. Example:

test-discovery -f "Name == 'BlueZ'"
test-discovery --filter="LegacyPairing == 1"

This option is useful for showing only devices which we are interested
on, e.g. LE devices (once we have a property to identify them).
---
 test/test-discovery |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/test/test-discovery b/test/test-discovery
index 22c88c3..92f931d 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -7,6 +7,13 @@ import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 
 def device_found(address, properties):
+	import sys
+	try:
+		if options.filter and not eval(options.filter, dict(properties)):
+			return
+	except NameError:
+		return
+
 	print "[ " + address + " ]"
 
 	for key in properties.keys():
@@ -30,6 +37,9 @@ if __name__ == '__main__':
 	option_list = [
 			make_option("-i", "--device", action="store",
 					type="string", dest="dev_id"),
+			make_option("-f", "--filter", action="store",
+					type="string", dest="filter", metavar="PYTHON_EXPR",
+					help="Filter results according to PYTHON_EXPR"),
 			]
 	parser = OptionParser(option_list=option_list)
 
-- 
1.7.0.4

