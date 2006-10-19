Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <ef9938ec0610191008t708c43cfjf6bae40763596eba@mail.gmail.com>
Date: Thu, 19 Oct 2006 13:08:20 -0400
From: "Albert Huang" <albert@csail.mit.edu>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.63.0610191205320.29304@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
References: <200610191334.25362.denis.kenzior@trolltech.com>
	<Pine.LNX.4.63.0610191205320.29304@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] SDP over XML
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

Hi Peter,


> I remember there was an implementation which uses XML in the past,
> but I think this was not for Bluez. May be XML is a little bit of an
> overkill, but on the other hand it is a well established and flexible data
> format

Perhaps you're thinking of OS X?  All service records are stored in
XML until they're actually advertised.

http://developer.apple.com/documentation/DeviceDrivers/Conceptual/Bluetooth/BT_Develop_BT_Apps/chapter_4_section_4.html#//apple_ref/doc/uid/TP30000997-CH216-BACJGDDH

I'm not sure if that link will show properly.  If not, then google for
"OS X Bluetooth Collection Tasks"

-albert

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
