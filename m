Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Is there authenticate only incoming mode
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <422F4208.8070706@ul.ie>
References: <422F4208.8070706@ul.ie>
Content-Type: text/plain
Message-Id: <1110393974.5462.45.camel@notepaq>
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
Date: Wed, 09 Mar 2005 19:46:13 +0100

Hi Joe,

> Is it possible to configure hcid so that authentication (i.e. PIN 
> challenge) is only invoked on incoming connections. I'd like to make a 
> PIN request only if some other device tries to use my PC (e.g. object 
> push) but it is not required if I want to send to them (and my PC 
> initiates the connection). I'm not too bothered about encryption at this 
> stage..
> 
> I've searched the newslist and tried configuring hcid.conf but haven't 
> been able to get it working. Guess it is not intended to  work that way.

this is only possible with security mode 2.

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
