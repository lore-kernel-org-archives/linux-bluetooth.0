Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] remove trailing whitespaces in manpages
Date: Sat, 27 Jun 2009 17:01:40 +0200
Message-Id: <1246114900-14482-4-git-send-email-filippo@esaurito.net>
In-Reply-To: <1246114900-14482-1-git-send-email-filippo@esaurito.net>
References: <1246114900-14482-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 rfcomm/rfcomm.1     |    6 +-
 src/bluetoothd.8.in |   18 ++++----
 src/hcid.conf.5.in  |   52 +++++++++++-----------
 test/bdaddr.8       |    4 +-
 tools/ciptool.1     |    6 +-
 tools/dfutool.1     |    2 +-
 tools/hciattach.8   |    8 ++--
 tools/hciconfig.8   |    2 +-
 tools/sdptool.1     |  124 +++++++++++++++++++++++++-------------------------
 9 files changed, 111 insertions(+), 111 deletions(-)

diff --git a/rfcomm/rfcomm.1 b/rfcomm/rfcomm.1
index eaec05d..06252e5 100644
--- a/rfcomm/rfcomm.1
+++ b/rfcomm/rfcomm.1
@@ -92,12 +92,12 @@ specified channel. If no channel is specified, it will use the
 channel number 1. If also the Bluetooth address is left out, it
 tries to read the data from the config file. This command can
 be terminated with the key sequence CTRL-C.
-.TP 
+.TP
 .BI listen " <dev> [channel] [cmd]"
 Listen on a specified RFCOMM channel for incoming connections.
 If no channel is specified, it will use the channel number 1, but
 a channel must be specified before cmd. If cmd is given, it will be
-executed as soon as a client connects. When the child process 
+executed as soon as a client connects. When the child process
 terminates or the client disconnect, the command will terminate.
 Occurences of {} in cmd will be replaced by the name of the device
 used by the connection. This command can be terminated with the key
@@ -107,7 +107,7 @@ sequence CTRL-C.
 Watch is identical to
 .B listen
 except that when the child process terminates or the client
-disconnect, the command will restart listening with the same 
+disconnect, the command will restart listening with the same
 parameters.
 .TP
 .BI bind " <dev> [bdaddr] [channel]"
diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
index ce03b84..a7ae77b 100644
--- a/src/bluetoothd.8.in
+++ b/src/bluetoothd.8.in
@@ -1,4 +1,4 @@
-.\" 
+.\"
 .TH "BLUETOOTHD" "8" "March 2004" "Bluetooth daemon" "System management commands"
 .SH "NAME"
 bluetoothd \- Bluetooth daemon
@@ -12,17 +12,17 @@ bluetoothd \- Bluetooth daemon
 .SH "DESCRIPTION"
 This manual page documents briefly the
 .B bluetoothd
-daemon, which manages all the Bluetooth devices. 
+daemon, which manages all the Bluetooth devices.
 .B bluetoothd
 itself does not accept many command\-line options, as most of its
-configuration is done in the 
+configuration is done in the
 .B @CONFIGDIR@/main.conf
 file, which has its own man page.
 .B bluetoothd
 can also provide a number of services via the D-Bus message bus
 system.
 .SH "OPTIONS"
-.TP 
+.TP
 .BI \-n
 Don't run as daemon in background.
 .TP
@@ -33,11 +33,11 @@ Enable debug information output.
 Use specific MTU size for SDP server.
 
 .SH "FILES"
-.TP 
+.TP
 .I @CONFIGDIR@/main.conf
 Default location of the global configuration file.
 
-.TP 
+.TP
 .I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/linkkeys
 Default location for link keys of paired devices. The directory
 \fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
@@ -50,7 +50,7 @@ the following columns separated by whitespace:
 
 \fIn\fP Link type integer.
 
-.TP 
+.TP
 .I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/names
 Default location for the device name cache. The directory
 \fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
@@ -61,7 +61,7 @@ the following columns separated by whitespace:
 
 \fIname\fP Remote device name, terminated with newline.
 
-.TP 
+.TP
 .I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/features
 Default location for the features cache. The directory
 \fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
@@ -72,7 +72,7 @@ the following columns separated by whitespace:
 
 \fInnnnnnnnnnnnnnnn\fP Remote device LMP features coded as an 8 byte bitfield.
 
