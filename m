Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Mark Hellman <markhellman@techie.com>
Date: Tue, 06 Feb 2007 13:06:29 +0000
Message-ID: <eq9ugs$63s$1@sea.gmane.org>
References: <1170700026.3240.56.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Plugz with Dell inbuilt-BT
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

Jon Barnett wrote:

> The only problem is that skype can't use the plugz device as it doesn't
> recognize it  - since it doesn't do detection of available pcm devices.

>>From a user's perspective that is, in my opinion, the main problem with
using plugz instead of btsco. Skype and Ekiga are the reasons why 90% of
users want to install plugz.

Is this an ALSA limitation, or isn't Skype using the right functions from
the ALSA's API to enumerate all available devices? Who must be fixes: Skype
of ALSA?
Could some developer enlighten us on this issue?

Thanks,
Mark


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
