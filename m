Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_acldata_packet error in a Palm connection.
From: Marcel Holtmann <marcel@holtmann.org>
To: Eduardo Moreno <emoreno@dim.uchile.cl>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40C85761.4060201@dim.uchile.cl>
References: <40C85761.4060201@dim.uchile.cl>
Content-Type: text/plain
Message-Id: <1086873349.7930.2.camel@pegasus>
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
Date: Thu, 10 Jun 2004 15:15:49 +0200

Hi Eduardo,

> I'm starting in the bluetooth world, and i'm trying to connect my Palm 
> Tungsten T2 with my Kernel 2.6.6 + usb dongle.
> 
> I followed all the clasical howtos of Palm+BlueZ (of course, using the 
> 2.6.6 modules).
> 
> I start hcid, sdpd, without problem, the communication with the palm 
> works great, I can also l2ping the palm device.
> 
> But when I try a ppp connection (using dund) I receive the following 
> message in /var/log/messages:
> 
> kernel: hci_acldata_packet: hci0 ACL packet for unknown connection handle 1
> 
> Searching "ACL packet for unknown connection handle 1" in google, I 
> found 3 very old messages (2001) of this mailing list speaking about a 
> bug.....

what kind of dongle are you using (hciconfig -a)? Maybe you need a
firmware update for your Palm or you have to buy yourself another
dongle.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
