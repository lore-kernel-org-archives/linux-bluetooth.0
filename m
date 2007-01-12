Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4f436aae0701120859o16d8f9cbxeaa75202b818a147@mail.gmail.com>
Date: Fri, 12 Jan 2007 18:59:19 +0200
From: "Choi Sonim" <choisonim@gmail.com>
To: thomas.kear@gmail.com, "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <200701120955.24082.thomas.kear@gmail.com>
MIME-Version: 1.0
References: <4f436aae0701110833m5aa4155bxbbc61920f5421f3c@mail.gmail.com>
	<200701120955.24082.thomas.kear@gmail.com>
Subject: Re: [Bluez-users] Profiles on Bluez
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Thomas,

Thank you for the help.

I also found that BlueZ supports PAN and BNEP inherently.

can I please ask about more profiles and protocols like goep, obex, spp, hid,
dun, spp ?

Are they supported ? by whom,where ?

Thanks again !!!!
Choi.

On 1/11/07, Thomas Kear <thomas.kear@gmail.com> wrote:
> SCO (handsfree), A2DP and AVRCP are supported by the bluetooth-alsa driver
> http://bluetooth-alsa.sourceforge.net
>
> BPP, depending on which way you want to use it, is a bit of an issue at the
> moment.  I haven't yet found a server that lets my PC accept print requests
> from mobile devices and print them through CUPS.  However working the other
> way, CUPS has a bluetooth backend that supports adding queues for bluetooth
> printers (I believe using HCRP).
>
> OPP and FTP are handled just fine by KDE's 'kdebluetooth' package, if you have
> it installed, bluetooth:/ in a konqueror view should give you a device
> listing, double clicking a device icon should display supported profiles, FTP
> is called "OBEX File Transfer".  In OPP's case, sending a file from a device
> to the PC should automatically open a dialogue to facilitate recieving it.
> Sending files is as easy as right clicking them in a konqueror view and
> selecting "Actions> Send with Bluetooth...".  Gnome's bluetooth utilities
> should have similar funtionality, I cannot comment further as I've never used
> them.
>
> --Thomas
>
> On Friday 12 January 2007 5:33 am, Choi Sonim wrote:
> > Hello ppl!
> >
> > What Bluetooth profile do BlueZ support ?
> > I found some OBEX utilities (which both gnome and kde provides),
> > and the builtin BNEP support. but that;s it. no hands-free, bpp,
> > opp,a2dp,ftp, nothing ?
> >
> > I know it is high-level and everything can be written on top of bluez
> > but i wonder what is already supported ?
> >
> > Thank You ppl,
> > Choi.
> >
> > -------------------------------------------------------------------------
> > Take Surveys. Earn Cash. Influence the Future of IT
> > Join SourceForge.net's Techsay panel and you'll get the chance to share
> > your opinions on IT & business topics through brief surveys - and earn cash
> > http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
