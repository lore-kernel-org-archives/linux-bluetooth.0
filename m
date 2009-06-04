Return-Path: <cyrus@holtmann.org>
From: Zygo Blaxell <zygo.blaxell@xandros.com>
To: linux-bluetooth@vger.kernel.org
Cc: Zygo Blaxell <zygo.blaxell@xandros.com>
Subject: [PATCH] Remove some dead files that are no longer distributed
Date: Thu,  4 Jun 2009 16:05:39 -0400
Message-Id: <1244145939-32456-3-git-send-email-zygo.blaxell@xandros.com>
In-Reply-To: <1244145939-32456-2-git-send-email-zygo.blaxell@xandros.com>
References: <1244145939-32456-1-git-send-email-zygo.blaxell@xandros.com>
 <1244145939-32456-2-git-send-email-zygo.blaxell@xandros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/module-bluetooth-sink.c |   39 -------
 doc/node-api.txt              |   28 -----
 src/hcid.conf                 |   57 ----------
 src/hcid.conf.5               |  227 -----------------------------------------
 4 files changed, 0 insertions(+), 351 deletions(-)
 delete mode 100644 audio/module-bluetooth-sink.c
 delete mode 100644 doc/node-api.txt
 delete mode 100644 src/hcid.conf
 delete mode 100644 src/hcid.conf.5

