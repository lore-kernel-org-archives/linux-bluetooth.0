Return-Path: <cijoml@volny.cz>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Problems with MS mouse and keyboard
Date: Wed, 26 Nov 2003 22:54:20 +0100
References: <20031105093947.J63252@minotaur.apache.org> <20031126131925.M25686@minotaur.apache.org> <1069882659.9032.54.camel@pegasus>
In-Reply-To: <1069882659.9032.54.camel@pegasus>
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200311262254.21024.cijoml@volny.cz>
List-ID: <bluez-users.lists.sourceforge.net>

Hi,

this switches works for me perfectly
/usr/local/bin/bthid -m -s -p 600 -l "$MYS" "$KLAVESNICE"

Michal

Dne st=F8eda 26 listopad 2003 22:37 Marcel Holtmann napsal(a):
> Hi Gareth,
>
> > I was really hoping it was not going to work. Unfortunately it does :( I
> > would really appreciate any help in sorting this out. I have rebuilt and
> > installed the bluez modules against my patched 2.4.22 kernel and all is
> > the same. The output from the 0.8 bthid is:
> >
> > Nov 26 21:05:34 zebedee bthid[1747]: Serving Bluetooth HID at BD
> > 00:50:F2:E2:EB:E6
> > Nov 26 21:06:26 zebedee bthid[1753]: Bluetooth HID daemon by Peter
> > Klausler <pmk@cray.com>
> > Nov 26 21:06:26 zebedee bthid[1754]: attempting connection to BD
> > 00:50:F2:E2:EB:E6
> > Nov 26 21:06:27 zebedee bthid[1754]: L2CAP socket 5 connected to BD
> > 00:50:F2:E2:EB:E6 PSM 1
> > Nov 26 21:06:28 zebedee bthid[1754]: L2CAP socket 6 connected to BD
> > 00:50:F2:E2:EB:E6 PSM 17
> > Nov 26 21:06:28 zebedee bthid[1754]: L2CAP socket 7 connected to BD
> > 00:50:F2:E2:EB:E6 PSM 19
> > Nov 26 21:06:28 zebedee bthid[1754]: Serving Bluetooth HID at BD
> > 00:50:F2:E2:EB:E6
> > Nov 26 21:06:28 zebedee bthid[1754]: device: Wireless IntelliMouse
> > Explorer for Bluetooth
> > Nov 26 21:06:28 zebedee bthid[1754]: made by Microsoft
> > Nov 26 21:06:28 zebedee bthid[1754]: device version 1.0
> > Nov 26 21:06:28 zebedee bthid[1754]: is virtually cabled
> > Nov 26 21:06:28 zebedee bthid[1754]: will initiate reconnections
> > Nov 26 21:06:28 zebedee bthid[1754]: is battery-powered
> > Nov 26 21:07:15 zebedee bthid[1754]: vendor HID usage 0xff00fe01 value
> > 0x1 Nov 26 21:07:15 zebedee bthid[1754]: adequate battery on Wireless
> > IntelliMouse Explorer for Bluetooth
> > Nov 26 21:17:40 zebedee bthid[1754]: EOF on Interrupt channel
> >
> >
> > After the EOF on interrupt channel it will not reconnect. If there is a
> > bthid -l listening then 100% of the CPU is consumed. I have cvs checked
> > out and am happy to put debug in etc to find out the problem and
> > hopefuly get this working.
>
> this is the implementation from Peter and I can't help you with it. I
> have only used it once.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
