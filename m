Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AD8DD1.9020904@prim-time.fr>
From: Xavier Garreau <x.garreau@prim-time.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] using select()?
References: <000a01c4d733$8609ce30$6401000a@zool>
In-Reply-To: <000a01c4d733$8609ce30$6401000a@zool>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 01 Dec 2004 10:24:33 +0100

Hi,

> Is there anyware some examples or any source code in the BlueZ utils. 
> where they use the standard network select() function?
> I really want to use this instead of the more "heavier" fork() function. :-)

Marcel sent us some time ago an example which uses poll on hci raw sockets.

A cached version can be found here : 
http://www.xgarreau.org/temp/bluetooth_docs/bluez/mh_hci_raw.c

Maybe Marcel has a more recent example ?

Regards,
Xavier Garreau


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
