Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcitool returns error 0x11 with RSSI command
From: Marcel Holtmann <marcel@holtmann.org>
To: Alvin Lam <alvinlam@shaw.ca>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40616653.3000904@shaw.ca>
References: <20040323223102.25A8F1D0425@sc8-sf-uberspam1.sourceforge.net>
	 <40616653.3000904@shaw.ca>
Content-Type: text/plain
Message-Id: <1080129697.2515.103.camel@pegasus>
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
Date: Wed, 24 Mar 2004 13:01:38 +0100

Hi Alvin,

> I am using BlueZ with two Socket CompactFlash BT card using the dtl1_cs 
> driver.  I run "sdptool browse &" and when a connection is established I 
> then run "hcitool <rssi | lq | tpl> <bdaddr>".  This yields the 
> following errors:
> 
> HCI get_link_quality cmd failed (0x11)
> Read RSSI returned (error) status 0x11
> HCI read_transmit_power_level cmd failed (0x11)
> 
> Since 0x11 is 17 in decimal, looking at errno.h shows that this error 
> corresponds to "File Exists".  I found several previous messages on the 
> mailing list referring to a similar error, but a different return value 
> (0x01).
> 
> I am thinking perhaps the Socket CF card does not support these 
> features?  Any ideas what in particular is failing in hci_send_req()?

the socket card don't support these features. Check your card features
with this command "hciconfig hci0 features".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
