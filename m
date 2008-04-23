Return-Path: <cyrus@holtmann.org>
From: Florian Echtler <floe@butterbrot.org>
To: bluez-devel@lists.sourceforge.net
Date: Wed, 23 Apr 2008 13:37:31 +0200
Message-Id: <1208950651.6611.167.camel@pancake>
Mime-Version: 1.0
Subject: [Bluez-devel] Question about hci_create_connection and clock offset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello everyone,

I'm trying to find the fastest possible way to get RSSI values for
Bluetooth devices. So far, my code looks like this:

    dev_id = hci_get_route(NULL);
    hci_devinfo(dev_id,&di);
...
    num_rsp = hci_inquiry(dev_id, len, max_rsp, NULL, &ii, flags);
...
    for (i = 0; i < num_rsp; i++) {
	uint16_t myhandle;
	if (hci_create_connection(
		sock,
		&(ii+i)->bdaddr,
		htobs(di.pkt_type & ACL_PTYPE_MASK),
		(ii+i)->clock_offset,
		0,
		&myhandle,
		0
	) < 0) perror("hci_create_con");
	
	if (hci_read_rssi(sock, myhandle, &rssi, 0) < 0)
		rssi = -127;
	hci_disconnect(sock, myhandle, HCI_OE_USER_ENDED_CONNECTION, 0);
...
    }

Now, while this works, I feel it's really slow.

Can somebody please enlighten me to the meaning of parameters 3-5 of
hci_create_connection? I also would be grateful for some mid-level
description of the Bluetooth protocol..
What I believe to know is this:

- ptype: Packet types which are allowed for this connection. 
  Intersection of what the device supports and all ACL packet types.

- clock offset: difference in ticks between local device clock and
  target device clock. My limited Bluetooth knowledge made me think that
  when I specify the offset from hci_inquiry, the connection should be 
  created faster, as the clock offset doesn't have to be calculated
  again. However, I don't really see a difference when I just set this
  to 0.

- rswitch: Allow role switch. Not a difference either..

I know that somebody posted a while ago that L2CAP should be preferred
for such tasks, but IIRC, opening an L2CAP connection requires
authentication/pairing while this method doesn't.

Please correct my half-knowledge, where appropriate :-)

Thanks for your help,
Yours, Florian
-- 
0666 - Filemode of the Beast


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