-.TP 
+.TP
 .I @STORAGEDIR@/nn:nn:nn:nn:nn:nn/manufacturers
 Default location for the manufacturers cache. The directory
 \fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
diff --git a/src/hcid.conf.5.in b/src/hcid.conf.5.in
index b4fd0b6..b771389 100644
--- a/src/hcid.conf.5.in
+++ b/src/hcid.conf.5.in
@@ -9,10 +9,10 @@ It consists of sections and parameters. A section begins with
 the name of the section followed by optional specifiers and the
 parameters inside curly brackets. Sections contain parameters of
 the form:
-.TP 
+.TP
 \fIname\fP \fIvalue1\fP, \fIvalue2\fP ... ;
 
-.PP 
+.PP
 Any character after a hash ('#') character is ignored until newline.
 Whitespace is also ignored.
 
@@ -21,23 +21,23 @@ The valid section names for
 .B hcid.conf
 are, at the moment:
 
-.TP 
+.TP
 .B options
 contains generic options for hcid and the pairing policy.
-.TP 
+.TP
 .B device
 contains lower\-level options for the hci devices connected to the computer.
 .SH "OPTIONS SECTION"
 The following parameters may be present in an option section:
 
 
-.TP 
+.TP
 \fBautoinit\fP  yes|no
 
 Automatically initialize newly connected devices. The default is \fIno\fP.
 
 
-.TP 
+.TP
 \fBpairing\fP  none|multi|once
 
 \fInone\fP means that pairing is disabled. \fImulti\fP allows pairing
@@ -45,7 +45,7 @@ with already paired devices. \fIonce\fP allows pairing once and denies
 successive attempts. The default hcid configuration is shipped with \fBmulti\fP
 enabled
 
-.TP 
+.TP
 \fBoffmode\fP  noscan|devdown
 
 \fInoscan\fP means that page and inquiry scans are disabled when you call
@@ -64,7 +64,7 @@ Bluetooth device ID service record.
 The default PIN for incoming connections if \fBsecurity\fP has been
 set to \fIauto\fP.
 
-.TP 
+.TP
 \fBsecurity\fP  none|auto|user
 
 \fInone\fP means the security manager is disabled. \fIauto\fP uses
@@ -77,14 +77,14 @@ device section, will be applied to all devices and device sections
 where these are unspecified. The following optional device specifiers
 are supported:
 
-.TP 
+.TP
 \fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
 
 Parameters specified within this section will be applied to the device
 with this \fIdevice bluetooth address\fP. All other parameters are applied from
 the default section.
 
-.TP 
+.TP
 \fBhci\fIn\fP
 
 Parameters specified within this section will be applied to the device
@@ -93,20 +93,20 @@ with this \fIdevice interface\fP, unless that device is matched by a
 the default section.
 
 
-.PP 
+.PP
 \fBNote\fP: Most of the options supported in the \fBdevice\fP section are described to some extent in the bluetooth specification version 1.2 Vol2, Part E section 6. Please refer to it for technical details.
 
-.PP 
+.PP
 The following parameters may be present in a device section:
 
-.TP 
+.TP
 \fBname\fP  "\fIname\fP"
 
 The device name. \fI%d\fP inserts the device id. \fI%h\fP inserts
 the host name.
 
 
-.TP 
+.TP
 \fBclass\fP  0x\fISSDDdd\fP (three bytes)
 
 The Bluetooth Device Class is described in the Bluetooth Specification section 1.2 ("Assigned Numbers \- Bluetooth Baseband").
@@ -122,7 +122,7 @@ In practice, most Bluetooth clients scan their surroundings in two successive st
 This means that the hcid.conf "class" parameter needs to be set up properly if particular services are running on the host, such as "PAN", or "OBEX Obect Push", etc: in general a device looking for a service such as "Network Access Point" will only scan for this service on devices containing "Networking" in their major service class.
 
 
-.IP 
+.IP
 Major service class byte allocation (from LSB to MSB):
 
 Bit 1:	Positioning (Location identification)
@@ -141,11 +141,11 @@ Bit 7:  Telephony (Cordless telephony, Modem, Headset service, ...)
 
 Bit 8:  Information (WEB\-server, WAP\-server, ...)
 
