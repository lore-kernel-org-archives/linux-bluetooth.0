Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: =?windows-1252?Q?G=F6tz_Issel?= <g.issel@fh-wolfenbuettel.de>
To: bluez-devel@lists.sourceforge.net
Message-id: <56a2c5bc55.5bc5556a2c@fh-wolfenbuettel.de>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_+18PoeZmH692/p1i99bxIg)"
Subject: [Bluez-devel] Re: Re: Re: Infineon hardware "SingleStone PBA31307"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 22 Feb 2006 11:14:34 +0100

This is a multi-part message in MIME format.

--Boundary_(ID_+18PoeZmH692/p1i99bxIg)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Re: Infineon hardware "SingleStone PBA31307" (Marcel Holtmann)

Hi Marcel, 
I got the hardware to work simply by using the manufacturer "any" with
the hciattach tool. Problem before was hardware based. 

Now I will try to implement SAP and will probably come back to you on
some upcoming problems.

Goetz

--Boundary_(ID_+18PoeZmH692/p1i99bxIg)
Content-type: message/rfc822

Return-path: <bluez-devel-admin@lists.sourceforge.net>
Received: from conversion-daemon.mail.fh-wolfenbuettel.de by
 mail.fh-wolfenbuettel.de
 (iPlanet Messaging Server 5.2 HotFix 2.04 (built Feb  8 2005))
 id <0IUM00D01ZGWAE@mail.fh-wolfenbuettel.de>
 (original mail from bluez-devel-admin@lists.sourceforge.net)
 for g.issel@fh-wolfenbuettel.de; Mon, 13 Feb 2006 18:52:24 +0100 (MET)
Received: from mailgate.fh-wolfenbuettel.de
 (mailgate.fh-wolfenbuettel.de [141.41.1.160]) by mail.fh-wolfenbuettel.de
 (iPlanet Messaging Server 5.2 HotFix 2.04 (built Feb  8 2005))
 with ESMTP id <0IUN00CG00BC96@mail.fh-wolfenbuettel.de> for
 g.issel@fh-wolfenbuettel.de; Mon, 13 Feb 2006 18:52:24 +0100 (MET)
Received: from lists-outbound.sourceforge.net
 (lists-outbound.sourceforge.net [66.35.250.225])
	by mailgate.fh-wolfenbuettel.de (8.12.11/8.12.11) with ESMTP id k1DIvKiT020256
	for <g.issel@fh-wolfenbuettel.de>; Mon, 13 Feb 2006 19:57:21 +0100
Received: from sc8-sf-list2-b.sourceforge.net
 (sc8-sf-list2-b.sourceforge.net [10.3.1.8])	by sc8-sf-spam1.sourceforge.net
 (Postfix) with ESMTP	id CD1D5892F7; Mon, 13 Feb 2006 09:52:14 -0800 (PST)
Date: Mon, 13 Feb 2006 09:51:16 -0800
From: bluez-devel-request@lists.sourceforge.net
Subject: Bluez-devel digest, Vol 1 #1902 - 12 msgs
Sender: bluez-devel-admin@lists.sourceforge.net
To: bluez-devel@lists.sourceforge.net
Errors-to: bluez-devel-admin@lists.sourceforge.net
Reply-to: bluez-devel@lists.sourceforge.net
X-Reply-to: bluez-devel@lists.sourceforge.net
Message-id: <20060213175214.CD1D5892F7@sc8-sf-spam1.sourceforge.net>
MIME-version: 1.0
X-Mailer: Mailman v2.0.9-sf.net
Content-type: text/plain
Content-transfer-encoding: 7BIT
Precedence: bulk
X-BeenThere: bluez-devel@lists.sourceforge.net
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.3.0.0,
 Antispam-Data: 2006.02.13.091206 (FH-Wolfenbuettel.DE)
X-PMX-Spam: Gauge=IIIIIII, Probability=7%
X-PMX-Spam-Report: Report=The following antispam rules were triggered by this
 message:	Rule          Score Description	NO_REAL_NAME  0.000 From: does not
 include a real name
X-PMX-Spam-Level: IIIIIII
X-PMX-Spam-Status: NO
X-Mailman-Version: 2.0.9-sf.net
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
Original-recipient: rfc822;g.issel@fh-wolfenbuettel.de

Send Bluez-devel mailing list submissions to
	bluez-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.sourceforge.net/lists/listinfo/bluez-devel
