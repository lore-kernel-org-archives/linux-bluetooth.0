Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <44A21B71.6090108@ibmt.fraunhofer.de>
References: <4497CE54.5080305@ibmt.fraunhofer.de>
	<4498EB58.3090200@ibmt.fraunhofer.de>	<1150883159.3950.34.camel@localhost>
	<44991DF2.2000409@ibmt.fraunhofer.de>
	<1150886307.3950.36.camel@localhost>
	<44A21B71.6090108@ibmt.fraunhofer.de>
Date: Wed, 28 Jun 2006 09:32:59 +0200
Message-Id: <1151479980.9544.8.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Fwd: Re:  Problem connecting Bluetooth device]
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

Hi Harald,

> The problem regarding the linkkey is that the stored linkkey from the first connection is
> OK and all further connections are successful. But if I switch off and then switch on the
> remote device, a new linkkey, different from the first, will be generated, but the old
> linkkey will not be overwritten with the new one! Therefore I can contact the remote
> device only one time (after entering the PIN). Why the linkkey is not overwritten?!

how can the remote device generate a new link key when it is switched
off. This can't be right. Bluetooth is not working this way. And this is
also not what we saw in hcidump. The local device is giving a wrong link
key and thus the authentication was refused.

Regards

Marcel



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
