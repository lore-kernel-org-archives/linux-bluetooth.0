Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Question about l2ping: 0 bytes always
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <B72A22937C14184DB0AF3324476E9C791A53FC@MBOX22.stu.nus.edu.sg>
References: <B72A22937C14184DB0AF3324476E9C791A53FC@MBOX22.stu.nus.edu.sg>
Content-Type: text/plain
Message-Id: <1105963645.8080.42.camel@pegasus>
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
Date: Mon, 17 Jan 2005 13:07:25 +0100

Hi Teck,

> I am able to run l2ping, attempting to send and receive packets from my linux box to my sony ericsson T630. However the output is always 
>  
> 0 bytes from xx:xx:xx:xx:xx id x time x ms. 
>  
> It always ends with x bytes sent, x bytes received, 0% loss. 
>  
> Is this the correct output?

according to the L2CAP part of the specification the device can send you
whatever echo responds it wants. This includes a zero byte response and
for security reasons this is good, because we have seen DoS attacks when
they are unable to handle big echo packets.

Regards

Marcel




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
