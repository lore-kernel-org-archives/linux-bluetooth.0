Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 19 Oct 2016 10:22:38 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Steve Gladden <steve@michiganbroadband.com>
Cc: Jason Anderssen <j@keyinitiative.com>,
        Joseph Hwang <josephsih@google.com>,
        Hieu Le <hieu.le@veriksystems.com>,
        Barry Byford <31baz66@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: How can you set Transmit power level in Bluetooth LE mode for an
 LE beacon?
Message-ID: <20161019072235.GC6145@comms.fi.intel.com>
References: <FEFD25773376F6448FE2884F5C1FA527F5E8622404@X2.michiganbb.local>
 <FEFD25773376F6448FE2884F5C1FA5270117A63D4D2C@X2.michiganbb.local>
 <CAAu3APZmaK_npAwEk9cd=KB8zqt2=DFnKJqV8Wd_QTUNi5vHrQ@mail.gmail.com>
 <FEFD25773376F6448FE2884F5C1FA5270117A63D4D2D@X2.michiganbb.local>
 <CADEmUHMF3gRai_kUHcKwA5RMi3WevMsE00NL2_NqWZWgu27OuA@mail.gmail.com>
 <FEFD25773376F6448FE2884F5C1FA5270117A63CE75B@X2.michiganbb.local>
 <CAHFy41_8FzDF-jATapn20Km8vbX6nt44DN9uPnazDMOJ_yD=Kw@mail.gmail.com>
 <FEFD25773376F6448FE2884F5C1FA5270117A63CE773@X2.michiganbb.local>
 <FC15A70F-9629-49C8-8BF4-88561B7DEEA3@keyinitiative.com>
 <FEFD25773376F6448FE2884F5C1FA5270117A63CE774@X2.michiganbb.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <FEFD25773376F6448FE2884F5C1FA5270117A63CE774@X2.michiganbb.local>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steve,

On Mon, Oct 17, 2016 at 12:15:40AM -0400, Steve Gladden wrote:
> Hi Jason and thanks!
>=20
> No, fully agree with what you say.
>=20
> I'm willing to do the extra research.
> just a little bummed that the information I seek seemingly just is not th=
ere anywhere.
>=20
> And I also would thing that many other applications (and people) would
> want to be able to adjust the power for other uses as well.
> Especially to get full range available with full TX output power
> versus the "unknown default".  Or firmware set unknown default etc.

Johan already replied that there is no standard HCI command for that.
But you can use Vendor Specific Commands if there are any for changing
TX power.

So you should check manual for your hardware and use the command you
mentioned below:

hcitool -i hci0 cmd ....

Best regards=20
Andrei Emeltchenko=20

>=20
> I thought there'd be more people out here that wanted and knew how to set=
/change transmit power level.
>=20
> Thanks for replying and it was enjoyable to hear from you!
>=20
> Take care!
>=20
>=20
> Steve Gladden
>=20
> Michigan Broadband Systems
> Connecting Your Business!
>=20
>=20
>=20
> +1 734.527.7150 Direct
> +1 248.327.4389 Fax
> steve@michiganbroadband.com
> www.michiganbroadband.com
>=20
> -----Original Message-----
> From: Jason Anderssen [mailto:j@keyinitiative.com]
> Sent: Sunday, October 16, 2016 6:49 PM
> To: Steve Gladden
> Cc: Joseph Hwang; Hieu Le; Barry Byford; linux-bluetooth@vger.kernel.org
> Subject: Re: How can you set Transmit power level in Bluetooth LE mode fo=
r an LE beacon?
>=20
> Hi Steve,
>=20
> I have been reading and watching your emails, and have not replied as I p=
robably don=E2=80=99t have any answers, but my guess is as follows :
>=20
> Most people, myself included, are using Linux and hardware like Raspberry=
 pi to pick up beacons, not actually be a beacon, I know you can create a b=
eacon with linux, but it is not really the main focus for a lot of people.
> The hardware I use for BLE advertising completely lets me and others to p=
rogram the power level, which then is received from the Raspberry pi or lik=
e hardware, so I don=E2=80=99t have your issue or frustration.
>=20
> So my summary is: you maybe a minority in your work :-)  Nothing wrong wi=
th that, but it does mean extra development and research on your behalf I w=
ould say.
>=20
> Anyway, I hear your frustration, and I add no value to your question, hop=
efully some insight as how I see things fit in life and might explain your =
current situation.
>=20
> Remember this is simply my opinion, and is probably wrong too :)
>=20
> Cheers
> Jason
>=20
> > On 17 Oct 2016, at 7:56 AM, Steve Gladden <steve@michiganbroadband.com>=
 wrote:
> >
> > Ok, this is getting really frustrating.
> > Why would something so simple like this be so difficult?
> >
> > Am I really the only sheep out here that has any interest whatsoever in=
 the past 5 years on how to actually set LE transmit power on a USB device?
> > Do I just not get it?
> > Really I don=E2=80=99t get it.
> >
> > A really simple task and nobody out here either knows or has any intere=
st in doing it.
> >
> > My question is not even technical at all.   If I actually asked somethi=
ng technical out here would would happen?
> >
> > No offense to anyone out here just to myself really but what gives?
> >
> > How could people working with this stuff NOT be interested in simply
> > controlling the TX power output versus just living with some UNKNOWN DE=
FAULT that just sorta works if you=E2=80=99re happy with only 20 feet of ra=
nge although the chip can put out +10dbm and go further Or set it way back =
to -40dbm and get jstu a few feet and years of battery life.
> >
> > How the actual F- are people NOT interested in this and talking about i=
t and working with it?   =E2=98=BA
> >
> > All I have found on bccmd is a PDF document from 2005 that predates ANY=
 kind of BTLE stuff.
> >
> > And that=E2=80=99s just for the CSR chipsets the ONE that I could find =
documentation on.
> >
> > What about all the others?
> >
> > What gives here man?
> >
> > Am I completely in the wrong place to be asking about this?
> >
> > I don=E2=80=99t mean any disrespect, really I don=E2=80=99t!
> >
> > But where in the world do I go to get this basic information?
> >
> > And why does nobody care of have any hands-on experience here and/or in=
terest?
> >
> > Thanks!!
> >
> > Steve
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > Tried that of course already days ago.
> > As well as anything else a simple google search turns up.
> >
> > To set Max tx power:
> > sudo bccmd psset -s 0x0000 0x0017 10
> > To set default tx power:
> > sudo bccmd psset -s 0x0000 0x002d 10
> >
> > It eats both of those commands and does not complain no errors but also=
 no change in TX power output.
