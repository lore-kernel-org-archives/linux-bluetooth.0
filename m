Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 1/3] GATT: Remove individual config switches
Date: Wed, 14 Mar 2012 10:07:11 +0200
Message-Id: <1331712433-27930-2-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1331712433-27930-1-git-send-email-chen.ganir@ti.com>
References: <1331712433-27930-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Remove individial GATT plugin configuration switches, and add a
new master gatt switch to the ./config called --enable-gatt to
enable/disable all GATT related plugins at once.
---
 Makefile.am         |   38 ++++++++++----------------------------
 Makefile.tools      |    8 +++++---
 acinclude.m4        |   32 ++++----------------------------
 bootstrap-configure |    6 +-----
 4 files changed, 20 insertions(+), 64 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index bd587eb..ddc28d2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -199,36 +199,11 @@ builtin_sources += network/main.c \
 			network/connection.h network/connection.c
 endif
 
-if PROXIMITYPLUGIN
-builtin_modules += proximity
-builtin_sources += proximity/main.c \
-			proximity/manager.h proximity/manager.c \
-			proximity/monitor.h proximity/monitor.c \
-			proximity/reporter.h proximity/reporter.c
-endif
-
 if SERVICEPLUGIN
 builtin_modules += service
 builtin_sources += plugins/service.c
 endif
 
-if GATT_EXAMPLE_PLUGIN
-builtin_modules += gatt_example
-builtin_sources += plugins/gatt-example.c
-endif
-
-if TIMEPLUGIN
-builtin_modules += time
-builtin_sources += time/main.c \
-		   time/server.h time/server.c
-endif
-
-if ALERTPLUGIN
-builtin_modules += alert
-builtin_sources += alert/main.c \
-		   alert/server.h alert/server.c
-endif
-
 if HEALTHPLUGIN
 builtin_modules += health
 builtin_sources += health/hdp_main.c health/hdp_types.h \
@@ -237,13 +212,20 @@ builtin_sources += health/hdp_main.c health/hdp_types.h \
 			health/hdp_util.h health/hdp_util.c
 endif
 
-if THERMOMETERPLUGIN
-builtin_modules += thermometer
+if GATTMODULES
+builtin_modules += thermometer alert time gatt_example proximity
 builtin_sources += thermometer/main.c \
 			thermometer/manager.h thermometer/manager.c \
-			thermometer/thermometer.h thermometer/thermometer.c
+			thermometer/thermometer.h thermometer/thermometer.c \
+			alert/main.c alert/server.h alert/server.c \
+			time/main.c time/server.h time/server.c \
+            plugins/gatt-example.c \
+            proximity/main.c proximity/manager.h proximity/manager.c \
+			proximity/monitor.h proximity/monitor.c \
+			proximity/reporter.h proximity/reporter.c
 endif
 
+
 builtin_modules += hciops mgmtops
 builtin_sources += plugins/hciops.c plugins/mgmtops.c
 
diff --git a/Makefile.tools b/Makefile.tools
index f997a3f..7b7a43f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -218,12 +218,14 @@ EXTRA_DIST += test/apitest test/sap-client test/hsplay test/hsmicro \
 		test/test-device test/test-service test/test-serial \
 		test/test-telephony test/test-network test/simple-agent \
 		test/simple-service test/simple-endpoint test/test-audio \
-		test/test-input test/test-attrib test/test-proximity \
-		test/test-sap-server test/test-oob test/test-serial-proxy \
-		test/test-thermometer test/test-health test/test-health-sink \
+		test/test-input test/test-sap-server test/test-oob \
+		test/test-serial-proxy test/test-health test/test-health-sink \
 		test/service-record.dtd test/service-did.xml \
 		test/service-spp.xml test/service-opp.xml test/service-ftp.xml
 
+if GATTMODULES
+EXTRA_DIST += test/test-attrib test/test-proximity test/test-thermometer
+endif
 
 if HIDD
 bin_PROGRAMS += compat/hidd
