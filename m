Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a8e1da0711282343v4397e754qbcedf9f67c94499a@mail.gmail.com>
Date: Thu, 29 Nov 2007 15:43:23 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: pwachend@uni-koeln.de
In-Reply-To: <474B110A.7000804@uni-koeln.de>
MIME-Version: 1.0
References: <4745D9EE.4020101@uni-koeln.de> <4749FAD6.6080403@uni-koeln.de>
	<1196055526.4217.44.camel@aeonflux> <474AA430.6010307@uni-koeln.de>
	<1196080043.17196.4.camel@aeonflux> <474B110A.7000804@uni-koeln.de>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] hcitool scan returns wrong bdaddr
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Nov 27, 2007 2:31 AM, Paul Wachendorf <pwachend@uni-koeln.de> wrote:
> Hi Marcel,
> I found the 3.21 tarball, thanks. Unfortunately the error still occurs
> with the resulting  libbluetooth.so.2.9.1. Because of the output from
> ldd, I'm sure that hcitool is linked against the "right" lib. So the Bug
> must be in 3.21 too, or there is an completely different Problem as I
> assume, because of the same behavior with libbluetooth.so.2.9.0 from
> debian lenny, and because you told me that it should work with an D-Bus
> API, which is installed.
> So perhaps the Problem is rooted in my D-Bus setup. I installed it from
> the debian repository and thought it should work without any further
> configurations.
> I'll search for it,
> thank you very much for your time and help,

Maybe the Dbus api works for you, but the problem with hcitool is still there.

If you could build the bluez-utils/lib with -g and debug the hcitool,
you might get the answer then.

Regards
dave

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