-.IP 
+.IP
 Example: class 0x02hhhh : the device offers networking service
 
 
-.IP 
+.IP
 Major device class allocation:
 
 0x00: Miscellaneous
@@ -164,17 +164,17 @@ Major device class allocation:
 
 Other values are not defined (refer to the Bluetooth specification for more details
 
-.IP 
+.IP
 Minor device class allocation: the meaning of this byte depends on the major class allocation, please refer to the Bluetooth specifications for more details).
 
-.IP 
+.IP
 .B Example:
 if PAND runs on your server, you need to set up at least \fBclass 0x020100\fP, which stands for "Service Class: Networking" and "Device Class: Computer, Uncategorized".
 
 
-.TP 
+.TP
 \fBiscan\fP  enable|disable
-.TP 
+.TP
 \fBpscan\fP  enable|disable
 
 Bluetooth devices discover and connect to each other through the use of two special Bluetooth channels, the Inquiry and Page channels (described in the Bluetooth Spec Volume 1, Part A, Section 3.3.3, page 35). These two options enable the channels on the bluetooth device.
@@ -183,14 +183,14 @@ Bluetooth devices discover and connect to each other through the use of two spec
 
 \fBpscan enable\fP: makes the bluetooth device "connectable to" by enabling the use of the "page scan" channel.
 
-.TP 
+.TP
 \fBlm\fP  none|accept,master
 
 \fInone\fP means no specific policy. \fIaccept\fP means always accept
 incoming connections. \fImaster\fP means become master on incoming
 connections and deny role switch on outgoing connections.
 
-.TP 
+.TP
 \fBlp\fP  none|rswitch,hold,sniff,park
 
 \fInone\fP means no specific policy. \fIrswitch\fP means allow role
@@ -208,18 +208,18 @@ park:  this is a mode where the device is put on standby on the piconet, for pow
 
 rswitch: this is a mode that enables role\-switch (master <\-> slave) between two devices in a piconet. It is not clear whether this needs to be enabled in order to make the "lm master" setting work properly or not.
 
-.TP 
+.TP
 \fBpageto\fP  \fIn\fP
 
 Page Timeout measured in number of baseband slots. Interval length = N * 0.625 msec (1 baseband slot)
 
-.TP 
+.TP
 \fBdiscovto\fP  \fIn\fP
 
 The time in seconds that the device will stay in discoverable mode. 0 disables this feature and forces the device to be always discoverable.
 
 .SH "FILES"
-.TP 
+.TP
 .I @CONFIGDIR@/hcid.conf
 Default location of the global configuration file.
 
diff --git a/test/bdaddr.8 b/test/bdaddr.8
index 78d4794..88345f8 100644
--- a/test/bdaddr.8
+++ b/test/bdaddr.8
@@ -13,7 +13,7 @@ bdaddr \- Utility for changing the Bluetooth device address
 .B
 bdaddr
 is used to query or set the local Bluetooth device address (BD_ADDR). If run
-with no arguments, 
+with no arguments,
 .B
 bdaddr
 prints the chip manufacturer's name, and the current BD_ADDR. If the IEEE OUI
@@ -46,7 +46,7 @@ Specify a particular device to operate on. If not specified, default is the
 first available device.
 .TP
 .BI -r
-Reset device and make new BD_ADDR active. 
+Reset device and make new BD_ADDR active.
 .B
 CSR
 devices only.
diff --git a/tools/ciptool.1 b/tools/ciptool.1
index 982f414..65d903d 100644
--- a/tools/ciptool.1
+++ b/tools/ciptool.1
@@ -54,12 +54,12 @@ offers CIP support.
 Connect the local device to the remote Bluetooth device on the
 specified PSM number. If no PSM is specified, it will use the
 SDP to retrieve it from the remote device.
-.TP 
+.TP
 .BI release " [bdaddr]"
 Release a connection to the specific device. If no address is
 given and only one device is connected this will be released.
-.TP 
-.BI loopback " <bdaddr> [psm]" 
+.TP
+.BI loopback " <bdaddr> [psm]"
 Create a connection to the remote device for Bluetooth testing.
 This command will not provide a CAPI controller, because it is
 only for testing the CAPI Message Transport Protocol.
