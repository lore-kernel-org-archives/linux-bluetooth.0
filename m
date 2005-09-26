Return-Path: <linux-usb-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [linux-usb-devel] Re: [Bluez-devel] problem in linux 2.6.9-11
Message-ID: <7BCD17BB75C4464D866EB5A20D5E889E988098@HYD-MKD-MBX01.wipro.com>
From: <rao.shalini@wipro.com>
To: <hadess@hadess.net>, <bluez-devel@lists.sourceforge.net>
Cc: <linux-usb-devel@lists.sourceforge.net>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
Date: Mon, 26 Sep 2005 12:19:16 +0530
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Bastien=20

Thank you your suggestions.


Regards,
Shalini G

-----Original Message-----
From: linux-usb-devel-admin@lists.sourceforge.net
[mailto:linux-usb-devel-admin@lists.sourceforge.net] On Behalf Of
Bastien Nocera
Sent: Sunday, September 25, 2005 5:50 PM
To: bluez-devel@lists.sourceforge.net
Cc: linux-usb-devel@lists.sourceforge.net
Subject: [linux-usb-devel] Re: [Bluez-devel] problem in linux 2.6.9-11

On Sun, 2005-09-25 at 16:21 +0530, rao.shalini@wipro.com wrote:
> Hi,
<snip>
> One more observation on usbserial module which is working fine with
> linux kernel 2.6.5-11, whereas with kernel 2.6.9-11 is giving kernel
> panic for disconnect function.=20

The kernel versions would be 2.6.9-5.EL and 2.6.9-11.EL. So you have a
regression between 2 versions of the RHEL4 kernel.

I think you might be seeing this bug with Bluetooth:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D161314

Which is a deadlock while pairing. It's already fixed in the beta kernel
for RHEL4 U2 (available on RHN). As for the panic on disconnect, there
are also a bunch of USB serial related fixes in RHEL4 U2 beta.

Next time you see regressions in Red Hat kernels, contact the Red Hat
support. They're much better equipped than the community to answer this
sort of questions.

Cheers

---
Bastien Nocera <hadess@hadess.net>=20




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server.
Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
