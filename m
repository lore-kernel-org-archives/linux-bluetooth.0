Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] BNEP connection destroing :(
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1109664374.42242276c644b@mail.orbitel.bg>
References: <1109664374.42242276c644b@mail.orbitel.bg>
Content-Type: text/plain
Message-Id: <1109666579.17256.126.camel@pegasus>
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
Date: Tue, 01 Mar 2005 09:42:59 +0100

Hi Todor,

> I successful make a bnep connection between my laptop (with Slackware 10.0, kernel 2.4.26 with openmosix 
> patch and latest version of bluez libs and bluez pand, but i tryed also with other versions) and desktop PC with 
> Windows XP Pro, after few minutes  (not measured), on linux system the bnep0 interface was destroyed.
> 
> Attempting to reconnect with pand worked silently, but the bnep0 interface was not created. Workaround was to 
> remove and re-insert the dongle on my laptop, then i recreate the bnep connection again.

run "hcidump -X -V" as root while connecting and see what really
happens.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
