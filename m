Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <eekued$aae$1@sea.gmane.org>
References: <eekued$aae$1@sea.gmane.org>
Date: Mon, 18 Sep 2006 08:04:55 +0200
Message-Id: <1158559495.30486.4.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Connection Problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Chris,

> I'm getting strange behavior from a device. Sometimes I can connect just
> fine, but other times I get an error. However, the blinking blue light
> on the device becomes solid, indicating it's connected. The device is
> fully charged (plugged-in in fact) and my bluetooth dongle is sitting
> right next to it, so I don't think it's a signal strength issue. Is
> there any other reason why I would this problem?
> 
> []# hidd --connect 00:0B:24:40:C7:83
> Connected to 00:0B:24:40:C7:83 on channel 1
> 
> []# hidd --connect 00:0B:24:40:C7:83
> Can't open input device: No such file or directory (2)

make sure that the uinput kernel module has been loaded.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
