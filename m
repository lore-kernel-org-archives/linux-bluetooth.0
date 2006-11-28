Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <c49421c50611261142i2d525f85yd67cb43d28a06e3d@mail.gmail.com>
References: <c49421c50611261142i2d525f85yd67cb43d28a06e3d@mail.gmail.com>
Date: Tue, 28 Nov 2006 05:44:21 +0100
Message-Id: <1164689061.13955.18.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] reading RSSI (continuation)
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

Hi Loreno,

> I read that a device may send a DAC packet to another one, which will
> answer with another DAC packet. Thus, the first device can read the
> RSSI to the other device without establishing a baseband connection
> among them. In such a scenario, the first device has previous
> knowledge of the BD_ADDR and clock offset of the queried device. 
> 
> The doubt is: is there any way of doing this using BlueZ??

there is no way. The HCI doesn't provide any interface to these kind of
information and if it is not supported by HCI, then BlueZ can't use it.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
