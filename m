Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Connect to mysql server thorugh SDP
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20050225194018.4684.qmail@web60401.mail.yahoo.com>
References: <20050225194018.4684.qmail@web60401.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1109578606.17256.11.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Feb 2005 09:16:46 +0100

Hi Tanveer,

> Me and my frined are doing a project here just to
> learn where we have a db server(mysql) in Linux PC and
> installed all necessary IDE & SDK in win2000 PC. Now
> We want to design a program that can access that
> database through LAN as we dont have a NOKIA 60 series
> phone or USB dongles. Now asked baout SDP because how
> to offer the mysqld service to my win2000 PC?
> I can connect my emulator to internet and also to
> another PC on LAN. But how to access the mysql server?
> So that when I manage a compatible phone then I can
> interact to database via BT on that phone.
> Hope I made myself clear.

this has nothing to do with BlueZ. Use the DUN or PAN profile to get a
TCP/IP connection and then use this.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
