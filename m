Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Piconet problems
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <I92JZQ$4438CF5CD46EDB224256583706BE5074@libero.it>
References: <I92JZQ$4438CF5CD46EDB224256583706BE5074@libero.it>
Content-Type: text/plain
Message-Id: <1103627796.15574.1.camel@pegasus>
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
Date: Tue, 21 Dec 2004 12:16:36 +0100

Hi Jers,

> I'm trying to create a simple piconet consisting of a master and two slaves. I'm using three Digicom Palladio 
> dongles. 
> My packages list is: 
>  - bluez-libs-2.8-1.i386.rpm 
>  - bluez-bluefw-1.0-1.i386.rpm 
>  - bluez-hcidump-1.10-1.i386.rpm 
>  - bluez-sdp-1.5-1.i386.rpm 
>  - bluez-pan-1.1-1.i386.rpm 
>  - bluez-utils-2.8-1.i386.rpm 
>  - bridge-utils-0.9.6-1.i386.rpm 

the bluez-sdp, bluez-pan and bluez-bluefw packages are deprecated. Get
yourself newer versions of bluez-libs and bluez-utils.

What is the output of "hciconfig -a" for these dongles?

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
