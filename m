Return-Path: <ELafargue@montrouge.sns.slb.com>
Date: Tue, 23 Mar 2004 19:31:22 +0100
From: Edouard Lafargue <ELafargue@montrouge.sns.slb.com>
Subject: Re: [Bluez-devel] Documentation for hcid.conf ?
In-reply-to: <1080064121.2515.35.camel@pegasus>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Collin R. Mulliner" <collin@betaversion.net>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Message-id: <1080066682.7507.90.camel@gryffindor>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_NuSFbaZM8xRkgLlWISEdCg)"
References: <1080053029.7507.40.camel@gryffindor>
 <20040323183818.3d21f901@coredump> <1080064121.2515.35.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>


--Boundary_(ID_NuSFbaZM8xRkgLlWISEdCg)
Content-type: multipart/alternative;
 boundary="Boundary_(ID_3W5x2eDuURtkdUHxwWB5wQ)"


--Boundary_(ID_3W5x2eDuURtkdUHxwWB5wQ)
Content-type: text/plain
Content-transfer-encoding: 7BIT


  Speaking of: attached is a first draft of a fairly detailed
"hcid.conf" man page (section 5), where I tried to detail most of the
options as much as possible. Send any corrections and/or to my address,
I will update it. Marcel, if you would like to include this in
bluez-utils, please do.

   This might actually be too detailed for most users, but at the same
time, hcid.conf is a really low-level file. Tell me what you think.

Regards,

Edouard

On Tue, 2004-03-23 at 18:48, Marcel Holtmann wrote:

> Hi Collin,
> 
> > buy the way ... how do I configure multiple bluetooth devices thru
> > hcid.conf?
> > 
> > How can one set the "options" and "defaults" for a specific device
> > (selected by BD_ADDR?) ... of course not all options make sense on a per
> > device configuration.
> 
> you can use this syntax:
> 
> 	device [hciX|bdaddr] {
> 	}
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-- 
Edouard Lafargue <ELafargue@montrouge.sns.slb.com>
Schlumberger NIS

--Boundary_(ID_3W5x2eDuURtkdUHxwWB5wQ)
Content-type: text/html; charset=utf-8
Content-transfer-encoding: 7BIT

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.9">
</HEAD>
<BODY>
<BR>
&nbsp; Speaking of: attached is a first draft of a fairly detailed &quot;hcid.conf&quot; man page (section 5), where I tried to detail most of the options as much as possible. Send any corrections and/or to my address, I will update it. Marcel, if you would like to include this in bluez-utils, please do.<BR>
<BR>
&nbsp;&nbsp; This might actually be too detailed for most users, but at the same time, hcid.conf is a really low-level file. Tell me what you think.<BR>
<BR>
Regards,<BR>
<BR>
Edouard<BR>
<BR>
On Tue, 2004-03-23 at 18:48, Marcel Holtmann wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#483689"><I>Hi Collin,

&gt; buy the way ... how do I configure multiple bluetooth devices thru
&gt; hcid.conf?
&gt; 
&gt; How can one set the &quot;options&quot; and &quot;defaults&quot; for a specific device
&gt; (selected by BD_ADDR?) ... of course not all options make sense on a per
&gt; device configuration.

you can use this syntax:

	device [hciX|bdaddr] {
	}

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.</FONT><A HREF="http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click"><U>http://ads.osdn.com/?ad_id=1470&amp;alloc_id=3638&amp;op=click</U></A>
<FONT COLOR="#483689">_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net</FONT>
<A HREF="https://lists.sourceforge.net/lists/listinfo/bluez-devel"><U>https://lists.sourceforge.net/lists/listinfo/bluez-devel</U></I></A></PRE>
</BLOCKQUOTE>
<PRE><TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Edouard Lafargue &lt;<A HREF="mailto:ELafargue@montrouge.sns.slb.com"><U>ELafargue@montrouge.sns.slb.com</U></A>&gt;<BR>
Schlumberger NIS
</TD>
</TR>
</TABLE>
</PRE>
</BODY>
</HTML>

--Boundary_(ID_3W5x2eDuURtkdUHxwWB5wQ)--

--Boundary_(ID_NuSFbaZM8xRkgLlWISEdCg)
Content-type: text/x-troff-man; name=hcid.conf.5; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=hcid.conf.5

