Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm confusion
From: Marcel Holtmann <marcel@holtmann.org>
To: Ken <a5a33956@telus.net>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40AC714E.9040306@telus.net>
References: <40AB4D9F.7010307@telus.net> <1084969555.4327.60.camel@pegasus>
	 <40AC714E.9040306@telus.net>
Content-Type: text/plain
Message-Id: <1085045114.4327.138.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 20 May 2004 11:25:15 +0200

Hi Ken,

> Thanks for the response.  It is Windows on the iPAQ.
> I've tried again using /dev/rfcomm0 for <dev> but the results are the 
> same. (I think it was defaulting to rfcomm0 before even though I put 
> hci0 in the <dev> field)
> 
> So, in linux I do:
>  > rfcomm connect /dev/rfcomm0 08:00:28:90:25:D6 1
> Connected /dev/rfcomm0 to 08:00:28:90:25:D6 on channel 1
> Press CTRL-C for hangup
> 
> When I do this the iPAQ shows a connection icon, and when click into the 
> status screen for that connection it shows me the details including 
> connection time, activity, and signal strength.
> 
> Everything looks good but the activity always shows 0 bytes transfered 
> and 0 bytes received.
> 
> So, I guess my question is, how do I send data through this connection?
> Should I just be able to echo data into /dev/rfcomm0? (ie: echo "some 
> data" > /dev/rfcomm0)
> 
> Or is it the case that I need an application on the iPAQ side to be 
> listening for data before it will show any bytes received or transfered?

I think so, but I don't have any knowledge about Windows operating
systems.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
