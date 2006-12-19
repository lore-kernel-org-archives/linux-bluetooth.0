Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 19 Dec 2006 16:36:27 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-ID: <20061219153627.GJ7959@suse.de>
References: <4587BB0E.2070909@glidos.net> <1166523629.29972.18.camel@violet>
	<4587DAEC.8000603@glidos.net>
MIME-Version: 1.0
In-Reply-To: <4587DAEC.8000603@glidos.net>
Subject: Re: [Bluez-users] hcid.conf seemingly ignored
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Tue, Dec 19, 2006 at 12:28:28PM +0000, Paul Gardiner wrote:
> Marcel Holtmann wrote:
> > Hi Paul,
> > =

> >> I had my server (running SuSE 10.1) set up as a gateway for my PDA
> >> following the advice in: =

> >> http://wiki.xda-developers.com/index.php?pagename=3Dbluetoothnetworking
> >>
> >> I've just swapped over to SuSE 10.2 which has bluesz 3.7-14 and
> >> the set up no longer works.
> >>
> >> hciconfig says:
> >>
> >> hci0:   Type: USB
> >>          BD Address: 00:09:DD:50:47:BB ACL MTU: 384:8 SCO MTU: 64:8
> >>          UP RUNNING PSCAN
> >>          RX bytes:401 acl:0 sco:0 events:18 errors:0
> >>          TX bytes:317 acl:0 sco:0 commands:17 errors:0
> >>
> >> with ISCAN missing, although my hcid.conf file has  "iscan enable".
>  >
> > to make this work you need to set discovto to 0, because otherwise hcid
> > will automatically switch you device into non-discoverable mode to
> > protect you.
> > =

> > You can of course install bluez-gnome and use bluetooth-properties to do
> > this configuration with a shiny UI.
> =

> I can't get that to work. It seems very flaky. Sometimes I get INQUIRY
> instead of PSCAN. Other times I get nothing.  I think the SuSE 10.2
> installation may be messed up.  I've installed it on two computers
> and had the same problems.

Hm. It works for me. I have not configured anything via YaST, but just with
bluetooth-applet and apitest (in the bluez-test package).

seife@strolchi:~> apitest GetMode
discoverable
seife@strolchi:~> apitest GetDiscoverableTimeout
0
seife@strolchi:~> hciconfig -a
hci0:   Type: USB
        BD Address: 00:50:F2:EA:6B:EF ACL MTU: 377:10 SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN
        RX bytes:523488 acl:33305 sco:0 events:3021 errors:0
        TX bytes:110032 acl:8249 sco:0 commands:180 errors:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ strolchi (0)'
        Class: 0x3e010c
        Service Classes: Networking, Rendering, Capturing, Object Transfer,=
 Audio
        Device Class: Computer, Laptop
        HCI Ver: 1.2 (0x2) HCI Rev: 0x3 LMP Ver: 1.2 (0x2) LMP Subver: 0x800
        Manufacturer: Broadcom Corporation (15)

> For now I seem to be able to at least make progress by issuing:
> =

>    hciconfig hci0 auth encryt
> =

> and
> =

>    hciconfig hci0 piscan

And this does not work with

	apitest SetDiscoverableTimeout 0
	apitest SetMode discoverable

?

If this does not work, it sound not like a SUSE specific bug but like a
generic bug which we all would like to know about :-)
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
