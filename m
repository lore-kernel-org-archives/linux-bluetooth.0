Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] DiNovo and bluetooth-hub functionality
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1111174767.8177.2.camel@localhost.localdomain>
References: <1111167187.8560.6.camel@localhost.localdomain>
	 <1111171397.9600.29.camel@pegasus>
	 <1111174767.8177.2.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1111175076.9600.37.camel@pegasus>
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
Date: Fri, 18 Mar 2005 20:44:36 +0100

Hi Matthias,

> Now, I have logged in as root instead and tried to run all those
> commands. Still, everything works, but I sure would like to find out
> where that init script is. Is there a way I can do find it manually? And
> then install it manually?
> 
> I'm going to try to remove all Bluez-stuff with apt-get as root, and
> then reinstalling them again, just to make sure that the script wasn't
> included from the beginning (maybe it couldn't be created?).

it is in the bluez-utils source tarball, but maybe the Ubuntu package
maintainer was too lazy. The init script is not installed by default,
because every distribution provides its own.

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
