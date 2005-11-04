Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <436BBCE5.60505@masaka.cs.ohiou.edu>
From: Jim Wyllie <jwyllie@masaka.cs.ohiou.edu>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-devel] Protocols over Bluetooth Baseband and disabiling Retransmissions
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 04 Nov 2005 14:56:21 -0500

I am attempting to run an experimental protocol on top of a Bluetooth 
connection to test our theories of reliability vs. the standard 
Bluetooth retransmission scheme (mainly ARQ retransmissions).  We're 
using BlueZ on Linux 2.6.12.5 to test this.

I would like to "break" the retransmission mechanism for L2CAP Packets 
(I am forced to use Java and JSR-82 for my testing, so I'm restricted to 
L2CAP as the lowest accessible layer).  I looked through 
[include/]net/bluetooth/l2cap.[hc] and the Bluetooth spec, and I could 
easily set the default flush_to to 0x0001 (.625 milliseconds should be 
effectively 0, and with no packet to retransmit, it should timeout the 
retransmission).  Am I on the right track, and would just changing all 
flush_to assignments to 0x0001 (including the default) work like I think 
it would?  If I'm not on the right track, could someone point me to a 
good way to achieve this?

Also, I looked into other solutions, such as shoe-horning Broadcast 
packets to do this, but Java doesn't seem to support it.  I also 
couldn't find a Java interface for SCO/e-SCO where I could frame my own 
packets in the stream (not that that's a very good way to do it, IMHO). 
  Anyone have any $.02 that he or she would like to offer to this?

Many thanks for your help,
Jim Wyllie
IRG Lab
Ohio University


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
