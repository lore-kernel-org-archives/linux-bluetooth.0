Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT 120 B4 + 2.6.6 / 2.6.6-mh1
From: Marcel Holtmann <marcel@holtmann.org>
To: Simon Huggins <huggie@earth.li>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040513220010.GD19473@paranoidfreak.co.uk>
References: <20040513202052.GJ14471@paranoidfreak.co.uk>
	 <1084485054.25099.153.camel@pegasus>
	 <20040513220010.GD19473@paranoidfreak.co.uk>
Content-Type: text/plain
Message-Id: <1084486715.25099.164.camel@pegasus>
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
Date: Fri, 14 May 2004 00:18:35 +0200

Hi Simon,

> Ok it shows:
> 	huggie@thin:~$ hcidump -x
> 	HCIDump - HCI packet analyzer ver 1.5
> 	device: hci0 snap_len: 1028 filter: 0xffffffff
> 	> HCI Event: Command Status(0x0f) plen 4
> 	  00 01 01 04 
> 	> HCI Event: Inquiry Complete(0x01) plen 1
> 	  00 

I miss the inquiry command. Do you ran hcidump as root? You must see
something like this:

	< HCI Command: Inquiry(0x01|0x0001) plen 5
	  33 8B 9E 08 64 
	> HCI Event: Command Status(0x0f) plen 4
	  00 01 01 04 

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
