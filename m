Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] GPRS /  pppd problem
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1103312469.4788.15.camel@justakiss>
References: <1103312469.4788.15.camel@justakiss>
Content-Type: text/plain
Message-Id: <1103323155.28046.127.camel@pegasus>
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
Date: Fri, 17 Dec 2004 23:39:15 +0100

Hi Erwin,

> I'm using GPRS on a Ericsson T630 over bluetooth successfully. When I
> press a key on the phone to terminate the GPRS connection, pppd doesn't
> recognize that, however. I did a hcidump to see what happens after the
> key has been pressed on the phone (see below). Any ideas if there's a
> way to signal pppd that the GPRS connection has been terminated? The
> pppd debug log doesn't show any activity in that case.

get the full dump or run it with --psm=3 to enable RFCOMM decoding.

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
