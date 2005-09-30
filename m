Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth 1.2 and 2.0 dongles support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <01C5C5C9.58C8F330.emonturus@teltronic.es>
References: <01C5C5C9.58C8F330.emonturus@teltronic.es>
Content-Type: text/plain
Message-Id: <1128082981.4955.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 30 Sep 2005 14:23:01 +0200

Hi Esteban,

> 	I have some other questions about BlueZ I had forgotten to ask you, so 
> here they go:
> 1.	I would like to buy a 2.0+EDR dongle to use with BlueZ. I have visited 
> your "Bluetooth device features and revision information" page, but I 
> haven't found any one. Does BlueZ support Bluetooth 2.0+EDR?.

yes. EDR is fully supported.

> 2.	I have a Cellink BTA-3120 dongle. Although Cellink says that it is 
> Bluetooth 1.2 compliant, when I use it with BlueZ, the HCI version I get 
> with hciconfig is 1.1. Is that wright?

Send in the "hciconfig hci0 features" output.

> 3.	I also have an old Belkin F8T001 dongle. When I plugged it BlueZ loaded 
> always some firmware stuff and it worked properly. My old version of BlueZ 
> had a bluez-bluefw-1.0-202 rpm packet. I think this is equivalent to the 
> new tarball bluez-firmware that I have downloaded from BlueZ's homepage and 
> installed, but the reality is that this dongle doesn't work anymore.

Use bluez-firmware and the bcm203x kernel driver for the 2.6 kernels.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
