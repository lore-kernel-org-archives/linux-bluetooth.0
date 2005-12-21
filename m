Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bcsp problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <F6E1228667B6D411BAAA00306E00F2A506A75557@pdc2.nestec.net>
References: <F6E1228667B6D411BAAA00306E00F2A506A75557@pdc2.nestec.net>
Content-Type: text/plain
Message-Id: <1135163576.26233.60.camel@localhost>
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
Date: Wed, 21 Dec 2005 12:12:56 +0100

Hi Jibin,

> 	I am using bluez stack.  I found a Bluetooth Problem with Mobile
> 	 phone.
>      It's happen when bluetooth device  connect to Mobile Phone for a long
>      time,it shows the following error message.
> 
>  	 bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
>  	 bcsp_pkt_cull: Peer acked invalid packet
>  	
>  	I Think thehe above messages shows that the  bluetooth device was
>   reset during the 	communication with mobile.So the bluecore firmware
>   embedded in the chip will start sending 	Sync packets again to bcsp
>   stack to establish the link between bluecore and bcsp stack.

run "hciconfig hci0 revision" (as root) and show us the output. What
versions of the BlueZ packages and Linux kernel are you using?

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
