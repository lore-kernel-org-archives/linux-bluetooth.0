Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hidp and hidd related bugs
References: <200405120030.54220.cijoml@volny.cz> <1084368090.25099.22.camel@pegasus>
In-Reply-To: <1084368090.25099.22.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200405122109.01893.cijoml@volny.cz>
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
Date: Wed, 12 May 2004 21:09:01 +0200

On Wednesday 12 of May 2004 15:21, Marcel Holtmann wrote:
> Hi Michal,
>
> > I did little research and here is output:
> >
> > keys which are not reported in xev:
> > Eigene Dateien
> > Eigene Bilder
> > Eigene Musik
> > Messenger
> > Abmelden
> >
> > Reported badly
> > Rechner is reported like Pause
> > Standby like Print
> >
> > Do you want send keycodes which reports bthid in 2.4.26 to have the same
> > hotkeys events?
>
> you own a german keyboard ;)

Yes :) Microsoft don't sell it on our market and boarder is so near... :)

>
> However I can't help you in that case, because I have little interest to
> fix this. The HID parser that is used by the HIDP kernel module is the
> same parser as in the USB HID driver.

I know, I looked at it to fix it, but it's silly. When I use table from bthid, 
colona doesn't work as with bthid - as expected :) I'll have time to make 
closer look after graduate...

> In some near future they will be 
> joined to use the same generic parser. The parser in bthid was written
> for the Microsoft keyboard and maybe did some assumptions that are wrong
> for other keyboards.

I have MS keyboard :)

> Try to get the buttons work with current HIDP and 
> some external programs like hotkeys.

I described problem with hidp - with bthid only colona key doesn't work

>
> > hidd --killall wants atribute BDADDR
>
> Silly typo. I only tested "-K" and that was working. It is fixed in CVS
> now.

Nice :)

I find out, that l2ping pings from 200 not 0 - you remembered to include my 
minor fix

>
> Regards
>
> Marcel

Michal


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
