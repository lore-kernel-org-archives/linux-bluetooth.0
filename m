Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hci_acldata_packet error in a Palm connection.
Message-ID: <20040610130139.GA7833@gmx.net>
References: <40C85761.4060201@dim.uchile.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40C85761.4060201@dim.uchile.cl>
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
Date: Thu, 10 Jun 2004 15:01:39 +0200

On  0, Eduardo Moreno <emoreno@dim.uchile.cl> wrote:
> [Tungsten T2 and 2.6.6] 
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
> 
> Anybody can help me? thanks.

Post a hcidump of the connection, while this appears. You are not so
clear about, how dund behaves. Does it exit? What does it show if you
don't detach the daemon.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