or, via email, send a message with subject or body 'help' to
	bluez-devel-request@lists.sourceforge.net

You can reach the person managing the list at
	bluez-devel-admin@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Bluez-devel digest..."


Today's Topics:

   1. Re: [DBUS PATCH] BlueZ D-Bus redesign (Johan Hedberg)
   2. Re: [DBUS PATCH] BlueZ D-Bus redesign (Marcel Holtmann)
   3. Deprecating some hcid.conf options (Marcel Holtmann)
   4. Re: Can't discover device (Marcel Holtmann)
   5. Re: [DBUS PATCH] BlueZ D-Bus redesign (Claudio Takahasi)
   6. Re: [DBUS PATCH] BlueZ D-Bus redesign (Marcel Holtmann)
   7. Re: [DBUS PATCH] BlueZ D-Bus redesign (Claudio Takahasi)
   8. Re: [DBUS PATCH] BlueZ D-Bus redesign (Marcel Holtmann)
   9. Infineon hardware "SingleStone PBA31307" (=?windows-1252?Q?G=F6tz_Issel?=)
  10. Re: Infineon hardware "SingleStone PBA31307" (Marcel Holtmann)
  11. Re: Re: Developing Broadcom driver support (Brad Midgley)
  12. [DBUS PATCH] scan mode (Claudio Takahasi)

--__--__--

Message: 1
Date: Mon, 13 Feb 2006 09:30:21 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
Reply-To: bluez-devel@lists.sourceforge.net

Hi Marcel,

On Sat, Feb 11, 2006, Marcel Holtmann wrote:
> > Btw Marcel, the API document should probably be added to CVS or
> > published on this list since AFAIK currently you, I, Claudio and Eduardo
> > are the only ones in posession of it.
> 
> Actually I wanted to wait until it is in a better shape, but since they
> mentioned it several times on the mailing list, we should make it public
> anyway. Please do a last review and then I commit it to the CVS.

I don't have currently any big issues with it. One thing we may want to
add to it in the future is descriptions of the different types of errors
that the methods can return.

> > > Should we split the Manager interface and the Device interface into two
> > > separate files?
> > 
> > I think that would make sense. That way you could also define clearer
> > interfaces between them in the code (function wise).
> 
> Any proposals on how we gonna do the split?

I see you've already made the split in CVS, and it looks ok. I'd
probably split the dbus.h file also into separate files (one for each .c
file). At some point we might also need a "dbus-common.c" file for
common helper functions (e.g. the client lifetime tracking may be one
thing that could go into it).

Johan


--__--__--

Message: 2
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 13 Feb 2006 09:03:22 +0100
Reply-To: bluez-devel@lists.sourceforge.net

Hi Johan,

> > > Btw Marcel, the API document should probably be added to CVS or
> > > published on this list since AFAIK currently you, I, Claudio and Eduardo
> > > are the only ones in posession of it.
> > 
> > Actually I wanted to wait until it is in a better shape, but since they
> > mentioned it several times on the mailing list, we should make it public
> > anyway. Please do a last review and then I commit it to the CVS.
> 
> I don't have currently any big issues with it. One thing we may want to
> add to it in the future is descriptions of the different types of errors
> that the methods can return.

and I am thinking of re-designing the errors. Once you deal with
languages like C# or Java, you might wanna have clear exceptions.

However we need an updated dbus-test script. Can someone please address
this.

> > > > Should we split the Manager interface and the Device interface into two
> > > > separate files?
> > > 
> > > I think that would make sense. That way you could also define clearer
> > > interfaces between them in the code (function wise).
> > 
> > Any proposals on how we gonna do the split?
> 
> I see you've already made the split in CVS, and it looks ok. I'd
> probably split the dbus.h file also into separate files (one for each .c
> file). At some point we might also need a "dbus-common.c" file for
> common helper functions (e.g. the client lifetime tracking may be one
> thing that could go into it).

The split is not perfect, because we have overlaps for that I had to
introduce some ugly hacks to get them working. However the current split
makes it a little bit easier to work with the code. I also introduced
some generic device handling. In the end this layer should take care of
the inquiry cache and the connection tracking.

The Manager part should work now as expected, but I had some small race
condition with the BD_ADDR. So I think we send the DeviceAdded signal a
little bit too soon. I worked around it with re-reading the address if
it hasn't been set correctly.

