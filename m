Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] managing pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412030443.52876.wim.delvaux@adaptiveplanet.com>
References: <200412030025.02336.wim.delvaux@adaptiveplanet.com>
	 <1102042677.7350.31.camel@pegasus>
	 <200412030443.52876.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102045811.7350.42.camel@pegasus>
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
Date: Fri, 03 Dec 2004 04:50:11 +0100

Hi Wim,

> > there were plans to move this file into a text file, but no code has
> > been written so far. However you can do your modification by hand, but
> > at the moment after each change the hcid must be restarted.
> 
>  restarting is doable.  
>  If I understand properly, the file is binary. Can you point me to the
>  source file where the IO to the link_key file is written ? For the time being
>  I could use that code to load the link_key file and later use the proper 
> ASCII format.

check utils/hcid/hcid.h and utils/hcid/security.c.

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
