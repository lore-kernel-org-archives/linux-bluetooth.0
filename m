Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] more on rfcomm : function not implemented.
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200412132014.18120.wim.delvaux@adaptiveplanet.com>
References: <200412132014.18120.wim.delvaux@adaptiveplanet.com>
Content-Type: text/plain
Message-Id: <1102980691.2143.57.camel@pegasus>
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
Date: Tue, 14 Dec 2004 00:31:31 +0100

Hi Wim,

> I think it might have something to do with PAND --search --persist --cache
> 
> If pand is NOT running i can perform hcitool scan and get
> response from my phone.
> 
> When I start pand with above options, after it 'detects' my desktop's PAND
> hcitool scan fails and l2ping too 

is this still the iPAQ with build id 0x72? If yes, then this is the
reason, because you can't connect while you run an inquiry or start an
inquiry while you have a connection open. The second restriction is gone
with HCI 16.x firmwares.

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