diff --git a/tools/dfutool.1 b/tools/dfutool.1
index 78b1fe7..115114b 100644
--- a/tools/dfutool.1
+++ b/tools/dfutool.1
@@ -45,7 +45,7 @@ Change DFU specific values in the firmware file.
 .TP
 .BI upgrade " <dfu-file>"
 Upgrade the device with a new firmware.
-.TP 
+.TP
 .BI archive " <dfu-file>"
 Archive the current firmware of the device.
 .SH AUTHOR
diff --git a/tools/hciattach.8 b/tools/hciattach.8
index f9d295e..f750222 100644
--- a/tools/hciattach.8
+++ b/tools/hciattach.8
@@ -5,7 +5,7 @@ hciattach \- attach serial devices via UART HCI to BlueZ stack
 .B hciattach
 .RB [\| \-n \|]
 .RB [\| \-p \|]
-.RB [\| \-t 
+.RB [\| \-t
 .IR timeout \|]
 .I tty
 .IR type \||\| id
@@ -108,10 +108,10 @@ instead.
 
 .TP
 .I bdaddr
-The 
+The
 .I bdaddr
-specifies the Bluetooth Address to use.  Some devices (like the STLC2500) 
-do not store the Bluetooth address in hardware memory.  Instead it must 
+specifies the Bluetooth Address to use.  Some devices (like the STLC2500)
+do not store the Bluetooth address in hardware memory.  Instead it must
 be uploaded during the initialization process.  If this argument
 is specified, then the address will be used to initialize the device.
 Otherwise, a default address will be used.
diff --git a/tools/hciconfig.8 b/tools/hciconfig.8
index f03b1c1..13f52c6 100644
--- a/tools/hciconfig.8
+++ b/tools/hciconfig.8
@@ -27,7 +27,7 @@ the system. If
 .I hciX
 is given but no command is given, it prints basic information on device
 .I hciX
-only. Basic information is 
+only. Basic information is
 interface type, BD address, ACL MTU, SCO MTU, flags (up, init, running, raw,
 page scan enabled, inquiry scan enabled, inquiry, authentication enabled,
 encryption enabled).
diff --git a/tools/sdptool.1 b/tools/sdptool.1
index 686ec95..0f100e2 100644
--- a/tools/sdptool.1
+++ b/tools/sdptool.1
@@ -49,82 +49,82 @@
 .ds f2\"
 .ds f3\"
 .ds f4\"
-'\" t 
-.ta 8n 16n 24n 32n 40n 48n 56n 64n 72n  
-.TH "sdptool" "1" 
-.SH "NAME" 
-sdptool \(em control and interrogate SDP servers 
-.SH "SYNOPSIS" 
-.PP 
-\fBsdptool\fR [\fIoptions\fR]  {\fIcommand\fR}  [\fIcommand parameters\fR \&...]  
-.SH "DESCRIPTION" 
-.PP 
-\fBsdptool\fR provides the interface for 
-performing SDP queries on Bluetooth devices, and administering a 
-local \fBsdpd\fR. 
-.SH "COMMANDS" 
-.PP 
-The following commands are available.  In all cases \fBbdaddr\fR 
+'\" t
+.ta 8n 16n 24n 32n 40n 48n 56n 64n 72n
+.TH "sdptool" "1"
+.SH "NAME"
+sdptool \(em control and interrogate SDP servers
+.SH "SYNOPSIS"
+.PP
+\fBsdptool\fR [\fIoptions\fR]  {\fIcommand\fR}  [\fIcommand parameters\fR \&...]
+.SH "DESCRIPTION"
+.PP
+\fBsdptool\fR provides the interface for
+performing SDP queries on Bluetooth devices, and administering a
+local \fBsdpd\fR.
+.SH "COMMANDS"
+.PP
+The following commands are available.  In all cases \fBbdaddr\fR
 specifies the device to search or browse.  If \fIlocal\fP is used
 for \fBbdaddr\fP, then the local \fBsdpd\fR is searched.
 .PP
-Services are identified and manipulated with a 4-byte \fBrecord_handle\fP 
-(NOT the service name).  To find a service's \fBrecord_handle\fP, look for the 
+Services are identified and manipulated with a 4-byte \fBrecord_handle\fP
+(NOT the service name).  To find a service's \fBrecord_handle\fP, look for the
 "Service RecHandle" line in the \fBsearch\fP or \fBbrowse\fP results
-.IP "\fBsearch [--bdaddr bdaddr] [--tree] [--raw] [--xml] service_name\fP" 10 
-Search for services.. 
-.IP "" 10 
+.IP "\fBsearch [--bdaddr bdaddr] [--tree] [--raw] [--xml] service_name\fP" 10
+Search for services..
+.IP "" 10
 Known service names are DID, SP, DUN, LAN, FAX, OPUSH,
 FTP, HS, HF, HFAG, SAP, NAP, GN, PANU, HCRP, HID, CIP,
 A2SRC, A2SNK, AVRCT, AVRTG, UDIUE, UDITE and SYNCML.
-.IP "\fBbrowse [--tree] [--raw] [--xml] [bdaddr]\fP" 10 
-Browse all available services on the device 
-specified by a Bluetooth address as a parameter. 
+.IP "\fBbrowse [--tree] [--raw] [--xml] [bdaddr]\fP" 10
+Browse all available services on the device
+specified by a Bluetooth address as a parameter.
 .IP "\fBrecords [--tree] [--raw] [--xml] bdaddr\fP" 10
 Retrieve all possible service records.
-.IP "\fBadd [ --handle=N --channel=N ]\fP" 10 
-Add a service to the local  
-\fBsdpd\fR. 
+.IP "\fBadd [ --handle=N --channel=N ]\fP" 10
+Add a service to the local
+\fBsdpd\fR.
 .IP "" 10
 You can specify a handle for this record using
 the \fB--handle\fP option.
-.IP "" 10 
-You can specify a channel to add the service on 
-using the \fB--channel\fP option. 
-.IP "\fBdel record_handle\fP" 10 
-Remove a service from the local  
-\fBsdpd\fR. 
-.IP "\fBget [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle\fP" 10 
-Retrieve a service from the local  
-\fBsdpd\fR. 
-.IP "\fBsetattr record_handle attrib_id attrib_value\fP" 10 
-Set or add an attribute to an SDP record. 
- 
-.IP "\fBsetseq record_handle attrib_id attrib_values\fP" 10 
-Set or add an attribute sequence to an 
-SDP record. 
-.SH "OPTIONS" 
-.IP "\fB--help\fP" 10 
-Displays help on using sdptool. 
- 
-.SH "EXAMPLES" 
-.PP 
+.IP "" 10
+You can specify a channel to add the service on
+using the \fB--channel\fP option.
+.IP "\fBdel record_handle\fP" 10
+Remove a service from the local
+\fBsdpd\fR.
+.IP "\fBget [--tree] [--raw] [--xml] [--bdaddr bdaddr] record_handle\fP" 10
+Retrieve a service from the local
+\fBsdpd\fR.
+.IP "\fBsetattr record_handle attrib_id attrib_value\fP" 10
+Set or add an attribute to an SDP record.
+
+.IP "\fBsetseq record_handle attrib_id attrib_values\fP" 10
+Set or add an attribute sequence to an
+SDP record.
+.SH "OPTIONS"
+.IP "\fB--help\fP" 10
+Displays help on using sdptool.
+
+.SH "EXAMPLES"
+.PP
 sdptool browse 00:80:98:24:15:6D
-.PP 
+.PP
 sdptool browse local
-.PP 
+.PP
 sdptool add DUN
-.PP 
+.PP
 sdptool del 0x10000
-.SH "BUGS" 
-.PP 
-Documentation needs improving. 
-.SH "AUTHOR" 
-.PP 
-Maxim Krasnyansky <maxk@qualcomm.com>. Man page written 
-by Edd Dumbill <ejad@debian.org>. 
- 
-.SH "SEE ALSO" 
-.PP 
+.SH "BUGS"
+.PP
+Documentation needs improving.
+.SH "AUTHOR"
+.PP
+Maxim Krasnyansky <maxk@qualcomm.com>. Man page written
+by Edd Dumbill <ejad@debian.org>.
+
+.SH "SEE ALSO"
+.PP
 sdpd(8)
-.\" created by instant / docbook-to-man, Thu 15 Jan 2004, 21:01 
+.\" created by instant / docbook-to-man, Thu 15 Jan 2004, 21:01
-- 
1.6.3.1

