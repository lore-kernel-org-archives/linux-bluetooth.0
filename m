Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PAN with ISSC USB-dongle and MTU
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <acb0c1690601250222w42226d95j4e9fb2fe1ba46735@mail.gmail.com>
References: <010201c62197$be32dae0$14141bac@mgpi.de>
	 <acb0c1690601250214x18ef7646ta0f56ae2d2b2e53d@mail.gmail.com>
	 <acb0c1690601250222w42226d95j4e9fb2fe1ba46735@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1138187268.5782.36.camel@localhost>
Mime-Version: 1.0
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
Date: Wed, 25 Jan 2006 12:07:48 +0100

Hi Paulo,

> Yeah, it works! Great! Now I'm running Gentoo Portage in my notebook
> via bluetooth NAP at 60kb/s (yeah, my Internet link speed)... =)
> Someone could put this information at the BlueZ website...

I am curious what happens if you shrink the L2CAP MTU inside the pand.
Maybe this also works. Then it would be easy to add such command line
option and a quirk for ISSC chips.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
