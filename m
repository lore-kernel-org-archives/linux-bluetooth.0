Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Bc. Michal Semler" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net,
   Daniel Scott <danieljamesscott@gmail.com>
Subject: Re: [Bluez-users] MS Optical Desktop for bluetooth - Stops working after a time
References: <6835906b04091701465c5e3c7c@mail.gmail.com> <1095411684.3280.20.camel@pegasus> <6835906b04091702575f479226@mail.gmail.com>
In-Reply-To: <6835906b04091702575f479226@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200409171232.36243.cijoml@volny.cz>
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
Date: Fri, 17 Sep 2004 12:32:36 +0200

Dne p=E1 17. z=E1=F8=ED 2004 11:57 Daniel Scott napsal(a):
> Hi Marcel,
>
> Thanks for your quick reply,
>
> > show us the output of "hciconfig -a".
>
> Here it is, I see there are quite a few errors, is this the problem?
>
> hci0:   Type: USB
>         BD Address: 00:50:F2:E4:C2:F5 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:543843 acl:38475 sco:0 events:262 errors:0
>         TX bytes:4403 acl:176 sco:0 commands:36 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'SCOTTD'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x1f9 LMP Ver: 1.1 (0x1) LMP Subver:
> 0x1f9 Manufacturer: Cambridge Silicon Radio (10)
>
> > > Another minor problem is that I tend to leave my system running
> > > constantly, after ~2 days, the mouse stops working and will not
> > > restart, I have tried replacing the batteries, reconnecting the
> > > devices and restarting the hci0 device (hciconfig hci0 down, hciconfig
> > > hci0 up).
> > >
> > > Would restarting hidd help, I cannot find a 'clean' way to shut it
> > > down and I will try killing it and restarting it the next time that it
> > > happens. The only solution that I currently have is a reboot.
> > >
> > > Thanks for your time, as I said, they are only minor problems so,
> > > don't worry about it too much.
> >
> > In general the mouse should disconnect after 12 minutes and reconnect
> > when it is needed again.
>
> OK, I will investigate this further and try to figure out what is
> happening when the mouse stops working.
>
> Thanks,
>
> Dan

Hi, use this in your hcid.conf:

        lp rswitch,hold,sniff,park;
        security auto;
        pairing multi;

Michal


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
