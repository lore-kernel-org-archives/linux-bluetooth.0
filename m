Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Can't understand
From: Marcel Holtmann <marcel@holtmann.org>
To: "Nicholas A. Preyss" <nalp@gmx.net>
Cc: bluez-users@lists.sf.net
In-Reply-To: <20040513163305.GA4989@gmx.net>
References: <200405130659.45969.hedin@hiervard.ru>
	 <200405131627.34993.hedin@hiervard.ru> <20040513103228.GA4449@gmx.net>
	 <200405131950.38279.hedin@hiervard.ru>  <20040513163305.GA4989@gmx.net>
Content-Type: text/plain
Message-Id: <1084485267.25099.158.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 13 May 2004 23:54:27 +0200

Hi Nicholas,

> > [root@host-81-1-226-59 hedin]# /usr/sbin/hciconfig inqmode
> > Can't get device info: No such device
> 
> nor "inqmode". Why do you think, these are possible arguments?

let me correct you, because with bluez-utils-2.7 hciconfig has a command
inqmode to set the inquiry mode. Check with -h or the manpage for the
new Bluetooth 1.2 commands.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
