Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 2.6.10 multimedia keys
References: <41D85BB7.5020506@comcast.net> <1104698820.8894.34.camel@pegasus>
In-Reply-To: <1104698820.8894.34.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200501032144.53762.cijoml@volny.cz>
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
Date: Mon, 3 Jan 2005 21:44:53 +0100

Marcel pls write support for user space configuring hotkey keycodes too, 
coz I have multimedia keys on my laptop and those keys returns other key press 
keycodes than keys on MS desktop........than I can't configure it well, coz 
254 returns IE key on notebook and email key on MS desktop and so on...

THANKS :)

Michal

Dne ne 2. ledna 2005 21:47 Marcel Holtmann napsal(a):
> Hi Walt,
>
> > I just updated to 2.6.10, and my media keys stopped working, hcidump
> > shows nothing.  I tried applying the mh1 patch, but that didnt help.  I
> > have the ms keyboard v1, and using the newest libs/utils.  any ideas?
>
> actually I removed the report mode protocol support from the -mh1 patch.
> I will be replaced with a better solution. The boot protocol mode has no
> support for any "coffee key".
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
