Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth capture and client manager
From: Marcel Holtmann <marcel@holtmann.org>
To: Manjunath Prabhu <manjunath.mp@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de46576041101220615adedb4@mail.gmail.com>
References: <2de46576041101220615adedb4@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1099392428.10948.28.camel@pegasus>
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
Date: Tue, 02 Nov 2004 11:47:08 +0100

Hi Manjunath,

> I am working on a BT project and am trying to capture bluetooth packets. 
> 
> I have done a simple test, where in using hcidump i have captured the
> packets and saved it to a file. I have then fed the file to
> ethereal.........which gives limited and insufficient information like
> data bytes, frame number etc. I am not able to retrieve any header
> contents

I never finished the Bluetooth decoder for Ethereal and so it is only
capable of reading the hcidump format.

> Is it possible to capture and analyse BT packets from the air
> interface, calculate the data transfer rate, etc...something similar
> to a 802.11 client manager???? Please do send the links ..if some work
> has already taken place on this front.

For getting air packets you need a protocol analyzer. For a client
manager you can use the link quality, RSSI etc. and you should look the
HCI part of the specification, because everything you can do is in
there.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
