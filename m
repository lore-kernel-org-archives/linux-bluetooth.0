Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alvin Lam <alvinlam@shaw.ca>
In-reply-to: <20040323223102.25A8F1D0425@sc8-sf-uberspam1.sourceforge.net>
To: bluez-users@lists.sourceforge.net
Message-id: <40616653.3000904@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
References: <20040323223102.25A8F1D0425@sc8-sf-uberspam1.sourceforge.net>
Subject: [Bluez-users] hcitool returns error 0x11 with RSSI command
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
Date: Wed, 24 Mar 2004 02:43:31 -0800

Hello,

I am using BlueZ with two Socket CompactFlash BT card using the dtl1_cs 
driver.  I run "sdptool browse &" and when a connection is established I 
then run "hcitool <rssi | lq | tpl> <bdaddr>".  This yields the 
following errors:

HCI get_link_quality cmd failed (0x11)
Read RSSI returned (error) status 0x11
HCI read_transmit_power_level cmd failed (0x11)

Since 0x11 is 17 in decimal, looking at errno.h shows that this error 
corresponds to "File Exists".  I found several previous messages on the 
mailing list referring to a similar error, but a different return value 
(0x01).

I am thinking perhaps the Socket CF card does not support these 
features?  Any ideas what in particular is failing in hci_send_req()?

Thanks.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
