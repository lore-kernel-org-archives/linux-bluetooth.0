Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RE[2]: inquiry scan problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41AB96DF.4080405@zhwin.ch>
References: <41AB96DF.4080405@zhwin.ch>
Content-Type: text/plain
Message-Id: <1101765045.7562.48.camel@pegasus>
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
Date: Mon, 29 Nov 2004 22:50:45 +0100

Hi Marco,

> yes. i tried the inquiries with "hcitool scan".
> again, i do 5 and more inquiries in a row with one second sleep between 
> inquiries single "hcitool scan"'s...
> 
> here what i noted:
> - it needs in average 4 inquiries to get a new device after it's in 
> rainge (4 single "hcitool scan" until it's visible).
> - it needs in average 2 inquiries to see that a device is no longer in 
> rainge (or has bluetooth disabled). the first new inquiry usually gives 
> "n/a" as the friendlyName, the second one doesn't list it again.
> does maybe bluez or my bluetooth dongle cache old inquiries or is there 
> still radiation in the air :-) ?

for me this sounds more like a job periodic inquiry.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
