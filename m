Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 2.6.10 multimedia keys
References: <41D85BB7.5020506@comcast.net> <200501032252.57493.cijoml@volny.cz> <1104790659.8894.81.camel@pegasus>
In-Reply-To: <1104790659.8894.81.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200501032350.19104.cijoml@volny.cz>
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
Date: Mon, 3 Jan 2005 23:50:19 +0100

I asked Vojtech from suse...hope he will help

M.

Dne po 3. ledna 2005 23:17 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > > > Marcel pls write support for user space configuring hotkey keycodes
> > > > too, coz I have multimedia keys on my laptop and those keys returns
> > > > other key press keycodes than keys on MS desktop........than I can't
> > > > configure it well, coz 254 returns IE key on notebook and email key
> > > > on MS desktop and so on...
> > >
> > > some parts of this are not my job. The input guys must work on it. The
> > > Bluetooth HIDP is only a transport layer between L2CAP and the generic
> > > HID parser and/or the input subsystem.
> >
> > This is work for our driver I thought...We pass 254 to subsystem which
> > than work with it...so we should send for example 117 instead of 254
> > originally reported.
>
> what you talk about is a quirk and since the current USB HID parser
> already contains enough of them, I try to avoid as much of them as
> possible. In general the value is correct, but our problem is that we
> have to deal with PS/2 as protocol at the level of the input subsystem.
> However don't bother me about that quirk. Send in a patch or get the
> input guys to redesign parts of their subsystem.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