Does anybody know how to receive D-Bus signals within C#? I started to
write some bluetooth-sharp bindings for the BlueZ D-Bus API, but I can't
find any documentation on how to deal with the signals. The methods
stuff is working perfect.

Regards

Marcel




--__--__--

Message: 3
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 13 Feb 2006 09:26:19 +0100
Subject: [Bluez-devel] Deprecating some hcid.conf options
Reply-To: bluez-devel@lists.sourceforge.net

Hi,

while working on the D-Bus interface, I came along some unneeded complex
functionality inside hcid and its configuration options. The questions
is now what options are really used and what haven't been changed by
anyone.

Does someone uses hcid with autoinit disabled?

What about the security and pairing option? What do we really need?

The iscan and pscan will combined into a new mode option.

Changing the pkt_type is useless and will be removed no matter what.

The auth and encrypt options will also be removed, because we don't
support security mode 3 anymore.

Do we need link policy setting or should hcid calculate the best setting
from the supported features?

Regards

Marcel




--__--__--

Message: 4
Subject: Re: [Bluez-devel] Can't discover device
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 13 Feb 2006 09:30:36 +0100
Reply-To: bluez-devel@lists.sourceforge.net

Hi Arpit,

> That fixed the problem. But its funny, coz everytime I restart the
> computer I have to run piscan.Hmm.

I've seen this race conditions with some dongles, but not with all of
them and it seems the HCI flow control is broken on these. However I
never fully investigated why this happens.

Regards

Marcel




--__--__--

Message: 5
Date: Mon, 13 Feb 2006 10:44:01 -0200
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
Reply-To: bluez-devel@lists.sourceforge.net

Hi,

On 2/13/06, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> Hi Marcel,
>
> On Sat, Feb 11, 2006, Marcel Holtmann wrote:
> > > Btw Marcel, the API document should probably be added to CVS or
> > > published on this list since AFAIK currently you, I, Claudio and Edua=
rdo
> > > are the only ones in posession of it.
> >
> > Actually I wanted to wait until it is in a better shape, but since they
> > mentioned it several times on the mailing list, we should make it publi=
c
> > anyway. Please do a last review and then I commit it to the CVS.
>
> I don't have currently any big issues with it. One thing we may want to
> add to it in the future is descriptions of the different types of errors
> that the methods can return.
>
> > > > Should we split the Manager interface and the Device interface into=
 two