> > I=E2=80=99m watching the beacons on a receiver and a spectrum analyser.
> >
> > If I issue: ~# hciconfig hci0 inqtpl
> > hci0:   Type: BR/EDR  Bus: USB
> >         BD Address: 00:15:83:EA:0A:B9  ACL MTU: 310:10  SCO MTU: 64:8
> >         Inquiry transmit power level: 4
> >
> > Always reads back that =E2=80=9C4=E2=80=9D
> >
> > Issuing either:
> >
> > # bccmd warmreset
> > -or
> > # bccmd coldreset
> >
> > results in transmitter off and have to do:
> >
> > hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 E2 0A 39
> > F4 73 F5 4B C4 A1 2F 01 73 45 27 71 50 0A 28 0A 28 01 FF -and ~#
> > hciconfig hci0 leadv3
> >
> > To get it transmitting again (at the same non changed level.
> >
> > And
> >
> > ~# hciconfig hci0 inqtpl
> >
> > hci0:   Type: BR/EDR  Bus: USB
> >         BD Address: 00:15:83:EA:0A:B9  ACL MTU: 310:10  SCO MTU: 64:8
> >         Inquiry transmit power level: 4
> >
> > Always shows =E2=80=9C4=E2=80=9D
> >
> > On top of everything I have stated and tried here..
> > I don=E2=80=99t think that setting (if it even worked) has any relation=
 to LE GFSK advertising mode.
> >
> > Pretty sure it does not.
> > That (if it worked) sets power on Basic Rate and EDR as seen in the res=
ult =E2=80=9Chci0:   Type: BR/EDR  Bus: USB=E2=80=9D when issuing the hcico=
nfig hci0 inqtpl command.
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > Steve Gladden
> >
> > Michigan Broadband Systems
> > Connecting Your Business!
> >
> >
> >
> > +1 734.527.7150 Direct
> > +1 248.327.4389 Fax
> > steve@michiganbroadband.com
> > www.michiganbroadband.com
> >
> > From: Joseph Hwang [mailto:josephsih@google.com]
> > Sent: Wednesday, October 12, 2016 11:55 AM
> > To: Steve Gladden
> > Cc: Hieu Le; Barry Byford; linux-bluetooth@vger.kernel.org
> > Subject: Re: How can you set Transmit power level in Bluetooth LE mode =
for an LE beacon?
> >
> > Hi Steve:
> >
> >   Maybe you can try CSR's command line utility, bccmd. The system contr=
ol command Max_Tx_Power and Default_Tx_Power allow you to set tx power.
> >
> > Good luck!
> >
> > Joseph
> >
> >
> > On Wed, Oct 12, 2016 at 11:33 PM, Steve Gladden <steve@michiganbroadban=
d.com> wrote:
> > Thanks,
> > I was hoping there was an easier way and somehow at the command line bu=
t I'll do what I need to do and figure it out somehow.
> > I usually end up on 10 other rabbit trails when it comes to having to
> > recompile anything because it usually just fails for me and I'm not yet=
 well versed in troubleshooting when things won't compile successfully asid=
e from what I can easily google.
> >
> > I also think it's a little more complicated than just setting the power.
> > I have gathered at least wit hthe CSR chipset that there are at least 3=
 separate power settings that can be adjusted and not any overall power set=
ting.
> > So the various modulation modes (including GFSK -LE advertising-) need =
to be addressed and set individually.
> > There's not a master transmit level that sets them all.
> >
> >
> > Steve Gladden
> >
> > Michigan Broadband Systems
> > Connecting Your Business!
> >
> >
> >
> > +1 734.527.7150 Direct
> > +1 248.327.4389 Fax
> > steve@michiganbroadband.com
> > www.michiganbroadband.com
> >
> > -----Original Message-----
> > From: Hieu Le [mailto:hieu.le@veriksystems.com]
> > Sent: Wednesday, October 12, 2016 1:00 AM
> > To: Steve Gladden
> > Cc: Barry Byford; linux-bluetooth@vger.kernel.org
> > Subject: Re: How can you set Transmit power level in Bluetooth LE mode =
for an LE beacon?
> >
> > Hi,
> >
> > In my opinion, the only way I can find to increase the tx_power is to
> > recompile the linux kernel. There may be a better way
> >
> > It seems that bluetooth stack within kernel separated into two classes:
> > 1. Inquiry Tx_power.
> > 2. Advertise Tx_power.
> >
> > And the default value is 0.
> >
> > You can take a look at:
> > *hci_alloc_dev(void)  function within net/bluetooth/hci_core.c file
> > hdev->inq_tx_power =3D HCI_TX_POWER_INVALID; adv_tx_power =3D
> > hdev->HCI_TX_POWER_INVALID;
> >
> > Hope it will be helpful to you.
> >
> > Regards,
> > Hieu.
> >
> > On Wed, Oct 12, 2016 at 12:52 AM, Steve Gladden <steve@michiganbroadban=
d.com> wrote:
> >> Thanks!!
> >> Yes it's nice to hear from somebody.
> >>
> >> I've been scouring the web so far to no avail on what I think should b=
e a simple and accessible setting.
> >> It's obvious from the specs that most chips have a programmable (setta=
ble) transmitter power.
> >> And with beacons it is very important and expected that one should be =
able to adjust the transmitter level.
> >> All of the serial boards do it with simple AT commands.
> >>
> >> I just don't get why there's no documentation on how to do it with a U=
SB device!!
> >>
> >> They sell class 1 bluetooth usb dongles for applications that require =
more range (100m) is quoted on most class 1 products.
> >>
> >> I'd expect there should be a straight forward easy to set power in LE =
mode to get more range or save power and limit range when wanted.
> >>
> >> But I'm really not finding this information out there!
> >>
> >> I don;t understand what I am doing wrong or why this is so difficult
> >> to find.  :)
> >>
> >>
> >>
> >>
> >>
> >>
> >>
> >> On 11 October 2016 at 17:50, Steve Gladden <steve@michiganbroadband.co=
m> wrote:
> >>> Is this this list just some kind of automated patch announcement log =
and not an actual mailing list where you can ask anything about bluetooth.
> >>> This is all I have seen here for the past few days?
> >>> Where can I ask an actual question about bluetooth?
> >>
> >> There are some real humans here too!  :-)
> >>
> >> If you look back on the archive of this list you will see a mixture
> >> of questions and patch requests.
> >> marc.info/?l=3Dlinux-bluetooth
> >>
> >> I've kept quiet as I'm not sure I can answer questions. To offer some
> >> shared experience, I can say that I've been experimenting with
> >> (Eddystone) beacons on Linux single board computers accessing BlueZ
> >> through the DBus API using Python. I also have not found a way to
> >> change the power level of advertisements either. For what I'm doing,
> >> just making sure the TX power in the Eddystone advert matches what
> >> the dongle is actually broadcasting has been good enough.
> >>
> >> Sorry I couldn't be of more help.
> >>
> >> Regards,
> >> Barry
> >>
> >>>
> >>>
> >>>
> >>>
> >>> Steve Gladden
> >>>
> >>> Michigan Broadband Systems
> >>> Connecting Your Business!
> >>>
> >>>
> >>>
> >>> +1 734.527.7150 Direct
> >>> +1 248.327.4389 Fax
> >>> steve@michiganbroadband.com
> >>> www.michiganbroadband.com
> >>>
> >>> ________________________________________
> >>> From: Steve Gladden
> >>> Sent: Sunday, October 09, 2016 12:11 PM
> >>> To: linux-bluetooth@vger.kernel.org
> >>> Subject: How can you set Transmit power level in Bluetooth LE mode fo=
r an LE beacon?
> >>>
> >>> Hi,
> >>> My name is Steve and I am located in Ann Arbor Michigan USA.
> >>>
> >>> I am new  bluetooth LE and lately am obsessed with Bluetooth LE beaco=
ns and trying them out.
> >>>
> >>> I have read article after article and page after page about how
> >>> people have setup up beacons with USB BT 4.0 interfaces as well as se=
rial bluetooth boards.
> >>>
> >>> I am currently experimenting with a beacon running on a Raspberry Pi-=
B and using an external USB Bluetooth 4.0 class 1 dongle.
> >>>
> >>> My frustration is that I have not been able to find any useful
> >>> information in how to change the Transmitter power level when in LE m=
ode.
> >>>
> >>> The dongle appears to be working at default level below zero dbm.
> >>>
> >>> The whole point of building your own beacon this way is to be able
> >>> to customize it and setting the power level is an important key item =
that should be easily accessible yet I find that NOBODY ever even mentions =
it let alone do they explain or provide a way to set the power.
> >>>
> >>>
> >>> Every text that I have found that details beacon setups from command =
line never bother to mention setting beacon TX power.
> >>>
> >>> All the pages I have found seem to copy each other and repeat the
> >>> same information over & over But never get around to even mentioning =
or discussing setting the power output level of the blutooth dongle.
> >>>
> >>> sudo hcitool -i hci0 cmd 0x08 0x0008 1E 02 01 1A 1A FF 4C 00 02 15 [
> >>> 92 77 83 0A B2 EB 49 0F A1 DD 7F E3 8C 49 2E DE ] [ 00 00 ] [ 00 00
> >>> ]
> >>> C5 00
> >>>
> >>> The byte just left of the last one is the "reported" TX level that yo=
u are transmitting at.
> >>> Which means you're supposed to know (or guess?) what dbm level you ar=
e actually transmitting at and set it here to display to the world what you=
r transmitter level is set to so they can range (guess or estimate distance=
 from TX).
