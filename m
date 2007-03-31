Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <c49421c50703292018r4a1fb72fpc47f1339fa1f2939@mail.gmail.com>
References: <c49421c50703292018r4a1fb72fpc47f1339fa1f2939@mail.gmail.com>
Date: Sat, 31 Mar 2007 15:48:55 +0200
Message-Id: <1175348935.5815.262.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem reading rssi
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

> I am having some headache for reading the rssi of a remote device. The
> code bellow insists in returning 0 to the "rssi" variable when I try
> to read the rssi of a connected Nokia 770. If I run the same code for
> a connected desktop, then a non zero value is returned. For
> complicating even more, if I run "hcitool clkoff <addr>" when
> connected to the 770, then a non zero value is also returned. 

it depends on the local adapter you use and the Bluetooth chip in the
remote device. Some devices don't report the correct RSSI value. It
seems they always return 0.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
