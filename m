Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] re: Bluetooth scan & inq finds no devices
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1100805384.419cf50816afd@www.bluebottle.com>
References: <1100805384.419cf50816afd@www.bluebottle.com>
Content-Type: text/plain
Message-Id: <1100807480.7164.80.camel@pegasus>
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
Date: Thu, 18 Nov 2004 20:51:20 +0100

Hi,

> Didn't seem to help. But phone can discover see linux:
> 
> ---
> root@betty.net[~] # hcidump 
> HCIDump - HCI packet analyzer ver 1.9
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Inquiry (0x01|0x0001) plen 5
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Inquiry Complete (0x01) plen 1
> < HCI Command: Inquiry (0x01|0x0001) plen 5
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Inquiry Complete (0x01) plen 1
> 
> ---
> betty.net[~] $ hciconfig hci0 up
> betty.net[~] $ hcitool scan
> Scanning ...
> betty.net[~] $ hcitool inq 
> Inquiring ...
> betty.net[~] $ 
> betty.net[~] $ hcitool doesnt matter what you type, no error
> messages!
> betty.net[~] $  (!)

is the other device discoverable and in range? What does "hciconfig -a"
say about your local device.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