> > > > separate files?
> > >
> > > I think that would make sense. That way you could also define clearer
> > > interfaces between them in the code (function wise).
> >
> > Any proposals on how we gonna do the split?
>
> I see you've already made the split in CVS, and it looks ok. I'd
> probably split the dbus.h file also into separate files (one for each .c
> file). At some point we might also need a "dbus-common.c" file for
> common helper functions (e.g. the client lifetime tracking may be one
> thing that could go into it).
[Claudio Takahasi]
1. The functions get_device_name(hcitool.c) and
get_peer_name(dbus-device.c) does the same thing. We should move it to
a common file.
2. The header file dbus.h intends to be a file used by D-Bus client
developers. There are some constants, type definition and function
prototypes that we could move to internal header file:
"dbus-internal.h" or split into separeted file(one for each .c file -
according with Johan's suggestion).


Regards,
Claudio.

>
> Johan
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


--__--__--

Message: 6
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 13 Feb 2006 13:51:42 +0100
Reply-To: bluez-devel@lists.sourceforge.net

Hi Claudio,

> 1. The functions get_device_name(hcitool.c) and
> get_peer_name(dbus-device.c) does the same thing. We should move it to
> a common file.

not right now. The code duplication is that small that I have no
problems with it and creating another internal library for it, is way
too much overhead.

> 2. The header file dbus.h intends to be a file used by D-Bus client
> developers. There are some constants, type definition and function
> prototypes that we could move to internal header file:
> "dbus-internal.h" or split into separeted file(one for each .c file -
> according with Johan's suggestion).

I have no favor in any direction at the moment, but I don't think that
we need a global dbus.h file for other C clients using the D-Bus
interface. My understanding is that no client should depend on any code
or headers provided by bluez-libs or bluez-utils. We will make a clean
split with the D-Bus API. If this means that every client has some kind
of duplication, so will be it.

Regards

Marcel




--__--__--

Message: 7
Date: Mon, 13 Feb 2006 11:37:31 -0200
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
Reply-To: bluez-devel@lists.sourceforge.net

Hi guys,

Just to avoid code conflicts, I will start implement the
discoverable/connectable functions. Eduardo told me that he can fix
the dbus-test python script.

Regards,
Claudio.


On 2/13/06, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>
> > 1. The functions get_device_name(hcitool.c) and
> > get_peer_name(dbus-device.c) does the same thing. We should move it to
> > a common file.
>
> not right now. The code duplication is that small that I have no
> problems with it and creating another internal library for it, is way
> too much overhead.
>
> > 2. The header file dbus.h intends to be a file used by D-Bus client
> > developers. There are some constants, type definition and function
> > prototypes that we could move to internal header file:
> > "dbus-internal.h" or split into separeted file(one for each .c file -
> > according with Johan's suggestion).
>
> I have no favor in any direction at the moment, but I don't think that
> we need a global dbus.h file for other C clients using the D-Bus
> interface. My understanding is that no client should depend on any code
> or headers provided by bluez-libs or bluez-utils. We will make a clean
> split with the D-Bus API. If this means that every client has some kind
> of duplication, so will be it.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT


--__--__--

Message: 8
Subject: Re: [Bluez-devel] [DBUS PATCH] BlueZ D-Bus redesign
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 13 Feb 2006 15:16:35 +0100
Reply-To: bluez-devel@lists.sourceforge.net

Hi Claudio,

> Just to avoid code conflicts, I will start implement the
> discoverable/connectable functions.

go ahead. I have some other stuff to finish first.

> Eduardo told me that he can fix
> the dbus-test python script.

That would be great.

Regards

Marcel




--__--__--

Message: 9
Date: Mon, 13 Feb 2006 17:03:07 +0100
From: =?windows-1252?Q?G=F6tz_Issel?= <g.issel@fh-wolfenbuettel.de>
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Infineon hardware "SingleStone PBA31307"
Reply-To: bluez-devel@lists.sourceforge.net

Hi all, 

I am trying to get the Infineon bluetooth hardware to work. Exact name
is: PBA31307 SingleStone. It is a bluetooth module with a serial interface. 
See link:
http://www.infineon.com/cgi-bin/ifx/portal/ep/channelView.do?channelId=-65244&channelPage=%2Fep%2Fchannel%2FproductOverview.jsp&pageTypeId=17099

I am using the 2.4.19 kernel with bluez-libs-2.25 and bluez-utils-2.25. 

Maybe someone can aggree or correct me on the assumption that  

1. I need to add the initialisation sequence for this hardware to
bluez-utils-2.25/tools/hciattach.c ?

2. and then use i.e. "hciattach -s 115200 /dev/ttyS2 infineon" in the
shell followed by "hciconfig hci0 up" etc ?



The problems will arise with the correct initialisation I guess. I do
have a datasheet with a suggested sequence which is:

--------------------------------------------------------

# Initialisation sequence on PMB8761 v7.50 for Singlestone
# Switch to manufacturer mode

send: Infineon_Manufacturer_Mode
Mode_Switch: 0x01
Reset: 0x00

received: Command_Complete
Num_HCI_Command_Packets: 0x01
Command_Opcode: Infineon_Manufacturer_Mode (0xfc11)
Status: Command succeeded (0x00)

send: Infineon_Write_Clock_Data
Clock_Control1: 0x000088
Clock_Control2: 0x641415
Freq_Dev: 0xc8
RF_Boost: 0x3c
Startup_Control: 0x02
Sascal: 0x00
# UART rate is 115200 bit/s
Sabaud: 0x70
Multiple_Clock: 0x000000b4b405
LPM_Drift: 0x00

received: Command_Status
Status: Command succeeded (0x00)
Num_HCI_Command_Packets: 0x01
Command_Opcode: 0xfc1e

--------------------------------------------------------

and so on. Question: what about the longer hex numbers, i.e.
Command_Opcode: Infineon_Manufacturer_Mode (0xfc11) ? I figured out the
2 digit hex numbers, but how to send the longer ones as hci command? 

Any help appreciated.

Greetings from Germany,

goetz


--__--__--

Message: 10
Subject: Re: [Bluez-devel] Infineon hardware "SingleStone PBA31307"
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 13 Feb 2006 17:24:37 +0100
Reply-To: bluez-devel@lists.sourceforge.net

Hi Goetz,

> I am trying to get the Infineon bluetooth hardware to work. Exact name
> is: PBA31307 SingleStone. It is a bluetooth module with a serial interface. 
> See link:
> http://www.infineon.com/cgi-bin/ifx/portal/ep/channelView.do?channelId=-65244&channelPage=%2Fep%2Fchannel%2FproductOverview.jsp&pageTypeId=17099
> 
> I am using the 2.4.19 kernel with bluez-libs-2.25 and bluez-utils-2.25. 
> 
> Maybe someone can aggree or correct me on the assumption that  
> 
> 1. I need to add the initialisation sequence for this hardware to
> bluez-utils-2.25/tools/hciattach.c ?
> 
> 2. and then use i.e. "hciattach -s 115200 /dev/ttyS2 infineon" in the
> shell followed by "hciconfig hci0 up" etc ?

that is basically what is needed to make this device work.

> The problems will arise with the correct initialisation I guess. I do
> have a datasheet with a suggested sequence which is:
> 
> --------------------------------------------------------
> 
> # Initialisation sequence on PMB8761 v7.50 for Singlestone
> # Switch to manufacturer mode
> 
> send: Infineon_Manufacturer_Mode
> Mode_Switch: 0x01
> Reset: 0x00
> 
> received: Command_Complete
> Num_HCI_Command_Packets: 0x01
> Command_Opcode: Infineon_Manufacturer_Mode (0xfc11)
> Status: Command succeeded (0x00)
> 
> send: Infineon_Write_Clock_Data
> Clock_Control1: 0x000088
> Clock_Control2: 0x641415
> Freq_Dev: 0xc8
> RF_Boost: 0x3c
> Startup_Control: 0x02
> Sascal: 0x00
> # UART rate is 115200 bit/s
> Sabaud: 0x70
> Multiple_Clock: 0x000000b4b405
> LPM_Drift: 0x00
> 
> received: Command_Status
> Status: Command succeeded (0x00)
> Num_HCI_Command_Packets: 0x01
> Command_Opcode: 0xfc1e
> 
> --------------------------------------------------------
> 
> and so on. Question: what about the longer hex numbers, i.e.
> Command_Opcode: Infineon_Manufacturer_Mode (0xfc11) ? I figured out the
> 2 digit hex numbers, but how to send the longer ones as hci command? 

Looks like the chip is talking HCI even when it is not initialized. The
correct byte streams depends on the on the structure of these vendor
specific commands. Send me the datasheet and we see how it should look
like.

Regards

Marcel




--__--__--

Message: 11
Date: Mon, 13 Feb 2006 10:27:16 -0700
From: Brad Midgley <bmidgley@xmission.com>
To:  bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Developing Broadcom driver support
Reply-To: bluez-devel@lists.sourceforge.net

Keith

Did you try something similar to Whoopie's patch that changes both mtu
and sco_cnt?

 http://bluetooth-alsa.sourceforge.net/sco-mtu.patch

Brad


--__--__--

Message: 12
Date: Mon, 13 Feb 2006 15:50:40 -0200
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] [DBUS PATCH] scan mode
Reply-To: bluez-devel@lists.sourceforge.net

------=_Part_12528_9485329.1139853040920
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi guys,


This patch add/fix the following services:
1. Changed GetMode/SetMode arguments to string, instead of use byte
2. Added IsConnectable
3. Added IsDiscoverable

Next action:
- Discoverable timout functions.

Regards,
Claudio
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_12528_9485329.1139853040920
Content-Type: text/x-patch; name=scan04.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejmwiip7
Content-Disposition: attachment; filename="scan04.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2006-02-12 05:27:40.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus.h	2006-02-13 11:53:24.000000000 -0200
@@ -206,17 +206,18 @@
 #define DEV_SIG_DISCOVER_COMPLETE	"DiscoverComplete"
 #define DEV_SIG_DISCOVER_RESULT		"DiscoverResult"
 
-/* FIXME: Change to string
+/*
  * Scanning modes, used by DEV_SET_MODE
  * off: remote devices are not allowed to find or connect to this device
  * connectable: remote devices are allowed to connect, but they are not
  *              allowed to find it.
  * discoverable: remote devices are allowed to connect and find this device
+ * unknown: reserved to not allowed/future modes
  */
-#define MODE_OFF		0x00	
-#define MODE_CONNECTABLE	0x01	
-#define MODE_DISCOVERABLE	0x02	
-
+#define MODE_OFF		"off"
+#define MODE_CONNECTABLE	"connectable"
+#define MODE_DISCOVERABLE	"discoverable"
+#define MODE_UNKNOWN		"unknown"
 
 /* BLUEZ_DBUS_ERROR 
  * EFailed error messages signature is : su
--- bluez-utils-cvs.orig/hcid/dbus-device.c	2006-02-12 04:33:18.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus-device.c	2006-02-13 12:42:26.000000000 -0200
@@ -41,6 +41,7 @@
 
 #include "textfile.h"
 
+
 static char *get_peer_name(const bdaddr_t *local, const bdaddr_t *peer)
 {
 	char filename[PATH_MAX + 1], addr[18];
@@ -257,7 +258,7 @@
 	const struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
 	const uint8_t hci_mode = dbus_data->path_data;
-	uint8_t scan_mode;
+	const char *scan_mode;
 
 	switch (hci_mode) {
 	case SCAN_DISABLED:
@@ -270,16 +271,16 @@
 		scan_mode = MODE_DISCOVERABLE;
 		break;
 	case SCAN_INQUIRY:
-	/* inquiry scan mode is not handled, return 0xff */
+	/* inquiry scan mode is not handled, return unknown */
 	default:
 		/* reserved */
-		scan_mode = 0xff;
+		scan_mode = MODE_UNKNOWN;
 	}
 
 	reply = dbus_message_new_method_return(msg);
 
 	dbus_message_append_args(reply,
-					DBUS_TYPE_BYTE, &scan_mode,
+					DBUS_TYPE_STRING, &scan_mode,
 					DBUS_TYPE_INVALID);
 
 	return reply;
@@ -287,14 +288,40 @@
 
 static DBusMessage* handle_dev_is_connectable_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	const uint8_t hci_mode = dbus_data->path_data;
+	dbus_bool_t connectable = FALSE;
+
+	if (hci_mode & SCAN_PAGE)
+		connectable = TRUE;
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply,
+					DBUS_TYPE_BOOLEAN, &connectable,
+					DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage* handle_dev_is_discoverable_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	const uint8_t hci_mode = dbus_data->path_data;
+	dbus_bool_t discoverable = FALSE;
+
+	if (hci_mode & SCAN_INQUIRY)
+		discoverable = TRUE;
+	
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply,
+					DBUS_TYPE_BOOLEAN, &discoverable,
+					DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage* handle_dev_set_class_req(DBusMessage *msg, void *data)
@@ -315,36 +342,31 @@
 	DBusMessage *reply = NULL;
 	struct hci_request rq;
 	int dd = -1;
-	const uint8_t scan_mode;
+	const char* scan_mode;
 	uint8_t hci_mode;
 	uint8_t status = 0;
 	const uint8_t current_mode = dbus_data->path_data;
 
 	dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_BYTE, &scan_mode,
+					DBUS_TYPE_STRING, &scan_mode,
 					DBUS_TYPE_INVALID);
 
