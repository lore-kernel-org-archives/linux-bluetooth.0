Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] valgrind complains
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412080123.07501.wim.delvaux@adaptiveplanet.com>
References: <200412080123.07501.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102478579.8447.62.camel@pegasus>
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
Date: Wed, 08 Dec 2004 05:02:59 +0100

Hi Wim,

> about unintialized values in the following code
> 
>  struct hci_dev_info di;
> 
>          di.dev_id = dev_id;
> 
>          if( ioctl( fd, HCIGETDEVINFO, (void*)&di) != 0 )
>               continue;  // uh ?
> 
>  printf( "%s\n", di.name ); // here valgrind complains on the third character
> 
> 
> Should I perhaps memset ? is name field null terminated ?

maybe you should include the filename to let us know where to look.

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
