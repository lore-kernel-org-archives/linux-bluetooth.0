Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Alexandros Karypidis <karypid@inf.uth.gr>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310101836.54089.karypid@inf.uth.gr>
Subject: [Bluez-devel] Lost L2CAP packet problems in 2.6.0-test5
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 10 Oct 2003 18:36:54 +0300

Hi all,

I am having some problems with the last packet sent over an L2CAP connection 
using 2.6.0-test5.

The short description:

I have a program which runs correctly on 2.4.22. It is a simple packet 
exchange over an L2CAP connection among peers A and B. When I run it using 
2.6.0, it always loses the last packet sent from peer A to peer B.

Peer A closes the connection after sending the last packet. IMPORTANT: Peer A 
is a custom-built embedded device which does not even have an OS. It is a 
dumb device which does not have a real BT stack. It simply repeats a sequence 
of HCI commands which results in an L2CAP connection establishment, a couple 
of small packets being exchanged (less than 100 bytes payload) and then the 
connection being torn down.

Now, I am pretty sure that A operates correctly, because whenever I run the 
client B on a computer with the 2.4.22 kernel (tested both with BlueZ and 
Affix stacks), everything works perfectly.

Whenever I run client B on a computer with the 2.6.0-test5 kernel, the last 
packet sent from A before the connection is closed is lost.

-- 
In theory, there is no difference between theory and practice.
In practice, there is. -- Yogi Berra.

Alexandros Karypidis
University of Thessaly
Computer & Communications Engineering dept.



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
