Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: pand connection to XP SP2 fails
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1103110263.4099.109.camel@justakiss>
References: <1103024795.4097.65.camel@justakiss>
	 <1103024932.2143.156.camel@pegasus> <1103025459.4095.68.camel@justakiss>
	 <cpmnro$2p5$1@sea.gmane.org>  <1103036073.4095.101.camel@justakiss>
	 <1103107355.2143.185.camel@pegasus>  <1103110263.4099.109.camel@justakiss>
Content-Type: text/plain
Message-Id: <1103110592.2143.218.camel@pegasus>
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
Date: Wed, 15 Dec 2004 12:36:32 +0100

Hi Erwin,

> yes, this works fine (with pand --service PANU ...).

please do a "sdptool browse|search ..." with the --tree option. May we
can get the service from the SDP record and use a good default. Does a
simple "pand --connect ..." without any extra options work for you?

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
