Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Khaled" <khaled@ipbill.com>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth Voice Setting
Message-ID: <HCEOIFALKKLBLJPENPNOCEGGCAAA.khaled@ipbill.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1133956321.3752.10.camel@blade>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 7 Dec 2005 11:58:12 -0000

Hi Marcel,

> > > > Would you not expect to see '> SCO' lines in the hcidump output
> > > given that I
> > > > am (trying to) use SCO for voice transfer? Like you said in
> one of the
> > > > archives, hcidump shows payload of the SCO packets over hci?
> > >
> > > The Headset and Headfree profiles specify when the SCO
> channel has to be
> > > opened. Maybe your connection is not in that state. Post the output of
> > > hcidump, so we can see what's going on.
> >
> > This is when the bluetooth phone is initialised:
>
> if you wanna emulate a headset then you need to add Headset profile
> records and not Headset Audio Gateway records.

I mean to use the handsfree profile, so that I can speak into my computer
through a headset (earphone and mic), sorry if I was unclear earlier.

I have done sdptool add hf to add the handsfree profile:

Service Name: Handsfree
Service RecHandle: 0x10002
Service Class ID List:
  "Handsfree" (0x111e)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101


One thing I have noticed is that Handsfree is reffered to as 0x111e; I need
to use 0x111f which is the handsfree audio gateway profile as advertised on
my mobile. Is this an incompatibility issue?
The service on the mobile of interest is:

Service Name: Voice Gateway
Service RecHandle: 0x10005
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 13
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0100

Thus I have specified channel 13 under rfcomm (only this channel registers
my machine as a headset to my mobile phone).
Any thoughts? When I do sdptool local browse:

[root@mdk10-voipgsm root]# sdptool browse local
Browsing FF:FF:FF:00:00:00 ...
Service Name: Voice Gateway
Service RecHandle: 0x10000
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 5
Profile Descriptor List:
  "Handfree Audio Gateway" (0x111f)
    Version: 0x0100

Service Name: Voice Gateway
Service RecHandle: 0x10001
Service Class ID List:
  "Handfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 6
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0100

Service Name: Handsfree
Service RecHandle: 0x10002
Service Class ID List:
  "Handsfree" (0x111e)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Handsfree" (0x111e)
    Version: 0x0101

Isn't this correct?



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