.TH "HCID.CONF" "5" "March 2004" "hcid.conf - HCI daemon ver 2.4" "System management commands"
.SH "NAME"
/etc/bluetooth/hcid.conf \- Configuration file for the hcid Bluetooth HCI daemon

.SH "DESCRIPTION"
/etc/bluetooth/hcid.conf contains all the options needed by the Bluetooth Host Controller Interface daemon.

It consists of sections and parameters. A section begins with
the name of the section followed by optional specifiers and the
parameters inside curly brackets. Sections contain parameters of
the form:
.TP 
\fIname\fP \fIvalue1\fP, \fIvalue2\fP ... ;

.PP 
Any character after a hash ('#') character is ignored until newline.
Whitespace is also ignored.


The valid section names for
.B hcid.conf
are, at the moment:

.TP 
.B options
contains generic options for hcid and the pairing policy.
.TP 
.B device
contains lower\-level options for the hci devices connected to the computer.
.SH "OPTIONS SECTION"
The following parameters may be present in an option section:


.TP 
\fBautoinit\fP  yes|no

Automatically initialize newly connected devices. The default is \fIno\fP.


.TP 
\fBpairing\fP  none|multi|once

\fInone\fP means that pairing is disabled. \fImulti\fP allows pairing
with already paired devices. \fIonce\fP allows pairing once and denies
successive attempts. The default hcid configuration is shipped with \fBmulti\fP
enabled

.TP 
\fBpin_helper\fP "\fIfile\fP"

The path to the PIN helper application. The default is "/bin/bluepin".
The following output is expected from the PIN helper:

PIN:12345678

Or, when no PIN is available:

ERR

.TP 
\fBsecurity\fP  none|auto|user

\fInone\fP means the security manager is disabled. \fIauto\fP uses
local PIN for incoming connections. \fIuser\fP always asks the user
for a PIN.

.SH "DEVICE SECTION"
Parameters within a device section with no specifier, the default
device section, will be applied to all devices and device sections
where these are unspecified. The following optional device specifiers
are supported:

.TP 
\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP\fB:\fP\fInn\fP

Parameters specified within this section will be applied to the device
with this \fIdevice bluetooth address\fP. All other parameters are applied from
the default section.

.TP 
\fBhci\fIn\fP

Parameters specified within this section will be applied to the device
with this \fIdevice interface\fP, unless that device is matched by a
\fIdevice address\fP section. All other parameters are applied from
the default section.


.PP 
\fBNote\fP: Most of the options supported in the \fBdevice\fP section are described to some extent in the bluetooth specification version 1.2 Vol2, Part E section 6. Please refer to it for technical details.

.PP 
The following parameters may be present in a device section:

.TP 
\fBname\fP  "\fIname\fP"

The device name. \fI%d\fP inserts the device id. \fI%h\fP inserts
the host name.


.TP 
\fBauth\fP  enable|disable
Enables or disables authentication between local and remote devices when they connect.

Authentication is done following a challenge\-response mechanism described in the Bluetooth Specification 1.2 volume 2 part C section 4.2, and uses the link key generated during pairing as the shared secret.

.TP 
\fBencrypt\fP  enable|disable
Enable or disable link encryption. Should be set to enable in most cases, unless one of the devices does not support encryption for some reason.

Encryption can only occur on authenticated connections, as a shared secret key is necessary for encryption to work. The detailed encryption mechanism is described in the bluetooth specification as mentioned above.


.TP 
\fBclass\fP  0x\fISSDDdd\fP (three bytes)

The Bluetooth Device Class is described in the Bluetooth Specification section 1.2 ("Assigned Numbers \- Bluetooth Baseband").

The default shipped with hcid is 0x000100 which simply stands for "Computer".

The Bluetooth device class is a high\-level description of the bluetooth device, composed of three bytes: the "Major Service Class" (byte "SS" above), the "Major Device Class" (byte "DD" above) and the "Minor Device Class" (byte "dd" above). These classes describe the high\-level capabilities of the device, such as "Networking Device", "Computer", etc. This information is often used by clients who are looking for a certain type of service around them.

Where it becomes tricky is that another type of mechanism for service discovery exists: "SDP", as in "Service Discovery Protocol".

