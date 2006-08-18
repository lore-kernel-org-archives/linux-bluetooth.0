Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <93B941A7-3D59-4432-A4BF-A8BB2D675854@cs.bath.ac.uk>
To: bluez-devel@lists.sourceforge.net
From: Vassilis Kostakos <vk@cs.bath.ac.uk>
Date: Fri, 18 Aug 2006 01:20:53 +0100
Subject: [Bluez-devel] Low-level HCI event
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Dear BlueZ developers,

I am trying to write a program that is aware of other devices  
scanning the area.  I have looked through the official Bluetooth  
event list, and there is no event that offers this information.  I  
would like to figure out
- When has someone piked up my Bluetooth Address
- When has someone picked up my Bluetooth name.

Would a kernel patch do the job?

Thanks

-- 
Dr Vassilis Kostakos
Human Computer Interaction Group
Department of Computer Science
University of Bath
vk@cs.bath.ac.uk - http://www.cs.bath.ac.uk/~vk



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
