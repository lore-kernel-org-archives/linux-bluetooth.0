Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] uinput and modules.conf
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403161813.51693.cijoml@volny.cz>
References: <200403160905.27291.cijoml@volny.cz>
	 <200403161746.03391.cijoml@volny.cz> <1079456964.3307.116.camel@pegasus>
	 <200403161813.51693.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1079457663.3307.120.camel@pegasus>
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
Date: Tue, 16 Mar 2004 18:21:03 +0100

Hi Michal,

> I don't understand???
> 
> > add extra syslog() statement to see where your code fails. It is working
> > perfect with all my Bluetooth HID devices.

syslog() is like printf(), but you get your message through syslogd. Try
to track down where the input events are not sent to uinput. I don't see
any problem in the current code.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
