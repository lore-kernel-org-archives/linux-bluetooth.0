Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Kevin Mahaffey" <kevin.mahaffey@flexilis.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Thu, 17 Aug 2006 17:32:34 -0700
MIME-Version: 1.0
in-reply-to: <93B941A7-3D59-4432-A4BF-A8BB2D675854@cs.bath.ac.uk>
Message-ID: <E1GDsI1-0000dE-Ou@mail.sourceforge.net>
Subject: Re: [Bluez-devel] Low-level HCI event
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

I believe this is taken care of on the radio itself and not sent over the
HCI. There may be some proprietary vendor commands to alert you to
inquiry/page/remote name requests, but what you describe would most likely
need a protocol analyzer or baseband sniffer.

Anyone know of vendor commands that would do this?

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Vassilis
Kostakos
Sent: Thursday, August 17, 2006 5:21 PM
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Low-level HCI event

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
Get stuff done quickly with pre-integrated technology to make your job
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
