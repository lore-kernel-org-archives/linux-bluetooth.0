Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <474B110A.7000804@uni-koeln.de>
Date: Mon, 26 Nov 2007 19:31:38 +0100
From: Paul Wachendorf <pwachend@uni-koeln.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <4745D9EE.4020101@uni-koeln.de>
	<4749FAD6.6080403@uni-koeln.de>	<1196055526.4217.44.camel@aeonflux>
	<474AA430.6010307@uni-koeln.de> <1196080043.17196.4.camel@aeonflux>
In-Reply-To: <1196080043.17196.4.camel@aeonflux>
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

Hi Marcel,
I found the 3.21 tarball, thanks. Unfortunately the error still occurs 
with the resulting  libbluetooth.so.2.9.1. Because of the output from 
ldd, I'm sure that hcitool is linked against the "right" lib. So the Bug 
must be in 3.21 too, or there is an completely different Problem as I 
assume, because of the same behavior with libbluetooth.so.2.9.0 from 
debian lenny, and because you told me that it should work with an D-Bus 
API, which is installed.
So perhaps the Problem is rooted in my D-Bus setup. I installed it from 
the debian repository and thought it should work without any further 
configurations.
I'll search for it,
thank you very much for your time and help,
Regards,

Paul


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
