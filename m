Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <422CA521.40303@emenaker.com>
From: Joe Emenaker <joe@emenaker.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Automatically accepting pairing from a mouse?
References: <4227A238.5030003@emenaker.com> <1109933159.8058.19.camel@pegasus>
In-Reply-To: <1109933159.8058.19.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 07 Mar 2005 19:01:53 +0000

Marcel Holtmann wrote:

>it is enought to edit /etc/default/bluez-utils to contain
>
>	HIDD_ENABLED=1
>	HIDD_OPTIONS="--server"
>
>and then restart the Bluetooth subsystem. The next time your mouse will
>reconnect and this will be handled by the running hidd.
>  
>
I was so certain that this wasn't going to work that I was getting ready 
to step through the process and capture output from "hcitool" etc. to 
show you that it wasn't working when.... uh.... it worked. :)

Strangely, I had HIDD_ENABLED=1, and HIDD_OPTIONS="-i 00:0E:A1:01:FD:A7 
--server"

What was the "-i" option doing which made it not work?

- Joe


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
