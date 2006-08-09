Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44DA046D.7020600@pracucci.com>
Date: Wed, 09 Aug 2006 15:51:09 +0000
From: Marco Pracucci <development@pracucci.com>
MIME-Version: 1.0
To: Bluez Development ML <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] connect() and L2CAP_CONN_TIMEOUT
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

Hi,

I need to be sure that an SDP connection does not take more than X
seconds. In order to achieve my goal, I have correctly set the page
timeout of my local device. However, if I'm right, the page timeout is
the max time the local Link Manager will wait for a baseband page
response. But what does it happen if the page request is successfully
completed and an error occur during the connection to L2CAP remote
"layer"? Is there a timeout for this? Maybe L2CAP_CONN_TIMEOUT...

I have posted this message, because practical experiments demonstrate
that sometimes the sdp_connect() timeout expires after 40 seconds.

Have you any idea and/or suggestion?

Thanks,
Marco Pracucci


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
