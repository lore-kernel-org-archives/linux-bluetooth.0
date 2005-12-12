Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] After two SCO links been created, Can not
	transfer ACL data
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <OFD779B58D.5D315849-ON482570D5.00402621-482570D5.00422C3C@zte.com.cn>
References: 
	 <OFD779B58D.5D315849-ON482570D5.00402621-482570D5.00422C3C@zte.com.cn>
Content-Type: text/plain
Message-Id: <1134389864.1468.36.camel@blade>
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
Date: Mon, 12 Dec 2005 13:17:44 +0100

Hi,

> After I creat two SCO links from two different Teminal devices to one
> Gateway device, I can not transfer any ACL data between the gateway
> and teminal. 
> the note is: 
> # hcitool con 
> Connections: 
>         < SCO 00:00:11:22:33:44 handle 2 state 1 lm SLAVE   
>         < SCO 00:00:55:66:77:88 handle 1 state 1 lm SLAVE 
>         > ACL 00:00:11:22:33:44 handle 7 state 1 lm MASTER 
>         > ACL 00:00:55:66:77:88 handle 6 state 1 lm MASTER 
> 
> Software: Using bluez stacks; 
> hareware: using broardcom bluetooth chip or CSR bluetooth chip. 
> I watch the uart port of the bluetooth chip and find that some ACL
> data have been sent to bluetooth chip of gateway, but no any acl data
> have been received from bluetooth chip of teminal. 

the example above is not a CSR chip. Use the CSR chip as reference and
provide output of "hciconfig hci0 revision".

> Is bugs of the bluetooth chips , or the bluez stacks is wrongly used?

With this little information it is totally unclear. However since you
mentioned UART, it might be an UART limitation.

>  btw: the surport of chip  manufacturer is poor.   

What does this crap mean. We support all chip manufacturers and the guys
at CSR were always helpful.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
