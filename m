Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Erwin Authried <eauth@softsys.co.at>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1098480115.3258.61.camel@justakiss>
Mime-Version: 1.0
Subject: [Bluez-users] lockup problem with larger packets
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
Date: Fri, 22 Oct 2004 23:21:55 +0200

I have cross-compiled bluez for uClinux-2.4.20 for ARM7, with the bluez
kernel patch applied, and bluez-utils 2.10. I'm using the Conceptronic
CBT100C PCMCIA card on the system. The card is initialized with
"hciattach ttyS2 bcsp". Basically, the system works fine, but I see
occasional overrun errors on the UART, maybe because the ARM7 is running
with 40MHz only. When I transmit larger packets (l2ping -s 300 ...), the
number of overrun errors increases, and sometimes the system locks up.
I'm getting an endless sequence of: 

bcsp_pkt_cull: Peer acked invalid packet
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_pkt_cull: Peer acked invalid packet
bcsp_handle_le_pkt: Found a LE sync pkt, card has reset
bcsp_pkt_cull: Peer acked invalid packet
...

Regards,
Erwin




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
