Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v3 20/20] test: Enable speed and cadence calculation in test-cyclingspeed
Date: Tue, 4 Dec 2012 13:43:46 +0100
Message-ID: <1354625026-29358-21-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1354625026-29358-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to enable instantenous speed and cadence calculation
based on measurement received from remote device.

To enable calculations additional parameter "--circumference <value>"
needs to be used when calling script which sets wheel circumference in mm.

Both speed and cadence are enabled at the same time. Speed is calculated
in km/h and cadence in rpm.
---
 test/test-cyclingspeed | 71 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/test/test-cyclingspeed b/test/test-cyclingspeed
index 92fe935..841456c 100755
--- a/test/test-cyclingspeed
+++ b/test/test-cyclingspeed
@@ -14,23 +14,86 @@ import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
 
+class MeasurementQ:
+	def __init__(self, wrap_v):
+		self._now = [None, None]
+		self._prev = [None, None]
+		self._wrap_v = wrap_v
+
+	def can_calc(self):
+		return ((self._now[0] is not None)
+			and (self._now[1] is not None)
+			and (self._prev[0] is not None)
+			and (self._prev[1] is not None))
+
+	def delta_v(self):
+		delta = self._now[0] - self._prev[0]
+		if (delta < 0) and (self._wrap_v):
+			delta = delta + 65536
+		return delta
+
+	def delta_t(self):
+		delta = self._now[1] - self._prev[1]
+		if delta < 0:
+			delta = delta + 65536
+		return delta
+
+	def put(self, data):
+		self._prev = self._now
+		self._now = data
+
 class Watcher(dbus.service.Object):
+	_wheel = MeasurementQ(False)
+	_crank = MeasurementQ(True)
+	_circumference = None
+
+	def enable_calc(self, v):
+		self._circumference = v
+
 	@dbus.service.method("org.bluez.CyclingSpeedWatcher",
 					in_signature="oa{sv}", out_signature="")
 	def MeasurementReceived(self, device, measure):
 		print("Measurement received from %s" % device)
 
+		rev = None
+		evt = None
 		if "WheelRevolutions" in measure:
+			rev = measure["WheelRevolutions"]
 			print("WheelRevolutions: ", measure["WheelRevolutions"])
-
 		if "LastWheelEventTime" in measure:
+			evt = measure["LastWheelEventTime"]
 			print("LastWheelEventTime: ", measure["LastWheelEventTime"])
+		self._wheel.put( [rev, evt] )
 
+		rev = None
+		evt = None
 		if "CrankRevolutions" in measure:
+			rev = measure["CrankRevolutions"]
 			print("CrankRevolutions: ", measure["CrankRevolutions"])
-
 		if "LastCrankEventTime" in measure:
+			evt = measure["LastCrankEventTime"]
 			print("LastCrankEventTime: ", measure["LastCrankEventTime"])
+		self._crank.put( [rev, evt] )
+
+		if self._circumference is None:
+			return
+
+		if self._wheel.can_calc():
+			delta_v = self._wheel.delta_v()
+			delta_t = self._wheel.delta_t()
+
+			if (delta_v >= 0) and (delta_t > 0):
+				speed = delta_v * self._circumference * 1024 / delta_t # mm/s
+				speed = speed * 0.0036 # mm/s -> km/h
+				print("(calculated) Speed: %.2f km/h" % speed)
+
+		if self._crank.can_calc():
+			delta_v = self._crank.delta_v()
+			delta_t = self._crank.delta_t()
+
+			if delta_t > 0:
+				cadence = delta_v * 1024 / delta_t
+				print("(calculated) Cadence: %d rpm" % cadence)
 
 def properties_changed(interface, changed, invalidated):
 	if "Location" in changed:
@@ -46,6 +109,8 @@ if __name__ == "__main__":
 			type="string", dest="adapter"),
 		make_option("-b", "--device", action="store",
 			type="string", dest="address"),
+		make_option("-c", "--circumference", action="store",
+			type="int", dest="circumference"),
 		]
 
 	parser = OptionParser(option_list=option_list)
@@ -77,6 +142,8 @@ if __name__ == "__main__":
 
 	watcher_path = "/test/watcher"
 	watcher = Watcher(bus, watcher_path)
+	if options.circumference:
+		watcher.enable_calc(options.circumference)
 	cscmanager.RegisterWatcher(watcher_path)
 
 	csc = dbus.Interface(bus.get_object("org.bluez", device_path),
-- 
1.8.0

