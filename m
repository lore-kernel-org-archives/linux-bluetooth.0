Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY117-F15C565B7A1429116FE75BCBF8E0@phx.gbl>
References: <BAY117-F15C565B7A1429116FE75BCBF8E0@phx.gbl>
Date: Fri, 23 Feb 2007 08:08:39 +0100
Message-Id: <1172214519.28266.6.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] PIN request for embedded Bluez
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

Hi Kelvin,

> I have install Bluez on my ARM-board. I managed to partly established a PAN 
> connection to my mobile phone. However, i could not finish the connection as 
> my phone would require my board to respond to its PIN authentification.
> 
> I have no problem doing that on a Fedora Core 5 computer, as there will be a 
> prompt for the PIN.
> There are however no prompt for a text-based Linux. How do i respond to the 
> challenge PIN in such an environment?

when running a bluez-utils-3.x you can use the passkey-agent.c example
to enter the PIN via command line or you can easily write a program by
yourself.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
