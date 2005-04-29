Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Timeouts
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4272363F.30502@futurlink.com>
References: <1687ed8405042723003ae1da8e@mail.gmail.com>
	 <4272363F.30502@futurlink.com>
Content-Type: text/plain
Message-Id: <1114782143.8836.91.camel@pegasus>
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
Date: Fri, 29 Apr 2005 15:42:23 +0200

Hi Pedro,

> I am having some trouble with the timeouts of connections under Bluetooth.
> 
> My first concern is the initial connection timeout. I try to send a file 
> to a mobile phone using OpenOBEX (I use the BtOBEX_TransportConnect()). 
> If the owner of the mobile phone ignores the message that appears in the 
> mobile's screen (asking him/her whether to accept the connection), after 
> 30 seconds the connection fails with "Resource temporarily unavailable" 
> (errno=11). How can I modify this 30 seconds?

you need to integrate a connect timeout (SABM timeout) into the RFCOMM
kernel code.

> I can control the page timeout issuing "hciconfig hci0 pageto 8192", 
> that will limit the time for (correct me if I am wrong) completing the 
> HCI connection to about 5 seconds. But my problem is at a higher level 
> (RFCOMM), since the device is whithin range and the HCI connection is 
> done correctly. Is there any specific command in the bluez API to change 
> the overall connect() timeout? Or is this a Linux issue (something like 
> setsockopt())?

The page timeout is only for the underlaying ACL links. The RFCOMM stuff
is not configurable at the moment.

> The other problem is with the call sdp_service_search_attr_req(). There 
> is one mobile that I am testing, that does not always respond (I am 
> trying to track down the reason). This call takes about 2 minutes to 
> give up so, in the previous scenario, it means that other clients are 
> waiting for two minutes, something unacceptable. Is there a way to 
> reduce this 2 minutes timeout?

I have no idea. I need the phone to play with it.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
