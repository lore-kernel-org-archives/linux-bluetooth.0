Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth modem under SuSE 9.1
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez@hippie-online.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <5725483$1095842295415139f78ba4b0.63992150@config17.schlund.de>
References: <5725483$1095842295415139f78ba4b0.63992150@config17.schlund.de>
Content-Type: text/plain
Message-Id: <1095843147.5762.30.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 22 Sep 2004 10:52:27 +0200

Hi,

> I am looking for a solution to use my bluetooth modem without root
> permissions.
> 
> The modem is a "Trust 56k v92 bluetooth wireless modem" which I use in
> connection with a "Trust BT180 USB bluetooth adapter". The behaviour
> described in the following is identical for two different boxes, a
> desktop and a notebook machine, running under SuSE 9.1 (kernel 2.6.4).
> I installed the packages bluez-libs (2.5-43), bluez-sdp (1.5-59),
> bluez-utils (2.4-65) and kdebluetooth (0.0.cvs20040216-42).
> 
> I modified two config files: In /etc/bluetooth/pin I entered the
> 12-digit PIN printed at the bottom of the modem. In /etc/rfcomm.conf I
> replaced the default entries "device" and "comment" by the modem's
> address (determined by the command "hcitool scan") and name.
> 
> So far everything works fine as described in the helpful online
> documentations of Marcel Holtmann and Jochen Lillich (except for
> "sdptool browse <address>" which does not return any information).
> 
> There are no rfcomm devices defined by SuSE. So I created one by the
> command "mknod -m 666 /dev/rfcomm0 c 216 0". After this I can connect
> to the modem by "rfcomm connect 0 <address> 1" and use it like a normal
> modem via /dev/rfcomm0 (I use wvdial/kinternet for this).
> 
> My problem occurs when terminating the internet connection: At the same
> time the bluetooth connection is disconnected and /dev/rfcomm0 is
> deleted! So I need root permissions to recreate the device file every
> time I want to connect to the modem. :-(
> 
> Can anybody give me a solution or workaround for this disturbing
> behaviour?

install the udev package and everything should be fine.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