diff --git a/audio/module-bluetooth-sink.c b/audio/module-bluetooth-sink.c
deleted file mode 100644
index 2944d18..0000000
--- a/audio/module-bluetooth-sink.c
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#if 0
-#include <pulsecore/module.h>
-
-PA_MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>")
-PA_MODULE_DESCRIPTION("Bluetooth sink")
-PA_MODULE_VERSION(VERSION)
-
-int pa__init(pa_core *core, pa_module *module)
-{
-	return 0;
-}
-#endif
diff --git a/doc/node-api.txt b/doc/node-api.txt
deleted file mode 100644
index 7a33dab..0000000
--- a/doc/node-api.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-BlueZ D-Bus Node API description
-********************************
-
-Copyright (C) 2004-2008  Marcel Holtmann <marcel@holtmann.org>
-
-
-Node hierarchy
-==============
-
-Service		org.bluez
-Interface	org.bluez.Node
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/{node0,...}
-
-Methods		dict GetProperties()
-
-			Returns all properties for the device node. See the
-			properties section for available properties.
-
-			Possible Errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.InvalidArguments
-
-Properties	string Name [readonly]
-
-			The name of the node. For example "rfcomm0".
-
-		object Device [readonly]
-
-			The object path of the device this node belongs to.
diff --git a/src/hcid.conf b/src/hcid.conf
deleted file mode 100644
index b6ce3b4..0000000
--- a/src/hcid.conf
+++ /dev/null
@@ -1,57 +0,0 @@
-#
-# HCI daemon configuration file.
-#
-
-# HCId options
-options {
-	# Automatically initialize new devices
-	autoinit yes;
-
-	# Security Manager mode
-	#   none - Security manager disabled
-	#   auto - Use local PIN for incoming connections
-	#   user - Always ask user for a PIN
-	#
-	security user;
-
-	# Pairing mode
-	#   none  - Pairing disabled
-	#   multi - Allow pairing with already paired devices
-	#   once  - Pair once and deny successive attempts
-	pairing multi;
-
-	# Default PIN code for incoming connections
-	passkey "BlueZ";
-}
-
-# Default settings for HCI devices
-device {
-	# Local device name
-	#   %d - device id
-	#   %h - host name
-	name "BlueZ (%d)";
-
-	# Local device class
-	class 0x000100;
-
-	# Default packet type
-	#pkt_type DH1,DM1,HV1;
-
-	# Inquiry and Page scan
-	iscan enable; pscan enable;
-
-	# Default link mode
-	#   none   - no specific policy 
-	#   accept - always accept incoming connections
-	#   master - become master on incoming connections,
-	#            deny role switch on outgoing connections
-	lm accept;
-
-	# Default link policy
-	#   none    - no specific policy
-	#   rswitch - allow role switch
-	#   hold    - allow hold mode
-	#   sniff   - allow sniff mode
-	#   park    - allow park mode
-	lp rswitch,hold,sniff,park;
-}
diff --git a/src/hcid.conf.5 b/src/hcid.conf.5
deleted file mode 100644
index cb5bcfa..0000000
--- a/src/hcid.conf.5
+++ /dev/null
@@ -1,227 +0,0 @@
-.TH "HCID.CONF" "5" "March 2004" "hcid.conf - HCI daemon" "System management commands"
-.SH "NAME"
-/etc/bluetooth/hcid.conf \- Configuration file for the hcid Bluetooth HCI daemon
-
-.SH "DESCRIPTION"
-/etc/bluetooth/hcid.conf contains all the options needed by the Bluetooth Host Controller Interface daemon.
-
-It consists of sections and parameters. A section begins with
-the name of the section followed by optional specifiers and the
-parameters inside curly brackets. Sections contain parameters of
-the form:
-.TP 
-\fIname\fP \fIvalue1\fP, \fIvalue2\fP ... ;
-
-.PP 
-Any character after a hash ('#') character is ignored until newline.
-Whitespace is also ignored.
-
-
-The valid section names for
-.B hcid.conf
-are, at the moment:
-
-.TP 
-.B options
-contains generic options for hcid and the pairing policy.
-.TP 
-.B device
-contains lower\-level options for the hci devices connected to the computer.
-.SH "OPTIONS SECTION"
-The following parameters may be present in an option section:
-
-
-.TP 
-\fBautoinit\fP  yes|no
-
-Automatically initialize newly connected devices. The default is \fIno\fP.
-
-
-.TP 
-\fBpairing\fP  none|multi|once
-
-\fInone\fP means that pairing is disabled. \fImulti\fP allows pairing
-with already paired devices. \fIonce\fP allows pairing once and denies
-successive attempts. The default hcid configuration is shipped with \fBmulti\fP
-enabled
-
-.TP 
-\fBoffmode\fP  noscan|devdown
-
-\fInoscan\fP means that page and inquiry scans are disabled when you call
-SetMode("off"). \fIdevdown\fP sets the adapter into down state (same what
-\fIhciconfig hci0 down\fP does).
-
-.TP
-\fBdeviceid\fP	<vendor>:<product>:<version>
-
-This option allows to specify the vendor and product information of the
-Bluetooth device ID service record.
-
-.TP
-\fBpasskey\fP "\fIpin\fP"
-
-The default PIN for incoming connections if \fBsecurity\fP has been
-set to \fIauto\fP.
-
-.TP 
-\fBsecurity\fP  none|auto|user
-
-\fInone\fP means the security manager is disabled. \fIauto\fP uses
-local PIN, by default from pin_code, for incoming
-connections. \fIuser\fP always asks the user for a PIN.
-
-.SH "DEVICE SECTION"
-Parameters within a device section with no specifier, the default
-device section, will be applied to all devices and device sections
-where these are unspecified. The following optional device specifiers
-are supported:
-
-.TP 
-\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP
-
-Parameters specified within this section will be applied to the device
-with this \fIdevice bluetooth address\fP. All other parameters are applied from
-the default section.
-
-.TP 
-\fBhci\fIn\fP
-
-Parameters specified within this section will be applied to the device
-with this \fIdevice interface\fP, unless that device is matched by a
-\fIdevice address\fP section. All other parameters are applied from
-the default section.
-
-
-.PP 
-\fBNote\fP: Most of the options supported in the \fBdevice\fP section are described to some extent in the bluetooth specification version 1.2 Vol2, Part E section 6. Please refer to it for technical details.
-
-.PP 
-The following parameters may be present in a device section:
-
-.TP 
-\fBname\fP  "\fIname\fP"
-
-The device name. \fI%d\fP inserts the device id. \fI%h\fP inserts
-the host name.
-
-
-.TP 
-\fBclass\fP  0x\fISSDDdd\fP (three bytes)
-
-The Bluetooth Device Class is described in the Bluetooth Specification section 1.2 ("Assigned Numbers \- Bluetooth Baseband").
-
-The default shipped with hcid is 0x000100 which simply stands for "Computer".
-
-The Bluetooth device class is a high\-level description of the bluetooth device, composed of three bytes: the "Major Service Class" (byte "SS" above), the "Major Device Class" (byte "DD" above) and the "Minor Device Class" (byte "dd" above). These classes describe the high\-level capabilities of the device, such as "Networking Device", "Computer", etc. This information is often used by clients who are looking for a certain type of service around them.
-
-Where it becomes tricky is that another type of mechanism for service discovery exists: "SDP", as in "Service Discovery Protocol".
-
-In practice, most Bluetooth clients scan their surroundings in two successive steps: they first look for all bluetooth devices around them and find out their "class". You can do this on Linux with the \fBhcitool scan\fP command. Then, they use SDP in order to check if a device in a given class offers the type of service that they want.
-
-This means that the hcid.conf "class" parameter needs to be set up properly if particular services are running on the host, such as "PAN", or "OBEX Obect Push", etc: in general a device looking for a service such as "Network Access Point" will only scan for this service on devices containing "Networking" in their major service class.
-
-
-.IP 
-Major service class byte allocation (from LSB to MSB):
-
-Bit 1:	Positioning (Location identification)
-
-Bit 2:  Networking (LAN, Ad hoc, ...)
-
-Bit 3:  Rendering (Printing, Speaker, ...)
-
-Bit 4:  Capturing (Scanner, Microphone, ...)
-
-Bit 5:  Object Transfer (v\-Inbox, v\-Folder, ...)
-
-Bit 6:  Audio (Speaker, Microphone, Headset service, ...)
-
-Bit 7:  Telephony (Cordless telephony, Modem, Headset service, ...)
-
-Bit 8:  Information (WEB\-server, WAP\-server, ...)
-
-.IP 
-Example: class 0x02hhhh : the device offers networking service
-
-
-.IP 
-Major device class allocation:
-
-0x00: Miscellaneous
-
-0x01: Computer (desktop,notebook, PDA, organizers, .... )
-
-0x02: Phone (cellular, cordless, payphone, modem, ...)
-
-0x03: LAN /Network Access point
-
-0x04: Audio/Video (headset,speaker,stereo, video display, vcr.....
-
-0x05: Peripheral (mouse, joystick, keyboards, ..... )
-
-0x06: Imaging (printing, scanner, camera, display, ...)
-
-Other values are not defined (refer to the Bluetooth specification for more details
-
-.IP 
-Minor device class allocation: the meaning of this byte depends on the major class allocation, please refer to the Bluetooth specifications for more details).
-
-.IP 
-.B Example:
-if PAND runs on your server, you need to set up at least \fBclass 0x020100\fP, which stands for "Service Class: Networking" and "Device Class: Computer, Uncategorized".
-
-
-.TP 
-\fBiscan\fP  enable|disable
-.TP 
-\fBpscan\fP  enable|disable
-
-Bluetooth devices discover and connect to each other through the use of two special Bluetooth channels, the Inquiry and Page channels (described in the Bluetooth Spec Volume 1, Part A, Section 3.3.3, page 35). These two options enable the channels on the bluetooth device.
-
-\fBiscan enable\fP: makes the bluetooth device "discoverable" by enabling it to answer "inquiries" from other nearby bluetooth devices.
-
-\fBpscan enable\fP: makes the bluetooth device "connectable to" by enabling the use of the "page scan" channel.
-
-.TP 
-\fBlm\fP  none|accept,master
-
-\fInone\fP means no specific policy. \fIaccept\fP means always accept
-incoming connections. \fImaster\fP means become master on incoming
-connections and deny role switch on outgoing connections.
-
-.TP 
-\fBlp\fP  none|rswitch,hold,sniff,park
-
-\fInone\fP means no specific policy. \fIrswitch\fP means allow role
-switch. \fIhold\fP means allow hold mode. \fIsniff\fP means allow
-sniff mode. \fIpark\fP means allow park mode. Several options can be
-combined.
-
-This option determines the various operational modes that are allowed for this device when it participates to a piconet. Normally  hold and sniff should be enabled for standard operations.
-
-hold: this mode is related to synchronous communications (SCO voice channel for example).
-
-sniff: when in this mode, a device is only present on the piconet during determined slots of time, allowing it to do other things when it is "absent", for example to scan for other bluetooth devices.
-
-park:  this is a mode where the device is put on standby on the piconet, for power\-saving purposes for example.
-
-rswitch: this is a mode that enables role\-switch (master <\-> slave) between two devices in a piconet. It is not clear whether this needs to be enabled in order to make the "lm master" setting work properly or not.
-
-.TP 
-\fBpageto\fP  \fIn\fP
-
-Page Timeout measured in number of baseband slots. Interval length = N * 0.625 msec (1 baseband slot)
-
-.TP 
-\fBdiscovto\fP  \fIn\fP
-
-The time in seconds that the device will stay in discoverable mode. 0 disables this feature and forces the device to be always discoverable.
-
-.SH "FILES"
-.TP 
-.I /etc/bluetooth/hcid.conf
-Default location of the global configuration file.
-
-.SH "AUTHOR"
-This manual page was written by Edouard Lafargue, Fredrik Noring, Maxim Krasnyansky and Marcel Holtmann.
-- 
1.5.6.5

