Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1TbfAhT3odPcbXt"
Message-Id: <200404150002.29515.cijoml@volny.cz>
Subject: [Bluez-users] patched script
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 15 Apr 2004 00:02:29 +0200


--Boundary-00=_1TbfAhT3odPcbXt
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

sending patched script bluetooth for debian

1]added bthid daemon to start/stop sections
2]fixes variables to prevent atacker pass some extended values into them

Hope you`ll include it

Michal

--Boundary-00=_1TbfAhT3odPcbXt
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="bluetooth.rc.deb.new"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bluetooth.rc.deb.new"

--- /usr/src/bluez-utils-2.6/scripts/bluetooth.rc.deb	Fri Apr  2 03:21:04 2004
+++ bluetooth	Wed Apr 14 23:56:17 2004
@@ -11,6 +11,7 @@
 HCIATTACH=/usr/sbin/hciattach
 UART_CONF=/etc/bluetooth/uart
 SDPD=/usr/sbin/sdpd
+BTHID=/opt/bluetooth/sbin/bthid
 RFCOMM=/usr/bin/rfcomm
 RFCOMM_CONF=/etc/bluetooth/rfcomm.conf
 
@@ -18,30 +19,35 @@
 
 start_uarts() 
 {
-	[ -x $HCIATTACH -a -f $UART_CONF ] || return
-	grep -v '^#' $UART_CONF | while read i; do
-		$HCIATTACH $i
+	[ -x "$HCIATTACH" -a -f "$UART_CONF" ] || return
+	grep -v '^#' "$UART_CONF" | while read i; do
+		"$HCIATTACH" "$i"
 	done
 }
 
 stop_uarts()
 {
-	killall $HCIATTACH > /dev/null 2>&1 || true
+	killall "$HCIATTACH" > /dev/null 2>&1 || true
 }
 
 case "$1" in
   start)
 	echo -n "Starting $DESC:"
-	if [ -x $HCID -a -f $HCID_CONF ] ; then
-		$HCID -f $HCID_CONF
+	if [ -x "$HCID" -a -f "$HCID_CONF" ] ; then
+		"$HCID" -f "$HCID_CONF"
 		echo -n " hcid"
 	fi
-	if [ -x $SDPD ] ; then
-		$SDPD
+	if [ -x "$SDPD" ] ; then
+		"$SDPD"
 		echo -n " sdpd"
 	fi
-	if [ -x $RFCOMM -a -f $RFCOMM_CONF ] ; then
-		$RFCOMM -f $RFCOMM_CONF bind all
+        if [ -x "$BTHID" ] ; then
+		"$BTHID" -d
+		echo -n " bthid"
+	fi
+
+	if [ -x "$RFCOMM" -a -f "$RFCOMM_CONF" ] ; then
+		"$RFCOMM" -f "$RFCOMM_CONF" bind all
 		echo -n " rfcomm"
 	fi
 	echo "."
@@ -49,30 +55,32 @@
 	;;
   stop)
 	echo -n "Stopping $DESC:"
-	if [ -x $RFCOMM ] ; then
+	if [ -x "$RFCOMM" ] ; then
 		echo -n " rfcomm"
-		$RFCOMM release all
+		"$RFCOMM" release all
 	fi
 	echo -n " sdpd"
-	killall $SDPD > /dev/null 2>&1 || true
+	killall "$SDPD" > /dev/null 2>&1 || true
 	echo -n " hcid"
-	killall $HCID > /dev/null 2>&1 || true
+	killall "$HCID" > /dev/null 2>&1 || true
+	echo -n " bthid"
+	killall "$BTHID" > /dev/null 2>&1 || true
 	echo "."
 	stop_uarts
 	;;
   restart|force-reload)
 	echo -n "Restarting $DESC:"
 	echo -n " hcid"
-	killall $HCID > /dev/null 2>&1 || true
+	killall "$HCID" > /dev/null 2>&1 || true
 	sleep 1
-	if [ -x $HCID -a -f $HCID_CONF ] ; then
-		$HCID -f $HCID_CONF
+	if [ -x "$HCID" -a -f "$HCID_CONF" ] ; then
+		"$HCID" -f "$HCID_CONF"
 	fi
 	echo -n " sdpd"
-	killall $SDPD > /dev/null 2>&1 || true
+	killall "$SDPD" > /dev/null 2>&1 || true
 	sleep 1
-	if [ -x $SDPD ] ; then
-		$SDPD
+	if [ -x "$SDPD" ] ; then
+		"$SDPD"
 	fi
 	echo "."
 	;;

--Boundary-00=_1TbfAhT3odPcbXt--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