-	switch (scan_mode) {
-	case MODE_OFF:
+	if (!scan_mode)
+		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+
+	if (strcasecmp(MODE_OFF, scan_mode) == 0)
 		hci_mode = SCAN_DISABLED;
-		break;
-	case MODE_CONNECTABLE:
+	else if (strcasecmp(MODE_CONNECTABLE, scan_mode) == 0)
 		hci_mode = SCAN_PAGE;
-		break;
-	case MODE_DISCOVERABLE:
+	else if (strcasecmp(MODE_DISCOVERABLE, scan_mode) == 0)
 		hci_mode = (SCAN_PAGE | SCAN_INQUIRY);
-		break;
-	default:
-		/* invalid mode */
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
-		goto failed;
-	}
+	else
+		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
 
 	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
+		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 	}
 
 	/* Check if the new requested mode is different from the current */
--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-12 03:49:17.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus.c	2006-02-13 12:42:27.000000000 -0200
@@ -1054,7 +1054,7 @@
 	struct hci_request rq;
 	int id;
 	int dd = -1;
-	uint8_t scan_mode;
+	const char *scan_mode;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 	id = hci_devid(local_addr);
@@ -1123,7 +1123,7 @@
 	}
 
 	dbus_message_append_args(message,
-					DBUS_TYPE_BYTE, &scan_mode,
+					DBUS_TYPE_STRING, &scan_mode,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {

------=_Part_12528_9485329.1139853040920--



--__--__--

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


End of Bluez-devel Digest

--Boundary_(ID_+18PoeZmH692/p1i99bxIg)--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
