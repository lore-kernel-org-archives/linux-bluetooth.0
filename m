Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hidp and connecting
From: Marcel Holtmann <marcel@holtmann.org>
To: cijoml@volny.cz
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200405142343.04831.cijoml@volny.cz>
References: <200405141524.04481.cijoml@volny.cz>
	 <1084556671.25099.201.camel@pegasus>  <200405142343.04831.cijoml@volny.cz>
Content-Type: text/plain
Message-Id: <1084572580.24119.16.camel@pegasus>
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
Date: Sat, 15 May 2004 00:09:40 +0200

Hi Michal,

> > what kind of errors are you talking about? You must be more specific.
> 
> hci_acldata_packet: hci0 ACL packet for unknown connection handle 41
> hci_acldata_packet: hci0 ACL packet for unknown connection handle 42

show us the hcidump -x for this reconnect, because it must be a problem
in the Bluetooth core. What does /proc/bluetooth/l2cap show?

> Why not? If kernel knows them via list specified in some config by root, hidd 
> should be used only for connecting a new one and killling them.

The HIDP module is not able to accept or create new connections and
actually how should the kernel get the HID report descriptor? We don't
have a kernel SDP client implementation and I will never accept such
stuff. Look at the SDP specification and you will understand why.

> It reminds me, that --kill option kills connection, but device can reconnect. 
> Maybe should be implemented option, which will kill device and it will not be 
> allowed to reconnect.

The --unplug option is on my list, but I haven't had time to put it in
this release. The kernel already supports the virtual cable unplug.

> Why? After connecting I can kill hidd and devices works. So if under single 
> mode will not be control for bdaddr and unknown connections, it should be 
> possible to work too.

Same argument as above. A userspace daemon must accept the connection
and it has to retrieve the needed SDP records.

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