In practice, most Bluetooth clients scan their surroundings in two successive steps: they first look for all bluetooth devices around them and find out their "class". You can do this on Linux with the \fBhcitool scan\fP command. Then, they use SDP in order to check if a device in a given class offers the type of service that they want.

This means that the hcid.conf "class" parameter needs to be set up properly if particular services are running on the host, such as "PAN", or "OBEX Obect Push", etc: in general a device looking for a service such as "Network Access Point" will only scan for this service on devices containing "Networking" in their major service class.


.IP 
Major service class byte allocation (from LSB to MSB):

Bit 1:	Positioning (Location identification)

Bit 2:  Networking (LAN, Ad hoc, ...)

Bit 3:  Rendering (Printing, Speaker, ...)

Bit 4:  Capturing (Scanner, Microphone, ...)

Bit 5:  Object Transfer (v\-Inbox, v\-Folder, ...)

Bit 6:  Audio (Speaker, Microphone, Headset service, ...)

Bit 7:  Telephony (Cordless telephony, Modem, Headset service, ...)

Bit 8:  Information (WEB\-server, WAP\-server, ...)

.IP 
Example: class 0x02hhhh : the device offers networking service


.IP 
Major device class allocation:

0x00: Miscellaneous

0x01: Computer (desktop,notebook, PDA, organizers, .... )

0x02: Phone (cellular, cordless, payphone, modem, ...)

0x03: LAN /Network Access point

0x04: Audio/Video (headset,speaker,stereo, video display, vcr.....

0x05: Peripheral (mouse, joystick, keyboards, ..... )

0x06: Imaging (printing, scanner, camera, display, ...)

Other values are not defined (refer to the Bluetooth specification for more details

.IP 
Minor device class allocation: the meaning of this byte depends on the major class allocation, please refer to the Bluetooth specifications for more details).

.IP 
.B Example:
if PAND runs on your server, you need to set up at least \fBclass 0x020100\fP, which stands for "Service Class: Networking" and "Device Class: Computer, Uncategorized".


.TP 
\fBiscan\fP  enable|disable
.TP 
\fBpscan\fP  enable|disable

Bluetooth devices discover and connect to each other through the use of two special Bluetooth channels, the Inquiry and Page channels (described in the Bluetooth Spec Volume 1, Part A, Section 3.3.3, page 35). These two options enable the channels on the bluetooth device.

\fBiscan enable\fP: makes the bluetooth device "discoverable" by enabling it to answer "inquiries" from other nearby bluetooth devices.

\fBpscan enable\fP: makes the bluetooth device "connectable to" by enabling the use of the "page scan" channel.

.TP 
\fBlm\fP  none|accept,master

\fInone\fP means no specific policy. \fIaccept\fP means always accept
incoming connections. \fImaster\fP means become master on incoming
connections and deny role switch on outgoing connections.

.TP 
\fBlp\fP  none|rswitch,hold,sniff,park

\fInone\fP means no specific policy. \fIrswitch\fP means allow role
switch. \fIhold\fP means allow hold mode. \fIsniff\fP means allow
sniff mode. \fIpark\fP means allow park mode. Several options can be
combined.

This option determines the various operational modes that are allowed for this device when it participates to a piconet. Normally  hold and sniff should be enabled for standard operations.

hold: this mode is related to synchronous communications (SCO voice channel for example).

sniff: when in this mode, a device is only present on the piconet during determined slots of time, allowing it to do other things when it is "absent", for example to scan for other bluetooth devices.

park:  this is a mode where the device is put on standby on the piconet, for power\-saving purposes for example.

rswitch: this is a mode that enables role\-switch (master <\-> slave) between two devices in a piconet. It is not clear whether this needs to be enabled in order to make the "lm master" setting work properly or not.




.TP 
\fBpkt_type\fP  DH1,DM1,HV1, etc.

This fairly obscure option determines the packet types that the bluetooth device will send or accept. This is a very low\-level option that should probably not be changed for normal use. You do not need to specify defaults.

You can check the Bluetooth specification version 1.2 Volume 2, Part B section 6 for more details about this.
.SH "FILES"
.TP 
.I /etc/bluetooth/hcid.conf
Default location of the global configuration file.

.SH "AUTHOR"
This manual page was written by Edouard Lafargue, Fredrik Noring and Maxim Krasnyansky.

--Boundary_(ID_NuSFbaZM8xRkgLlWISEdCg)--