diff --git a/acinclude.m4 b/acinclude.m4
index b0f790c..429e466 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -196,13 +196,9 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	serial_enable=yes
 	network_enable=yes
 	sap_enable=no
-	proximity_enable=no
-	time_enable=no
-	alert_enable=no
 	service_enable=yes
 	health_enable=no
 	pnat_enable=no
-	gatt_example_enable=no
 	tools_enable=yes
 	hidd_enable=no
 	pand_enable=no
@@ -219,7 +215,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	sap_driver=dummy
 	dbusoob_enable=no
 	wiimote_enable=no
-	thermometer_enable=no
+	gatt_enable=no
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -246,18 +242,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	])
 	AC_SUBST([SAP_DRIVER], [sap-${sap_driver}.c])
 
-	AC_ARG_ENABLE(proximity, AC_HELP_STRING([--enable-proximity], [enable proximity plugin]), [
-		proximity_enable=${enableval}
-	])
-
-	AC_ARG_ENABLE(time, AC_HELP_STRING([--enable-time], [enable Time Profile plugin]), [
-		time_enable=${enableval}
-	])
-
-	AC_ARG_ENABLE(alert, AC_HELP_STRING([--enable-alert], [enable Phone Alert Profile plugin]), [
-		alert_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(serial, AC_HELP_STRING([--disable-serial], [disable serial plugin]), [
 		serial_enable=${enableval}
 	])
@@ -282,10 +266,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		pnat_enable=${enableval}
 	])
 
-	AC_ARG_ENABLE(gatt-example, AC_HELP_STRING([--enable-gatt-example], [enable GATT example plugin]), [
-		gatt_example_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(gstreamer, AC_HELP_STRING([--enable-gstreamer], [enable GStreamer support]), [
 		gstreamer_enable=${enableval}
 	])
@@ -368,8 +348,8 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		hal_enable=${enableval}
 	])
 
-	AC_ARG_ENABLE(thermometer, AC_HELP_STRING([--enable-thermometer], [enable thermometer plugin]), [
-		thermometer_enable=${enableval}
+	AC_ARG_ENABLE(gatt, AC_HELP_STRING([--enable-gatt], [enable gatt module]), [
+		gatt_enable=${enableval}
 	])
 
 	if (test "${fortify_enable}" = "yes"); then
@@ -404,15 +384,11 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SAPPLUGIN, test "${sap_enable}" = "yes")
-	AM_CONDITIONAL(PROXIMITYPLUGIN, test "${proximity_enable}" = "yes")
-	AM_CONDITIONAL(TIMEPLUGIN, test "${time_enable}" = "yes")
-	AM_CONDITIONAL(ALERTPLUGIN, test "${alert_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes")
 	AM_CONDITIONAL(READLINE, test "${readline_found}" = "yes")
-	AM_CONDITIONAL(GATT_EXAMPLE_PLUGIN, test "${gatt_example_enable}" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
 	AM_CONDITIONAL(HIDD, test "${hidd_enable}" = "yes")
 	AM_CONDITIONAL(PAND, test "${pand_enable}" = "yes")
@@ -428,5 +404,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
-	AM_CONDITIONAL(THERMOMETERPLUGIN, test "${thermometer_enable}" = "yes")
+	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
 ])
diff --git a/bootstrap-configure b/bootstrap-configure
index c38045b..e5f9daa 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -17,10 +17,6 @@ fi
 		--localstatedir=/var \
 		--libexecdir=/lib \
 		--enable-capng \
-		--enable-gatt-example \
-		--enable-proximity \
-		--enable-time \
-		--enable-alert \
 		--enable-health \
 		--enable-tools \
 		--enable-bccmd \
@@ -35,7 +31,7 @@ fi
 		--enable-maemo6 \
 		--enable-pnat \
 		--enable-sap \
-		--enable-thermometer \
 		--enable-wiimote \
 		--disable-pcmcia \
+		--enable-gatt \
 		--disable-datafiles $*
-- 
1.7.4.1

