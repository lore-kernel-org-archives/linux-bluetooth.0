Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-users] disappointed with my MX900 battery life
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1073583568.2563.29.camel@pegasus>
References: <1073555620.5632.8.camel@bluez.bueche.ch>
	 <1073583568.2563.29.camel@pegasus>
Content-Type: text/plain
Message-Id: <1073636191.8413.743.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 09:16:31 +0100
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

On Thu, 2004-01-08 at 18:39, Marcel Holtmann wrote:
> Hi Charles,
> 
> > I'm using the CVS version of libs2 and utils2, with my MX900. I have the
> > impression that the MX900 batteries don't last very long between two
> > charging cycles (2-3 days). Can other here confirm this ?
> > 
> > I must explain that I use my MX900 without the docking (with a laptop
> > underway), so I only dock the mouse to load it when it blink red.
> > 
> > And being with empty batteries underway leaves me with the poor
> > touchpad.
> > 
> > Any better experience under Window$ ? Is some optimization possible in
> > the code to better use the "standby" modes of the MX900 ?
> 
> the HID specification is clear about that the HID device itself must
> take care about its power consumption. What is your link policy? Maybe
> the sniff mode is not enabled. 

looks like it is :

hci0:   Type: USB 
        BD Address: 00:10:C6:22:54:AF ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:155055 acl:10298 sco:0 events:75 errors:0
        TX bytes:851 acl:22 sco:0 commands:15 errors:0
        Features: 0xff 0xff 0x0f 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'laptopcb (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x235 LMP Ver: 1.1 (0x1) LMP Subver:
0x235
        Manufacturer: Cambridge Silicon Radio (10)

> On the other hand the Apple Bluetooth
> mouse never uses sniff mode to save power. Run a hcidump and check what
> your mouse is doing.

I left hcidump running for a while (~15 min) and I saw it doing a change
mode :

1073632217.880298 > HCI Event: Mode Change(0x14) plen 6
1073632217.892269 > HCI Event: Mode Change(0x14) plen 6

....time goes a bit

1073632832.674873 > HCI Event: Mode Change(0x14) plen 6
1073632832.688834 > HCI Event: Mode Change(0x14) plen 6

....time goes a bit

1073633988.937287 < ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0040
1073633989.189536 > HCI Event: Number of Completed Packets(0x13) plen 5
1073633989.583548 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0040
1073633989.585550 > ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0044
1073633989.585577 < ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0044
1073633989.596539 > HCI Event: Mode Change(0x14) plen 6
1073633989.598508 > HCI Event: Number of Completed Packets(0x13) plen 5
1073633989.645541 > HCI Event: Mode Change(0x14) plen 6
1073633989.883553 > HCI Event: Mode Change(0x14) plen 6
1073633989.970552 > HCI Event: Disconn Complete(0x05) plen 4

Can you interpret this ? Looks like Klingon to me :-)

Charles

-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
