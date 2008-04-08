Return-Path: <cyrus@holtmann.org>
Message-ID: <47FBA18A.3030906@infitsrl.com>
Date: Tue, 08 Apr 2008 18:47:06 +0200
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Log messages causes
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

Hi all,
I'm trying to understand what can generate following log lines using a 
software I'm writing:

add_conn: Failed to register connection device
l2cap_recv_acldata: Unexpected continuation frame (len 0)
hci_acldata_packet: hci2 ACL packet for unknown connection handle 13
hci_acldata_packet: hci2 ACL packet for unknown connection handle 11

(I've many line of every message...)

I'm trying to understand the meaning of every single message to correct 
the erroneous behaviour that cause them in my software.

add_conn: ... : If I've correct understand looking at the sources it 
appear when I try to open more connections to the same device, it's right?
l2cap_recv_acldata: .... : Seems to me a problem of the device 
responding in a l2cap flow with a frame of 0 len, but how this is possible?
hci_acldata_packet: ... : may be these messages related to connections 
not closed in the right way so the remote peer isn't informed and 
continue to send packets to me?

I'm trying to find in my sources causes of these problems but I'd like 
to known if are the right problems to look at.

I'm using kernel 2.6.22-1 and bluez-libs-3.22.


Many thanks
Fabrizio

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Register now and save $200. Hurry, offer ends at 11:59 p.m., 
Monday, April 7! Use priority code J8TLD2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