> >>> This value does not influence or reflect actual transmit power.
> >>>
> >>> Please help!!
> >>>
> >>> Could use any pointers.
> >>>
> >>> I'm a hardware guy as well so not very experienced in software/progra=
mming but I'm willing to try anything to get control of this.
> >>>
> >>> Been at this for over a week and have some working beacons but no con=
trol of transmit power level.
> >>>
> >>> Am using Trendnet USB dongles which appear to use a Cambridge Chip.  =
But I'm not exactly sure which chip.
> >>>
> >>>
> >>> :~# lsusb
> >>> Bus 001 Device 007: ID 0a12:0001 Cambridge Silicon Radio, Ltd
> >>> Bluetooth Dongle (HCI mode)
> >>>
> >>>
> >>> root@raspberrypi:~# hciconfig hci0
> >>> hci0:   Type: BR/EDR  Bus: USB
> >>>          BD Address: 00:15:83:EA:0A:B9  ACL MTU: 310:10  SCO MTU: 64:8
> >>>          UP RUNNING
> >>>          RX bytes:780 acl:0 sco:0 events:50 errors:0
> >>>          TX bytes:1110 acl:0 sco:0 commands:50 errors:0
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe
> >>> linux-bluetooth" in the body of a message to
> >>> majordomo@vger.kernel.org More majordomo info at
> >>> http://vger.kernel.org/majordomo-info.html
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe
> >> linux-bluetooth" in the body of a message to
> >> majordomo@vger.kernel.org More majordomo info at
> >> http://vger.kernel.org/majordomo-info.html
> >
> >
> >
> > --
> > ---- Hieu Le ---
> >
> >
> >
> >
> > --
> >
> > Joseph Shyh-In Hwang
> > Email: josephsih@google.com
> >
> > N   r y   b X =C7=A7v ^ )=DE=BA{.n + { n[ - )   w*jg =1E  =DD=A2j/   z =
=DE=96  2 =DE=99   & )=DF=A1 a
> >   =7F =1E G  h =0F j:+v w =D9=A5
>=20
