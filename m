Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Re: [Bluez-users] PANU service search
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <e1effdeb05032811466fe34801@mail.gmail.com>
References: <e1effdeb05032805225cf1b8dd@mail.gmail.com>
	 <1112016560.9016.32.camel@pegasus>
	 <e1effdeb0503280607600d1863@mail.gmail.com>
	 <1112019482.9016.37.camel@pegasus>
	 <e1effdeb050328110339a02eb7@mail.gmail.com>
	 <1112037740.9016.45.camel@pegasus>
	 <e1effdeb05032811466fe34801@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112040117.9016.47.camel@pegasus>
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
Date: Mon, 28 Mar 2005 22:01:57 +0200

Hi Claudio,

> The code for support search for PANU service is attached. The change
> is very small
> but will help me create a PAN for UPnP application in ad hoc scenario.

I applied the patch to the CVS, but I still don't get why you needed it
in the first place. The pand application is able to register the PANU
service record and search for it by itself.

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
