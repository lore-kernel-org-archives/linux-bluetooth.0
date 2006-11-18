Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <455F2DA5.5050808@xmission.com>
Date: Sat, 18 Nov 2006 08:58:29 -0700
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <20061118110247.10397.qmail@web52105.mail.yahoo.com>
In-Reply-To: <20061118110247.10397.qmail@web52105.mail.yahoo.com>
Subject: Re: [Bluez-users] Errors pairing with headset
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

Paolo

> Trying to connect to my bluetooth headset on a new Ubuntu Edgy install (have'nt touched any of the /etc/bluetooth/*.conf files)

For some reason, edgy has an hcid.conf that requires bluez-passkey-gnome
in order to work but they don't install the package by default. Check
your setup.

I wrote in some detail how to get audio working without the kernel
module. I linked it from the page you referenced.

https://help.ubuntu.com/community/BluetoothAudio

Brad

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
