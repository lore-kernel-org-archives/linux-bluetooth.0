Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sf.net
Subject: Re: [Bluez-users] Re: Can't understand
Message-ID: <20040513174520.GA5154@gmx.net>
References: <200405130659.45969.hedin@hiervard.ru> <200405131627.34993.hedin@hiervard.ru> <20040513103228.GA4449@gmx.net> <200405131950.38279.hedin@hiervard.ru> <20040513163305.GA4989@gmx.net> <009701c43906$45bbf770$b67ba8c0@zaz1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <009701c43906$45bbf770$b67ba8c0@zaz1>
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
Date: Thu, 13 May 2004 19:45:20 +0200

On  0, Xavier Garreau <x.garreau@prim-time.fr> wrote:

> > > usr/sbin/hciconfig scan
> > > Can't get device info: No such device
> >
> > hciconfig hasn't any "scan" argument.
> >
> > > [root@host-81-1-226-59 hedin]# /usr/sbin/hciconfig inqmode
> > > Can't get device info: No such device
> >
> > nor "inqmode". Why do you think, these are possible arguments?
> >
> > > I can't have it working. No such log available.
> >
> > Then maybe it is called different in your distribution. Look in /var/log/
> > for the right one.
> > Maybe you post:
> > - kernel version
> > - bluez-utils/libs version
> > - distribution
> What you're looking for is called hcitool, hciconfig is for configuration
> purposes ...

You are probably not taking to me, although you are replying to my posting. Please reply to the right message. Then please read the thread. Then notice he hasn't even a hci device up. So hcitool is at this point useless.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
